FROM node:22-bullseye-slim

WORKDIR /app

# Copy package manifest first for Docker layer caching
COPY package.json pnpm-lock.yaml ./

# Install dependencies via pnpm (aligns with deploy.yml auto-detection)
RUN corepack enable && pnpm install --frozen-lockfile

# Copy project files
COPY . .

ENV PORT=3000
EXPOSE 3000

# Default: build and preview (bind to 0.0.0.0 so host can access)
CMD ["sh", "-c", "pnpm run build && pnpm run preview -- --host 0.0.0.0 --port $PORT"]