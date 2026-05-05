# latexmkrc
# Configuration file for latexmk.

# Enable synctex, set interaction mode to run thru and set shell escape mode
# needed for the 'minted' package.
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 -shell-escape';
# $latexoption = '-interaction=nonstopmode -synctex=1 -shell-escape';


# Add rules to run makeglossaries if required.
# From https://tex.stackexchange.com/a/1228 [2021-04-21]

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
add_cus_dep('nlo', 'nls', 0, 'run_makeindex');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

sub run_makeindex {
  if ($silent) {
    Run_subst("makeindex -q -o %D %S");     # %D - destination; %S - source
  }
  else {
    Run_subst("makeindex -o %D %S");
  };
}


# Add extensions to clean up procedure.
push @generated_exts, qw(
    acn acr alg glsdefs ist maf margin-glg margin-glo margin-gls mtc* nlo nls
    run.xml tdo synctex(busy)
);

# For more complicated patterns, use $clean_ext. Variable %R is the base name.
$clean_ext .= ' _minted-%R/* _minted-%R/';

$bibtex_use = 2;    # clean .bbl files and run bibtex/biber to update bbl's.
