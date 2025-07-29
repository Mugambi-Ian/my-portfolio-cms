# syntax=docker/dockerfile:1

# =========================
# 1️⃣ Build Stage
# =========================
FROM node:20-alpine AS builder

# Install necessary dependencies for native modules
RUN apk add --no-cache python3 make g++ libc6-compat

WORKDIR /app

# Install node-gyp globally to avoid native module issues
RUN npm install -g node-gyp

# Copy necessary files for dependency installation
COPY package.json package-lock.json ./

# Install dependencies (production & dev)
RUN npm ci

# Copy entire project (except files in .dockerignore)
COPY . .

# Build the Strapi admin panel
RUN NODE_OPTIONS="--max-old-space-size=4096" npm run build

# =========================
# 2️⃣ Production Image
# =========================
FROM node:22-alpine AS production

# Install runtime dependencies
RUN apk add --no-cache libc6-compat

WORKDIR /app

# Copy only production node_modules and built app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/.env ./.env
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/config ./config
COPY --from=builder /app/src ./src
COPY --from=builder /app/public ./public
COPY --from=builder /app/database ./database
COPY --from=builder /app/tsconfig.json ./tsconfig.json

ENV NODE_ENV=production
EXPOSE 1337

# Start Strapi in production mode
CMD ["npm", "run", "start"]
