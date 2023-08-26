# build phase
FROM node:20-alpine as builder

WORKDIR /app

COPY package.json .

RUN corepack enable
RUN yarn install --network-timeout 1000000

COPY . .

RUN yarn build

# Run phase
FROM nginx
COPY --from=builder /app/dist /usr/share/nginx/html