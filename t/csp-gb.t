#!perl -wT

use Test::More tests => 8;
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
    state6 => '*&^',
};

my $untainter = CGI::Untaint->new($vars);
my $c = $untainter->extract(-as_CountyStateProvince => 'state1');
ok(!defined($c), 'Maryland');

$c = $untainter->extract(-as_CountyStateProvince => 'state2');
ok($c eq 'kent', 'Kent');

$c = $untainter->extract(-as_CountyStateProvince => 'state3');
ok(!defined($c), 'Empty');

$c = $untainter->extract(-as_CountyStateProvince => 'state4');
ok($c eq 'west yorkshire', 'West Yorkshire');

$c = $untainter->extract(-as_CountyStateProvince => 'state5');
ok($c eq 'west yorkshire', 'West Yorks');

$c = $untainter->extract(-as_CountyStateProvince => 'state6');
ok(!defined($c), '*&^');
