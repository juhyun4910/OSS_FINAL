```mermaid
flowchart TD
  %% Client 영역
  subgraph Client
    A1[Web Client (PC/Mobile)]
    A2[Admin Dashboard]
  end

  %% CDN
  subgraph CDN
    CF[CloudFront]
  end

  %% Web Tier
  subgraph Web_Tier
    EC1[EC2 - Web/App Server 1]
    EC2[EC2 - Web/App Server 2]
  end

  %% API
  subgraph API
    API1[RESTful API<br/>(JWT, RBAC, OAuth2)]
  end

  %% DB
  subgraph DB
    DB1[(MySQL Master - RDS)]
    DB2[(MySQL Read Replica)]
  end

  %% Media
  subgraph Media
    S3[(S3 Bucket)]
  end

  %% Monitoring
  subgraph Monitoring
    MON1[Prometheus]
    MON2[Grafana]
    MON3[OpenSearch + Kibana]
    MON4[AWS X-Ray]
  end

  %% Security
  subgraph Security
    WAF[Web Application Firewall]
    SSL[HTTPS (TLS 1.3)]
    AUTH[2FA + OAuth2 + JWT]
  end

  %% 연결
  A1 -->|HTTPS| CF
  A2 -->|HTTPS + 2FA| CF

  CF --> WAF
  WAF --> EC1
  WAF --> EC2

  EC1 --> API1
  EC2 --> API1

  API1 -->|Read/Write| DB1
  API1 -->|Read| DB2
  API1 --> S3

  API1 -->|Metrics| MON1
  API1 -->|Trace| MON4
  EC1 --> MON3
  DB1 --> MON3

  MON1 --> MON2
  MON3 --> MON2

  click API1 href "https://swagger-ui.example.com" "Swagger API Docs"

