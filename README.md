# 시스템 아키텍처 다이어그램

다음은 전체 시스템 아키텍처를 표현한 Mermaid 다이어그램입니다:

> 💡 GitHub에서는 Mermaid 미리보기가 보이지 않을 수 있습니다. 확인하려면 [Mermaid Live Editor](https://mermaid.live) 또는 [Obsidian](https://obsidian.md) 같은 툴을 사용하세요.

```mermaid
flowchart TD
  subgraph Client
    A1[Web Client (PC/Mobile)]
    A2[Admin Dashboard]
  end

  subgraph CDN
    CF[CloudFront]
  end

  subgraph Web_Tier
    EC1[EC2 - Web/App Server]
    EC2[EC2 - Web/App Server]
  end

  subgraph API
    API[RESTful API\n(JWT + RBAC + OAuth2)]
  end

  subgraph DB
    DB1[(MySQL Master - RDS)]
    DB2[(MySQL Read Replica)]
  end

  subgraph Media
    S3[(S3 Bucket - 이미지/영상 저장)]
  end

  subgraph Monitoring
    MON1[Prometheus]
    MON2[Grafana]
    MON3[OpenSearch + Kibana]
    MON4[AWS X-Ray]
  end

  subgraph Security
    WAF[Web Application Firewall]
    SSL[HTTPS (TLS 1.3)]
    AUTH[2FA + OAuth2 + JWT]
  end

  A1 -->|HTTPS| CF
  A2 -->|HTTPS + 2FA| CF

  CF --> WAF
  WAF --> EC1
  WAF --> EC2

  EC1 --> API
  EC2 --> API

  API -->|Read/Write| DB1
  API -->|Read| DB2
  API --> S3

  API -->|Metrics| MON1
  API -->|Trace| MON4
  EC1 --> MON3
  DB1 --> MON3

  MON1 --> MON2
  MON3 --> MON2

  click API href "https://swagger-ui.example.com" "Swagger API Docs"
```

