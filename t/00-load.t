#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok('CGI::Untaint');
    use_ok( 'CGI::Untaint::CountyStateProvince::GB' ) || print "Bail out!
";
}

diag( "Testing CGI::Untaint::CountyStateProvince::GB $CGI::Untaint::CountyStateProvince::GB::VERSION, Perl $], $^X" );
