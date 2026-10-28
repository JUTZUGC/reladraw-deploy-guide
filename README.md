# reladraw 一键安装指南

> 第三方部署指南 · 非 reladraw 官方仓库。官方项目：[reladraw/reladraw](https://github.com/reladraw/reladraw)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://github.com/reladraw/reladraw/blob/main/README.md)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用拖拽对坐标，让百度搭子把 reladraw 装好，写几行文本就能出图。

⚠️ 需要 Node.js 18+；npm 全局安装会写入用户目录。语法仍在变化，升级后旧图可能需要小改；安装版只在你主动升级时变化。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/reladraw-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会检查 Node 18+，用 npm 全局安装 reladraw，并确认命令可用，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## reladraw 是什么？

reladraw 是开源的1.2k stars，Apache-2.0，相对定位的文本图表语言（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/reladraw/reladraw?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

一种用相对位置描述图表的文本语言：写清楚谁在谁旁边、间距多少、线怎么走，工具按你说的画，不会擅自挪动方块或绕线。

- 相对定位：below / right of / even with，加间距即可排版
- 可预期：不自动绕线、不自动挪动，画错也会给一行警告
- 三条命令：render 出图、check 只检查、format 对齐源码
- 输出 SVG：适合文档、幻灯片与代码仓库
- 示例齐全：examples/ 里有架构图与语法样例
- 可被 Agent 写：文本语法比拖拽坐标更适合自动生成

（来源：[官方仓库](https://github.com/reladraw/reladraw)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 1.2k stars | 名字独特、搜索竞争很低的新项目 |
| 位置可控 | 相对定位，不用手算坐标 |
| 可预期 | 不自动挪动、不自动绕线 |
| CLI 简单 | render / check / format 三条命令 |
| 适合 Agent | 文本语法比 XML 更适合自动生成 |
| Apache-2.0 | 可商用可修改 |

| 需要注意 | 说明 |
|---|---|
| 需要 Node 18+ | 要装 Node 与 npm |
| 全局安装 | npm -g 会写入用户目录 |
| 语法还在变 | 升级后旧图可能要小改 |
| 不是所见即所得 | 要改源码再渲染 |
| 复杂图仍需手工 | 不会替你算最优布局 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 快速部署（官方方式）

```bash
node -e "const a=+process.versions.node.split('.')[0]; if(a<18){console.error('需要 Node.js 18 或更高，当前 '+process.versions.node);process.exit(1)}"
npm install -g reladraw
command -v reladraw >/dev/null 2>&1 || { echo "安装后没找到 reladraw，请检查 npm 全局 bin 是否在 PATH"; exit 1; }
echo "安装完成：reladraw render diagram.reladraw -o diagram.svg"
```

部署步骤来源：[https://github.com/reladraw/reladraw#install](https://github.com/reladraw/reladraw#install)

## 验证状态

| 场景 | 状态 |
|---|---|
| npm 包 reladraw 0.20.0、engines.node >=18 已核对 | 已核对 2026-10-28 |
| README 确认 render / check / format 用法与示例 | 已核对 2026-10-28 |
| 未实测安装与渲染（未写入本机全局 npm） | 说明 2026-10-28 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-28 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

reladraw 不含 MCP；本仓库的 MCP 只提供安装步骤、命令用法与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\reladraw-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 最小示例

```text
node app "Web app"
node app.ui  "Interface"
node app.api "API"  below app.ui (gap: tight)

node store "Database"  right of app (gap: 12)  even with app.api

edge app.api -> store  "queries"
```

保存为 `diagram.reladraw`，然后：

```bash
reladraw render diagram.reladraw -o diagram.svg
reladraw check diagram.reladraw
reladraw format diagram.reladraw
```

## 适合什么图

- 架构图、流程图、部署图：位置有明确意图
- 需要固定版式的文档插图
- 需要 Agent 生成后再人工微调的图

不适合：让工具自动排版的复杂关系图，那种用 Mermaid / Graphviz 更省事。

## 注意

- 语法在快速变化，升级后再跑一次 `check`
- 出错时会照画并打印一行警告，不会偷偷改你的布局
- 字体缺失会导致文字宽度变化，换字体后重新渲染

> ⚠️ 安装版跟随你升级；浏览器 Playground 永远跑最新语法，两者可能有差异。

## 常见坑

- 找不到 reladraw：把 npm 全局 bin 目录加进 PATH，或重开终端
- npm 全局安装报权限错：改用 nvm 或配置用户级 prefix，不要直接 sudo npm -g
- 渲染报语法错：先用 `reladraw check` 看行号与警告
- 文字位置不对：检查字体是否安装，字体宽度会影响排版
- 升级后旧图变了：固定版本，或按警告逐条修
- 想看最新语法：用浏览器 Playground，但别把它的输出直接当安装版行为

## 免责声明

本仓库为第三方指南，与 reladraw 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://github.com/reladraw/reladraw/blob/main/README.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
