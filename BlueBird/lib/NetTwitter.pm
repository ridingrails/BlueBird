use strict;
package NetTwitter;
use Net::Twitter;
use base 'Exporter';
#our @EXPORT_OK = ('say_token');

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
	my $twitter = return_object();
	my @user_list = @_;
	our @follow_array = ();

}

1;
# good until invalidated, with ...
#$nt->invalidate_token
