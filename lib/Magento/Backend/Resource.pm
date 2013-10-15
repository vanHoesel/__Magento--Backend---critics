package Magento::Backend::Resource;

use Moose::Role;

# holds a reference to where this object came from
has _backend => (
    is  => 'rw',
#    isa => 'Magento::Backend',
    default => sub { { } },
);

1; # Magneto::Base

__END__

=head1 NAME

Magento::Backend::Resource - Moose::Rol

=head1 VERSION

0.02 beta

=head1 SYNOPSIS

Initialising

    use Magento::Backend;
    use Magento::Backend::Resource::CatalogProduct;
    
    my $backend=Magento::Backend->new(config=>\%config);    

Retrieving a filtered list of products from the C<$backend>

    @list=$backend->catalogProduct_list(
        filter=>{
            price=>{'lt'=>10.00},
            weight=>{'gt'=>250.00},
        },
    );

Retrieving detailed info on a specified product from the C<$backend>

    %info=$backend->catalogProduct_info(
        productSKU=>$sku,
        attributes=>[qw/name price weight/]),
        storeView=>'en_uk',
    );
    

=head1 DESCRIPTION

This describes the overview of the Magento Resources

=head1 RESOURCES

=head2 CatalogProduct

This module allows you to manage products
For more information see
L<Magento::Backend::Resources::CatalogProduct>

=over 4

=item $backend->catalogProduct_list

Allows you to retrieve the list of products

=back

=head1 DISCLAIMER

This software is as is, and does not do any pre-checks or error processing

B<Use at your own risk!>

=head1 AUTHOR

Theo van Hoesel

=over 4

=item Send-a-Newbie - YAPC::EU::2013 Kiev

=item proudly sponsered by the community

=cut

#=item L<Enlightened Perl Organisation|http://www.send-a-newbie.enlightenedperl.org>

=item L<http://www.send-a-newbie.enlightenedperl.org>

=back

=head1 COPYRIGHT

Copyright 2013 Th.J. van Hoesel

=head1 SEE ALSO

=over 4

=item Magento API - Catalog Product

L<http://www.magentocommerce.com/api/soap/catalog/catalogProduct/catalogProduct.html>

=back

=cut
