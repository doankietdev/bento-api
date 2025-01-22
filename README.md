# Bento API - Social Network

## Requirements
- Node.js: `>= 20.0.0`
- pnpm: `>= 9.0.0`

## How to run in development mode
1. Clone this repository
2. Install dependencies: `pnpm install`
4. Start services with docker compose: `docker-compose up -d`
5. Migrate database: `pnpm migrate:dev`
6. Start server: `pnpm dev`

## How to run in production preview
1. Clone this repository
2. Install dependencies: `pnpm install`
4. Start services with docker compose: `docker-compose up -d`
5. Migrate database: `pnpm migrate:dev`
6. Start server: `pnpm preview`

## How to migrate database for development
1. Check the value of the `DATABASE_URL` variable matches the database you want to migrate with the files in the following order of priority: `.env.development.local`, `.env.development`, `.env.local`, `.env`
2. Migrate database: `pnpm migrate:dev`

## How to migrate database for production
1. Check the value of the `DATABASE_URL` variable matches the database you want to migrate with the files in the following order of priority: `.env.production.local`, `.env.local`
2. Migrate database: `pnpm migrate:dev`
