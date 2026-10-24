
Phlox workflow in [calcit-js](https://github.com/Quamolit/phlox.calcit)
----

### Usage

使用配对的正式 Calcit/procs **0.30.1**、Node 24、Yarn 4.18.0。
模块使用正式 Phlox 0.7.18、Respo 0.16.126、UI 0.8.1；
仅维护 `calcit.cirru` 和 `deps.cirru`，不提交 `js-out` 或恢复旧 Snapshot 文件。
更新后重新解析完整模块依赖并生成 JS，不混用旧缓存；传递依赖使用正式
Touch Control 0.0.33、Pointed Prompt 0.0.21、Router 0.8.38 和 js-ffi 0.2.6。

上轮修正旧 Option 迁移遗留的两类实际行为：二维码定位图案/转置网格取出 payload，
空格子 `nil` 与越界分开判断，避免空白格被当成占用。保留 31 格默认尺寸、原图案、
移动/旋转/消行规则与键盘按键。宿主数字、开放状态中的坐标/网格改为实际解码，
不再用 `unsafe-coerce` 假装证明；异构状态和格子数据仍有显式 Dynamic。

alpha.4 的核心 `contains-in?` 泛型索引问题已由上游修复并随配对 alpha.5 发布，见
[Calcit #2143](https://github.com/calcit-lang/calcit/issues/2143)。alpha.5 下完整 strict、全部179/179
定义、公共34/34定义、原有2/2附带回归和JS/Vite构建通过，没有改应用源码或绕过门禁。
上轮实际浏览器二维码图案、持续tick及键盘落块后的渲染通过，未见控制台warning/error；不代表所有
消行场景、浏览器或其他Phlox消费者已经验收。干净安装和上传结果仍以PR最新提交CI为准。
Phlox 重绘文字问题另见 [Phlox #71](https://github.com/Phlox-GL/phlox/issues/71)，本轮不声称已修复。

本轮配对正式依赖图，52 处内部 `option:unwrap-or` 改为公开 `.unwrap-or`
（含一处旧注释），保留 nil/空列表/环境变量 fallback，不重复修改落块与消行算法。
原附着测试中的另外两处内部 Option 调用也同步迁移，九个断言和预期值不变。
`middle-idx` 明确为 Number，直接使用已检查的 Number grid-size，不再做无必要的宿主转换。
`hud!` 页面报错和成功提示保留。沿用两条原附着回归，不加脚本、强转或测试框架。
Actions 使用精确正式 tag，接受 tag 可移动风险；本轮正式 CI/原入口验收不以旧 alpha 结果代替。

继续迁移 20 处旧写法：10 处内部 `option:unwrap` 改为 `.unwrap`，7 处 List 计数
（含原附带测试一处）改为 `.len`，2 处 `foldl` 和 1 处同签名 `reduce` 改为 `.foldl`。
保留原参数、初始值和左折叠顺序、Set 累积及落块/消行算法；两条测试的名称、九个断言和预期不变。
同步已发布的正式依赖图，不改变 31 格尺寸、按键、nil/越界、重置和刷新合同，
不新增验证脚本、包装器、类型预算或编译器改写规则。

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
