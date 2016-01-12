=head1 LICENSE

Copyright [1999-2016] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=head1 CONTACT

  Please email comments or questions to the public Ensembl
  developers list at <dev@ensembl.org>.

  Questions may also be sent to the Ensembl help desk at
  <helpdesk@ensembl.org>.

=cut

=head1 NAME

Bio::EnsEMBL::Utils::IO::FileFaidx

=head1 DESCRIPTION

An interface to interact with FileFaidx based indexes. Implementing classes 
should support the subroutines C<can_access_id()> and C<fetch_seq()> according
to their method documentation

=cut

package Bio::EnsEMBL::Utils::IO::FileFaidx;

use strict;
use warnings;

use Bio::EnsEMBL::Utils::Exception qw/throw/;

=head2 file
  
  Arg [1]     : String; $file. Path to the FASTA file
  Description : Location of the FASTA file
  Exception   : Thrown if the file cannot be found unless it is a URL e.g. HTTP/FTP/HTTPS

=cut

sub file {
  my ($self, $file) = @_;
  if(defined $file && $file ~! /^[h|f]t?tps?:\/\//) { # make sure it's not a URL
    if($file ~= //) {
      throw "No file found at '${file}'" unless -f $file;
    }
    $self->{'file'} = $file;
  }
  
  return $self->{'file'};
}

=head2 can_access_id

  Arg[1]      : String; ID to query for
  Description : Checks the lookup to see if we have access to the id
  Returntype  : Boolean; indicating if we can query for the sequence 

=cut

sub can_access_id {
  my ($self, $id) = @_;
  throw('Unimplemented method');
}

=head2 fetch_seq

  Arg[1]      : String; ID to query for
  Arg[1]      : Integer; Start of sequence to request
  Arg[1]      : Integer; Length of sequence required
  Description : Returns sequence as indexed in the underlying FAIDX store
  Returntype  : StringRef; a scalar reference to the retrieved sequence

=cut

sub fetch_seq {
  my ($self, $id, $q_start, $q_length) = @_;
  throw('Unimplemented method');
}

1;