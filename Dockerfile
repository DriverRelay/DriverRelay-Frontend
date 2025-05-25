FROM node:20-alpine AS build
WORKDIR /app
COPY ./package*.json ./
RUN npm ci
COPY ./ ./
RUN npm run build -- --configuration=production

FROM nginx:1.23.0-alpine
EXPOSE 80
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/driverrelay-frontend /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
