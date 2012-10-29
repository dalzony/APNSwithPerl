#!/usr/bin/env perl
# 이거슨 안되는 코드 입니다. 쓰지 마세용
use strict;
use warnings;

use 5.010;

use AnyEvent::APNS;

my $cv = AnyEvent->condvar;

my $device_token = '';

my $apns;

$apns = AnyEvent::APNS->new(
    certificate => 'push.cer',
    private_key => 'push.key',
    sandbox     => 1,
    on_error    => sub { print 'ERROR'; },
    on_connect  => sub {
	say 'Ahhhhhhhhhhhhhhhhhhhhhhhhhhh';
	say $device_token;
        $apns->send( $device_token => {
		aps => {
               		alert => 'Message received from Bob',
          	},
        });
	say 'Ohhhhhhhhhhhhhhhhhhhhhhhhhhh';
    },
);
$apns->connect;
$cv->recv;
