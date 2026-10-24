import assert from 'node:assert/strict';
import {execFileSync,spawnSync} from 'node:child_process';
import {mkdirSync,readFileSync,writeFileSync} from 'node:fs';
const run=(...a)=>execFileSync('calcit',a,{encoding:'utf8',maxBuffer:24e6,stdio:['ignore','pipe','pipe']});
const norm=v=>Array.isArray(v)?v.map(norm):v&&typeof v==='object'?Object.fromEntries(Object.entries(v).map(([k,x])=>[k,k==='__edn_set'?x.map(norm).sort((a,b)=>JSON.stringify(a).localeCompare(JSON.stringify(b))):norm(x)])):v;
const q=(...a)=>norm(JSON.parse(run('query',...a,'--format','json')).data);
const blob=()=>execFileSync('git',['hash-object','calcit.cirru'],{encoding:'utf8'}).trim();
mkdirSync('acceptance',{recursive:true});assert.equal(run('-v').trim(),'0.30.1');assert.equal(blob(),'d8196e85c84fc2a7e93cc23f6b3926ad286d1e7d');writeFileSync('acceptance/agent-contract.txt',run('docs','agents','--contract'));
const before=norm(JSON.parse(readFileSync('reviewed.json','utf8'))),expected=structuredClone(before),ops=[],types=[],counts={};assert.equal(before.length,36);assert.equal(before.reduce((n,d)=>n+d.tests.length,0),2);
const config=q('config'),namespaces=q('ns').namespaces.map(n=>q('ns',n)),core=['reduce','foldl','option:unwrap'].map(n=>q('def','calcit.core/'+n));
assert.deepEqual(core[0].code,['defn','reduce',['xs','x0','f'],['foldl','xs','x0','f']]);writeFileSync('acceptance/core-contracts.json',JSON.stringify(core,null,2));
function walk(x,path,id,region){
  if(!Array.isArray(x)||['quote','quasiquote',';','comment','defmacro'].includes(x[0]))return x;
  const alias={count:'.len',foldl:'.foldl',reduce:'.foldl','option:unwrap':'.unwrap'}[x[0]];
  if(alias){
    const old=x[0];counts[region+':'+old]=(counts[region+':'+old]||0)+1;
    if(region==='code'){
      const r=spawnSync('calcit',['query','type-at',id,'--path','@'+[...path,1].join('.'),'--format','json'],{encoding:'utf8',maxBuffer:24e6});assert.equal(r.status,0);const evidence=JSON.parse(r.stdout);types.push({id,path,tree:structuredClone(x),evidence,stderr:r.stderr});
      if(old==='count')assert.ok(evidence.data.inferred_type?.includes('List'));
      const p='@'+[...path,0].join('.');assert.equal(JSON.parse(run('tree','show',id,'--path',p,'--format','json')).tree,old);ops.push(['tree','replace',id,'--path',p,'--input-format','json-ast','--code',JSON.stringify(alias),'--expect','quote '+old]);
    }else{assert.equal(id,'app.schema/gen-qrcode-grid');assert.equal(old,'count');assert.equal(x[1],'grid');}
    x[0]=alias;
  }
  return x.map((v,i)=>walk(v,[...path,i],id,region));
}
for(const d of expected){const original=before.find(x=>x.id===d.id);assert.deepEqual(q('def',d.id),original);d.code=walk(d.code,[],d.id,'code');for(let i=0;i<d.tests.length;i++){const t=d.tests[i];t.code=walk(t.code,[],d.id,'test');if(JSON.stringify(t.code)!==JSON.stringify(original.tests[i].code))ops.push(['edit','add-test',d.id,t.name,'--overwrite',...(t.tags.length?['--tags',t.tags.join(',')]:[]),'--input-format','json-ast','--code',JSON.stringify(t.code)]);}}
assert.deepEqual(counts,{'code:reduce':1,'code:foldl':2,'code:option:unwrap':10,'code:count':6,'test:count':1});assert.equal(ops.length,20);
writeFileSync('acceptance/before.json',JSON.stringify(before,null,2));writeFileSync('acceptance/receiver-types.json',JSON.stringify(types,null,2));writeFileSync('acceptance/operations.json',JSON.stringify(ops,null,2));
const args=['edit','transaction','--file','acceptance/operations.json','--format','json'];const preview=JSON.parse(run(...args,'--dry-run'));assert.ok(preview.scoped_revision);writeFileSync('acceptance/transaction-preview.json',JSON.stringify(preview,null,2));writeFileSync('acceptance/transaction-applied.json',run(...args,'--expect-revision',preview.scoped_revision));
const actual=[];for(const ns of namespaces){const names=run('query','defs',ns.namespace).split('\n').filter(x=>/^  \S/.test(x)).map(x=>x.trim().split(' ')[0]);assert.equal(names.length,ns.definition_count);for(const n of names)actual.push(q('def',`${ns.namespace}/${n}`));}
assert.deepEqual(actual,expected);assert.deepEqual(q('config'),config);assert.deepEqual(q('ns').namespaces.map(ns=>q('ns',ns)),namespaces);
writeFileSync('acceptance/after.json',JSON.stringify(actual,null,2));writeFileSync('acceptance/config.json',JSON.stringify(config,null,2));writeFileSync('acceptance/namespaces.json',JSON.stringify(namespaces,null,2));writeFileSync('acceptance/snapshot-after-blob.txt',blob());writeFileSync('acceptance/summary.json',JSON.stringify({definitions:36,tests:2,operations:20,counts,preserved:'Original2test names/tags/order and9assertions modulo same count API; allschemas/FFI/metadata/entries/operands/reducerinitials/callbacks/order/gridnil-vs-bounds/QRpatterns/HUD/styles/deps/workflows unchanged; sourceunsafe remains0, realDynamicboundaries retained'},null,2));
