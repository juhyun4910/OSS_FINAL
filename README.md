graph TD
  subgraph Client
    C1[웹 브라우저<br/>React/Vite 기반 UI]
    C2[모바일 웹<br/>반응형 지원]
  end

  subgraph Frontend
    FE[Next.js/React<br/>SSR/CSR 지원]
    FE -->|REST API| API[API Gateway (/api/v1)]
  end

  C1 --> FE
  C2 --> FE

  subgraph Backend
    API --> S1[Auth 서비스<br/>JWT, OAuth, 2FA]
    API --> S2[게시글 서비스<br/>작성/조회/수정/삭제]
    API --> S3[댓글/추천/신고 서비스]
    API --> S4[검색/정렬 서비스]
    API --> S5[휴지통 서비스]
    API --> S6[카테고리 서비스]
    API --> ADM[관리자 서비스<br/>대시보드/정책 관리]
  end

  subgraph Infra
    DB[(MySQL 8.0<br/>이중화 RDS)]
    Cache[Redis / Memcached<br/>임시 저장/세션/인기글 캐시]
    MQ[SQS<br/>비동기 처리 (신고/알림)]
    Media[S3 저장소<br/>+ CloudFront CDN]
    AuthLog[(AuditLog DB)]
    Xray[AWS X-Ray<br/>Trace 추적]
    Prometheus[Prometheus + Grafana<br/>모니터링/알림]
  end

  subgraph DevOps
    CI[GitHub Actions<br/>테스트/빌드/배포]
    Docker[Docker + ECS or EKS]
    Rollout[Blue/Green 배포 or 롤링 업데이트]
  end

  S1 --> DB
  S2 --> DB
  S3 --> DB
  S4 --> DB
  S5 --> DB
  S6 --> DB
  ADM --> DB
  API --> Cache
  S2 --> Media
  S3 --> MQ
  MQ --> S3
  API --> AuthLog
  API --> Xray
  DB --> Prometheus
  Media --> Prometheus

  CI --> Docker
  Docker --> FE
  Docker --> API
  Rollout --> Docker
