default[:storm][:user] = 'ubuntu'
default[:storm][:group] = 'ubuntu'
default[:storm][:executable_path] = '/usr/local/bin'
default[:storm][:install_root] = "/usr/local"
default[:storm][:release_root] = "https://github.com/downloads/nathanmarz/storm"
default[:storm][:release_version] = "0.8.2"
default[:storm][:release_name] = nil
default[:storm][:log_dir] = "${storm.home}/logs"
default[:storm][:local_dir] = "/mnt/storm"
default[:storm][:worker][:childopts] = "-Xmx768m"
default[:storm][:supervisor][:childopts] = "-Xmx256m"
default[:storm][:data_dir] = "/mnt/storm"
default[:jzmq][:repo] = "git://github.com/nathanmarz/jzmq.git"
default[:jzmq][:srcdir] = "/usr/local/src/jzmq"
default[:storm][:supervisor][:workers] = 8
default[:storm][:zookeeper][:root] = "/storm"
default[:storm][:netty][:max_retries] = 300
default[:storm][:nimbus][:thrift_max_buffer_size] = 10485760
