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
            my @tweets = $twitter->user_timeline({screen_name => $user});
            return \@tweets;
        }
        catch 
        {
            my ($exception) = @_;
	    handle_exceptions($exception);
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
    if (exists($data->{'user_list'}))
    {
        try 
        { 
            my @user_list = @{$data->{'user_list'}}; 
            return NetTwitter::user_list_intersection($twitter, @user_list);
        }
        catch 
        {
            my ($exception) = @_;
	    handle_exceptions($exception);
        };
    }
    else 
    {
       send_error("Error: user list not given");
    }
};




#exception handling subroutine

sub handle_exceptions {
    my $exception = @_;
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

true;
