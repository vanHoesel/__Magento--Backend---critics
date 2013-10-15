use strict;
use warnings;

use Magento::Backend;

my $config = {
    'Connector::Default' => "MISSING",
    'Connector::XMLRPC' => {
        host_url => "http://networkserver.boekhandel-lighthouse.nl/magento/index.php/api/xmlrpc",
        username => "GitHub_test_products_136",
        password => "GitHub_136!",
    },
    'Connector::DBI' => {
        dbi_handle => "dbi:CSV:f_dir=$ENV{HOME}/magento/",
#       username => "database_user",
#       password => "top-secret",
    },
    'Resource::Store' => {
        connector => "XMLRPC",
        cachetime => 7 * 24 * 3600,
    },
};

my $backend = Magento::Backend->new($config);

__END__