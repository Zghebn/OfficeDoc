%!TEX root = notice-example
\NeedsTeXFormat{LaTeX2e}[2025-11-01]
\ProvidesExplClass
	{govdoc}
	{2026/05/08}
	{0.2.0}
	{LaTeX3 class for Chinese government notice documents}

\msg_new:nnn { govdoc } { need-xetex }
	{ 使用~XeLaTeX~编译~govdoc~模板。 }
\msg_new:nnnn { govdoc } { title-font-missing }
	{ 标题字体~`#1'~不存在。 }
	{ 请安装该字体，或使用~\string\documentclass[titlefont=...]{govdoc}~指定可用字体。 }

\sys_if_engine_xetex:F
	{
		\msg_fatal:nn { govdoc } { need-xetex }
		\msg_line_context:
	}

\keys_define:nn { govdoc / format }
	{
		titlefont .tl_set:N = \l_govdoc_format_titlefont_tl,
		titlefont .initial:n = { 华文中宋 ~ Bold },
	}

\ProcessKeyOptions [ govdoc / format ]

\LoadClass [ UTF8, a4paper, twoside, fontset = none ] { ctexart }

\RequirePackage { fontspec }
\RequirePackage { geometry }
\RequirePackage { xcolor }
\RequirePackage { fancyhdr }

\tl_const:Nn \c_govdoc_user_font_path_tl
	{ /Users/zghebn/Library/Fonts/ }

\cs_new_protected:Npn \govdoc_setup_cjk_fonts:
	{
		\setCJKmainfont { simsun.ttc }
			[
				Path = \c_govdoc_user_font_path_tl,
				BoldFont = simhei.ttf,
				ItalicFont = simkai.ttf,
			]
		\setCJKsansfont { simhei.ttf }
			[ Path = \c_govdoc_user_font_path_tl ]
		\setCJKmonofont { simfang.ttf }
			[ Path = \c_govdoc_user_font_path_tl ]
		\setCJKfamilyfont { zhsong } { simsun.ttc }
			[ Path = \c_govdoc_user_font_path_tl ]
		\setCJKfamilyfont { zhhei } { simhei.ttf }
			[ Path = \c_govdoc_user_font_path_tl ]
		\setCJKfamilyfont { zhfs } { simfang.ttf }
			[ Path = \c_govdoc_user_font_path_tl ]
		\setCJKfamilyfont { zhkai } { simkai.ttf }
			[ Path = \c_govdoc_user_font_path_tl ]
		\cs_set_protected:Npn \songti { \CJKfamily { zhsong } }
		\cs_set_protected:Npn \heiti { \CJKfamily { zhhei } }
		\cs_set_protected:Npn \fangsong { \CJKfamily { zhfs } }
		\cs_set_protected:Npn \kaishu { \CJKfamily { zhkai } }
	}

\govdoc_setup_cjk_fonts:

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

\tl_new:N \l_govdoc_info_issuer_tl
\tl_new:N \l_govdoc_info_mark_tl
\tl_new:N \l_govdoc_info_doc_number_tl
\tl_new:N \l_govdoc_info_title_tl
\tl_new:N \l_govdoc_info_recipient_tl
\tl_new:N \l_govdoc_info_date_tl
\tl_new:N \l_govdoc_info_note_tl
\tl_new:N \l_govdoc_info_print_office_tl
\tl_new:N \l_govdoc_info_print_date_tl
\tl_new:N \l_govdoc_info_attachment_tl
\tl_new:N \l_govdoc_info_signer_tl

\keys_define:nn { govdoc / info }
	{
		issuer       .tl_set:N = \l_govdoc_info_issuer_tl,
		mark         .tl_set:N = \l_govdoc_info_mark_tl,
		doc-number   .tl_set:N = \l_govdoc_info_doc_number_tl,
		title        .tl_set:N = \l_govdoc_info_title_tl,
		recipient    .tl_set:N = \l_govdoc_info_recipient_tl,
		date         .tl_set:N = \l_govdoc_info_date_tl,
		note         .tl_set:N = \l_govdoc_info_note_tl,
		print-office .tl_set:N = \l_govdoc_info_print_office_tl,
		print-date   .tl_set:N = \l_govdoc_info_print_date_tl,
		attachment   .tl_set:N = \l_govdoc_info_attachment_tl,
		attachments  .tl_set:N = \l_govdoc_info_attachment_tl,
		signer       .tl_set:N = \l_govdoc_info_signer_tl,
	}

\tl_const:Nn \g_govdoc_mark_format_tl
	{ \color { govdocred } \govdoc_titlefont: \fontsize { 24bp } { 32bp } \selectfont }
\tl_const:Nn \g_govdoc_doc_number_format_tl
	{ \fangsong \zihao { 3 } }
\tl_const:Nn \g_govdoc_title_format_tl
	{ \govdoc_titlefont: \zihao { 2 } }
\tl_const:Nn \g_govdoc_body_format_tl
	{ \fangsong \zihao { 3 } }
\tl_const:Nn \g_govdoc_imprint_format_tl
	{ \fangsong \zihao { 4 } }
\dim_const:Nn \g_govdoc_body_baselineskip_dim { 28.95pt }

\cs_new:Npn \govdoc_tl_if_blank_p:N #1
	{ \exp_args:NV \tl_if_blank_p:n #1 }

\cs_new_protected:Npn \govdoc_tl_if_blank:NTF #1#2#3
	{ \exp_args:NV \tl_if_blank:nTF #1 {#2} {#3} }

\cs_new:Npn \govdoc_page_number:n #1
	{ { \songti \zihao { 4 } -~#1~- } }

\fancypagestyle { govdoc }
	{
		\fancyhf {}
		\renewcommand { \headrulewidth } { 0pt }
		\renewcommand { \footrulewidth } { 0pt }
		\fancyfoot [ RO ] { \govdoc_page_number:n { \thepage } \skip_horizontal:n { 1em } }
		\fancyfoot [ LE ] { \skip_horizontal:n { 1em } \govdoc_page_number:n { \thepage } }
	}

\cs_new_protected:Npn \govdoc_setup_title_font:
	{
		\str_case_e:nnF { \tl_to_str:N \l_govdoc_format_titlefont_tl }
			{
				{ STZhongsong } { \govdoc_setup_title_font_file:n { STZHONGS.TTF } }
				{ STZHONGS.TTF } { \govdoc_setup_title_font_file:n { STZHONGS.TTF } }
				{ 华文中宋 } { \govdoc_setup_title_font_file:n { STZHONGS.TTF } }
				{ SourceHanSerifSC } { \govdoc_setup_title_font_file:n { SourceHanSerifSC-Regular.otf } }
				{ Source~Han~Serif~SC } { \govdoc_setup_title_font_file:n { SourceHanSerifSC-Regular.otf } }
				{ NotoSerifCJKsc } { \govdoc_setup_title_font_file:n { NotoSerifCJKsc-Regular.otf } }
				{ Noto~Serif~CJK~SC } { \govdoc_setup_title_font_file:n { NotoSerifCJKsc-Regular.otf } }
			}
			{ \govdoc_setup_title_font_name: }
	}

\cs_new_protected:Npn \govdoc_setup_title_font_file:n #1
	{
		\file_if_exist:nTF { \c_govdoc_user_font_path_tl #1 }
			{
				\newfontfamily \govdoc_titlefont: { #1 }
					[ Path = \c_govdoc_user_font_path_tl ]
			}
			{
				\msg_error:nnn { govdoc } { title-font-missing } { #1 }
			}
	}

\cs_new_protected:Npn \govdoc_setup_title_font_name:
	{
		\exp_args:NV \fontspec_font_if_exist:nTF \l_govdoc_format_titlefont_tl
			{
				\exp_args:NNV \newfontfamily
					\govdoc_titlefont:
					\l_govdoc_format_titlefont_tl
			}
			{
				\msg_error:nnx { govdoc } { title-font-missing }
					{ \tl_use:N \l_govdoc_format_titlefont_tl }
			}
	}

\cs_new_protected:Npn \govdoc_body_font:
	{
		\g_govdoc_body_format_tl
		\skip_set:Nn \baselineskip { \g_govdoc_body_baselineskip_dim }
	}

\cs_new_protected:Npn \govdoc_use_mark:
	{
		\govdoc_tl_if_blank:NTF \l_govdoc_info_mark_tl
			{ \tl_use:N \l_govdoc_info_issuer_tl }
			{ \tl_use:N \l_govdoc_info_mark_tl }
	}

\cs_new_protected:Npn \govdoc_use_signer:
	{
		\govdoc_tl_if_blank:NTF \l_govdoc_info_signer_tl
			{ \tl_use:N \l_govdoc_info_issuer_tl }
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
			{ \g_govdoc_doc_number_format_tl \tl_use:N \l_govdoc_info_doc_number_tl \par }
			\skip_vertical:n { 4mm }
			{ \color { govdocred } \rule { \textwidth } { 0.8pt } \par }
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

\cs_new_protected:Npn \govdoc_make_attachment:
	{
		\govdoc_tl_if_blank:NTF \l_govdoc_info_attachment_tl
			{ }
			{
				\par \skip_vertical:n { \baselineskip }
				\noindent \skip_horizontal:n { 2\ccwd } 附件：\tl_use:N \l_govdoc_info_attachment_tl \par
			}
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

\cs_new_protected:Npn \govdoc_make_note:
	{
		\govdoc_tl_if_blank:NTF \l_govdoc_info_note_tl
			{ }
			{
				\par \skip_vertical:n { 0.5 \baselineskip }
				\noindent \skip_horizontal:n { 2\ccwd } （\tl_use:N \l_govdoc_info_note_tl ）\par
			}
	}

\cs_new_protected:Npn \govdoc_make_imprint:
	{
		\bool_lazy_and:nnF
			{ \govdoc_tl_if_blank_p:N \l_govdoc_info_print_office_tl }
			{ \govdoc_tl_if_blank_p:N \l_govdoc_info_print_date_tl }
			{
				\par \vfill
				\group_begin:
					\g_govdoc_imprint_format_tl
					\noindent \rule { \textwidth } { 0.35mm } \par
					\skip_vertical:n { 2pt }
					\noindent
					\skip_horizontal:n { 1\ccwd }
					\tl_use:N \l_govdoc_info_print_office_tl
					\hfill
					\tl_use:N \l_govdoc_info_print_date_tl 印发
					\skip_horizontal:n { 1\ccwd }
					\par
					\skip_vertical:n { 2pt }
					\noindent \rule { \textwidth } { 0.35mm } \par
				\group_end:
			}
	}

\cs_new_protected:Npn \govdoc_make_backmatter:
	{
		\govdoc_make_note:
		\govdoc_make_imprint:
	}

\DeclareDocumentCommand { \govdocinfo } { m }
	{ \keys_set:nn { govdoc / info } { #1 } }

\DeclareDocumentCommand { \makegovdochead } { }
	{ \govdoc_make_head: }

\DeclareDocumentCommand { \makegovdoctitle } { }
	{ \govdoc_make_title: }

\DeclareDocumentCommand { \makegovdocattachment } { }
	{ \govdoc_make_attachment: }

\DeclareDocumentCommand { \makegovdocsignature } { }
	{ \govdoc_make_signature: }

\DeclareDocumentCommand { \makegovdocbackmatter } { }
	{ \govdoc_make_backmatter: }

\AtBeginDocument
	{
		\govdoc_setup_title_font:
		\pagestyle { govdoc }
		\govdoc_body_font:
		\dim_set:Nn \parindent { 2\ccwd }
		\skip_set:Nn \parskip { 0pt }
	}
