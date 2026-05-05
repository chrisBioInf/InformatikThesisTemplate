\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{UniLeipzigBioinfThesisSA}[2018/08/03 v0.1 Uni Leipzig Bioinformatik Thesis Template, stand-alone version]
\LoadClass[10pt,a4paper,oneside]{memoir}


\IfFileExists{silence.sty}{%
    \RequirePackage{silence}%
    \WarningFilter{glossaries}{Overriding}%
    \WarningFilter{minitoc(hints)}{W0030}%
    \WarningFilter{minitoc(hints)}{W0023}%
    \WarningFilter{minitoc(hints)}{W0028}%
    \WarningFilter{minitoc(hints)}{W0024}%
    \WarningFilter{memoir}{You are using the caption package}%
}{}

\RequirePackage{kvoptions}
%Parse options
\SetupKeyvalOptions{prefix=BioinfThesisSA@}
% \DeclareStringOption[3]{maxdis}%Max distance of an abbreviation before the full name is used.
\DeclareStringOption[lms]{font}%Change font
\DeclareStringOption[misc/thesis_info]{infopath}%Path to thesis info file
\DeclareStringOption[fggf]{bibauthorstyle}%Change bib authorstyle
\DeclareStringOption[off]{todo}%Define todo command?
\DeclareBoolOption[false]{smallautoref}%Change the autoref to first small letter
\DeclareBoolOption[false]{bibtex}%Use bibtex instead of biblatex
\DeclareBoolOption[false]{noglossary}%Don't use glossary package
\DeclareBoolOption[false]{fullcitename}%Activate first name in bibliogtaphy
\DeclareBoolOption[false]{smallmargins}%Activate to have smaller margins

\ProcessKeyvalOptions*

% Load externally defined commands and environments.
\PassOptionsToClass{font=\BioinfThesisSA@font}{UniLeipzigBioinfThesisCommon}
\PassOptionsToClass{bibauthorstyle=\BioinfThesisSA@bibauthorstyle}{UniLeipzigBioinfThesisCommon}
\ifBioinfThesisSA@smallautoref%
    \PassOptionsToClass{smallautoref}{UniLeipzigBioinfThesisCommon}%
\fi
\ifBioinfThesisSA@bibtex%
    \PassOptionsToClass{bibtex}{UniLeipzigBioinfThesisCommon}%
\fi
\ifBioinfThesisSA@noglossary%
    \PassOptionsToClass{noglossary}{UniLeipzigBioinfThesisCommon}%
\fi
\ifBioinfThesisSA@fullcitename%
    \PassOptionsToClass{fullcitename}{UniLeipzigBioinfThesisCommon}%
\fi
\RequirePackage{UniLeipzigBioinfThesisCommon}

% Load thesis information from file.
\input{\BioinfThesisSA@infopath}

% Set up fonts.
\BioinfThesisCmn@fontsetup{\BioinfThesisSA@font}

% Set up small margins if requested.
\ifBioinfThesisSA@smallmargins%
    \setlrmarginsandblock{4cm}{4cm}{*}%
    \checkandfixthelayout%
\fi

%autoref stuff
\BioinfThesisCmn@autorefsetup

% Set style of chapter title.
\renewcommand{\chaptitlefont}{\normalfont\sffamily\Huge\bfseries\centering}

% Set up todo notes. Consider smallmargins option.
\BioinfThesisCmn@todosetup{\BioinfThesisSA@todo}
\ifBioinfThesisSA@smallmargins%
    \setmarginnotes{0.5cm}{3.0cm}{0.5cm}%
\else%
    \setmarginnotes{0.5cm}{3.5cm}{0.5cm}
\fi

% Make title and author visible in header of "plain" pages (e.g. chapter page)
\makeoddhead{plain}{\mdseries\sffamily\itshape\ttitle\hfill\upshape\authorname}{}{}
\makeheadrule{plain}{\textwidth}{\normalrulethickness}
\makeoddfoot{plain}{}{}{}       % no page number on bottom of chapter page

% Make header on other pages (using headings style) consistent.
\makeoddhead{headings}{\mdseries\sffamily\itshape\ttitle\hfill\upshape\thepage}{}{}
\makeheadrule{headings}{\textwidth}{\normalrulethickness}

% End of UniLeipzigBioinfThesisSA.cls
