#!perl -wT

use Test::More tests => 7;
BEGIN {
	use_ok('CGI::Untaint');
	use_ok('CGI::Untaint::CountyStateProvince::GB');
};

my $vars = {
    state1 => 'MD',
    state2 => 'Kent',
    state3 => ' ',
    state4 => 'West Yorkshire',
    state5 => 'West Yorks',
};

my $untainter = CGI::Untaint->new($vars);
my $c = $untainter->extract(-as_CountyStateProvince => 'state1');
ok(!defined($c), 'Maryland');

$c = $untainter->extract(-as_CountyStateProvince => 'state2');
ok($c eq 'Kent', 'Kent');

$c = $untainter->extract(-as_CountyStateProvince => 'state3');
ok(!defined($c), 'Empty');

$c = $untainter->extract(-as_CountyStateProvince => 'state4');
ok($c eq 'West Yorkshire', 'West Yorkshire');

$c = $untainter->extract(-as_CountyStateProvince => 'state5');
ok($c eq 'West Yorks', 'West Yorks');
