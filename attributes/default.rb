default[:storm][:user] = 'ubuntu'
default[:storm][:group] = 'ubuntu'
default[:storm][:install_root] = "/usr/local"
default[:storm][:release_root] = "https://github.com/downloads/nathanmarz/storm"
default[:storm][:release_version] = "storm-0.6.2"
default[:storm][:install_dir] = "#{default[:storm][:install_root]}/#{default[:storm][:release_version]}"
default[:storm][:log_dir] = "/var/log/storm"
default[:storm][:data_dir] = "/mnt/storm"
default[:storm][:zk_cluster] = "zk"
default[:jzmq][:repo] = "git://github.com/nathanmarz/jzmq.git"
default[:jzmq][:srcdir] = "/usr/local/src/jzmq"

