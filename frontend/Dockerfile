FROM node:14.17.0
WORKDIR /app
COPY . .
RUN npm install
RUN chown -R node /app/node_modules
EXPOSE 3000
CMD ["npm", "index.js"]

