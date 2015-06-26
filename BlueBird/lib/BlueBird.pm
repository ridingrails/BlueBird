package BlueBird;
use Dancer2;
use NetTwitter;
use JSON;

our $VERSION = '0.1';

my $twitter = NetTwitter::return_object();

get '/' => sub {
    return $twitter->access_token;
};

post '/recent' => sub {
    my $data_json = request->body;
    my $data = from_json( $data_json );
    my $user = $data->{'user'};
    my @tweets = $twitter->user_timeline({screen_name => $user});
    my $json_tweets = encode_json(\@tweets); 
    return $json_tweets;
};

true;
