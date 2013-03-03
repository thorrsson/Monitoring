#!/usr/bin/env python

#
# Writes a passed value to the graphite server of your choosing.
# * *Arguments:
#  host 
#  port
#  tree(Structure to create in Graphite) 
#  value (to be written to graphite 
#
# Examples:
# +from write_to_graphite import w2g+
# +w2g('graphite.yourdomain.com', 2003, 'Data.To.Log', value)+
# 
#
# @author Tim Hunter

import socket
import time
import argparse


def w2g(server, port, tree, value):
	##	define our graphpoint to send (tree, value, timestamp)
	graphpoint = "%s %s %d\n" % (tree, value, int(time.time()))
	##	define and opne our socket to the graphite host
	con = socket.socket()
	con.connect((server, port))
	##	send the graph point to the graphite server
	con.sendall(graphpoint)
	##	cleanup
	con.close()

if __name__ == '__main__':
	##	let us run this from the command line too
	parse = argparse.ArgumentParser(description="Graphite Writer")
	parse.add_argument('-s', '--server', type=str, help="Graphite Server name")
	parse.add_argument('-p', '--port', type=int, help="Graphite Server Port")
	parse.add_argument('-t', '--tree', type=str, help="Graphite tree Structure to write to. ex: Production.Server1.CPU")
	parse.add_argument('-v', '--value', type=str, help="Value to send to Graphite")
	##	sanity checks, make sure we have all the nessecary data
	args = parse.parse_args()
	if args.server and args.port and args.tree and args.value: 
		w2g(args.server,args.port,args.tree,args.value)
	else:
		parse.print_help()
