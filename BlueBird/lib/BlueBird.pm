package BlueBird;
use Dancer2;
use NetTwitter;
use List::Compare;
use Dancer::Exception qw(:all);
use JSON;
set serializer => 'JSON';

our $VERSION = '0.1';

my $twitter = NetTwitter::return_object();



post '/api/recent' => sub {
    my $data_json = request->body;
    my $data = from_json( $data_json );
  
    if (exists($data->{'user'})) 
    {
        try 
        {
            my $user = $data->{'user'};
	    debug $user;
            my @tweets = $twitter->user_timeline({screen_name => $user});
            #my $json_tweets = encode_json(\@tweets); 
            #return $json_tweets;
            return \@tweets;
        }
        catch 
        {
            my ($exception) = @_;
            if ($exception->does('Core')) 
            {
                send_error(join(' ', "Core exception: ",
                  $exception->code, $exception->message, $exception->error));
            } 
            else 
            {
                send_error(join(' ', "Error getting timeline: ",
                  $exception->code, $exception->message, $exception->error)); 
	    }
        };
    }
    else 
    {
       send_error("Error: screen name not given");
    }
};

post '/api/common_follows' => sub {
    my $data_json = request->body;
    my $data = decode_json($data_json); 
    my @user_list = @{$data->{'user_list'}};
    if (exists($data->{'user_list'}))
    {
        try 
        { 
	    #debug "@user_list\n";
	    my @follow_array = ();
	    #for each user in list get follows
	    for my $i (0 .. $#user_list)
	    {
	        my $user_name = $user_list[$i];
	        debug "$user_name\n";
	        my @user_names = ();        
	        for ( my $cursor = -1, my $r; $cursor; $cursor = $r->{next_cursor} ) {
		    my $r = $twitter->friends_list({ screen_name => $user_name, cursor => $cursor });
		    debug "$r->{users}\n";
		    #my @user_names = ();
		    my @user_array =  @{ $r->{ users } };
		    foreach(@user_array)
		    {
		        debug $_->{screen_name};
		        push @user_names, $_->{screen_name};
		    }
		    #$r = $twitter->friends_list({ screen_name => $user_name, cursor => $cursor });
	        } 
	        push @follow_array, [ @user_names ];
	        debug "@follow_array\n"
	    }

	    my $compare_obj = List::Compare->new(@follow_array);
	    my @intersection = $compare_obj->get_intersection;
	    #my $json_intersection = encode_json(\@intersection); 
	    #return $json_intersection;
	    return \@intersection;
        }
        catch 
        {
            my ($exception) = @_;
            if ($exception->does('Core')) 
            {
                send_error(join(' ', "Core exception: ",
                  $exception->code, $exception->message, $exception->error));
            } 
            else 
            {
                send_error(join(' ', "Error getting intersection: ",
                  $exception->code, $exception->message, $exception->error)); 
	    }
        }
    }
    else 
    {
       send_error("Error: user list not given");
    }
};

true;
