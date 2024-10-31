{
  enable = true;
  enableAgentMode = true;

  globalConfig.scrape_interval = "1m";

  scrapeConfigs = [
    {
      job_name = "minio-job";
      metrics_path = "/minio/v2/metrics/cluster";

      static_configs = [{
        targets = [ "172.16.0.2:9000" ];
      }];

    }
  ];

  exporters.node = {
    enable = true;
    port = 9000;

    enabledCollectors = [ "systemd" ];
  };
}
