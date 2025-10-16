#!/usr/bin/env node
import http from 'node:http';
import { readFileSync, existsSync } from 'node:fs';
import { spawn } from 'node:child_process';
import { WebSocketServer } from 'ws';
import path from 'node:path';
const PORT = parseInt(process.env.PORT || '8089', 10);
const server = http.createServer((req,res)=>{
  if (req.url === '/') {
    const html = readFileSync(path.join(process.cwd(), 'packages/mcpbox-web', 'static', 'index.html'),'utf8');
    res.writeHead(200, {'Content-Type':'text/html'}); return res.end(html);
  }
  if (req.url === '/report') {
    if (existsSync('reports/xcode_report.json')) {
      const data = readFileSync('reports/xcode_report.json','utf8');
      res.writeHead(200, {'Content-Type':'application/json'}); return res.end(data);
    } else { res.writeHead(404).end('No report'); } return;
  }
  res.writeHead(404).end('Not found');
});
const wss = new WebSocketServer({ noServer: true });
wss.on('connection', (ws) => {
  ws.on('message', (raw) => {
    let msg; try { msg = JSON.parse(raw.toString()); } catch { return; }
    if (msg.method === 'xcode.validate') {
      const params = msg.params || {};
      const env = { ...process.env, XCODE_MODULE: params.module_path || 'examples/sample-repo', XCODE_RULES_FILE: params.rules_path || 'packages/xcodebox-core/core/xcode.rules.yaml' };
      const child = spawn('npx', ['tsx','packages/xcodebox-core/core/runner/xcode-runner.ts'], { env });
      child.stdout.on('data', d => ws.send(JSON.stringify({ method: 'xcode.progress', params: { chunk: d.toString() } })));
      child.stderr.on('data', d => ws.send(JSON.stringify({ method: 'xcode.progress', params: { chunk: d.toString() } })));
      child.on('close', (code) => {
        let report = null;
        try { report = JSON.parse(readFileSync('reports/xcode_report.json','utf8')); } catch {}
        ws.send(JSON.stringify({ id: msg.id || null, result: { code, report } }));
      });
    } else if (msg.method === 'ping') {
      ws.send(JSON.stringify({ id: msg.id || null, result: { ok: true } }));
    }
  });
});
server.on('upgrade', (req, sock, head) => {
  if (req.url === '/ws') wss.handleUpgrade(req, sock, head, (ws)=>wss.emit('connection', ws, req));
  else sock.destroy();
});
server.listen(8089, () => console.log(`[mcpbox:web] http://localhost:8089  (WS: /ws)`));
