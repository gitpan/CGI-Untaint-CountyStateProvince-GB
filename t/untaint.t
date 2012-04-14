#!perl -w

use strict;
use warnings;
use Test::More tests => 3;

BEGIN {
	use_ok('CGI::Untaint::CountyStateProvince::GB');
};

eval 'use Test::CGI::Untaint';

if($@) {
	plan skip_all => 'Test::CGI::Untaint required for testing extraction handler';
} else {
	is_extractable('Devon', 'devon', 'CountyStateProvince');
	unextractable('Foo', 'CountyStateProvince');
}
