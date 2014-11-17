maintainer       "Yieldbot"
maintainer_email "dwhite@yieldbot.com"
license          "All rights reserved"
description      "Installs/Configures storm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.5"

%w{ ntp git java python zeromq silverware }.each do |cb|
  depends cb
end
