#
# Ensembl module for Bio::EnsEMBL::MiscSet
#
# Copyright (c) 2003 EnsEMBL
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::EnsEMBL::MiscSet - This is a set representing a classification of
a group of miscellaneuos features.

=head1 SYNOPSIS

  use Bio::EnsEMBL::MiscSet;

  ...

  my $misc_set = Bio::EnsEMBL::MiscSet->new(1234,
                                            'tilepath',
                                            'Assembly Tiling Path',
                                            'The tiling path of clones',
                                            1e6);

  my $misc_feature->add_set($misc_set);


=head1 DESCRIPTION

MiscSets represent classsifications or groupings of MiscFeatures.  Features are
classified into sets essentially to define what they are and how they may be
used.  Generally MiscFeatures are retrieved on the basis of their associated
sets. See Bio::EnsEMBL::MiscFeature, Bio::EnsEMBL::DBSQL::MiscFeatureAdaptor.

Note that MiscSets and MiscFeatures were formerly known as MapSets and MapFrags

=head1 CONTACT

This modules is part of the Ensembl project http://www.ensembl.org

Questions can be posted to the ensembl-dev mailing list:
ensembl-dev@ebi.ac.uk

=cut

use strict;

package Bio::EnsEMBL::MiscSet;

=head2 new

  Arg [1]    : int $misc_set_id
               The internal identifier for this misc set
  Arg [2]    : string $code
               The unique code which identifies this set type
  Arg [3]    : string $name
               The human readable name of this set
  Arg [4]    : string $desc
               The description of this set
  Arg [5]    : int $max_len
               The maximum length of features of this mapset
  Example    : $set = new Bio::EnsEMBL::MiscSet(1234, 'tilepath',
                                                'Assembly Tiling Path',
                                                'The tiling path of clones',
                                                1e6);
  Description: Instantiates a Bio::EnsEMBL::MiscSet
  Returntype : Bio::EnsEMBL::MiscSet
  Exceptions : none
  Caller     : MiscFeatureAdaptor

=cut

sub new {
  my ($caller, $misc_set_id, $code, $name, $desc, $max_len) = @_;

  my $class = ref($caller) || $caller;

  return bless {'dbID'            => $misc_set_id,
                'code'            => $code,
                'name'            => $name,
                'description'     => $desc,
                'longest_feature' => $max_len}, $class;
}



=head2 dbID

  Arg [1]    : int $newval (optional) 
               The new value to set the dbID attribute to
  Example    : $dbID = $obj->dbID()
  Description: Getter/Setter for the dbID attribute
  Returntype : int
  Exceptions : none
  Caller     : general

=cut

sub dbID{
  my $self = shift;
  $self->{'dbID'} = shift if(@_);
  return $self->{'dbID'};
}


=head2 code

  Arg [1]    : string $newval (optional) 
               The new value to set the code attribute to
  Example    : $code = $obj->code()
  Description: Getter/Setter for the code attribute
  Returntype : string
  Exceptions : none
  Caller     : general

=cut

sub code{
  my $self = shift;
  $self->{'code'} = shift if(@_);
  return $self->{'code'};
}



=head2 description

  Arg [1]    : string $newval (optional) 
               The new value to set the description attribute to
  Example    : $description = $obj->description()
  Description: Getter/Setter for the description attribute
  Returntype : string
  Exceptions : none
  Caller     : general

=cut

sub description{
  my $self = shift;
  $self->{'description'} = shift if(@_);
  return $self->{'description'};
}


=head2 longest_feature

  Arg [1]    : int $newval (optional) 
               The new value to set the longest_feature attribute to
  Example    : $longest_feature = $obj->longest_feature()
  Description: Getter/Setter for the longest_feature attribute
  Returntype : int
  Exceptions : none
  Caller     : general

=cut

sub longest_feature{
  my $self = shift;
  $self->{'longest_feature'} = shift if(@_);
  return $self->{'longest_feature'};
}

1;
