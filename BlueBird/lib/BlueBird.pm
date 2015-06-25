package BlueBird;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

post '/sign_in' => sub {
    template 'sign_in';
};

true;
