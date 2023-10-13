FROM ubuntu

# Install required packages
RUN apt-get update
RUN apt-get install -y wget

# Download Loki and Promtail configuration files
RUN wget https://raw.githubusercontent.com/grafana/loki/v2.2.1/cmd/loki/loki-local-config.yaml -O loki-config.yaml
RUN wget https://raw.githubusercontent.com/grafana/loki/v2.2.1/cmd/promtail/promtail-docker-config.yaml -O promtail-config.yaml

# Expose ports for Loki, Promtail, and Grafana
EXPOSE 3100 9080 3100

# Start Loki, Promtail, and Grafana containers
CMD docker run -d --name loki -v $(pwd):/mnt/config -p 3100:3100 grafana/loki:2.2.1 -config.file=/mnt/config/loki-config.yaml
    docker run -d --name promtail -v $(pwd):/mnt/config -v /var/log:/var/log grafana/promtail:2.2.1 -config.file=/mnt/config/promtail-config.yaml
    docker run -d --name grafana -p 3000:3000 -v grafana_config:/etc/grafana -v grafana_data:/var/lib/grafana -v grafana_logs:/var/log/grafana grafana/grafana
