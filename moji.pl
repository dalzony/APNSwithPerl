#!/usr/bin/env perl

use strict;
use warnings;

use 5.010;
use Mojo::UserAgent;
use Data::Dumper;

my $ua = Mojo::UserAgent->new;
my %feeds;
my %pushed;
my $hot = 10;
$| = 1;

while(1) {
    update();
	while(my ($id, $v) = each %feeds) {
		if(!defined $pushed{$id} && $v->{hit} > $hot) {
			say "PUSH :: ", $id, Dumper($v);
			$pushed{$id} = 1;
		}
		elsif(defined $pushed{$id}) {
			#say "Already PUSHed :: ", $id, Dumper($v);
		}
		else {
			say "Not yet PUSHed :: ", $id, Dumper($v);
		}
	}
	sleep 5;
}

sub update {
    my $tx = $ua->get( "http://clien.career.co.kr/cs2/bbs/board.php?bo_table=park" ); 
    $tx->res->dom->find("tr.mytr")->each(sub {
        my ($tr) = @_;
		my @td = $tr->td->each;

		my $e;    

        my $id;
		$id = $td[0]->text;

        my $hit;
		$hit = $td[4]->text;

        my $a;
        my $subject;
		$e = $td[1]->at('a');
		#say "A element is $e";
		$a = $e->attrs('href');
		$subject = $e->text;


	# 1 : <td>15937331</td>
	# 2 : <td class="post_subject">??<a href="../bbs/board.php?bo_table=park&amp;wr_id=15937331">현실을 배경으로 한 온라인 게임 아이디어...</a></td>
	# 3 : <td class="post_name"><img align="absmiddle" border="0" src="/cs2/data/member/ze/zeon.gif?dt=20121011" /></td>
	# 4 : <td><span title="2012-10-13 17:14:59">17:14</span></td>
	# 5 : <td>5</td>
            
		$feeds{$id} = {
			id      => $id,
			a       => $a,
			subject => $subject,
			hit     => $hit,
		};
        #say "$id, $a, $subject, $hit" if $hit > $max;
    });
}
