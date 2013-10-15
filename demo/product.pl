use strict;
use warnings;

use Magento::Backend;
use Magento::Backend::Resource::CatalogProduct;

my %config = (
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
    'Resource::CatalogProduct' => {
        connector => "XMLRPC",
        cachetime => 7 * 24 * 3600,
    },
);

my $backend = Magento::Backend->new(config => \%config);

# print "\n";
# print "#### \$productlist = \$backend->catalogProduct_list()\n";
# print "#### filters out weight > 300 gr\n";
# print "#### productList returns a ARRAYREF\n";
# print "####\n";
# 
# my $productlist = $backend->catalogProduct_list(
#     filter=>{
#         weight=>{'gt'=> 300},
#         dimensions_depth=>{'lt'=>40},
#     }
# );
# foreach (@$productlist) {
#     printf "%-15s                                 %s\n", $_->sku, $_->name;
# }

# warn "This demo takes long! as it uses all products";
# print "\n";
# print "#### foreach \$backend->catalogProduct_list()\n";
# print "#### productList returns a ARRAY\n";
# print "####\n";
# 
# print "SKU             grams        w    h    d  Price Name\n";
# foreach ($backend->catalogProduct_list) {
#     my %info = $_->info(attributes=>[ qw(
#         sku
#         weight
#         dimensions_width
#         dimensions_height
#         dimensions_depth
#         price
#         name
#     ) ]);
#     printf "%-15s %5d     %4d %4d %4d %6.2f %s\n",
#         $info{sku},
#         $info{weight} || 0,
#         $info{dimensions_width} || 0,
#         $info{dimensions_height} || 0,
#         $info{dimensions_depth} || 0,
#         $info{price} || 0,
#         $info{name};
# };


# print "\n";
# print "#### \$productinfo = \$backend->catalogProduct_info(\n";
# print "####     productSKU=>\$sku,\n";
# print "####     attributes=>[...],\n";
# print "#### )\n";
# print "#### productInfo returns a HASHREF\n";
# print "####\n";
# 
# my $productinfo = $backend->catalogProduct_info(
#     storeView => "winkel_en_uk",
#     productSKU => 9789064510977,
#     attributes => [ qw ( sku weight category_ids price name pages ) ]
# );

# print "$productinfo->{sku}, weights $productinfo->{weight}grams and is called $productinfo->{name}\n";

# printf "%-30s => %s\n", $_, $productinfo->{$_} || '<undef>' foreach (keys %$productinfo);


# print "\n";
# print "#### \$backend->catalogProduct_info(productSKU=>\$sku)\n";
# print "#### productInfo with NO attributes parameter\n";
# print "####\n";
# 
# my $productNONE = $backend->catalogProduct_info(
#     productSKU => 9789064510977,
# );
# printf "%-30s => %s\n", $_, $productNONE->{$_} || '<undef>' foreach (keys %$productNONE);



# print "\n";
# print "#### \$backend->catalogProduct_info(productSKU=>\$sku, attributes=>undef)\n";
# print "#### productInfo with EMPTY attributes parameter\n";
# print "####\n";
# 
# my $productNDEF = $backend->catalogProduct_info(
#     productSKU => 9789064510977,
#     attributes => undef ,
# );
# printf "%-30s => %s\n", $_, $productNDEF->{$_} || '<undef>' foreach (keys %$productNDEF);
# 


# print "\n";
# print "#### \$backend->catalogProduct_info(productSKU=>\$sku, attributes=>[...])\n";
# print "#### productInfo with SOME attributes parameter\n";
# print "####\n";
# 
# my $productSOME = $backend->catalogProduct_info(
#     productSKU => 9789064510977,
#     attributes => [ qw(isbn name price) ],
#     storeView  => "winkel_nl_nl",
# );
# printf "%-30s => %s\n", $_, $productSOME->{$_} || '<undef>' foreach (keys %$productSOME);
# 
# my $someprice = $productSOME->{price};
# 
# print "\n";
# print "#### \$backend->catalogProduct_update(productSKU=>\$sku, updates=>{attribute => value ,...})\n";
# print "#### productUpdate with SOME attributes \n";
# print "####\n";
# 
# my $updateresult = $backend->catalogProduct_update(
#     productSKU => 9789064510977,
#     productData => {
#         name => "De Tempelberg doet aan Twister",
#        isbn => "12345X", # this would get me in trouble for testing
#        price => ++$someprice,
#     },
#    storeView  => "2",
#);

# check result
# my $productCHECK = $backend->catalogProduct_info(
#     productSKU => 9789064510977,
#     attributes => [ qw(isbn name price) ],
#     storeView  => "winkel_nl_nl",
# );
# printf "%-30s => %s\n", $_, $productCHECK->{$_} || '<undef>' foreach (keys %$productCHECK);



print "\n";
print "#### \$productlist = \$backend->catalogProduct_list()\n";
print "#### filters out thickness > 40 mm\n";
print "#### productList returns a ARRAY\n";
print "####\n";

# my @productlist = $backend->catalogProduct_list(
#     filter=>{
#         dimensions_depth=>{'gt'=>40},
#     }
# );
# foreach my $prod (@productlist) {
#     my %info = $prod->info(
#         attributes => [ qw(dimensions_depth price) ],
#     );
#     my $price_update = $info{price} * 1.10;
#     printf "%-15s                     %4d %6.2f %s\n",
#         $prod->sku,
#         $info{dimensions_depth},
#         $info{price},
#         $prod->name;
#     my $status = $prod->update(
#         productData => {
#             price => $price_update,
#         },
#     );
#     if ($status) {
#         printf "                                         %6.2f # updated price\n",
#             $price_update;
#     }
#     else {
#         print "something might have gone wrong\n";
#     }
# }


my $filter = {
    weight=>{'gt'=>500},
};
foreach ($backend->catalogProduct_list(filter=>$filter)) {
    $_->update(productData => {
        price => $_->get('price') * 1.10,
        },
    );
};


__END__
