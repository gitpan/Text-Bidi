#! perl -T

BEGIN {
our %Tests = (
'car is THE CAR in arabic'            => 'car is RAC EHT in arabic',
'CAR IS the car IN ENGLISH          ' => '          HSILGNE NI the car SI RAC',
'he said "IT IS 123, 456, OK"       ' => 'he said "KO ,456 ,123 SI TI"       ',
'he said "IT IS (123, 456), OK"     ' => 'he said "KO ,(456 ,123) SI TI"     ',
'he said "IT IS 123,456, OK"        ' => 'he said "KO ,123,456 SI TI"        ',
'he said "IT IS (123,456), OK"      ' => 'he said "KO ,(123,456) SI TI"      ',
'HE SAID "it is 123, 456, ok"'        => '"ok ,it is 123, 456" DIAS EH',
'he said "IT IS 789, 678, OK"'        => 'he said "KO ,678 ,789 SI TI"',
'he said "IT IS (789, 678), OK" '     => 'he said "KO ,(678 ,789) SI TI" ',
'he said "IT IS 789,678, OK"        ' => 'he said "KO ,789,678 SI TI"        ',
'he said "IT IS (789,678), OK"      ' => 'he said "KO ,(789,678) SI TI"      ',
'HE SAID "it is 789, 678, ok"       ' => '       "ok ,678 ,789 it is" DIAS EH',
'<H123>shalom</H123>                ' => '                <123H/>shalom<123H>',
'<h123>SALAAM</h123>                ' => '<h123>MAALAS</h123>                ',
'HE SAID "it is a car!" AND RAN     ' => '     NAR DNA "!it is a car" DIAS EH',
'HE SAID "it is a car!_>" AND RAN   ' => '   NAR DNA "it is a car!" DIAS EH',
'-2 CELSIUS IS COLD                 ' => '                 DLOC SI SUISLEC 2-',
'SOLVE 1*5 1-5 1/5 1+5              ' => '              5+1 5/1 5-1 5*1 EVLOS',
'THE RANGE IS 2.5..5                ' => '                5..2.5 SI EGNAR EHT',
'IOU $10                            ' => '                            $10 UOI',
'CHANGE -10%                        ' => '                        %10- EGNAHC',
'-10% CHANGE                        ' => '                        EGNAHC %10-',
'A TEST FOR WEAK TYPES: 123+,456    ' => '    456,123+ :SEPYT KAEW ROF TSET A',
'ANOTHER FOR WEAK TYPES: A123,456   ' => '   123,456A :SEPYT KAEW ROF REHTONA',
'MORE WEAK TYPES: hooloo123,456     ' => '     hooloo123,456 :SEPYT KAEW EROM',
'and TEST|L1 ||too   '                => 'and TSET|1L ||too   ',
);
}

use Test::More tests => scalar keys %Tests;
use Text::Bidi::CapRTL;

my $s = new Text::Bidi::CapRTL;

TODO: {
local $TODO = "Tests may fail due to a bug in libfribidi";
foreach ( sort keys %Tests ) {
    my $vis = $s->log2vis($_);
    is($vis, $Tests{$_}, $_);
}
}

1;
