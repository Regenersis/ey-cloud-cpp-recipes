rabbitmq Hash.new
rabbitmq[:nodename] = "rabbit"
rabbitmq[:address] = "0.0.0.0"
rabbitmq[:port] = "5672"
rabbitmq[:erl_args] = "+K true +A 30 \
-kernel inet_default_listen_options [{nodelay,true},{sndbuf,16384},{recbuf,4096}] \
-kernel inet_default_connect_options [{nodelay,true}]"
rabbitmq[:start_args] = ""
rabbitmq[:logdir] = "/var/log/rabbitmq"
rabbitmq[:mnesiadir] = "/var/lib/rabbitmq/mnesia"
rabbitmq[:cluster] = "no"