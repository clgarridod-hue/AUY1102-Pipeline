# Stage 1: Entorno de construccion y ejecucion de pruebas unitarias
FROM node:22-alpine AS test

RUN apk --no-cache upgrade

WORKDIR /usr/src/app
ENV CI=true

COPY package.json package-lock.json ./
RUN npm ci --ignore-scripts

COPY tsconfig.json tsconfig.eslint.json jest.config.js dts-generator.json ./
COPY src ./src
COPY test ./test

RUN chown -R node:node /usr/src/app
USER node

CMD ["npm", "run", "test:unit", "--", "--forceExit"]

# Stage 2: Imagen ligera y segura de produccion
FROM node:22-alpine AS production

RUN apk --no-cache upgrade

WORKDIR /usr/src/app
ENV NODE_ENV=production
ENV CI=true

COPY package.json package-lock.json ./
RUN npm ci --omit=dev --ignore-scripts && npm cache clean --force

COPY --chown=node:node src ./src

USER node

CMD ["node", "--experimental-strip-types", "src/index.ts"]
