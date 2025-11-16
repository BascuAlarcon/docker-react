FROM node:20-alpine as builder
# from here its builder stage
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build # Agregar el paso de construcción
CMD ["npm", "run", "start"]


FROM nginx
# from here its production stage
COPY --from=builder /app/build /usr/share/nginx/html
# copy from builder stage to nginx html folder