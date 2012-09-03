#!/usr/bin/env ruby

#
# Writes a passed value to the graphite server of your choosing.
# @author Tim Hunter
# * *Arguments:
#  host
#  port
#  tree(Structure to create in Graphite)
#  value (to be written to graphite
#
# Examples:
# +require 'write_to_graphite'+
# +graphite = Write_To_Graphite::Graph.new('graphite.yourdomain.com', 2003, 'DataTree.To.Log')+
# +graphite.write_out(value)+

require 'rubygems'
require 'socket'

module Write_To_Graphite

  class Graph
    def initialize (host,port,tree)
      @graphite_host = host
      @graphite_port = port
      time = Time.new
      @epoch = time.to_i #get me an epoch time to write to graphite
      @tree = tree #Tree is the structure in graphite
    end #end Init

    def write_out(value) #passed value to be written to graphite
      begin#open my socket
        socket = TCPSocket.open("#{@graphite_host}", "#{@graphite_port}") 
      rescue
        puts "failed to open the socket"
        socket.close
      else# write the data to graphite, then clean up after ourselves
        socket.write("#{@tree} #{value} #{@epoch}\n")
        socket.close
      end

    end
  end
end

    





