# Use official Nginx lightweight image
FROM nginx:alpine

# Remove default Nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy the custom HTML page to Nginx's serving directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 inside the container
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
