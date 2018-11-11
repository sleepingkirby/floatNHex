#!/usr/bin/perl 
use Data::Dumper qw(Dumper);

#----------------------------------------------
#Usage: floatNHex.pl <hex or float>
#Uses perl's pack and unpack to calculate. Not meant for highly scientific accuracy.
#Doesn't handle scientific notation (i.e. 1.23e5)
#Because I'm tired of doing it manually and there's no offline calc app that'll do it.
#----------------------------------------------

$in=$ARGV[0];

#--------------- it's a floating point, convert to 32 and 64 bit hex----------
if($in=~/^-?[0-9]*\.[0-9]*$/ || $in=~/^-?[0-9]+$/){
print "\nConverting from float to hex\n\n";

	if($in==0 || $in==0.0){
	printf("32 bit: %08d\n", $in);
	printf("64 bit: %016d \n", $in);
	}
	else{
	$sgn32= unpack "L", pack "f", $in;
	$sgn64= unpack "Q", pack "d", $in;
	printf "32 bit: %x\n", $sgn32;
	printf "64 bit: %x\n", $sgn64;
	}

exit 0;
}


#--------------- it's a hex, get how many bytes and convert to 32 or 64 bit float
if($in=~/(0[xX])?[0-9a-fA-F]./){
	#---- if has 0X or 0x, remove it.
	if($in=~/^(0[xX])/){
	$in=substr($in, 2);
	}


$len=length($in);

	if($len!=8 && $len!=16){
	print "Hex value entered not 32 or 64 bit: ".$in." [".(4*$len)." bits]\n";
	exit 1;
	}


	$in=hex $in; #converting the string into hex value

print "\nConverting from hex to float [".(4*$len)." bits]\n\n";
	if($len==8){
	my $sgn32= unpack "f", pack "L", $in ;
	printf "Float: %f\n", $sgn32;
	}
	elsif($len==16){
	$sgn64= unpack "d", pack "Q", $in;
	printf "Float: $sgn64\n";
	}

exit 0;
}


exit 0;
