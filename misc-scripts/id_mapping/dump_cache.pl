#!/usr/local/bin/perl

=head1 NAME


=head1 SYNOPSIS

.pl [arguments]

Required arguments:

  --dbname, db_name=NAME              database name NAME
  --host, --dbhost, --db_host=HOST    database host HOST
  --port, --dbport, --db_port=PORT    database port PORT
  --user, --dbuser, --db_user=USER    database username USER
  --pass, --dbpass, --db_pass=PASS    database passwort PASS

Optional arguments:

  --conffile, --conf=FILE             read parameters from FILE
                                      (default: conf/Conversion.ini)

  --logfile, --log=FILE               log to FILE (default: *STDOUT)
  --logpath=PATH                      write logfile to PATH (default: .)
  --logappend, --log_append           append to logfile (default: truncate)

  -v, --verbose=0|1                   verbose logging (default: false)
  -i, --interactive=0|1               run script interactively (default: true)
  -n, --dry_run, --dry=0|1            don't write results to database
  -h, --help, -?                      print help (this message)

=head1 DESCRIPTION


=head1 LICENCE

This code is distributed under an Apache style licence. Please see
http://www.ensembl.org/info/about/code_licence.html for details.

=head1 AUTHOR

Patrick Meidl <meidl@ebi.ac.uk>, Ensembl core API team

=head1 CONTACT

Please post comments/questions to the Ensembl development list
<ensembl-dev@ebi.ac.uk>

=cut

use strict;
use warnings;
no warnings 'uninitialized';

use FindBin qw($Bin);
use vars qw($SERVERROOT);

BEGIN {
    $SERVERROOT = "$Bin/../../..";
    unshift(@INC, "$SERVERROOT/ensembl/modules");
    unshift(@INC, "$SERVERROOT/bioperl-live");
}

use Getopt::Long;
use Pod::Usage;
use Bio::EnsEMBL::Utils::ConfParser;
use Bio::EnsEMBL::Utils::Logger;
use Bio::EnsEMBL::IdMapping::Cache;

$| = 1;

my $conf = new Bio::EnsEMBL::Utils::ConfParser(
  -SERVERROOT => $SERVERROOT,
);

# parse options
$conf->param('default_conf', './default.conf');
$conf->parse_common_options(@_);
$conf->parse_extra_options(qw(
  oldhost|old_host=s
  oldport|old_port=n
  olduser|old_user=s
  oldpass|old_pass=s
  olddbname|old_dbname=s
  newhost|new_host=s
  newport|new_port=n
  newuser|new_user=s
  newpass|new_pass=s
  newdbname|new_dbname=s
  dumppath|dump_path=s
  cachefile|cache_file=s
  chromosomes|chr=s@
  region=s
  biotypes=s@
));
$conf->allowed_params(
  $conf->get_common_params,
  qw(
    oldhost oldport olduser oldpass olddbname
    newhost newport newuser newpass newdbname
    dumppath cachefile
    chromosomes region biotypes
  )
);

if ($conf->param('help') or $conf->error) {
    warn $conf->error if $conf->error;
    pod2usage(1);
}

# ask user to confirm parameters to proceed
$conf->confirm_params;

# get log filehandle and print heading and parameters to logfile
my $logger = new Bio::EnsEMBL::Utils::Logger(
  -LOGFILE      => $conf->param('logfile'),
  -LOGPATH      => $conf->param('logpath'),
  -LOGAPPEND    => $conf->param('logappend'),
  -VERBOSE      => $conf->param('verbose'),
  -IS_COMPONENT => $conf->param('is_component'),
);

# initialise log
$logger->init_log($conf->list_all_params);

# check required parameters were set
$conf->check_required_params(
  qw(
    oldhost oldport olduser olddbname
    newhost newport newuser newdbname
    dumppath
  )
);

my $cache = new Bio::EnsEMBL::IdMapping::Cache(
  -LOGGER       => $logger,
  -CONF         => $conf,
);

unless ($cache->cache_file_exists) {
  # load objects from database
  $cache->build_cache;

  # write cache to file
  $cache->write_to_file;
}

# finish logfile
$logger->finish_log;


### END main ###

