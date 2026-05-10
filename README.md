# officedoc.cls

## 文件

- `officedoc.cls`：公文通知类文件。
- `example.tex`：最小可用通知示例。

## 编译

```bash
xelatex example.tex
```

## 基本用法

```latex
\documentclass{officedoc}

\officedocinfo{
	mark         = {发文机关名称文件},
	office       = {发文机关名称},
	doc-prefix   = {机关代字},
	doc-year     = {年份},
	doc-sequence = {顺序号},
	title        = {公文标题},
	recipient    = {主送机关},
	date         = {成文日期}
}

\begin{document}
\makeofficedochead
\makeofficedoctitle

正文内容。

\makeofficedocsignature
\end{document}
```

`doc-prefix`、`doc-year` 和 `doc-sequence` 会自动排成“机关代字〔年份〕顺序号号”。`recipient` 不需要写末尾冒号；模板会自动补全全角冒号。附件说明、附注和版记按普通正文手写即可。

## 标题字体

模板默认正文字体为 `仿宋`，默认标题字体为 `华文中宋`。

可以通过类选项覆盖正文和标题字体：

```latex
\documentclass[
	titlefont={方正小标宋简体}
	font={仿宋_GB2312},
]{officedoc}
```