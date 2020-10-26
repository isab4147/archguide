% IMTexam class is a exam typesetting class for LaTeX
%Copyright (C) 2020 - Isabella Basso do Amaral
%
%This program is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with this program.  If not, see <https://www.gnu.org/licenses/>.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IMTart}[2020/07/30 Isabella's Maths and TikZ article class is a fully customized exam class for typesetting guides and documentations.]

\RequirePackage{etoolbox}
\newtoggle{engl}
\DeclareOption{english}{\global\settoggle{engl}{true}}
\newtoggle{dark}
\DeclareOption{dark}{\global\settoggle{dark}{true}}
\newtoggle{idx}
\DeclareOption{index}{\global\settoggle{idx}{true}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions\relax

\LoadClass[a4paper, 11pt, answers]{exam}

\RequirePackage[top=0.6in,left=0.6in,right=0.6in,bottom=0.7in]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[useregional]{datetime2}
\RequirePackage{hyphenat}
\RequirePackage[skip=0.5em,indent=3ex]{parskip}
\RequirePackage{graphicx,float}

\RequirePackage{iftex}

\ifXeTeX
\RequirePackage[stretch=10,shrink=10]{microtype}
\AtBeginEnvironment{verbatim}{\microtypesetup{activate=false}}
\RequirePackage{polyglossia}
%	\RequirePackage{fontspec}
%	\newfontfamily\titlefont{utopia}
%	
\iftoggle{engl}{
	\setdefaultlanguage[]{english}
	\PolyglossiaSetup{english}{indentfirst=false}
}{
	\setdefaultlanguage[variant=brazilian]{portuguese}
	\PolyglossiaSetup{portuguese}{indentfirst=false}
}
\else
\RequirePackage[utf8]{inputenc}
\RequirePackage[activate={true,nocompatibility},stretch=10,shrink=10,kerning=true,tracking=true]{microtype}
\SetTracking{encoding={*}, shape=sc}{40}
\SetExtraKerning[unit=space]
{encoding={*}, family={bch}, series={*}, size={footnotesize,small,normalsize}}
{\textendash={400,400}, % en-dash, add more space around it
	"28={ ,150}, % left bracket, add space from right
	"29={150, }, % right bracket, add space from left
	\textquotedblleft={ ,150}, % left quotation mark, space from right
	\textquotedblright={150, }} % right quotation mark, space from left
\SetExtraKerning[unit=space]
{encoding={*}, family={bch}, series={*}, size={footnotesize,small,normalsize}}
{\textemdash={400,400}, % en-dash, add more space around it
	"28={ ,150}, % left bracket, add space from right
	"29={150, }, % right bracket, add space from left
	\textquotedblleft={ ,150}, % left quotation mark, space from right
	\textquotedblright={150, }} % right quotation mark, space from left
\pretocmd{\tableofcontents}{\microtypesetup{protrusion=false}}{}{}
\apptocmd{\tableofcontents}{\microtypesetup{protrusion=true}}{}{}
\pretocmd{\listoffigures}{\microtypesetup{protrusion=false}}{}{}
\apptocmd{\listoffigures}{\microtypesetup{protrusion=true}}{}{}
\pretocmd{\listoftables}{\microtypesetup{protrusion=false}}{}{}
\apptocmd{\listoftables}{\microtypesetup{protrusion=true}}{}{}
%	
\iftoggle{engl}{
	\RequirePackage[brazilian]{babel}
}
{
	\RequirePackage[english]{babel}
}
\fi

\RequirePackage{xcolor}

\RequirePackage{pagecolor}

%\def\@themecolor{383e79}
\newcommand{\themecolor}[1]{\definecolor{theme}{HTML}{#1}}
%\def\@termcolor{}
\newcommand{\termcolor}[1]{\definecolor{term}{HTML}{#1}}
%\def\@termrefcolor{}
\newcommand{\termrefcolor}[1]{\definecolor{termref}{HTML}{#1}}
%\def\@correctcolor{}
\newcommand{\correctcolor}[1]{\definecolor{correct}{HTML}{#1}}
%\def\@notcolor{}
\newcommand{\notcolor}[1]{\definecolor{not}{HTML}{#1}}

\iftoggle{dark}{
	\definecolor{papercolor}{HTML}{282828}
	\definecolor{textcolor}{HTML}{eeeeee} %{D8F5FF}
	\definecolor{theme}{HTML}{39AFEA}
	\definecolor{term}{HTML}{39EAAF}
	\definecolor{termref}{HTML}{9438EB}
	\definecolor{correct}{HTML}{EAAF39}
	\definecolor{not}{HTML}{EA3939}
}{
	\definecolor{papercolor}{HTML}{ffffff}
	\definecolor{textcolor}{HTML}{000000}
	\definecolor{theme}{HTML}{383e79}
	\definecolor{term}{HTML}{009b8e}
	\definecolor{termref}{HTML}{008080}
	\definecolor{correct}{HTML}{383e79}
	\definecolor{not}{HTML}{f68052}
}

\pagecolor{papercolor}
\color{textcolor}

\RequirePackage{hyperref}
\hypersetup{hidelinks,
	colorlinks=true,urlcolor=termref,linkcolor=theme}
\RequirePackage[all]{hypcap}

\usepackage{sectsty} % change header style
\sectionfont{\color{theme}}

\usepackage{ccicons} % Creative Commons icons
\usepackage{scrextend} % KOMA-Script extension
\newcommand\figureruletop{%
	{\bf%
		\def\stuff{\makebox[0.4em][c]{/}}%
		\tiny\color{theme}%
		\stuff\leaders\hbox{\stuff}\hfill \hfil%
	}\par
}
\newcommand\figurerulebottom{%
	{\bf%
		\def\stuff{\makebox[0.4em][c]{\textbackslash}}%
		\tiny\color{theme}%
		\stuff\leaders\hbox{\stuff}\hfill \hfil%
	}\par
}

\AtBeginEnvironment{figure}{\figureruletop}
\AtEndEnvironment{figure}{\figurerulebottom}

%\pretocmd{\centering}{\figureruletop}{}{}
%\apptocmd{\caption}{\figurerulebottom}{}{}

\newcommand\TODO[1]{%
	\figureruletop
	
	\texttt{\textcolor{lightgray}{/*}}\hfill%
	\textbf{\textcolor{theme}{TODO}}: #1%
	\hfill\texttt{\textcolor{lightgray}{*/}}%
	
	\figureruletbottom
}

\RequirePackage{imakeidx}

\newcommand\defcategory[1]{%
	\filbreak%
	\outline{1}{#1}%
	\section{#1}%
	\nopagebreak[4]%
}

\newcommand\term[2][]{%
	\termnoindex[#1]{#2}%
	\index{#2}%
}
\newcommand\termnoindex[2][]{%
	\textit{\textbf{\textcolor{term}{#2}}}\label{\if\relax\detokenize{#1}\relax term:#2\else term:#1\fi}%
}
\newcommand\refterm[2][]{%
	\reftermnoindex[#1]{#2}%
	\index{#2}%
}

\newcommand\reftermnoindex[2][]{%
	\def\lab{\if\relax\detokenize{#1}\relax term:#2\else term:#1\fi}%
	\@ifundefined{r@\lab}{%
		% \textcolor{red}{\textit{#2}\textsuperscript{??}}%
		\message{APD Warning: Ref to undefined term \lab, ignoring.}%
		#2%
	}{%
		\textcolor{termref}{\textit{\hyperref[\lab]{#2}}}%
	}%
}

\newcommand\ort{%
	\textbf{\textcolor{correct}{ou}}
}
\newcommand\nott{%
	\textbf{\textcolor{not}{NÃO}}
}
\newcommand\avdt{%
	\textit{\textcolor{not}{Evite: }}
}

%\setlength{\parindent}{0pt}
%\setlength{\parskip}{\baselineskip}

\AtBeginDocument{\RequirePackage{footnote}
	\makesavenoteenv{solution}}

\iftoggle{idx}{
	\makeindex[intoc]
	\AtEndDocument{\printindex}}{}

\def\@lcode{\relax}
\newcommand{\lcode}[1]{\gdef\@lcode{#1}}
\def\@lecture{\relax}
\newcommand{\lecture}[1]{\gdef\@lecture{#1}}
\def\@keywords{\relax}
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\def\@subtitle{\relax}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\email}[1]{\ <\href{mailto:#1}{\nolinkurl{#1}}>}
%\renewcommand{\@author}{\relax}
%\renewcommand{\author}[1]{\gdef\@author{#1}}

%\hypersetup{pdfkeywords={\@keywords}}

\RequirePackage{tikz}
\usetikzlibrary{positioning,calc,backgrounds,arrows.meta,fadings,through}

\RequirePackage{tcolorbox}
\tcbuselibrary{breakable}

\renewcommand{\maketitle}{
	\begin{titlepage}
		\begin{center}
			\LARGE{\@title} %\\\hrulefill
			\\[0.5cm] %\baselineskip
			\normalsize{\@subtitle} \\[0.5cm] %\vfill
%			\begin{flushleft}
				\footnotesize{%
					\@author \\ 
				\@date} \\[1cm]
%			\end{flushleft}
		
		\begin{tcolorbox}[width=0.8\linewidth,colframe=theme,colback=papercolor,coltext=theme,halign=center,opacityback=1,arc=0mm,breakable]
			\tableofcontents
		\end{tcolorbox}
		\end{center}
	\end{titlepage}
}


\renewcommand\partlabel{\makebox[0.7cm][l]{(\alph{partno})}}

\renewcommand{\questionshook}{%
	\setlength{\leftmargin}{0in}%
	\setlength{\labelwidth}{-\labelsep}%
	\setlength{\topsep}{0.3cm}%
	\setlength{\parskip}{0cm}%
	\setlength{\partopsep}{0cm}
}

\renewcommand{\partshook}{%
	\setlength{\leftmargin}{10pt}%
	\setlength{\labelsep}{0pt}
	\setlength{\labelwidth}{0cm}%
	\setlength{\topsep}{0.1cm}%
	\def\makelabel##1{##1}%
	\setlength{\parskip}{0.1cm}%
}

\RequirePackage{relsize}

\RequirePackage{navigator} % allows for custom bookmarks etc
\pdfdef\term#1{#1}
\pdfdef\termnoindex#1{#1}
\pdfdef\refterm#1{#1}
\pdfdef\reftermnoindex#1{#1}
%\pdfdef\ce#1{#1}
%\pdfdef\ldots{...}
%\pdfdef\textit#1{-#1-}
%\pdfdef\mbox#1{#1}
%\pdfdef\ref#1{#1}
%\pdfdef\index#1{}
%\pdfdef\beta{beta}
%\pdfdef\textbf#1{*#1*}

\qformat{
	\begingroup\strut\hspace{-0.4in}
	\begin{minipage}{\textwidth}
		\makebox[0pt][l]{\tikz[baseline=(text.base),fadingnode/.style={rectangle, right color=papercolor,shading=axis,shading angle=90, anchor=south west, minimum width={\linewidth + 0.4in}}]{
				\coordinate (A) at (0, 0);
				\coordinate (B) at (1\linewidth, 1.2\baselineskip);
				\path[use as bounding box] (A) rectangle (B);
				\node[fadingnode, minimum height=1pt,left color=theme!95!papercolor] at (A) {};
				\node[fadingnode,left color=theme!5!papercolor,minimum height=1.2\baselineskip] at ($ (A)+(0,0.5pt) $) {};
				\node[anchor=south west, text=theme](text) at (A) {\arabic{question} | \hspace{1em}\outline{2}{\thequestiontitle}\thequestiontitle\hfill\thepoints};
			}}\vspace{0.2cm}
	\end{minipage}
	\endgroup
}

\counterwithin{equation}{question}
\renewcommand{\theequation}{\thequestion.\arabic{equation}}

\def\@curpage{\iftoggle{engl}{Page \thepage\ of \numpages}{Página \thepage\ de \numpages}}

\pagestyle{headandfoot}
\firstpageheader{}{}{}
\firstpagefooter{}{\ifthenelse{\numpages = 1}{}{\@curpage}}{}

\runningfooter{}{}{}
\runningheader{}{\@curpage}{}

\runningheadrule

\renewcommand{\solutiontitle}{\par\noindent}

\newcommand{\extra}[1]{
	\bigskip
	\noindent\begingroup
	\vspace{0.5cm}
	\strut\hspace{-4pt}
	\begin{minipage}{\textwidth}
		\formattitletext{\textlarger{\textbf{#1}}}
%		\strut\newline
%		\rule[1.1ex]{\textwidth}{1.2pt}
	\end{minipage}
	\endgroup
	\vspace{-0.5cm}
}


\renewcommand\appendix{
	\bigskip
	\noindent\begingroup
	\vspace{0.5cm}
	\strut\hspace{-4pt}
	\begin{minipage}{\textwidth}
		\formattitletext{{\iftoggle{engl}{Appendix}{Apêndice}}}
		\strut\newline
		\rule[1.1ex]{\textwidth}{1.2pt}
	\end{minipage}
	\endgroup
	\vspace{-0.5cm}
}
