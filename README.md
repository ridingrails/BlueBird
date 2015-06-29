**BlueBird Documentation**

**Getting Started - UNIX/Linux**

Create a Twitter account

Sign up and create a Twitter app as a developer. Get a consumer key and secret.

Install perl (the API was created in Perl 5) 
```
sudo apt-get install perl
```
Install dependencies: Dancer, List::Compare, and Net::Twitter using cpanminus
```
cd /opt/
curl https://raw.github.com/miyagawa/cpanminus/master/cpanm > cpanm
chmod +x cpanm
ln -s /opt/cpanm /usr/bin/

cpanm --self-upgrade --sudo

cpan --sudo [Module::Name]
```
If running the API locally, deployment is done using Plackup Middlware, running the following command in the directory above /bin:
```
plackup -r bin/app.psgi
```

**Usage**

Go to the BlueBird deployment url (http://ec2-52-26-140-189.us-west-2.compute.amazonaws.com:5000 + endpoint path) to use the API. As a JSON API, the consumer will be responsable for choosing a format for response consumption. 

The API currently features 2 endpoints, decribed below:

POST /api/recent

This endpoint will take in a JSON map of a Twitter screen name in JSON format under the tag "user" and return a list of the 20 most recent tweets from that user in JSON. A malformed or incorrect JSON input will result in a 500 error and a message returning the actual Twitter API error if relevant.

SAMPLE request body: '{"user": "bob"}'

POST /api/common_follows

This endpoint will take in a JSON map of Twitter screen names in JSON array format under the tag "user_list" and return a JSON array of the screen names of the Twitter users followed by all users in the list. The number of users in the input can be more than 2.

SAMPLE request body: '{"user_list": ["riclbb", "billyboblbb", "JonnyBallin"]}'
