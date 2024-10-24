{
  enable = true;
  globalConfig.scrape_interval = "1m";

  scrapeConfigs = [
    {
      job_name = "node";
      static_configs = [{
        targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
      }];
    }
  ];

  exporters.node = {
    enable = true;
    port = 9000;

    enabledCollectors = [ "systemd" ];
  };
}
