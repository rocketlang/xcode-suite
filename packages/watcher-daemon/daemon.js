#!/usr/bin/env node
import chokidar from 'chokidar'; import { spawn } from 'node:child_process'; import fs from 'node:fs'; import path from 'node:path';
const ROOT=process.env.XBOX_WATCH_ROOT || './examples';
const WS_URL=process.env.XBOX_MCP_WS || 'ws://localhost:8089/ws';
function isRepo(dir){ return fs.existsSync(path.join(dir,'.git')) || fs.existsSync(path.join(dir,'package.json')) || fs.existsSync(path.join(dir,'pyproject.toml')); }
async function trigger(modulePath){
  try{ const WS=(await import('ws')).default; const ws=new WS(WS_URL);
    ws.on('open',()=>ws.send(JSON.stringify({jsonrpc:'2.0',id:Date.now(),method:'xcode.validate',params:{module_path:modulePath}})));
    ws.on('message',(m)=>process.stdout.write('[mcp] '+m.toString()+'\\n'));
    ws.on('error',()=>fallback(modulePath));
  }catch{ fallback(modulePath); }
}
function fallback(modulePath){
  const env={...process.env,XCODE_MODULE:modulePath,XCODE_RULES_FILE:'packages/xcodebox-core/core/xcode.rules.yaml'};
  const c=spawn('npx',['tsx','packages/xcodebox-core/core/runner/xcode-runner.ts'],{env,stdio:'inherit'});
  c.on('close',code=>console.log('local run exit',code));
}
console.log('Watching',ROOT);
const seen=new Set();
const w=chokidar.watch(ROOT,{ignoreInitial:false,depth:3,ignored:/(^|[\\/])\\./});
w.on('addDir',(p)=>{ if(!seen.has(p)&&isRepo(p)){ seen.add(p); console.log('repo:',p); trigger(p); } });
w.on('change',(p)=>{ const dir=path.dirname(p); if(isRepo(dir)&&!seen.has(dir)){ seen.add(dir); console.log('change in repo:',dir); trigger(dir); } });
