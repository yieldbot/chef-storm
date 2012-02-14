maintainer       "Yieldbot"
maintainer_email "dwhite@yieldbot.com"
license          "All rights reserved"
description      "Installs/Configures storm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

%w{ ntp git java python zeromq }.each do |cb|
  depends cb
end