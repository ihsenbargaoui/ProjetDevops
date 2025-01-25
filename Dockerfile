# Use node:16-alpine (or a suitable Node version) as a base
FROM node:16-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package*.json files
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of your application source
COPY . .

# Build the NestJS application
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Define the command to run the app
CMD ["npm", "run", "start:prod"]
