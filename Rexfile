# enable new Features
use Rex -feature => 0.40;
# load helper subroutines
use amazon qw(file_exists);

# put your server in this group
set group => "servers" => "server1", "server2";

# now load every module via ,,require''
require amazon;
require sw;

# Credentials to Amazon (EC2) VMs
user "root";
my $pub_key  = File::Spec->catfile( $ENV{PWD}, ".pub-key.key" );
my $priv_key = File::Spec->catfile( $ENV{PWD}, ".priv-key.pem" );
return 0 unless file_exists($pub_key);
return 0 unless file_exists($priv_key);
public_key $pub_key;
private_key $priv_key;
