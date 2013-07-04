package sw;

use Rex -base;
use Rex::Commands::Cloud;

####################
# Tasks
####################

desc "Install Apache web server";
task "apache", sub {

    run "apt-get update";
    install package => "apache2";

    service apache2 => "ensure", "started";

    # deploy your webapp, see Rex::Apache::Deploy for more information.
    #deploy "my-site.tar.gz";

    # or upload some files
    #file "/etc/passwd",
    #source => "/etc/passwd";

    # do what ever you want
    #use Rex::Commands::Iptables;
    #close_port "all";
};

1;
