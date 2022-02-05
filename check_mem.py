#!/usr/bin/python

# check_mem.py - basic memory check that writes out to graphite
# @author Tim Hunter

try:
	from write_to_graphite import w2g ##	(server, port, tree, value)
except:
	print "could not import the graphite writer, grab it from https://github.com/thorrsson/Monitoring"
import subprocess
import socket
try:
	import psutil
except:
	print "Could not import psutil, try 'pip install psutil',,,

def check_mem():
	server = 'localhost'
	port = 2003
	##	hostname needed for the graphite tree
	hostname = socket.gethostname()
	##	build the tree up a bit
	tree = hostname+".memory."
	##	build a dictionary of the values we want to graph
	try:
		mem_dict = {"total_physical_memory": psutil.phymem_usage().total, 'free_physical_memory':psutil.phymem_usage().free, "used_physical_memory": psutil.phymem_usage().used, "total_virtual_memory":psutil.total_virtmem(), "free_virtual_memory": psutil.avail_virtmem(), "used_virtual_memory": psutil.used_virtmem()}
		##	Iterate the dictionary and write out the value to graphite for each key
		for key in mem_dict:
			w2g(server, port, tree+key, mem_dict[key])
	except Exception as e: ##	clean up errors a bit
		print e
		exit(1)
		


if __name__ == '__main__':
	check_mem()
