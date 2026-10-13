FROM busybox:1.37
COPY index.html /www/index.html
EXPOSE 8002
CMD ["httpd", "-f", "-p", "8002", "-h", "/www"]
