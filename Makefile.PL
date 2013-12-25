
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "EZTV scrapper",
  "AUTHOR" => "Diego Kuperman <diego\@freekeylabs.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "WWW-EZTV",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "WWW::EZTV",
  "PREREQ_PM" => {
    "Mojo::UserAgent" => 0,
    "Moose" => 0,
    "Moose::Role" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.96",
    "strict" => 0
  },
  "VERSION" => "0.04",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Mojo::UserAgent" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "Test::More" => "0.96",
  "strict" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



