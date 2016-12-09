#!/bin/bash	

#backup /home directory to timestamped tar file
#must be run with su privileges

tar czf /var/backups/file_$(date +\%Y-\%m-\%d).tar.gz /home/jhodge