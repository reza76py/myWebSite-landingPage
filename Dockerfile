# Simple static site, served by Nginx
FROM nginx:1.27-alpine

# Copy our static HTML into the default Nginx web root
COPY . /usr/share/nginx/html

# Basic security headers (optional but nice)
RUN printf '%s\n' \
  'add_header X-Content-Type-Options "nosniff" always;' \
  'add_header X-Frame-Options "SAMEORIGIN" always;' \
  'add_header Referrer-Policy "strict-origin-when-cross-origin" always;' \
  'add_header X-XSS-Protection "1; mode=block" always;' \
  > /etc/nginx/conf.d/headers.conf

EXPOSE 80
