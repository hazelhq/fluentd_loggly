docker run -d \
  -v /var/lib/docker/containers:/var/lib/docker/containers \
  -e "LOGGLY_TOKEN={TOKEN}" \
  --name paysavvy_loggly \
  paysavvy/fluentd_loggly