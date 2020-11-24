#!/usr/bin/perl -w
use strict;
use Bio::DB::EUtilities;
use XML::LibXML;
use Email::Address;

my $factory = Bio::DB::EUtilities->new(-eutil => 'esearch',
                                       -email => 'abc@abc.com',
                                       -term  => '((cell-free DNA) OR (circulating cell-free DNA))',
                                       -db    => 'pubmed',
                                       -retmax => 500000);

# query terms are mapped; what's the actual query?
print "Query translation: ",$factory->get_query_translation,"\n";

# query hits
print "Count = ",$factory->get_count,"\n";

# UIDs
my @ids = $factory->get_ids;

for(my $i = 0; $i < $#ids; $i++){
    my $factory = Bio::DB::EUtilities->new(-eutil => 'efetch',
                                           -email => 'abc@abc.com
                                           -db    => 'pubmed',
                                           -retmode => 'xml',
                                           -id => $ids[$i]);

    my $xml = $factory -> get_Response->content;

    my $xml_parser = XML::LibXML->new();

    my $dom = $xml_parser->parse_string($xml);

    my $root = $dom->documentElement();

    for my $node ($root->findnodes('//*[text()]')){
        my $name = $node->nodeName();
        
        for my $child ($node->findnodes('*')){
          binmode STDOUT, ":utf8";
          
          my $nodeName = $child->nodeName;
          my $nodeValue = $child->textContent();
          
          print $nodeName . "\t" . $nodeValue . "\n";
        }
    }
}

