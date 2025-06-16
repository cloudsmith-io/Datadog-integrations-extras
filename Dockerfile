FROM public.ecr.aws/datadog/agent:7
ARG INTEGRATION_VERSION
RUN agent integration install -r -t datadog-cloudsmith==${INTEGRATION_VERSION}
CMD ["agent", "run"]