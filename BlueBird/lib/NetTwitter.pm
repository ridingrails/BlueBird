use strict;
package NetTwitter;
use Net::Twitter;
use base 'Exporter';
our @EXPORT_OK = ('say_token');

sub some_function {
    # put sane code here
    return 123;
}


my $nt = Net::Twitter->new(
	traits          => [ qw/AppAuth API::RESTv1_1/ ],
	consumer_key    => 'JkAf2da5YbQp6SKY8j5ManVOS',
	consumer_secret => 'fUhbRyqaTkxeimxonnSdNxuGJTF3YpHwBLiRGlz0WXXlzBYWxO',
);

$nt->request_access_token;


sub return_token {
        # put sane code here
	#say 'token: ', $nt->access_token;
        return $nt->access_token;
}

sub return_object {
        # put sane code here
	#say 'token: ', $nt->access_token;
        return $nt;
}


my $r = $nt->followers_ids({
	screen_name => 'timtoady',
	cursor      => -1,
});

# good until invalidated, with ...
#$nt->invalidate_token
