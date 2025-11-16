FROM node:20-alpine as builder
# from here its builder stage
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build # Agregar el paso de construcción
CMD ["npm", "run", "start"]


# from here its production stage
FROM nginx
# Exponer el puerto 80 para Elastic Beanstalk
EXPOSE 80 
# copy from builder stage to nginx html folder
COPY --from=builder /app/build /usr/share/nginx/html 