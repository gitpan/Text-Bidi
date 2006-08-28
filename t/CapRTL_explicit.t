#! perl -T

BEGIN {
our %Tests = (
'this is _LJUST_o' => 'this is JUST',
'a _lsimple _RteST_o th_oat' => 'a simple TSet that',
'HAS A _LPDF missing                ' => '                PDF missing A SAH',
'AnD hOw_L AbOuT, 123,987 tHiS_o    ' => '    w AbOuT, 123,987 tHiSOh DnA',
'a GOOD - _L_oTEST.' => 'a TSET - DOOG.',
'here_L is_o_o_o _R a good one_o' => 'here is eno doog a ',
'And _r 123,987_LTHE_R next_o oNE:  ' => '  987THEtxen  oNE:,123  ndA',
'_R_r and the last _LONE_o IS       ' => 'SI and the last ONE        ',
'THE _rbest _lONE and               ' => '               best ENO and EHT',
'A REAL BIG_l_o BUG!                ' => '                !GUB GIB LAER A',
'a _L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_L_Rbug' 
                                      => 'a gub',
'AN ARABIC _l_o 123-456 NICE ONE!   ' => '   !ENO ECIN 456-123  CIBARA NA',
'AN ARABIC _l _o 123-456 PAIR       ' => '       RIAP   123-456 CIBARA NA',
'this bug 67_r_o89 catched!' => 'this bug 6789 catched!',
);
}

use Test::More tests => scalar keys %Tests;
use Text::Bidi::CapRTL qw(log2vis);

TODO: {
local $TODO = "Tests may fail due to a bug in libfribidi";
foreach ( sort keys %Tests ) {
    my $vis = log2vis($_);
    is($vis, $Tests{$_}, $_);
}
}

1;
