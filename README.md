# 🐳 Cloudsmith Datadog Agent Image Builder

This repository automates the build and publication of a Datadog Agent Docker image with the [Cloudsmith integration](https://docs.cloudsmith.io/docs/integrations-datadog) pre-installed.

📦 Image published to [Docker Hub → `cloudsmith/cloudsmith-datadog-agent`](https://hub.docker.com/r/cloudsmith/cloudsmith-datadog-agent) and [Cloudsmith → `cloudsmith/cloudsmith-datadog-agent`](https://cloudsmith.io/~cloudsmith/repos/cloudsmith-datadog-agent/packages/)

---

## 📌 Purpose

Datadog users who integrate Cloudsmith can now use a prebuilt Agent image with the `datadog-cloudsmith` integration bundled in. This reduces setup time and ensures consistent observability.

---

## 🚀 How It Works

This repo contains a GitHub Actions workflow that:

- Watches the [official Datadog integrations-extras repo](https://github.com/DataDog/integrations-extras) for new Cloudsmith integration tags (`cloudsmith-*`)
- Triggers a Docker build using the official Datadog Agent base image
- Installs the `datadog-cloudsmith` integration at the corresponding version
- Pushes the final image to Cloudsmith and Docker Hub


---

## 🛠 Usage

To run the image locally:

```bash
docker run -it --rm \
  -e DD_API_KEY=<your-api-key> \
  -e DD_SITE=datadoghq.com \
  -e DD_HOSTNAME=custom-host \
  -v ./conf.yaml:/etc/datadog-agent/conf.d/cloudsmith.d/conf.yaml \
  -v ./datadog.yaml:/etc/datadog-agent/datadog.yaml:ro \
  cloudsmith/cloudsmith-datadog-agent:<version>
```

- Replace `<version>` with the appropriate tag (e.g., `1.0.0`, `1.1.0`, etc).
- You can also mount the Cloudsmith config dynamically instead of copying it into the image.

---

## 📥 Tags Monitoring
The CI workflow runs daily (via cron) and monitors for new tags like cloudsmith-1.2.3.

When a new tag appears:
- It triggers an automated Docker build
- The new image is pushed to Docker Hub
- `.last-built-version` is updated in this repo

---

## 📁 Project Structure

```
.
├── Dockerfile                   # Default build using Datadog’s official base image    
├── .last-built-version         # Tracks the most recently built tag  
├── README.md                   # GitHub repo README  
└── .github/  
    └── workflows/  
        └── build-cloudsmith-agent.yml   # CI workflow to auto-build and publish Docker image  
```

---

## 👥 Maintainer

The image and workflow are maintained by [Cloudsmith Customer Engineering team](https://cloudsmith.com). Built for both public use and internal observability integrations.

If you’re using Cloudsmith to distribute your packages, this is the easiest way to monitor activity directly within your Datadog dashboards.


