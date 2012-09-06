#!/usr/bin/env ruby

#
# Writes a passed value to the graphite server of your choosing.
# * *Arguments:
#  host <h>
#  port<p>
#  tree(Structure to create in Graphite) <t>
#  value (to be written to graphite <v>
#
# Examples:
# +require './write_to_graphite'+
# +graphite = Write_To_Graphite::Graph.new('graphite.yourdomain.com', 2003, 'Data.To.Log')+
# +graphite.write_out(value)+
#
# @author Tim Hunter

require 'rubygems'
require 'socket'
require 'logger'

module Write_To_Graphite

  class Graph
    def initialize (h,p,t)
      @log = Logger.new('/var/log/write_out.log', 'daily') #//TODO: path should be dynamic based on OS so that this can be run from Win too
      @log.level = Logger::DEBUG
      @graphite_host = h
      @graphite_port = p
      time = Time.new
      @epoch = time.to_i #get me an epoch time to write to graphite
      @tree = t #Tree is the structure in graphite
    end #end Init

    def write_out(v) #v = passed value to be written to graphite
      value = v
      begin#open my socket
        socket = TCPSocket.open("#{@graphite_host}", "#{@graphite_port}") 
      rescue#log out errors and close the socket and log nicely
        @log.error "error #{$!}"
        socket.close
        @log.close
      else#write a log entry for this transaction and then write the data to graphite, then clean up after ourselves
        @log.info "writing #{@tree} #{value} #{@epoch} to #{@graphite_host}:#{@graphite_port}"
        socket.write("#{@tree} #{value} #{@epoch}\n") #write out to graphite
        socket.close
        @log.close
      end

    end #end write_out
 end #end Graph
end #end Module