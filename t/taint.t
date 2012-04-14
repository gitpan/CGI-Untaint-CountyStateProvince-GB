#!perl -wT

use strict;
use warnings;

use Test::More tests => 12;

use_ok('CGI::Untaint');
use_ok('CGI::Untaint::CountyStateProvince::GB');

eval 'use Test::Taint';
if($@) {
	plan skip_all => 'Test::Taint required for testing untainting';
} else {
	my $vars = {
	    state1 => 'Kent',
	    state2 => 'West Yorkshire',
	    state3 => 'West Yorks',
	};

	taint_checking_ok();

	untainted_ok_deeply($vars);
	taint_deeply($vars);
	tainted_ok_deeply($vars);

	my $untainter = CGI::Untaint->new($vars);

	my $c = $untainter->extract(-as_CountyStateProvince => 'state1');
	tainted_ok($vars->{'state1'});
	untainted_ok($c);
	ok($c eq 'kent', 'Kent');

	$c = $untainter->extract(-as_CountyStateProvince => 'state2');
	untainted_ok($c);
	ok($c eq 'west yorkshire', 'West Yorkshire');

	$c = $untainter->extract(-as_CountyStateProvince => 'state3');
	untainted_ok($c);
	ok($c eq 'west yorkshire', 'West Yorks');
}
