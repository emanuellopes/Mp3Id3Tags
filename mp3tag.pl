#!/usr/bin/perl

use MP3::Tag; # import module
use File::Basename;

MP3::Tag->config(write_v24 => 1);
@files = <*.mp3>; # find MP3 files in current directory

# loop over file list
# print tag information


$i=0;
foreach (@files) {
	$mp3 = MP3::Tag->new($_);
	$fileInfo = basename($_, ".mp3");
	@info = split(/ - | — /, $fileInfo);
	print $info[0] . "|||||". $info[1] . "\n";

  	if (! exists $mp3->{ID3v1}){
  		$mp3->new_tag("ID3v1");
  	}

  	if (! exists $mp3->{ID3v2}){
  		$mp3->new_tag("ID3v2");
  	}


	#title
	$mp3->{ID3v1}->title($info[1]);
	$mp3->{ID3v2}->title($info[1]);
	#artist
	$mp3->{ID3v1}->artist($info[0]);
	$mp3->{ID3v2}->artist($info[0]);
	$mp3->{ID3v1}->write_tag();
	$mp3->{ID3v2}->write_tag();
	$mp3->close();
}
