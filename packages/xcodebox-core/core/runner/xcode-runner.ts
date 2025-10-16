import { execSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { resolve } from "node:path";
import * as crypto from "node:crypto";
import YAML from "yaml";
import { semanticReview } from "./semantic-reviewer";
const root = resolve(process.cwd());
const reportsDir = resolve(root,"reports"); if(!existsSync(reportsDir)) mkdirSync(reportsDir,{recursive:true});
function now(){ return new Date().toISOString(); }
function parseJSON(path:string){ try{ return JSON.parse(readFileSync(resolve(root,path),'utf-8')); }catch{ return null; } }
function parseCoverage(){ const j=parseJSON('reports/coverage-summary.json'); const pct=j?.total?.lines?.pct ?? j?.total?.statements?.pct; return typeof pct==='number'?pct:null; }
function parseAudit(){ const j=parseJSON('reports/audit.json'); const adv=j?.vulnerabilities||j?.metadata?.vulnerabilities; if(!adv) return null; return { high: adv.high||0, critical: adv.critical||0 }; }
function parseEslint(){ const j=parseJSON('reports/eslint.json'); if(!Array.isArray(j)) return null; let errors=0,warnings=0; for(const f of j){ errors+=f.errorCount||0; warnings+=f.warningCount||0;} return { errors,warnings }; }
function run(cmd:string){ try{ const out=execSync(cmd,{stdio:['ignore','pipe','pipe'],encoding:'utf-8'}); return { ok:true, stdout: out }; } catch(e:any){ return { ok:false, stdout: e?.stdout?.toString?.() || e?.message || 'error' }; } }
async function main(){
  const rulesFile = process.env.XCODE_RULES_FILE || 'packages/xcodebox-core/core/xcode.rules.yaml';
  const rules = YAML.parse(readFileSync(resolve(root, rulesFile), 'utf-8'));
  const passScore:number = rules.aggregation?.pass_score ?? 0.85;
  const stagesOut:any[] = [];
  for (const st of (rules.stages||[])) {
    const t0=Date.now(); let status:'PASS'|'FAIL'|'SKIPPED'|'ERROR'='SKIPPED'; let score=0; let logs=''; const metrics:any={};
    if (st.command){ const res=run(st.command); logs=res.stdout.slice(0,4000); status=res.ok?'PASS':'FAIL'; score=res.ok?1:0;
      if (st.id.includes('tests')){ const cov=parseCoverage(); if (typeof cov==='number' && typeof st.threshold==='number'){ metrics.coverage_pct=cov; score=cov>=st.threshold?1:Math.max(0,Math.min(1,cov/st.threshold)); status=cov>=st.threshold?'PASS':'FAIL'; } }
      if (st.id.includes('lint')){ const es=parseEslint(); if (es){ metrics.eslint_errors=es.errors; metrics.eslint_warnings=es.warnings; status=es.errors===0?'PASS':'FAIL'; score=es.errors===0?1:0; } }
      if (st.id.includes('sec_check')){ const a=parseAudit(); if (a){ metrics.vuln_high=a.high; metrics.vuln_critical=a.critical; const ok=(a.high+a.critical)<=0; status=ok?'PASS':'FAIL'; score=ok?1:0; } }
    } else if (st.agent==='reviewer.llm'){ const res=await semanticReview(process.cwd()); score=res.score; metrics.semantic_findings=res.findings?.length||0; logs = [`Analyzed: ${res.analyzedFiles.length}`,...res.findings.slice(0,30).map(f=>`${f.severity.toUpperCase()}: ${f.message}${f.file?` [${f.file}]`:''}`)].join('\n').slice(0,4000); status= score >= (st.threshold??0.8) ? 'PASS':'FAIL'; }
    metrics.duration_ms = Date.now()-t0;
    stagesOut.push({ id: st.id, label: st.label, status, weight: st.weight, score: Number(score.toFixed(3)), metrics, logs });
  }
  const totalScore = stagesOut.reduce((s,st)=>s+st.weight*st.score,0);
  const report = { version:'1.1.0',
    run:{ run_id: crypto.randomUUID(), started_at: now(), ended_at: now(), duration_ms: 0 },
    subject:{ module_path: process.env.XCODE_MODULE || 'examples/sample-repo', repo: process.env.GIT_REPOSITORY || '', branch: process.env.GIT_BRANCH || '', commit_sha: process.env.GIT_COMMIT || process.env.GITHUB_SHA || '' },
    environment:{ executor: process.env.XCODE_EXECUTOR || 'mono', os: process.platform, arch: process.arch, container_image: process.env.XCODE_IMAGE || '', tool_versions:{ node: process.version }},
    stages: stagesOut, aggregation:{ total_score: Number(totalScore.toFixed(3)), pass_score: passScore, pass: totalScore>=passScore },
    provenance:{ rules_version: process.env.XCODE_RULES_VERSION || 'packages/xcodebox-core/core/xcode.rules.yaml@v1.1', xcodebox_version: '1.1-mono', generated_at: now(), mcp_request_id: process.env.MCP_REQUEST_ID || '' } };
  const outPath = resolve(root,'reports','xcode_report.json'); writeFileSync(outPath, JSON.stringify(report,null,2)); console.log('Wrote '+outPath);
  if (!report.aggregation.pass){ console.error('XCodeBox: FAIL (score below pass threshold).'); process.exitCode=1; }
}
main();
