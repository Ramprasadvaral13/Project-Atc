# Use an official Nginx image as the base
FROM nginx:alpine

# Copy the HTML and CSS files into the Nginx web directory
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css

# Expose port 80 for the web server
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
