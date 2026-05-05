\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{UniLeipzigBioinfThesis}[2018/08/03 v0.1 Uni Leipzig Bioinformatik Thesis Template]
\LoadClass[a4paper,10pt]{memoir}

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
% Parse options
\SetupKeyvalOptions{prefix=BioinfThesis@}
\DeclareStringOption[3]{maxdis}%Max distance of an abbreviation before the full name is used.
\DeclareStringOption[lms]{font}%Change font
\DeclareStringOption[misc/thesis_info]{infopath}%Path to thesis info file
\DeclareStringOption[frontmatter/abstract]{abstractpath}
\DeclareStringOption[frontmatter/zusammenfassung]{zusammenpath}
\DeclareStringOption[frontmatter/acknowledgments]{acknowledgmentspath}
\DeclareStringOption[backmatter/curriculum_scientiae]{cs}
\DeclareStringOption[veelo]{chapterstyle}
\DeclareStringOption[gf]{baseonauthorstyle}%Change baseon authorstyle
\DeclareStringOption[fggf]{bibauthorstyle}%Change bib authorstyle
\DeclareStringOption[off]{todo}%Define todo command?
\DeclareBoolOption[false]{bibversion}%Change the title page
\DeclareBoolOption[false]{minted}%Change the how code is displayed
\DeclareBoolOption[false]{nominitoc}%Deactivate the mini tocs
\DeclareBoolOption[false]{figlist}%Activate the list of fig
\DeclareBoolOption[false]{tablist}%Activate the list of tables
\DeclareBoolOption[false]{smallautoref}%Change the autoref to first small letter
\DeclareBoolOption[false]{nostatistics}%Decativate statistics on bibpage
\DeclareBoolOption[false]{bibtex}%Use bibtex instead of biblatex
\DeclareBoolOption[false]{noglossary}%Don't use glossary package
\DeclareBoolOption[false]{fullcitename}%Activate first name in bibliogtaphy
\DeclareBoolOption[false]{definitionindex}%Activate to create defintion index
\DeclareBoolOption[false]{smallmargins}%Activate to have smaller margins

\ProcessKeyvalOptions*

% Load externally defined commands and environments.
\ifBioinfThesis@smallautoref%
    \PassOptionsToClass{smallautoref}{UniLeipzigBioinfThesisCommon}%
\fi
\ifBioinfThesis@bibtex%
    \PassOptionsToClass{bibtex}{UniLeipzigBioinfThesisCommon}%
\fi
\ifBioinfThesis@noglossary%
    \PassOptionsToClass{noglossary}{UniLeipzigBioinfThesisCommon}%
\fi
\ifBioinfThesis@fullcitename%
    \PassOptionsToClass{fullcitename}{UniLeipzigBioinfThesisCommon}%
\fi
\ifBioinfThesis@definitionindex%
    \PassOptionsToClass{definitionindex}{UniLeipzigBioinfThesisCommon}%
\fi
\PassOptionsToClass{font=\BioinfThesis@font}{UniLeipzigBioinfThesisCommon}
\RequirePackage{UniLeipzigBioinfThesisCommon}

% Load thesis information from file.
\input{\BioinfThesis@infopath}

% Set up fonts.
\BioinfThesisCmn@fontsetup{\BioinfThesis@font}

\setsecnumdepth{subsection}

\RequirePackage{multirow} % Required for tables


%Float stuff
\RequirePackage{caption}
\DeclareCaptionFormat{default}{\textbf{#1#2}#3}
\captionsetup{format=default,font=small}
\RequirePackage[rightcaption]{sidecap}

\newcommand{\captiont}[2]{%
    \caption[#1]{\textbf{#1} #2}%
}


%Algorithmic stuff
\newfloat{algorithmt}{alg}{Algorithm}
\DeclareCaptionFormat{algoformat}{\hrulefill\\\textbf{#1#2}#3\hrulefill}
\captionsetup[algorithmt]{format=algoformat,justification=justified,singlelinecheck=false,skip=0pt}
\newenvironment {algorithm}{ \begin{algorithmt}\hrule}{\hrule\end{algorithmt}}

\RequirePackage[noend]{algorithmic}

\ifBioinfThesis@minted
    \RequirePackage{minted}
    \newenvironment {code}[1]{\VerbatimEnvironment \begin{minted}[linenos]{#1}}{\end{minted}}
    \newenvironment {code2}[1]{\VerbatimEnvironment \begin{minted}[linenos]{#1}}{\end{minted}}
\else
    \RequirePackage{listings}
    \lstset{numbers=left,defaultdialect=[latex]tex}
    \RequirePackage{pdftexcmds}
    \newcommand{\correctlatex}[1]{%
        \ifnum\pdf@strcmp{#1}{\unexpanded{latex}}=\z@ {tex}%
        \else #1%
        \fi
    }

    \lstnewenvironment{code}[1]{\lstset{language=\correctlatex{#1}}}{}
    \lstnewenvironment{code2}[1]{\lstset{language=\correctlatex{#1}}}{}
\fi


\ifBioinfThesis@nostatistics%
\else
    \RequirePackage{xassoccnt}%

    % Declare total counters. Count mainpages and mainchapters only in main
    % matter, totalappendices only in appendix.
    \DeclareTotalDocumentCounter{mainpages}
    \DeclareTotalDocumentCounter{mainchapters}
    \DeclareTotalDocumentCounter{totalappendices}
    \DeclareAssociatedCounters{page}{mainpages}
    \DeclareAssociatedCounters{chapter}{mainchapters,totalappendices}
    \SuspendCounters{mainpages,mainchapters,totalappendices}

    \DeclareTotalDocumentCounter{totalfigs}
    \DeclareTotalDocumentCounter{totaltables}
    \DeclareTotalDocumentCounter{totalcites}
    \DeclareAssociatedCounters{figure}{totalfigs}
    \DeclareAssociatedCounters{table}{totaltables}
    \AtEndPreamble{
        \ifBioinfThesis@bibtex%
            \def\oldbibitem{} \let\oldbibitem=\bibitem
            \def\bibitem{\stepcounter{totalcites}\oldbibitem}
        \else
            \AtEveryBibitem{\stepcounter{totalcites}}
        \fi
    }
\fi


\chapterstyle{\BioinfThesis@chapterstyle}

% Define format of section titles, chapters and parts. Always use sans font,
% even if main text uses serifs.
\renewcommand{\partnamefont}{\normalfont\sffamily\huge\bfseries}
\renewcommand{\partnumfont}{\normalfont\sffamily\huge\bfseries}
\renewcommand{\parttitlefont}{\normalfont\sffamily\Huge\bfseries}
% This will break the chapter style, don't set. Comment out the redefinition
% of \chaptitlefont if there are problems with a specific style.
%\renewcommand{\chapnamefont}{\normalfont\sffamily\huge\bfseries\ruggedright}
%\renewcommand{\chapnumfont}{\normalfont\sffamily\huge\bfseries\ruggedright}
\renewcommand{\chaptitlefont}{\normalfont\sffamily\Huge\bfseries}
\setsecheadstyle{\normalfont\sffamily\Large\bfseries}
\setsubsecheadstyle{\normalfont\sffamily\large\bfseries}
\setsubsubsecheadstyle{\normalfont\sffamily\normalsize\bfseries}
\setparaheadstyle{\normalfont\sffamily\normalsize\bfseries}
\setsubparaheadstyle{\normalfont\sffamily\normalsize\bfseries}

\ifBioinfThesis@smallmargins%
    \setlrmarginsandblock{3.5cm}{4.5cm}{*}%
    \checkandfixthelayout%
\fi

\setlength{\headwidth}{\textwidth}

\addtolength{\headwidth}{\marginparwidth}
\addtolength{\headwidth}{\marginparsep}
\ifBioinfThesis@smallmargins%
    \addtolength{\headwidth}{-2cm}
\fi

\makepagestyle{default}
\makerunningwidth{default}{\headwidth}
\makeheadrule{default}{\headwidth}{\normalrulethickness}
\makeheadposition{default}{flushright}{flushleft}{}{}

% Define format of page header. Always use sans font, even if main text uses
% serifs. A -2cm hspace is required to left-align the title of pages for
% whatever reason.
\makeevenhead{default}%
{\normalfont\sffamily\bfseries\thepage}{}{%
    \normalfont\sffamily\bfseries\leftmark}
\makeoddhead{default}%
{\normalfont\sffamily\bfseries\hspace{-2cm}\rightmark}{}{%
    \normalfont\sffamily\bfseries\thepage}

\clearmark{section}
\makepsmarks{default}{%
    \nouppercaseheads
    \createmark{chapter}{both}{shownumber}{\@chapapp\ }{. \ }
    \createmark{part}{both}{shownumber}{\partname\ }{. \ }
}

\copypagestyle{chapter}{default}
\copypagestyle{part}{default}


% Set up todo notes.
\ifBioinfThesis@smallmargins%
    \setmarginnotes{0.5cm}{2.5cm}{0.5cm}%
\else%
    \setmarginnotes{0.5cm}{4cm}{0.5cm}
\fi
\BioinfThesisCmn@todosetup{\BioinfThesis@todo}

\RequirePackage{booktabs} %Advanced Tables

\renewcommand\textbullet{\ensuremath{\bullet}}


%Set PDF informations
\AtBeginDocument{
    \hypersetup{pdftitle=\ttitle} % Set the PDF's title to your title
    \hypersetup{pdfauthor=\authorname} % Set the PDF's author to your name
    \hypersetup{pdfkeywords=\keywords} % Set the PDF's keywords to your keywords
}

\RequirePackage{soul}

\ifBioinfThesis@bibversion
    \newcommand{\maketitlepage}{
        \begin{titlingpage}
            \calccentering\unitlength
            \begin{adjustwidth*}{\unitlength}{-\unitlength}
                \begin{center}
                {\Large\sffamily
                    {\Huge \bfseries \ttitlewithbreaks\par}
                    \ifcsname subtitle\endcsname%
                        \vspace{0.3cm}
                        {\LARGE %
                            \textit{\subtitlewithbreaks}
                        }\\
                    \fi


                    \vfill % Thesis title

                    Von der Fakult{\"a}t für Mathematik und Informatik\\
                    der Universität Leipzig \\
                    angenommene\\
                    \vfill
                    {\LARGE \so{DISSERTATION}}\\
                    \vfill
                    zur Erlangung des akademischen Grades\\
                    \vfill
                    {\LARGE Doctor rerum naturalium\\ (Dr.\ rer.\ nat.)}\\
                    \vfill
                    im Fachgebiet\\
                    \vfill
                    {\LARGE Informatik,}\\
                    \vfill
                    vorgelegt von\\
                    \vfill
                    \authortitle~\authorname, \authordegree,\\
                    geboren am \dayofbirth~in \birthplace.\\
                    \vfill
                    Die Annahme der Dissertation wurde empfohlen von:\\
                    \vfill
                    \begin{varwidth}{\textwidth}        %required to achieve centering
                    \begin{enumerate}
                        \item[1.] \firstreviewer
                        \item[2.] \secondreviewer
                    \end{enumerate}
                    \end{varwidth}
                    \vfill
                    Die Verleihung des akademischen Grades erfolgt mit Bestehen\\
                    der Verteidigung am \dayofdefens{} mit dem Gesamtpr{\"a}dikat\\
                    \vfill
                    \emph{\glqq\grade\grqq}.
                }
                \end{center}
            \end{adjustwidth*}
        \end{titlingpage}

        \cleardoublepage
        \copypagestyle{cleared}{default}
        \pagestyle{default}
    }
\else
    \newcommand{\maketitlepage}{
        \begin{titlingpage}
            \calccentering\unitlength
            \begin{adjustwidth*}{\unitlength}{-\unitlength}
                \begin{center}

                {\Large\sffamily
                    {\Huge \bfseries \ttitlewithbreaks\par}
                    \ifcsname subtitle\endcsname%
                    \vspace{0.3cm}
                    {\LARGE %
                        \textit{\subtitlewithbreaks}
                    }\\
                    \fi
                    \vfill % Thesis title

                    Der Fakultät für Mathematik und Informatik\\
                    der Universität Leipzig \\
                    eingereichte\\
                    \vfill
                    {\LARGE \so{DISSERTATION}}\\
                    \vfill
                    zur Erlangung des akademischen Grades\\
                    \vfill
                    {\LARGE Doctor rerum naturalium\\ (Dr.\ rer.\ nat.)}\\
                    \vfill
                    im Fachgebiet\\
                    \vfill
                    {\LARGE Informatik,}\\
                    \vfill
                    vorgelegt von\\
                    \vfill
                    \authortitle~\authorname, \authordegree,\\
                    geboren am \dayofbirth~in \birthplace.\\
                    \vfill
                    Leipzig, den \filingdate
                }
                \end{center}
            \end{adjustwidth*}
        \end{titlingpage}
        \cleardoublepage
        \copypagestyle{cleared}{default}
        \pagestyle{default}
    }
\fi

\newcommand{\makededication}{
    \ifcsname dedication\endcsname%
        \clearpage
        \vspace*{\fill}
        \begin{center}
            {\Huge\sffamily %
                \dedication
            }
        \end{center}
        \vfill
        \cleardoublepage
    \fi

}

%frontmatter
\newcommand{\makefrontmatter}{%
    \setcounter{itisfrontmatter}{1}
    \frontmatter

    % Make list of TODOs if using margin notes for todos
    \ifdefstring{\BioinfThesis@todo}{margin}{
        \listoftodos
        \cleardoublepage
    }

    \maketitlepage

    \makededication

    \makebibdescription


    \if\relax\detokenize{\BioinfThesis@abstractpath}\relax
    \else
        \include{\BioinfThesis@abstractpath}
        \cleardoublepage
    \fi

    \if\relax\BioinfThesis@zusammenpath\relax%
    \else%
        \begin{otherlanguage}{ngerman}%
        \include{\BioinfThesis@zusammenpath}%
        \cleardoublepage%
        \end{otherlanguage}%
    \fi

    \if\relax\BioinfThesis@acknowledgmentspath\relax%
    \else%
        \include{\BioinfThesis@acknowledgmentspath}%
        \cleardoublepage%
    \fi


    \tableofcontents*
    \setcounter{itisfrontmatter}{0}
}

\newcommand{\beginmainmatter}{%
    \mainmatter
    \ifBioinfThesis@nostatistics%
    \else
        \ResumeSuspendedCounters{mainpages,mainchapters}
    \fi
    \counterwithout{figure}{chapter}
    \counterwithout{table}{chapter}
}

\newcommand{\beginappendix}{%
    \ifBioinfThesis@nostatistics%
    \else
        \SuspendCounters{mainpages,mainchapters}
    \fi
    \addcontentsline{toc}{part}{Appendices}
    \part*{Appendices}
    \appendix
    \ifBioinfThesis@nostatistics%
    \else
        \ResumeSuspendedCounters{totalappendices}
    \fi
}


\newcommand{\makebackmatter}{%
    \ifBioinfThesis@nostatistics%
    \else
        \SuspendCounters{totalappendices}
    \fi
    \backmatter

    \makesymbols

    \printglossary[title=List of Abbreviations]
    \ifBioinfThesis@definitionindex%
        \printglossary[type=margin, style=index]
    \fi

    \ifBioinfThesis@figlist%
        \makefigures
    \fi
    \ifBioinfThesis@tablist%
        \maketables
    \fi
    % Bib stuff
    \printthebibliography%
    % Curriculum scientiae
    \if\relax\BioinfThesis@cs\relax%
    \else%
    \include{\BioinfThesis@cs}%
    \cleardoublepage%
    \fi

    \makedeclaration
}

%Theorem stuff
\newtheorem{definition}{Definition}
\newtheorem{proposition}{Proposition}
\newtheorem{corollary}{Corollary}
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}{Lemma}
\renewcommand{\labelenumi}{\roman{enumi})}
\renewcommand{\theenumi}{\roman{enumi}}

%autoref stuff
\BioinfThesisCmn@autorefsetup


%Bib information
\RequirePackage{listofitems}
\setsepchar{.}

\newcommand{\makebibdescription}{
    \readlist\mydate{\filingdate}
    \chapter*{Bibliographic Description}
        \begin{table}[h!]
            \begin{tabularx}{\textwidth}{rX}
                Title:&\ttitle\\
                \ifcsname subtitle\endcsname%
                Subtitle:&\subtitle\\
                \fi
                Type:&Dissertation\\
                Author:&\authorname\\
                Year:&\mydate[3]\\
                Professional discipline:&Bioinformatics\\
                Language:&English\\
                \ifBioinfThesis@nostatistics%
                \else%
                    Pages in the main part:& \TotalValue{mainpages}\\
                    Chapters in the main part:& \TotalValue{mainchapters}\\
                    Number of Figures:& \TotalValue{totalfigs}\\
                    Number of Tables:& \TotalValue{totaltables}\\
                    Number of Appendices:& \TotalValue{totalappendices}\\
                    Number of Citations:& \TotalValue{totalcites}\\
                \fi%
                %Classification (DDC):& 570; NSG 004\\
                Key Words:&\keywords\\
            \end{tabularx}
        \end{table}

        %Bib stuff
        \ifBioinfThesis@bibtex%
            \nocitebase{\basedon}
            \bibliographybase{thesis}
        \else
            \renewcommand*{\thefootnote}{\fnsymbol{footnote}}
            \section*{This thesis is based on the following publications:}
            \begin{refsection}
                \setbiblatexnamestyle{\BioinfThesis@baseonauthorstyle}
                \nocite{\basedon}
                \printbibliography[heading=none]
            \end{refsection}
            \ifnum\value{sharedfirstauthor}=1%
                \footnotetext[1]{The authors share first authorship.}
            \fi
            \renewcommand*{\thefootnote}{\arabic{footnote}}
            \setcounter{footnote}{0}
            \setbiblatexnamestyle{\BioinfThesis@bibauthorstyle}
        \fi
        \ifBioinfThesis@nostatistics%
        \else%
            \setcounter{totalcites}{0}
        \fi%
    \cleardoublepage
}


%Mini Toc at begin of chapter.
\ifBioinfThesis@nominitoc
\else
    \RequirePackage{minitoc}
    \dominitoc

    \renewcommand{\afterchaptertitle}{%
        \par\nobreak\vskip \afterchapskip%
        \if@mainmatter%
            \ifnum\pdf@strcmp{\@chapapp}{\appendixname}=\z@
                %
            \else%
                \minitoc \clearpage%
            \fi
        \fi
    }

    \newcommand{\tocchapter}[1]{
         \chapter{#1}
         \minitoc
         \clearpage
     }
\fi


%List of Figure in TOC
\newcommand{\makefigures}{
    \cleardoublepage
    \listoffigures % Prints the list of figures
}

%List of Tables in TOC
\newcommand{\maketables}{
    \cleardoublepage
    \listoftables % Prints the list of tables
}

% End of File
