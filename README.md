
Phlox workflow in [calcit-js](https://github.com/Quamolit/phlox.calcit)
----

### Usage

Use Calcit/procs 0.27.0 with canonical `calcit.cirru` and `deps.cirru`;
CI rejects retired `compact.cirru` and `package.cirru`. Config strings and the
development flag have explicit types; existing open boundaries remain.

PR preview assets use `pr/<number>/<run-id>/`. Vite and COS Action v1.1.1
share the base URL; upload verification is built into the action, without
an extra checker. Production prefixes and server deployment paths are unchanged.

```bash
yarn
calcit calcit.cirru js
yarn vite
```

### Resources

- https://shaunlebron.github.io/t3tr0s-slides/#2

### Workflow

Workflow https://github.com/Quamolit/phlox-workflow

### License

MIT
