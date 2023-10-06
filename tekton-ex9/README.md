# Writing a Tekton Pipeline for Building a Docker Container
Documentation checked. The manifests were taken from the examples.
https://tekton.dev/docs/installation/pipelines/
https://tekton.dev/docs/how-to-guides/kaniko-build-push/
https://hub.tekton.dev/tekton/task/kaniko
https://tekton.dev/docs/how-to-guides/kaniko-build-push/#full-code-samples


Tasks done for make it work:
```shell script
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/kaniko/0.6/raw #install the task
tkn hub install task kaniko #Install dependencies
tkn hub install task git-clone
kubectl create ns pipelines #We created a namespace for applying the manifests.
kubectl apply -f credentials.yaml   
kubectl apply -f pipeline.yaml    
kubectl create -f pipeline-run.yaml

```

Then we checked the execution:
```shell script
pipelinerun.tekton.dev/clone-build-push-run-84cgk created
tkn pipelinerun logs clone-build-push-run-84cgk -f                 
[fetch-source : clone] + '[' false '=' true ]
[fetch-source : clone] + '[' false '=' true ]
[fetch-source : clone] + '[' false '=' true ]
[fetch-source : clone] + CHECKOUT_DIR=/workspace/output/
[fetch-source : clone] + '[' true '=' true ]
[fetch-source : clone] + cleandir
[fetch-source : clone] + '[' -d /workspace/output/ ]
[fetch-source : clone] + rm -rf '/workspace/output//*'
[fetch-source : clone] + rm -rf '/workspace/output//.[!.]*'
[fetch-source : clone] + rm -rf '/workspace/output//..?*'
[fetch-source : clone] + test -z 
[fetch-source : clone] + test -z 
[fetch-source : clone] + test -z 
[fetch-source : clone] + git config --global --add safe.directory /workspace/output
[fetch-source : clone] + /ko-app/git-init '-url=https://github.com/komljen/dockerfile-examples.git' '-revision=' '-refspec=' '-path=/workspace/output/' '-sslVerify=true' '-submodules=true' '-depth=1' '-sparseCheckoutDirectories='
[fetch-source : clone] {"level":"info","ts":1696600265.5346153,"caller":"git/git.go:176","msg":"Successfully cloned https://github.com/komljen/dockerfile-examples.git @ 0834b09e172f9c899eb98ffe1463b67136cf05ea (grafted, HEAD) in path /workspace/output/"}
[fetch-source : clone] {"level":"info","ts":1696600265.57499,"caller":"git/git.go:215","msg":"Successfully initialized and updated submodules in path /workspace/output/"}
[fetch-source : clone] + cd /workspace/output/
[fetch-source : clone] + git rev-parse HEAD
[fetch-source : clone] + RESULT_SHA=0834b09e172f9c899eb98ffe1463b67136cf05ea
[fetch-source : clone] + EXIT_CODE=0
[fetch-source : clone] + '[' 0 '!=' 0 ]
[fetch-source : clone] + git log -1 '--pretty=%ct'
[fetch-source : clone] + RESULT_COMMITTER_DATE=1473408144
[fetch-source : clone] + printf '%s' 1473408144
[fetch-source : clone] + printf '%s' 0834b09e172f9c899eb98ffe1463b67136cf05ea
[fetch-source : clone] + printf '%s' https://github.com/komljen/dockerfile-examples.git

[build-push : build-and-push] INFO[0000] Retrieving image manifest komljen/ubuntu     
[build-push : build-and-push] INFO[0000] Retrieving image komljen/ubuntu from registry index.docker.io 
[build-push : build-and-push] INFO[0001] Built cross stage deps: map[]                
[build-push : build-and-push] INFO[0001] Retrieving image manifest komljen/ubuntu     
[build-push : build-and-push] INFO[0001] Returning cached image manifest              
[build-push : build-and-push] INFO[0001] Executing 0 build triggers                   
[build-push : build-and-push] WARN[0001] maintainer is deprecated, skipping           
[build-push : build-and-push] INFO[0001] Unpacking rootfs as cmd RUN   apt-get update &&   apt-get -y install           apache2 &&   rm /var/www/html/index.html &&   rm -rf /var/lib/apt/lists/* requires it. 
[build-push : build-and-push] INFO[0012] RUN   apt-get update &&   apt-get -y install           apache2 &&   rm /var/www/html/index.html &&   rm -rf /var/lib/apt/lists/* 
[build-push : build-and-push] INFO[0012] Taking snapshot of full filesystem...        
[build-push : build-and-push] INFO[0015] cmd: /bin/sh                                 
[build-push : build-and-push] INFO[0015] args: [-c apt-get update &&   apt-get -y install           apache2 &&   rm /var/www/html/index.html &&   rm -rf /var/lib/apt/lists/*] 
[build-push : build-and-push] INFO[0015] Running: [/bin/sh -c apt-get update &&   apt-get -y install           apache2 &&   rm /var/www/html/index.html &&   rm -rf /var/lib/apt/lists/*] 
[build-push : build-and-push] Ign http://archive.ubuntu.com trusty InRelease
[build-push : build-and-push] Get:1 http://archive.ubuntu.com trusty-updates InRelease [56.4 kB]
[build-push : build-and-push] Get:2 http://archive.ubuntu.com trusty-security InRelease [56.4 kB]
[build-push : build-and-push] Get:3 http://archive.ubuntu.com trusty Release.gpg [933 B]
[build-push : build-and-push] Get:4 http://archive.ubuntu.com trusty Release [58.5 kB]
[build-push : build-and-push] Get:5 http://archive.ubuntu.com trusty-updates/main Sources [809 kB]
[build-push : build-and-push] Get:6 http://archive.ubuntu.com trusty-updates/restricted Sources [9,993 B]
[build-push : build-and-push] Get:7 http://archive.ubuntu.com trusty-updates/universe Sources [435 kB]
[build-push : build-and-push] Get:8 http://archive.ubuntu.com trusty-updates/main amd64 Packages [1,460 kB]
[build-push : build-and-push] Get:9 http://archive.ubuntu.com trusty-updates/restricted amd64 Packages [28.7 kB]
[build-push : build-and-push] Get:10 http://archive.ubuntu.com trusty-updates/universe amd64 Packages [884 kB]
[build-push : build-and-push] Get:11 http://archive.ubuntu.com trusty-security/main Sources [314 kB]
[build-push : build-and-push] Get:12 http://archive.ubuntu.com trusty-security/restricted Sources [7,832 B]
[build-push : build-and-push] Get:13 http://archive.ubuntu.com trusty-security/universe Sources [188 kB]
[build-push : build-and-push] Get:14 http://archive.ubuntu.com trusty-security/main amd64 Packages [877 kB]
[build-push : build-and-push] Get:15 http://archive.ubuntu.com trusty-security/restricted amd64 Packages [24.6 kB]
[build-push : build-and-push] Get:16 http://archive.ubuntu.com trusty-security/universe amd64 Packages [490 kB]
[build-push : build-and-push] Get:17 http://archive.ubuntu.com trusty/main Sources [1,335 kB]
[build-push : build-and-push] Get:18 http://archive.ubuntu.com trusty/restricted Sources [5,335 B]
[build-push : build-and-push] Get:19 http://archive.ubuntu.com trusty/universe Sources [7,926 kB]
[build-push : build-and-push] Get:20 http://archive.ubuntu.com trusty/main amd64 Packages [1,743 kB]
[build-push : build-and-push] Get:21 http://archive.ubuntu.com trusty/restricted amd64 Packages [16.0 kB]
[build-push : build-and-push] Get:22 http://archive.ubuntu.com trusty/universe amd64 Packages [7,589 kB]
[build-push : build-and-push] Fetched 24.3 MB in 17s (1,359 kB/s)
[build-push : build-and-push] Reading package lists...
[build-push : build-and-push] Reading package lists...
[build-push : build-and-push] Building dependency tree...
[build-push : build-and-push] Reading state information...
[build-push : build-and-push] The following extra packages will be installed:
[build-push : build-and-push]   apache2-bin apache2-data libapr1 libaprutil1 libaprutil1-dbd-sqlite3
[build-push : build-and-push]   libaprutil1-ldap ssl-cert
[build-push : build-and-push] Suggested packages:
[build-push : build-and-push]   www-browser apache2-doc apache2-suexec-pristine apache2-suexec-custom ufw
[build-push : build-and-push]   apache2-utils openssl-blacklist
[build-push : build-and-push] The following NEW packages will be installed:
[build-push : build-and-push]   apache2 apache2-bin apache2-data libapr1 libaprutil1 libaprutil1-dbd-sqlite3
[build-push : build-and-push]   libaprutil1-ldap ssl-cert
[build-push : build-and-push] 0 upgraded, 8 newly installed, 0 to remove and 122 not upgraded.
[build-push : build-and-push] Need to get 1,289 kB of archives.
[build-push : build-and-push] After this operation, 5,369 kB of additional disk space will be used.
[build-push : build-and-push] Get:1 http://archive.ubuntu.com/ubuntu/ trusty/main libapr1 amd64 1.5.0-1 [85.1 kB]
[build-push : build-and-push] Get:2 http://archive.ubuntu.com/ubuntu/ trusty/main libaprutil1 amd64 1.5.3-1 [76.4 kB]
[build-push : build-and-push] Get:3 http://archive.ubuntu.com/ubuntu/ trusty/main libaprutil1-dbd-sqlite3 amd64 1.5.3-1 [10.5 kB]
[build-push : build-and-push] Get:4 http://archive.ubuntu.com/ubuntu/ trusty/main libaprutil1-ldap amd64 1.5.3-1 [8,634 B]
[build-push : build-and-push] Get:5 http://archive.ubuntu.com/ubuntu/ trusty-updates/main apache2-bin amd64 2.4.7-1ubuntu4.22 [845 kB]
[build-push : build-and-push] Get:6 http://archive.ubuntu.com/ubuntu/ trusty-updates/main apache2-data all 2.4.7-1ubuntu4.22 [160 kB]
[build-push : build-and-push] Get:7 http://archive.ubuntu.com/ubuntu/ trusty-updates/main apache2 amd64 2.4.7-1ubuntu4.22 [87.4 kB]
[build-push : build-and-push] Get:8 http://archive.ubuntu.com/ubuntu/ trusty/main ssl-cert all 1.0.33 [16.6 kB]
[build-push : build-and-push] Preconfiguring packages ...
[build-push : build-and-push] Fetched 1,289 kB in 0s (3,817 kB/s)
[build-push : build-and-push] Selecting previously unselected package libapr1:amd64.
[build-push : build-and-push] (Reading database ... 16415 files and directories currently installed.)
[build-push : build-and-push] Preparing to unpack .../libapr1_1.5.0-1_amd64.deb ...
[build-push : build-and-push] Unpacking libapr1:amd64 (1.5.0-1) ...
[build-push : build-and-push] Selecting previously unselected package libaprutil1:amd64.
[build-push : build-and-push] Preparing to unpack .../libaprutil1_1.5.3-1_amd64.deb ...
[build-push : build-and-push] Unpacking libaprutil1:amd64 (1.5.3-1) ...
[build-push : build-and-push] Selecting previously unselected package libaprutil1-dbd-sqlite3:amd64.
[build-push : build-and-push] Preparing to unpack .../libaprutil1-dbd-sqlite3_1.5.3-1_amd64.deb ...
[build-push : build-and-push] Unpacking libaprutil1-dbd-sqlite3:amd64 (1.5.3-1) ...
[build-push : build-and-push] Selecting previously unselected package libaprutil1-ldap:amd64.
[build-push : build-and-push] Preparing to unpack .../libaprutil1-ldap_1.5.3-1_amd64.deb ...
[build-push : build-and-push] Unpacking libaprutil1-ldap:amd64 (1.5.3-1) ...
[build-push : build-and-push] Selecting previously unselected package apache2-bin.
[build-push : build-and-push] Preparing to unpack .../apache2-bin_2.4.7-1ubuntu4.22_amd64.deb ...
[build-push : build-and-push] Unpacking apache2-bin (2.4.7-1ubuntu4.22) ...
[build-push : build-and-push] Selecting previously unselected package apache2-data.
[build-push : build-and-push] Preparing to unpack .../apache2-data_2.4.7-1ubuntu4.22_all.deb ...
[build-push : build-and-push] Unpacking apache2-data (2.4.7-1ubuntu4.22) ...
[build-push : build-and-push] Selecting previously unselected package apache2.
[build-push : build-and-push] Preparing to unpack .../apache2_2.4.7-1ubuntu4.22_amd64.deb ...
[build-push : build-and-push] Unpacking apache2 (2.4.7-1ubuntu4.22) ...
[build-push : build-and-push] Selecting previously unselected package ssl-cert.
[build-push : build-and-push] Preparing to unpack .../ssl-cert_1.0.33_all.deb ...
[build-push : build-and-push] Unpacking ssl-cert (1.0.33) ...
[build-push : build-and-push] Processing triggers for ureadahead (0.100.0-16) ...
[build-push : build-and-push] Setting up libapr1:amd64 (1.5.0-1) ...
[build-push : build-and-push] Setting up libaprutil1:amd64 (1.5.3-1) ...
[build-push : build-and-push] Setting up libaprutil1-dbd-sqlite3:amd64 (1.5.3-1) ...
[build-push : build-and-push] Setting up libaprutil1-ldap:amd64 (1.5.3-1) ...
[build-push : build-and-push] Setting up apache2-bin (2.4.7-1ubuntu4.22) ...
[build-push : build-and-push] Setting up apache2-data (2.4.7-1ubuntu4.22) ...
[build-push : build-and-push] Setting up apache2 (2.4.7-1ubuntu4.22) ...
[build-push : build-and-push] Enabling module mpm_event.
[build-push : build-and-push] Enabling module authz_core.
[build-push : build-and-push] Enabling module authz_host.
[build-push : build-and-push] Enabling module authn_core.
[build-push : build-and-push] Enabling module auth_basic.
[build-push : build-and-push] Enabling module access_compat.
[build-push : build-and-push] Enabling module authn_file.
[build-push : build-and-push] Enabling module authz_user.
[build-push : build-and-push] Enabling module alias.
[build-push : build-and-push] Enabling module dir.
[build-push : build-and-push] Enabling module autoindex.
[build-push : build-and-push] Enabling module env.
[build-push : build-and-push] Enabling module mime.
[build-push : build-and-push] Enabling module negotiation.
[build-push : build-and-push] Enabling module setenvif.
[build-push : build-and-push] Enabling module filter.
[build-push : build-and-push] Enabling module deflate.
[build-push : build-and-push] Enabling module status.
[build-push : build-and-push] Enabling conf charset.
[build-push : build-and-push] Enabling conf localized-error-pages.
[build-push : build-and-push] Enabling conf other-vhosts-access-log.
[build-push : build-and-push] Enabling conf security.
[build-push : build-and-push] Enabling conf serve-cgi-bin.
[build-push : build-and-push] Enabling site 000-default.
[build-push : build-and-push] runlevel:/var/run/utmp: No such file or directory
[build-push : build-and-push] /usr/sbin/policy-rc.d: 1: /usr/sbin/policy-rc.d: 2!/bin/sh: not found
[build-push : build-and-push] invoke-rc.d: policy-rc.d denied execution of start.
[build-push : build-and-push] Setting up ssl-cert (1.0.33) ...
[build-push : build-and-push] Processing triggers for libc-bin (2.19-0ubuntu6.9) ...
[build-push : build-and-push] Processing triggers for ureadahead (0.100.0-16) ...
[build-push : build-and-push] INFO[0122] Taking snapshot of full filesystem...        
[build-push : build-and-push] INFO[0123] Pushing image to fabrinator/task-work:infra-test 
[build-push : build-and-push] INFO[0126] Pushed image to 1 destinations               

[build-push : write-url] fabrinator/task-work:infra-test

```