#!perl

#############################################################################
#   kwIssuesParser is to convert the issues.xml into the html format. This 
#program support three kinds of outputs: 
#   issues.htm   - all issues displayed in list form
#   report.htm   - statistics of all the issues
#   somebody.htm - individual issues list, according to the ownership
#Created: 03/04/2012
#Version: 1.0.0              
#Revised: 03/04/2012
#Revised by: Liang Jiameng
#Author: Liang Jiameng
#############################################################################

use Getopt::Long qw(:config require_order no_ignore_case );
use Pod::Usage;
use File::Path;
use File::Basename;
use strict;
#use warnings;
 
my $input  = "issues.xml";              # issues.xml to be converted (default is issues.xml)
my $output = "issues.htm";              # all issues list in html format (default is issues.htm) 
my $report = "report.htm";				# statistics of all issues in html format (default is report.htm)
my $indivpath = "";					    # output dir for individual issues saving (according to the ownership)
my $homepath = ".";						# path where you have saved saxon9he.jar, xslt files(default is current dir)
my $debug    = "";						# print detail infomations during the process
my $version  = "1.0.0";
my $help;

GetOptions( 
		"input|i=s"	    =>  \$input,
		"output=s" 	    =>  \$output,
		"report=s" 	    =>  \$report,
		"indivpath|p=s" =>  \$indivpath,
		"homepath|H=s"  =>  \$homepath,
		"debug!" 	    =>  \$debug,
		"version" 	    =>  sub { VersionMessage() },
		'help|h|?'      =>  sub { pod2usage(-verbose => 2) },
	) or pod2usage(1);

#print "input=$input \n output=$output \n report=$report \n indivpath=$indivpath \n debug=$debug \n ";
#print "...result....$result \n";
!$debug or print "[DEBUG]: input file: $input\n";
!$debug or print "[DEBUG]: output file: $output\n";
!$debug or print "[DEBUG]: report file: $report\n";
!$debug or print "[DEBUG]: indivpath: $indivpath\n";

if ( ! -e "$homepath/saxon9he.jar" ){
	print "Error: FILE \"$homepath/saxon9he.jar\" doesn't exist, please make sure you have entered HOMEPATH correctly.\n";
	exit();
}
if ( ! -e "$homepath/report.xslt" ){
	print "Error: FILE \"$homepath/report.xslt\" doesn't exist, please make sure you have entered HOMEPATH correctly.\n";
	exit();
}
if ( ! -e "$homepath/issues.xslt" ){
	print "Error: FILE \"$homepath/issues.xslt\" doesn't exist, please make sure you have entered HOMEPATH correctly.\n";
	exit();
}
if ( ! -e "$homepath/owner.xslt" ){
	print "Error: FILE \"$homepath/owner.xslt\" doesn't exist, please make sure you have entered HOMEPATH correctly.\n";
	exit();
}

if ( ! -e $input){
	print "Error: input file \"$input\" doesn't exist, please make sure you have entered INPUT option correctly.\n";
	pod2usage(-verbose => 2);
}
my $outPath = dirname($output); 
if ( ! -e $outPath){
	eval { mkpath($outPath) };
	if ($@) {
		print "Error: Can not create $outPath: $@\n";
	}
}
my $reportPath = dirname($report); 
if ( ! -e $reportPath){
	eval { mkpath($reportPath) };
	if ($@) {
		print "Error: Can not create $reportPath: $@\n";
	}
}

# generate report.htm
!$debug or print "[DEBUG]: generating $report\n";
system( "java -jar $homepath/saxon9he.jar -s:$input -xsl:$homepath/report.xslt -o:$report" ) != 256 or die "[Fatal Error]: $? \n";
# generate issues.htm
!$debug or print "[DEBUG]: generating $output\n";
system( "java -jar $homepath/saxon9he.jar -s:$input -xsl:$homepath/issues.xslt -o:$output" ) != 256 or die "[Fatal Error]: $? \n";
# generate individual.htm
if ( !$indivpath == "" ){
	# If indivpath doesn't exist, create.
	if ( ! -e $indivpath){
		eval { mkpath($indivpath) };
		if ($@) {
			print "Error: Can not create $indivpath: $@\n";
		}
	}
	
	!$debug or print "[DEBUG]: generating individual issues html.\n";
	!$debug or print "[DEBUG]: generating owner.txt\n";
	system( "java -jar $homepath/saxon9he.jar -s:$input -xsl:$homepath/owner.xslt -o:$indivpath/owner.txt" ) != 256 or die "[Fatal Error]: $? \n";
	!$debug or print "[DEBUG]: reading ownership informations from owner.txt\n";
	open( OWN, "< $indivpath/owner.txt" )|| die("[Fatal Error]: Cannot obtain ownership informations.\n");
	my $count = 0;
	while(my $owner=<OWN>){   
		chomp $owner;
		if ( !$owner == "" ){
			!$debug or print "[DEBUG]: current user is: $owner\n";
			system( "java -jar $homepath/saxon9he.jar -s:$input -xsl:$homepath/issues.xslt -o:$indivpath/$owner.htm issueOwner=$owner" ) != 256 or die "[Fatal Error]: $? \n";
		}
		$count = $count + 1;
	}
	if ( $count == 0 ){
		print "[Warning]: No ownership informations found. \n";
	} else {
		!$debug or print "[DEBUG]: generate individual issues stage finish\n";
	}
	
}


#Version message information displayed in both --version and --help
sub main::VersionMessage {
    print <<"EOF";
kwIssuesParser - Klocwork Issues Parser. Version $version (for Klocwork 9.x).

Copyright (c) 2012 Beijing Cybersoftek Corp., Ltd. All rights reserved.
This program is free software for Cybersoftek's customer; 
Everyone WITHOUT AUTHORIZED can NOT redistribute it and/or modify. 

This program is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

EOF
    exit 1;
}

__END__

=head2 
kwIssuesParser - Klocwork Issues Parser. Version 1.0.0 (for Klocwork 9.x).
Copyright (c) 2012 Beijing Cybersoftek Corp., Ltd. All rights reserved.
This program is free software for Cybersoftek's customer; 
Everyone WITHOUT AUTHORIZED can NOT redistribute it and/or modify.

=head2
This program is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

=head2


=head1 USAGE

kwIssuesParser.pl [options]

=head1 OPTIONS

 --help, -h            display this help and exit
 --version, -v         print version and exit
 --homepath, -H	PATH   path where you have saved saxon9he.jar, xslt files(default is current dir)
 --input, -i FILE      XML file to be converted (default is issues.xml)
 --output, -o FILE     HTML file for all issues list (default is issues.htm) 
 --report, -r FILE     HTML file for all issues' statistics (default is report.htm)
 --indivpath, -p PATH  output dir for individual issues saving (according to the ownership)
 --debug, -d           print detail infomations during the process

