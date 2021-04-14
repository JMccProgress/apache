apt_update

package 'net-tools' do
  action :install
end

package 'apache2' do
  action :install
end

file '/var/www/html/index.html' do
  action :create
  content '<p><strong>HELLO!!</strong></p><p>&nbsp;</p><p><strong>this is a test page</strong></p><p>&nbsp;</p><p><strong><img src="https://html5-editor.net/tinymce/plugins/emoticons/img/smiley-cool.gif" alt="cool" /></strong></p>'
end

service 'apache2' do
  action [ :enable, :start ]
end
