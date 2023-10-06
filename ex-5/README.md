# Script/small program:

Given the access log file, we need to know:
-  Top 5  ips that visited the server
Example:
```shell script
9945 83.149.9.216
555 91.177.205.119
[...]
```
- Count the different http code status by http method
```shell script
999 200 GET
5 GET 200
1 200 POST
```


#References
The access log file was a random one found in [github](https://raw.githubusercontent.com/linuxacademy/content-elastic-log-samples/master/access.log) 