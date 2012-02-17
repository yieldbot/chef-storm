package "pkg-config"
package "libtool"

directory node[:jzmq][:srcdir] do
  mode 0755
  action :create
end
git node[:jzmq][:srcdir] do
  repository node[:jzmq][:repo]
  revision 'master'
  action :sync
end
execute "make_jzmq" do
  command "JAVA_HOME=/usr/lib/jvm/default-java ./autogen.sh && ./configure && make && make install"
  cwd "#{node[:jzmq][:srcdir]}/jzmq"
  action :run
end
