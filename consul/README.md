{
  "bootstrap_expect": 1,
  "server": true,
	"data_dir": "/opt/consul/data",
	"ui_dir": "/opt/consul/ui",
  "datacenter": "Paris",
  "domain": "riddopic.dev",
  "leave_on_terminate": true,
	"client_addr": "0.0.0.0",
	"ports": {
		"dns": 53
	},
	"recursor": "8.8.8.8",
	"disable_update_check": true
}


export USER=consul
export BIN=/usr/sbin/consul
export LOG=/opt/consul/log/agent.log
export CONFIG=/opt/consul/config
export BIND=`getent hosts ${HOSTNAME} | awk '{print $1}'`



Start the first node not with `-bootstrap`, but with `-bootstrap-expect 3`,
which will wait until there are 3 peers connected before self-bootstrapping and
becoming a working cluster.

    $BIN agent -config-dir $CONFIG --server -bootstrap-expect 3

Then we'll start `node2` and tell it to join `node1` using `$JOIN_IP`:

    $BIN agent -config-dir $CONFIG --server -join 172.17.0.244
    docker run -d --name consul02 -h consul02.mudbox.dev riddopic/consul

Now we can start `node3` the same way:

    $BIN agent -config-dir $CONFIG -join 172.17.0.244

We haven't published any ports to access the cluster, but we can use that as an
excuse to run a fourth agent node in "client" mode (dropping the `-server`).
This means it doesn't participate in the consensus quorum, but can still be used
to interact with the cluster. It also means it doesn't need disk persistence.

     agent -config-dir $CONFIG -join 172.17.0.244



    docker run -it --name consul01 -h consul01.mudbox.dev riddopic/consul-bootstraper
    docker run -it --name consul02 -h consul02.mudbox.dev riddopic/consul
    docker run -it --name consul03 -h consul03.mudbox.dev riddopic/consul


# https://github.com/just-containers/s6-overlay/releases/

aria2c -x5 -j5 https://github.com/just-containers/s6-overlay/releases/download/v1.10.0.3/s6-overlay-amd64.tar.gz
aria2c -x5 -j5 https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip
aria2c -x5 -j5 https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip
aria2c -x5 -j5 https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

dig @172.17.1.16 -p 53 consul.node.consul



{
  "service": {
    "name": "serf",
    "tags": ["agent"],
    "port": 7946,
    "checls": [
      {
        "script": "redis-check",
        "interval": "5s"
      }
    ]
  }
}


docker run -d -p 22 -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8400:8400 -p 8500:8500 --name consul -h consul.mudbox.dev riddopic/consul


/bin/sh

RSA_KEY=/etc/ssh/ssh_host_rsa_key
DSA_KEY=/etc/ssh/ssh_host_dsa_key

[ -f $RSA_KEY ] && /usr/bin/ssh-keygen -t rsa -f $RSA_KEY -N ''
[ -f $DSA_KEY ] && /usr/bin/ssh-keygen -t dsa -f $DSA_KEY -N ''

exec /usr/sbin/sshd -D -o UseDNS=no -o PasswordAuthentication=yes -o UsePrivilegeSeparation=no -o PidFile=/tmp/sshd.pid;








