from fastapi import FastAPI, Request, HTTPException
import hmac, hashlib, os, json, sqlite3
SECRET=os.environ.get('MEMOBOX_WEBHOOK_SECRET','change-me').encode()
DB_PATH=os.environ.get('MEMOBOX_DB_PATH','/data/memobox.db')
app=FastAPI(title='MemoBox Memory',version='1.1-mono')
def valid(raw,sig): return hmac.compare_digest(hmac.new(SECRET,raw,hashlib.sha256).hexdigest(), sig or '')
def db(): c=sqlite3.connect(DB_PATH); c.row_factory=sqlite3.Row; return c
@app.post('/api/hooks/xcodebox')
async def ingest(req:Request):
    raw=await req.body(); sig=req.headers.get('X-XCB-Signature','')
    if not valid(raw,sig): raise HTTPException(401,'bad signature')
    data=await req.json()
    s=data.get('subject',{}); agg=data.get('aggregation',{})
    repo=s.get('repo',''); branch=s.get('branch',''); sha=s.get('commit_sha','')
    passed=1 if agg.get('pass') else 0; score=agg.get('total_score')
    con=db(); cur=con.cursor()
    cur.executescript("CREATE TABLE IF NOT EXISTS reports(id INTEGER PRIMARY KEY, repo TEXT, branch TEXT, commit_sha TEXT, pass INTEGER, score REAL, payload_json TEXT);")
    cur.execute('INSERT INTO reports(repo,branch,commit_sha,pass,score,payload_json) VALUES (?,?,?,?,?,?)',(repo,branch,sha,passed,score,json.dumps(data))); con.commit(); con.close()
    return {'ok':True}
@app.get('/api/reports')
def list_reports():
    con=db(); cur=con.cursor()
    cur.execute('SELECT id, repo, branch, commit_sha, pass, score FROM reports ORDER BY id DESC LIMIT 100')
    out=[dict(r) for r in cur.fetchall()]; con.close(); return out
@app.get('/')
def home(): return {'ok':True}
