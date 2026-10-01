
Phlox workflow in [calcit-js](https://github.com/Quamolit/phlox.calcit)
----

### Usage

Use Calcit/procs 0.27.0 with canonical `calcit.cirru` and `deps.cirru`;
CI rejects retired `compact.cirru` and `package.cirru`. Config strings and the
development flag have explicit types; existing open boundaries remain.

PR preview assets use `pr/<number>/<run-id>/<attempt>/`. Vite and COS Action v1.1.1
share the base URL; upload verification is built into the action, without
an extra checker. Production prefixes and server deployment paths are unchanged.

```bash
caps --ci
yarn install --immutable
yarn dev
```

`yarn dev` compiles initially and starts Vite. For live Calcit edits, run
`calcit calcit.cirru js -w` in another terminal. `yarn build` and `yarn release` compile and build
once. CI keeps canonical formatting, strict entry/all-public checks and actual
build, without repeated migration/type-debt reports or new verification scripts.
Runs are grouped per PR and separately for production, without cancellation.
QR generation and drawing business source are unchanged.

### Resources

- https://shaunlebron.github.io/t3tr0s-slides/#2

### Workflow

Workflow https://github.com/Quamolit/phlox-workflow

### License

MIT
