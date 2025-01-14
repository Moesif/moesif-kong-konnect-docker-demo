# Moesif Kong Konnect Docker Demo

This repository provides a demonstration of integrating Moesif with Kong Konnect in a hybrid deployment setup. By following this guide, you will set up a custom Kong Konnect Self-Managed Hybrid Gateway with the Moesif plugin enabled, define services and routes, test the integration, and optionally deploy the Moesif Developer Portal.

## Prerequisites

- Docker and Docker Compose installed on your system.
- A Kong Konnect account.
- A Moesif account.

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

If you don't already have an account, sign up for Kong Konnect at [Kong Konnect](https://konghq.com/kong-konnect/).

#### Create a Hybrid Gateway

To integrate the Moesif plugin, we need to set up a self-managed hybrid gateway in Kong Konnect. This configuration connects the control plane in Kong Konnect to a data plane instance.

1. Log in to the Kong Konnect Portal.
2. Navigate to **Gateway Manager**.
3. Click on **New Gateway** and select **Self-Managed Hybrid**.
4. In the **General Information** section, add a **name** for your gateway.
5. Select a **version and platform** for your hybrid gateway setup. Kong Konnect will provide a docker `run` command which we will need to customize in the next steps.

#### Modify the Docker Run Command

Update the `docker run` command provided by Kong Konnect to include the following environment variables:

```yaml
-e "KONG_PLUGINS=bundled,moesif" \
-e "KONG_LUA_PACKAGE_PATH=/tmp/custom_plugins/?.lua;;" \
```

Replace the final line of the docker run command provided by Kong Konnect with the custom built image name:

```yaml
custom-kong-gateway:3.9.0.0
```

Paste the modified `docker run` command into your terminal to start the custom Kong Gateway.

### Configure Kong Konnect

#### Create a Service Gateway Service

1. Log in to the Kong Konnect Portal.
2. Navigate to the **Gateway Manager**.
3. Select **Gateway Services** from the side navigation bar.
4. Click on **New Gateway Service**.
5. In the **Add a Gateway Service** dialog, provide the following details:
   - **Name**: `TestService`
   - **Upstream URL**: Enter the URL of your backend service. For example, `https://www.httpbin.org`.
6. Click **Save** to create the service.

#### Add a Route to the Service

1. After saving the service, you'll be directed to the service's dashboard.
2. Click on **Add a Route**.
3. In the **Add a Route** dialog, provide the following details:
   - **Name**: `TestRoute`
   - **Protocols**: Select `HTTP` and `HTTPS`.
   - **Paths**: Enter `/test-route`.
4. Click **Save** to create the route.

### Enable the Moesif Plugin

To enable API analytics with a custom plugin, you need to add and configure the Kong Moesif plugin in your Kong Konnect data planes.

1. Navigate to the **Gateway Manager**.
2. Go to the **Plugins** section and click on **Add Custom Plugin**.
3. Upload the `schema.lua` file located in `kong-plugin-moesif/kong/plugins/moesif/` from the [Kong Plugin Moesif repository](https://github.com/Moesif/kong-plugin-moesif). The latest version of this plugin is included in this repository for your convenience.
4. Click **Save** to add the custom plugin.
5. Navigate back to the **Plugins** section, select **Custom Plugins**, and enable the **Moesif Plugin**.
6. Configure the plugin with the following field:
   - **Application ID**: Obtain your Application ID from the Moesif API Keys settings page.
7. Click **Save** to finalize the configuration.

### Test Endpoints

Test the defined service and route by sending requests to the configured endpoint.

1. Ensure that your data plane node is running and connected.
2. Send a request to your proxy URL appended with the route path. For example: `http://localhost:8000/test-route`.
3. A successful response indicates that your service and route are correctly configured.

Verify that data is being captured in your Moesif dashboard.

## Additional Resources

### Moesif Developer Portal

The repository includes a Docker Compose file to set up the Moesif Developer Portal for testing.

- Use the provided `docker-compose.yml` file as a starting point to spin up the Moesif Developer Portal.
- If you would like to get started with the Moesif Developer Portal refer to the official [Moesif Developer Portal documentation](https://www.moesif.com/docs/developer-portal/) for detailed setup instructions.
- If you have already followed the Moesif Developer Portal guide, you can [continue setting up Kong Konnect and the Moesif Developer Portal](https://www.moesif.com/docs/developer-portal/setup-kong-konnect-plugin/).

### Links

- [Moesif Documentation](https://www.moesif.com/docs/)
- [Kong Konnect Documentation](https://docs.konghq.com/konnect/)
- [Moesif Kong Plugin Documentation](https://docs.konghq.com/hub/moesif/kong-plugin-moesif/)
- [Moesif Developer Portal Documentation](https://www.moesif.com/docs/developer-portal/)
