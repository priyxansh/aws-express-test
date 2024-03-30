# Use an official Node.js runtime as the base image
FROM node:20-alpine

# Create a new user and group in the container
RUN addgroup --system app && adduser --system --ingroup app app

# Change the user to the app user
USER app

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Copy pnpm-lock.yaml file to the container
COPY pnpm-lock.yaml ./

# Change the user to root
USER root

# Change the ownership of the /app directory to the app user and group
RUN chown -R app:app /app

# Install the dependencies
RUN npm install

# Copy the index.js file to the container
COPY index.js .

# Expose the port on which the application will run
EXPOSE 3000

# Start the application
CMD [ "node", "index.js" ]
