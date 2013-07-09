package amazon;

use Rex -base;
use File::Spec;
use YAML;
use Rex::Commands::Cloud;
use Data::Dumper;

####################
# Amazon credentials
####################

# read content of $pass_file into $content
my $pass_file = File::Spec->catfile( $ENV{PWD}, ".pass.yml" );
return 0 unless file_exists($pass_file);
my $content = eval { local ( @ARGV, $/ ) = ($pass_file); <>; };

# load yaml into perl hashRef
my $config = Load($content);

my $access_key        = $config->{auth}->{access_key};
my $secret_access_key = $config->{auth}->{password};
my $cloud_region      = $config->{cloud}->{region};
cloud_service "Amazon";
cloud_auth "$access_key", "$secret_access_key";
cloud_region $cloud_region;

####################
# Helper subroutines
####################

# export those used in Rexfile
use Exporter qw(import);
our @EXPORT_OK = qw(file_exists);

sub file_exists {
    my $file = shift;
    unless ( -e $file ) {
        print "'$file' does not exist\n";
        return 0;
    }
    return 1;
}

sub vm_name2id {
    my $name = shift;

    for my $instance ( cloud_instance_list() ) {
        if ( $instance->{"name"} eq "$name" ) {
            return $instance->{"id"};
        }
    }
}

####################
# Tasks
####################

desc "List all VMs and volumes (raw format)";
task "dump", sub {
    print Dumper cloud_instance_list;
    print Dumper cloud_volume_list;
};

desc "List running VMs";
task "list-running", sub {
    for my $instance ( cloud_instance_list() ) {
        if ( $instance->{"state"} eq "running" ) {
            print "\n";
            say "NAME  : " . $instance->{"name"};
            say "IP    : " . $instance->{"ip"};
            say "ID    : " . $instance->{"id"};
        }
    }
};

desc "List all VMs";
task "list", sub {
    for my $instance ( cloud_instance_list() ) {
        print "\n";
        say "NAME  : " . ( $instance->{"name"}  // "n/a" );
        say "IP    : " . ( $instance->{"ip"}    // "n/a" );
        say "ID    : " . ( $instance->{"id"}    // "n/a" );
        say "STATE : " . ( $instance->{"state"} // "n/a" );
    }
};

desc "Create VM: $0 create --name=<vm-name>";
task "create", sub {
    my $params = shift;
    my $name   = $params->{name};
    unless ( defined $name ) {
        print STDERR "Usage: $0 create --name=<vm-name>\n";
        return;
    }
    cloud_instance create => {
        image_id => "ami-02103876",
        name     => $name,
        key      => "rex",
    };
    my ($instance) = grep { $_->{name} eq $name } cloud_instance_list();
    say $instance->{ip};
};

desc "Destroy VM: $0 destroy --name=<vm-name>";
task "destroy", sub {
    my $params = shift;
    unless ( $params->{name} ) {
        print STDERR "Usage: $0 destroy --name=<vm-name>\n";
        return;
    }
    my $instance_id = vm_name2id( $params->{name} );
    cloud_instance terminate => "$instance_id";
};

1;
