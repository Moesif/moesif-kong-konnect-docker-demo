# Moesif Kong Konnect Docker Demo

This repository provides a demonstration of integrating Moesif with Kong Konnect in a hybrid deployment setup. By following this guide, you will set up a custom Kong Konnect Self-Managed Hybrid Gateway with the Moesif plugin enabled, define services and routes, test the integration, and optionally deploy the Moesif Developer Portal.

## Prerequisites

- Docker and Docker Compose installed on your system.
- A Kong Konnect account.
- Application ID from Moesif.

## Getting Started

### Clone the Repository

Clone this repository and its submodules:

```bash
git clone --recurse-submodules https://github.com/Moesif/moesif-kong-konnect-docker-demo.git
```

### Build the Custom Kong Gateway

Navigate into the cloned directory and build the custom Kong Gateway image:

```bash
cd moesif-kong-konnect-docker-demo

docker build -t custom-kong-gateway:3.9.0.0 .
```

### Set Up Kong Konnect

1. **Sign Up for Kong Konnect:**

   If you don't already have an account, sign up for Kong Konnect at [Kong Konnect](https://konghq.com/kong-konnect/).

2. **Create a Hybrid Gateway:**

   Log in to Kong Konnect, navigate to "Gateway Manager", and create a new self-hosted hybrid gateway. Follow the instructions to get the `docker run` command for deploying the gateway.

3. **Modify the Docker Run Command:**

   Update the `docker run` command provided by Kong Konnect to include the following environment variables:

   ```yaml
   -e "KONG_PLUGINS=bundled,moesif" \
   -e "KONG_LUA_PACKAGE_PATH=/tmp/custom_plugins/?.lua;;" \
   ```

   Replace the final line of the docker run command provided by Kong Konnect with the custom built image name:

    ```yaml
    custom-kong-gateway:3.9.0.0
    ```

4. **Run the Command:**

   Paste the modified `docker run` command into your terminal to start the custom Kong Gateway.

### Configure Kong Gateway

1. **Define a Service and Route:**

   In Kong Konnect:
   - Navigate to the "Gateway Services" section and create a new service (e.g., `TestService`).
   - Navigate to "Routes" and define a route (e.g., `TestRoute`) associated with the service.

2. **Enable the Moesif Plugin:**

   - Go to the "Plugins" section and add a custom plugin..
   - Upload the `schema.lua` file located in `kong-plugin-moesif/kong/plugins/moesif/` from this repository and select "Save".
   - Navigate to the "Plugins" section, select "Custom Plugins", select "Enable" on the Moesif Plugin.
   - Input your Moesif Application ID and select "Save".

### Test Endpoints

Test the defined service and route by sending requests to the configured endpoint. Verify that data is being captured in your Moesif dashboard.

## Additional Resources

### Moesif Developer Portal

The repository includes a Docker Compose file to set up the Moesif Developer Portal for testing.

- Use the provided `docker-compose.yml` file as a starting point to spin up the Moesif Developer Portal.
- Refer to the official [Moesif Developer Portal documentation](https://www.moesif.com/docs/developer-portal/) for detailed setup instructions.

### Links

- [Moesif Documentation](https://www.moesif.com/docs/)
- [Kong Konnect Documentation](https://docs.konghq.com/konnect/)
- [Moesif Kong Plugin Documentation](https://docs.konghq.com/hub/moesif/kong-plugin-moesif/)
