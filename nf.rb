#!/usr/bin/ruby

require_relative 'lib/map.rb'
require_relative 'lib/path_group.rb'
require_relative 'lib/algorithm.rb'

map = NF::Map.load('resources/nf-map')
pg1 = NF::PathGroup.load('resources/path1.yml')
pg2 = NF::PathGroup.load('resources/path2.yml')
pg3 = NF::PathGroup.load('resources/path3.yml')
pg4 = NF::PathGroup.load('resources/path4.yml')

path_groups = [pg1, pg2, pg3, pg4]
NF::Algorithm.new(map, path_groups).call
