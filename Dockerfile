# Change node version according to requirement
FROM node:lts-alpine AS deps

# Set the working directory
WORKDIR /app

# Copy the local files to the container's workspace
COPY . .

# Install Dependencies
RUN npm install

# Build 
RUN npm run build

FROM node:lts-alpine
WORKDIR /app

# Copy build directories
COPY --from=deps /app/.next ./.next
COPY --from=deps /app/public ./public
COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app/package.json ./

# Expose the port your application listens on (replace 3000 with your port)
EXPOSE 3000

# Command to run your application
CMD ["npm", "start"]
