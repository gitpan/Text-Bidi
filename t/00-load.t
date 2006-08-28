#!perl -T

use Test::More tests => 2;

BEGIN {
	use_ok( 'Text::Bidi' );
        use_ok( 'Text::Bidi::CapRTL');
}

diag( "Testing Text::Bidi $Text::Bidi::VERSION, Perl $], $^X" );
