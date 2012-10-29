#!/usr/bin/env perl

use strict;
use warnings;
use Net::APNS::Persistent;

my $devicetoken_hex = '';

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
