FROM node:18-alpine
# Installing dependencies
WORKDIR /app
COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn install

# Copying source files
COPY . .

# Building app
RUN yarn build

# Running the app
EXPOSE 8080
CMD ["yarn", "start"]