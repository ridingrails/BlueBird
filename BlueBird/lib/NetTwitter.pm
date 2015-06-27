use strict;
package NetTwitter;
use Net::Twitter;
use List::Compare;
use base 'Exporter';

sub return_object {
	our $nt = Net::Twitter->new(
		traits          => [ qw/AppAuth API::RESTv1_1/ ],
		consumer_key    => 'in0v5PZIIXuTzw8ewEL6mhi0g',
		consumer_secret => 'IHkLyL91FuoKPkigSsFtqkdGMeZ9pfLnhgRriOzQ1cdMbF4fH1',
	);
	$nt->request_access_token;
        return $nt;
}

sub user_list_intersection {
        #my $twitter = return_object();
	my ($twitter, @user_list) = @_;
	our @follow_array = ();   

        #for each user in list get follows
        for my $i (0 .. $#user_list)
        {
		my $user_name = $user_list[$i];
		my @user_names = ();

		#iterate over cursor returned by twitter endpoint to get all follows
		for ( my $cursor = -1, my $r; $cursor; $cursor = $r->{next_cursor} ) {
		      my $r = $twitter->friends_list({ screen_name => $user_name, cursor => $cursor });
		      my @user_array =  @{ $r->{ users } };
		      foreach(@user_array)
		      {
			   push @user_names, $_->{screen_name};
		      } 
		}
	        push @follow_array, [ @user_names ]; 
        }

        my $compare_obj = List::Compare->new(@follow_array);
        our @intersection = $compare_obj->get_intersection;
        return \@intersection;
}

1;

# good until invalidated, with ...
#$nt->invalidate_token
