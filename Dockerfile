# Build CSS
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY tailwind.config.js postcss.config.js ./
COPY src ./src
COPY public ./public
RUN npm run build:css

# Serve with Nginx
FROM nginx:1.27-alpine
RUN printf '%s\n' \
  'add_header X-Content-Type-Options "nosniff" always;' \
  'add_header X-Frame-Options "SAMEORIGIN" always;' \
  'add_header Referrer-Policy "strict-origin-when-cross-origin" always;' \
  'add_header X-XSS-Protection "1; mode=block" always;' \
  > /etc/nginx/conf.d/headers.conf
COPY --from=build /app/public /usr/share/nginx/html
EXPOSE 80
