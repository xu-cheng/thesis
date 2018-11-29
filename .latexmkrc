# vim: set filetype=perl:

# Build arguments
$pdflatex = 'pdflatex --shell-escape --synctex=1 %O %S';
# Always create PDFs
$pdf_mode = 1;
# Try 5 times at maximum then give up
$max_repeat = 5;
# File extensions to remove when cleaning
$clean_ext = 'bbl fdb_latexmk fls loa nav pdfsync pyg run.xml snm synctex.gz thm upa vrb ' .
             '*-eps-converted-to.pdf */*-eps-converted-to.pdf */*/*-eps-converted-to.pdf';

no warnings 'redefine';

# Overwrite `cleanup1` functions to support more general pattern in $clean_ext.
# Ref: https://github.com/e-dschungel/latexmk-config/blob/master/latexmkrc
sub cleanup1 {
    my $dir = fix_pattern( shift );
    my $root_fixed = fix_pattern( $root_filename );
    foreach (@_) {
        (my $name = (/%R/ || /[\*\?]/) ? $_ : "%R.$_") =~ s/%R/$dir$root_fixed/;
        unlink_or_move( glob( "$name" ) );
    }
}
