
Phlox workflow in [calcit-js](https://github.com/Quamolit/phlox.calcit)
----

### Usage

使用配对的 Calcit/procs **0.30.1-alpha.4**（预发布，非正式 0.30.1）、
Node 24、Yarn 4.18.0。模块使用正式 Phlox 0.7.15、Respo 0.16.122、UI 0.7.41；
仅维护 `calcit.cirru` 和 `deps.cirru`，不提交 `js-out` 或恢复旧 Snapshot 文件。

本轮修正旧 Option 迁移遗留的两类实际行为：二维码定位图案/转置网格取出 payload，
空格子 `nil` 与越界分开判断，避免空白格被当成占用。保留 31 格默认尺寸、原图案、
移动/旋转/消行规则与键盘按键。宿主数字、开放状态中的坐标/网格改为实际解码，
不再用 `unsafe-coerce` 假装证明；异构状态和格子数据仍有显式 Dynamic。

当前完整 strict 被核心库 `contains-in?` 的泛型索引检查阻塞，已提供无依赖最小复现：
[Calcit #2143](https://github.com/calcit-lang/calcit/issues/2143)。不关闭该门禁，修复前不视为可合并。
Phlox 重绘文字问题另见 [Phlox #71](https://github.com/Phlox-GL/phlox/issues/71)，本轮不声称已修复。

PR preview assets use `pr/<number>/<run-id>/<attempt>/`. Vite and released COS Action v1.2.0
share the base URL; HTML reference and public upload verification are built into the action, without
an extra checker. Production prefixes and server deployment paths are unchanged.

```bash
caps --strict --ci
yarn install --immutable
yarn dev
```

`yarn dev` compiles initially and starts Vite. For live Calcit edits, run
`calcit calcit.cirru -w` in another terminal. `yarn build` and `yarn release` compile and build
once. CI keeps canonical formatting, strict entry/all-public checks and actual
build, without repeated migration/type-debt reports or new verification scripts.
Runs are grouped per PR and separately for production, without cancellation.
CI 执行全部定义、公共命名空间、两条针对上述行为的附带回归、完整 strict 和构建。
原项目附带测试为 0；新增的两条包含 9 个实际业务断言，覆盖空格/占用/越界、
原始格子、转置往返和无消行时保持网格，不引入独立验证脚本。

### Resources

- https://shaunlebron.github.io/t3tr0s-slides/#2

### Workflow

Workflow https://github.com/Quamolit/phlox-workflow

### License

MIT
