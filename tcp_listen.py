#!/usr/bin/env python
# little socket listener, helpfull for debugging your scripts that send data to graphite
# @author Tim Hunter
#
from socket import *

host = ''
port = 2003
addr = (host,port)

serv = socket(AF_INET,SOCK_STREAM)
serv.bind((addr))
serv.listen(5)
print 'listening...'
while True:
	conn,addr = serv.accept()
	print 'connected...'
	data = conn.recv(4096)
	print "received message: ", data	

