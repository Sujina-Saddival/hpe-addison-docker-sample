# Build
# Before creating a image login to docker for private hub - docker login hub.docker.hpecorp.net
# provide <hpe email ID><system password>
# Create a image - docker build -t boa-api-launches/1.0 .
# Run (remap container port to host 3000 port)
# Run a container - docker run -it -p 3000:8080 boa-api-launches/1.0
# Access in a web browser using base URL https://localhost
FROM hub.docker.hpecorp.net/global-it/addison-nodejs-test:3.0.0

# # Defining a HOST environment variable will make Addison listen on all interfaces (0.0.0.0)
# # on port 8080  (as port 3000 cannot be bound to when running as a non-privileged user)
ENV ADDISON_HOST=0.0.0.0 \
  ADDISON_PORT=8080 \
  https_proxy=http://proxy.houston.hpecorp.net:8080 \
  http_proxy=http://proxy.houston.hpecorp.net:8080

# Set our working directory
RUN mkdir boa-api-launches/
COPY . boa-api-launches/
WORKDIR boa-api-launches/

# Install node modules
RUN npm --registry https://registry.npmjs.itcs.hpecorp.net/ install --verbose

# Container port which app is going to listen on...
EXPOSE $ADDISON_PORT

# Start up info...
CMD ["npm", "start"]