use strict;
use warnings;

use Magento::Backend;
use Magento::Backend::Resource::Store;

my $config = {
#    'Connector::Default' => "MISSING",
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
#     'Resource::Store' => {
#         connector => "XMLRPC",
#         cachetime => 7 * 24 * 3600,
#     },
};

my $backend = Magento::Backend->new(config => $config);

print "\n";
print "#### \$backend->storeList\n";
print "####\n";

printf "%2d %2d: %-20s %s\n", $_->store_id, $_->website_id, $_->code, $_->name foreach $backend->store_list;


print "\n";
print "#### \%storeinfo = \$backend->storeInfo(storeID=>2)\n";
print "#### storeInfo returns a HASH\n";
print "####\n";

my %storeinfo = $backend->store_info(storeID=>2);
printf "%-30s => %s\n", $_, $storeinfo{$_} foreach (keys %storeinfo);
print "\n";


print "\n";
print "#### \$backend->storeInfo(storeID=>3)->{code}\n";
print "#### storeInfo returns a HASHREF\n";
print "####\n";

print $backend->store_info(storeID=>3)->{code}, "\n";
print "\n";


print "\n";
print "#### \$backend->storeList\n";
print "####     \$store->info (instance method)\n";
print "####\n";

foreach ($backend->store_list) {
    my %result = $_->info;
    printf "%2d %2d: %-20s %s\n",
        $result{store_id},
        $result{website_id},
        $result{code},
        $result{name};
};

__END__
