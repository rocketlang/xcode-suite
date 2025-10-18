Awesome — here’s your **deep, step-by-step usage guide** for XCodeBox v3.4.1 in Termux/proot. It’s written so you can copy-paste commands directly.
 
# XCodeBox v3.4.1 — Deep Usage Guide (Termux / proot)
 
## 0) One-time prep (recommended)
 
Make the alias auto-load in every new shell:
 `echo "source ~/.proot_aliases_xcode" >> ~/.bashrc ` 
Open a new shell or run:
 `source ~/.proot_aliases_xcode xhook --help `  
## 1) Scan your Termux home (safe first, then full)
 
### Quick discovery (fast, low I/O)
 `xhook hook:run --target /data/data/com.termux/files/home --steps preScan,scan ` 
### Full scan with reporting
 `xhook hook:run --target /data/data/com.termux/files/home --steps preScan,scan,enrich,report ` 
### See results
 `ls -lt /root/xcode/xcodesuite-mono-v1.1/reports | head ` 
If you created the minimal discovery script earlier, you may see `scan_result.txt`; otherwise, your plugins decide what artifacts appear (JSON/HTML).
 
 
⚠️ If you get “permission denied”, you’re likely blocked from reading `/data/data/*`. Options:
 
 
- Run from proot **as root** (you are).
 
- Copy a subset to a readable folder and scan that (see §3 “Scan a specific project directory”).
 

 
  
## 2) Scan a GitHub repository
 
### Public repo (no token)
 `xhook hook:run --target github:rocketlang/reflexia --steps preScan,scan,enrich,report ` 
### Private repo (with token)
 
Set your token (temporary for the current shell):
 `export GITHUB_TOKEN=ghp_yourPersonalAccessToken xhook hook:run --target github:yourorg/yourrepo@main --steps preScan,scan,enrich,report ` 
 
The repo is cloned into a temp working dir and scanned; artifacts are written to: `/root/xcode/xcodesuite-mono-v1.1/reports`.
 
  
## 3) Scan a specific local project directory
 
Pick a path and go:
 `xhook hook:run --target /root/reflexia --steps preScan,scan,enrich,report ` 
If you want to scan a **subset of Termux** without permissions drama:
 `mkdir -p /root/termux_copy cp -a /data/data/com.termux/files/home/myproject /root/termux_copy/ xhook hook:run --target /root/termux_copy/myproject --steps preScan,scan,enrich,report `  
## 4) Choose which stages to run (fine-grained control)
 
 
- **Discovery only** (quick): `preScan,scan`
 
- **Analysis only** (assumes discovery context ready): `enrich`
 
- **Reporting only** (assumes results exist): `report`
 
- **Everything** (default): `preScan,scan,enrich,report,post`
 

 
Example:
 `xhook hook:run --target /root/xcode --steps preScan,scan xhook hook:run --target /root/xcode --steps enrich,report `  
## 5) Where files live (know your paths)
 
 
-  
Suite root: `/root/xcode/xcodesuite-mono-v1.1/`
 
 
-  
CLI binary (what `xhook` points to): `/root/xcode/xcodesuite-mono-v1.1/packages/xcodebox-core/bin/xcode`
 
 
-  
Plugins (core): `/root/xcode/xcodesuite-mono-v1.1/packages/xcodebox-core/src/plugins/`
 
 
-  
Plugins (user-added, auto-loaded): `/root/xcode/xcodebox.plugins/`
 
 
-  
Reports (artifacts): `/root/xcode/xcodesuite-mono-v1.1/reports/`
 
 
-  
Health tools: `/root/xcode/xcode-tools/doctor.sh` `/root/xcode/xcode-tools/verify.sh`
 
 

  
## 6) Write your own plugin (most powerful part)
 
Create a file under `/root/xcode/xcodebox.plugins/`:
 `mkdir -p /root/xcode/xcodebox.plugins nano /root/xcode/xcodebox.plugins/sample-metrics.js ` 
Paste:
 `const fs = require('fs'); const path = require('path');  module.exports = {   name: 'sample-metrics',   supports: ['enrich','report'],   async run(hook, ctx) {     if (!ctx.resolved) return ctx;      // 1) during enrich: add simple metrics     if (hook === 'enrich') {       ctx.sample = { filesSeen: 0 };       try {         const walk = dir => {           for (const f of fs.readdirSync(dir)) {             const p = path.join(dir, f);             try {               const s = fs.statSync(p);               if (s.isDirectory()) walk(p);               else ctx.sample.filesSeen++;             } catch {}           }         };         walk(ctx.resolved.path);       } catch {}       return ctx;     }      // 2) during report: write a JSON artifact     if (hook === 'report') {       const outDir = '/root/xcode/xcodesuite-mono-v1.1/reports';       fs.mkdirSync(outDir, { recursive: true });       const out = path.join(outDir, 'sample_metrics.json');       fs.writeFileSync(out, JSON.stringify({         target: ctx.resolved.path,         metrics: ctx.sample || {}       }, null, 2));       ctx.artifacts = Object.assign({}, ctx.artifacts, { sample_metrics: out });       console.log('[sample-metrics] wrote', out);       return ctx;     }      return ctx;   } }; ` 
Run it:
 `xhook hook:run --target /root/xcode --steps preScan,enrich,report cat /root/xcode/xcodesuite-mono-v1.1/reports/sample_metrics.json `  
## 7) Batch scanning (many paths in one go)
 
Create a simple loop (example list):
 `cat > /root/xcode/targets.txt <<'TXT' /root/reflexia /root/xcode github:rocketlang/reflexia TXT  while read -r target; do   [ -z "$target" ] && continue   echo "==> Scanning $target"   xhook hook:run --target "$target" --steps preScan,scan,enrich,report done < /root/xcode/targets.txt `  
## 8) Performance & safety tips
 
 
- **Start small**: run `--steps preScan,scan` first to avoid long I/O on giant trees.
 
- **Exclude big dirs**: clone/copy only what you want to analyze; current core doesn’t have ignore globs—use targeted paths.
 
- **Node version**: keep ≥ 18 (you are on v20.17.0, good).
 
- **GitHub rate limits**: set `GITHUB_TOKEN` for private repos and fewer 429s.
 
- **Storage**: reports and clones consume space; clean temp dirs if you add that in a future plugin.
 

  
## 9) Diagnostics & recovery
 
Health check:
 `bash /root/xcode/xcode-tools/doctor.sh check ` 
Self-check (works even if alias didn’t load):
 `bash /root/xcode/xcode-tools/verify.sh ` 
Reload alias if needed:
 `source ~/.proot_aliases_xcode ` 
Reinstall/repair dependency (only if asked by doctor):
 `cd /root/xcode/xcodesuite-mono-v1.1/packages/xcodebox-core npm install js-yaml ` 
Common errors:
 
 
- `xhook: command not found` → `source ~/.proot_aliases_xcode`
 
- `MODULE_NOT_FOUND ... src/cli/xcode-hooks.js` → ensure bin wrapper points up **one** level to `.../packages/xcodebox-core/src/cli/xcode-hooks.js`
 
- `Node >=18 required` → install/upgrade Node
 

  
## 10) Handy aliases (optional)
 
Add short forms:
 `cat >> ~/.proot_aliases_xcode <<'ALIAS' alias xh='xhook' alias xhscan='xhook hook:run --target' ALIAS source ~/.proot_aliases_xcode ` 
Use:
 `xh --help xhscan /root/xcode --steps preScan,scan `  
### That’s it 🎉
 
You now have everything to scan:
 
 
- **Termux home**
 
- **Any local project**
 
- **GitHub repos** …and to **extend** XCodeBox with your own plugins and reports.
 

 
If you tell me the **exact folder** you want scanned first, I’ll give you a single, copy-paste command and the exact report file to open afterward.
