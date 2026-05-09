%!TEX root = notice-example
\NeedsTeXFormat{LaTeX2e}[2025-11-01]
\ProvidesExplClass
	{govdoc}
	{2026/05/08}
	{0.2.0}
	{LaTeX3 class for Chinese government notice documents}

\msg_new:nnn { govdoc } { need-xetex }
	{ 使用~XeLaTeX~编译~govdoc~模板。 }

\sys_if_engine_xetex:F
	{
		\msg_fatal:nn { govdoc } { need-xetex }
		\msg_line_context:
	}

\keys_define:nn { govdoc / format }
	{
		font .tl_set:N = \l_govdoc_format_font_tl,
		font .initial:n = { 仿宋 },
		titlefont .tl_set:N = \l_govdoc_format_titlefont_tl,
		titlefont .initial:n = { 华文中宋 },
	}

\ProcessKeyOptions [ govdoc / format ]

\LoadClass [ UTF8, a4paper, twoside  ] { ctexart }

\RequirePackage { fontspec }
\RequirePackage { geometry }
\RequirePackage { xcolor }
\RequirePackage { fancyhdr }

\exp_args:NV \setCJKmainfont \l_govdoc_format_font_tl
\exp_args:NNV \newCJKfontfamily \govdoc_titlefont: \l_govdoc_format_titlefont_tl

\geometry
	{
		paper = a4paper,
		left = 28mm,
		top = 37mm,
		textwidth = 156mm,
		textheight = 225mm,
		headheight = 0pt,
		headsep = 0pt,
		footskip = 10mm,
	}

\definecolor { govdocred } { RGB } { 196, 0, 0 }

\tl_new:N \l_govdoc_info_office_tl
\tl_new:N \l_govdoc_info_mark_tl
\tl_new:N \l_govdoc_info_doc_number_tl
\tl_new:N \l_govdoc_info_title_tl
\tl_new:N \l_govdoc_info_recipient_tl
\tl_new:N \l_govdoc_info_date_tl
\tl_new:N \l_govdoc_info_note_tl
\tl_new:N \l_govdoc_info_signer_tl

\keys_define:nn { govdoc / info }
	{
		office       .tl_set:N = \l_govdoc_info_office_tl,
		mark         .tl_set:N = \l_govdoc_info_mark_tl,
		doc-number   .tl_set:N = \l_govdoc_info_doc_number_tl,
		title        .tl_set:N = \l_govdoc_info_title_tl,
		recipient    .tl_set:N = \l_govdoc_info_recipient_tl,
		date         .tl_set:N = \l_govdoc_info_date_tl,
		note         .tl_set:N = \l_govdoc_info_note_tl,
		signer       .tl_set:N = \l_govdoc_info_signer_tl,
	}

\tl_const:Nn \g_govdoc_mark_format_tl
	{ \color { govdocred } \govdoc_titlefont: \fontsize { 24bp } { 32bp } \selectfont }
\tl_const:Nn \g_govdoc_doc_number_format_tl
	{ \normalfont \zihao { 3 } }
\tl_const:Nn \g_govdoc_title_format_tl
	{ \govdoc_titlefont: \zihao { 2 } }
\tl_const:Nn \g_govdoc_body_format_tl
	{ \normalfont \zihao { 3 } }
\tl_const:Nn \g_govdoc_imprint_format_tl
	{ \normalfont \zihao { 4 } }
\dim_const:Nn \g_govdoc_body_baselineskip_dim { 28.95pt }

\cs_new:Npn \govdoc_tl_if_blank_p:N #1
	{ \exp_args:NV \tl_if_blank_p:n #1 }

\cs_new_protected:Npn \govdoc_tl_if_blank:NTF #1#2#3
	{ \exp_args:NV \tl_if_blank:nTF #1 {#2} {#3} }

\fancypagestyle { govdoc }
	{
		\fancyhf {}
		\renewcommand { \headrulewidth } { 0pt }
		\renewcommand { \footrulewidth } { 0pt }
		\fancyfoot [ RO ] { { \normalfont \zihao { 4 } -~\thepage~- } \skip_horizontal:n { 1em } }
		\fancyfoot [ LE ] { \skip_horizontal:n { 1em } { \normalfont \zihao { 4 } -~\thepage~- } }
	}

\cs_new_protected:Npn \govdoc_body_font:
	{
		\g_govdoc_body_format_tl
		\skip_set:Nn \baselineskip { \g_govdoc_body_baselineskip_dim }
	}

\cs_new_protected:Npn \govdoc_use_mark:
	{
		\govdoc_tl_if_blank:NTF \l_govdoc_info_mark_tl
			{ \tl_use:N \l_govdoc_info_office_tl }
			{ \tl_use:N \l_govdoc_info_mark_tl }
	}

\cs_new_protected:Npn \govdoc_use_signer:
	{
		\govdoc_tl_if_blank:NTF \l_govdoc_info_signer_tl
			{ \tl_use:N \l_govdoc_info_office_tl }
			{ \tl_use:N \l_govdoc_info_signer_tl }
	}

\cs_new_protected:Npn \govdoc_make_head:
	{
		\thispagestyle { govdoc }
		\skip_vertical:n { 30mm }
		\group_begin:
			\centering
			{ \g_govdoc_mark_format_tl \govdoc_use_mark: \par }
			\skip_vertical:n { 1.5 \baselineskip }
			{ \g_govdoc_doc_number_format_tl \tl_use:N \l_govdoc_info_doc_number_tl }
			\skip_vertical:n { -7mm }
			{ \color { govdocred } \rule { \textwidth } { 0.35mm } \par }
		\group_end:
		\skip_vertical:n { 1.5 \baselineskip }
	}

\cs_new_protected:Npn \govdoc_make_title:
	{
		\group_begin:
			\centering
			{ \g_govdoc_title_format_tl \tl_use:N \l_govdoc_info_title_tl \par }
		\group_end:
		\skip_vertical:n { \baselineskip }
		\govdoc_tl_if_blank:NTF \l_govdoc_info_recipient_tl
			{ }
			{ \noindent \tl_use:N \l_govdoc_info_recipient_tl ：\par }
	}

\cs_new_protected:Npn \govdoc_make_signature:
	{
		\par \skip_vertical:n { \baselineskip }
		\noindent
		\hfill
		\begin { minipage } { 0.58 \textwidth }
			\centering
			\govdoc_use_signer: \par
			\tl_use:N \l_govdoc_info_date_tl \par
		\end { minipage }
		\par
	}

\DeclareDocumentCommand { \govdocinfo } { m }
	{ \keys_set:nn { govdoc / info } { #1 } }

\DeclareDocumentCommand { \makegovdochead } { }
	{ \govdoc_make_head: }

\DeclareDocumentCommand { \makegovdoctitle } { }
	{ \govdoc_make_title: }

\DeclareDocumentCommand { \makegovdocsignature } { }
	{ \govdoc_make_signature: }

\AtBeginDocument
	{
		\pagestyle { govdoc }
		\govdoc_body_font:
		\dim_set:Nn \parindent { 2\ccwd }
		\skip_set:Nn \parskip { 0pt }
	}
