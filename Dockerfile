FROM node:22.12.0-alpine AS builder

RUN apk add --no-cache openssl

ARG USERNAME="appuser"

RUN addgroup --gid 1001 -S $USERNAME && \
  adduser -G $USERNAME --shell /bin/false --disabled-password -H --uid 1001 $USERNAME && \
  mkdir -p /var/log/$USERNAME && \
  chown $USERNAME:$USERNAME /var/log/$USERNAME

RUN mkdir -p /home/$USERNAME/app
RUN chown -R $USERNAME /home/$USERNAME
WORKDIR /home/$USERNAME/app

COPY package.json pnpm-lock.yaml prisma /home/$USERNAME/app/

RUN npm install -g pnpm@9.15.4
RUN pnpm install --frozen-lockfile
RUN pnpx prisma generate

COPY . /home/$USERNAME/app/
RUN chown -R $USERNAME /home/$USERNAME

USER $USERNAME
RUN pnpm run build && pnpm prune --prod

FROM node:22.12.0-alpine

RUN apk add --no-cache openssl

ARG USERNAME="appuser"
WORKDIR /home/$USERNAME/app

COPY --from=builder /home/$USERNAME/app/node_modules /home/$USERNAME/app/node_modules
COPY --from=builder /home/$USERNAME/app/dist /home/$USERNAME/app

ENV NODE_ENV=production
ENV PORT=5600

EXPOSE 5600

CMD ["node", "server"]
