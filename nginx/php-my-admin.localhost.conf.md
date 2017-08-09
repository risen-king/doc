server {
        listen       80;
        server_name  php-my-admin.localhost;
 
 
        #access_log  logs/host.access.log  main;
 
        root   /usr/local/nginx/html/phpMyAdmin;
        
	      location / {
            index  index.html index.htm index.php;
        }

       # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
       location ~ \.php$ {
	     fastcgi_pass   127.0.0.1:9000;
	     fastcgi_index  index.php;
	     
	     include        fastcgi.conf;
	 }
}
