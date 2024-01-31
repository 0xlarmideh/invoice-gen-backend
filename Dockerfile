FROM ghcr.io/puppeteer/puppeteer:21.5.0

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

WORKDIR /usr/src/app

# Change ownership of the /usr/src/app directory
USER root
RUN chown -R pptruser:pptruser /usr/src/app
USER pptruser


COPY package*.json ./
RUN npm ci

# Add TypeScript as a development dependency
COPY . .
RUN npm install typescript --save-dev
RUN npx tsc
CMD [ "npm", "start" ]