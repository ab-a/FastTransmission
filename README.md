# FastTransmission

A little shell script to install and configure automatically `Transmission Torrent` (include `vsftpd` installation).

You've to edit the `USER-PASSWORD` and the `WEB-PASSWORD` variables (line 2), and : 

```
$ chmod +x init.sh
# ./init.sh
```

Then go to http://your-ip:9091 (user : transmission, password : `$WEB-PASSWORD`). 

For sFTP / FTP the user is `td`, the password is `$USER-PASSWORD` and the download directory is `/home/td/downloads`. 

Simple !
