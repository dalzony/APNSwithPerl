#!/usr/bin/env perl

use strict;
use warnings;


use Net::APNS::Persistent;

my $devicetoken_hex = '3b41673576f65b10e977fca7267d3113330b5640d44e77beddfa1e1120dc09d0';

my $apns = Net::APNS::Persistent->new({
  sandbox => 1,
  cert    => 'push.cer',
  key     => 'push.key',
  passwd  => '12345',
});

$apns->queue_notification(
  $devicetoken_hex,
  {
    aps => {
        alert => 'sweet!',
        sound => 'default',
        badge => 1,
    },
  });

$apns->send_queue;

$apns->disconnect;
