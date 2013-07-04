# enable new Features
use Rex -feature => 0.40;
# load helper subroutines
use amazon qw(file_exists);

# set your username
set user => "<user>";

# set your password
set password => "<password>";

# enable password authentication
set -passauth;

# put your server in this group
set group => "servers" => "server1", "server2";

####################
# Credentials to Amazon (EC2) VMs
####################
user "root";
my $pub_key  = File::Spec->catfile( $ENV{PWD}, ".pub-key.key" );
my $priv_key = File::Spec->catfile( $ENV{PWD}, ".priv-key.pem" );
return 0 unless file_exists($pub_key);
return 0 unless file_exists($priv_key);
public_key $pub_key;
private_key $priv_key;

# now load every module via ,,require''
require amazon;
