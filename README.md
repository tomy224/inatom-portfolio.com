# Portfolio サイト構築記録

GitHub Repository Description
AWS Infrastructure Engineer Portfolio - Modern serverless web application showcasing cloud architecture skills and real-world project experience
README.md
markdown# AWS Infrastructure Engineer Portfolio

AWS認定ソリューションアーキテクトとして、サーバーレスアーキテクチャによる実用的なWebポートフォリオサイトです。

## 🚀 Live Demo
[https://inatom-portfolio.com](https://inatom-portfolio.com)



## サイト概要
AWS を利用して静的 HTML サイトを **安全に HTTPS 配信** する構成を構築しました。  
独自ドメイン `inatom-portfolio.com` でアクセス可能です。

---

## 構成

| サービス | 役割 |
|----------|------|
| **S3 (Tokyo)** | 静的サイトホスティング。`index.html` を配置。パブリックアクセスはブロック。 |
| **CloudFront** | CDN。HTTPS 配信と高速化。Origin Access Control (OAC) で S3 への安全なアクセスを実現。 |
| **ACM (us-east-1)** | SSL/TLS 証明書。CloudFront に独自ドメイン用 HTTPS を設定。 |
| **Route53** | 独自ドメイン管理。Aレコード（エイリアス）で CloudFront に紐付け。 |

---

## セキュリティポイント

- S3 バケットは非公開（ACL 無効、パブリックアクセスブロックON）  
- CloudFront + OAC で S3 への安全なアクセス制御  
- HTTPS でブラウザ通信を暗号化

---

## アクセスフロー
[ブラウザ] ---> HTTPS ---> [CloudFront CDN] ---> [S3 バケット (非公開)]

## 💻 Tech Stack

### AWS Services
- **S3**: Static website hosting
- **CloudFront**: CDN, SSL termination, performance optimization  
- **Route53**: DNS management, high availability
- **ACM**: SSL certificate management
- **GitHub Actions**: CI/CD pipeline, automated deployment

### Frontend
- **HTML5**: Semantic markup, accessibility
- **CSS3**: Responsive design, modern UI
- **JavaScript**: Tab navigation, smooth interactions

## 📊 Key Features

### Technical Implementation
- **Serverless Architecture**: Zero server management, cost-effective scaling
- **Performance Optimized**: CloudFront CDN for global content delivery
- **Security**: HTTPS enforcement, secure headers
- **CI/CD Pipeline**: Automated testing and deployment
- **Responsive Design**: Mobile-first approach

### Content Highlights
- AWS SAA certification and practical experience
- Serverless data processing system (100k+ records/month)
- Real-world project outcomes and metrics
- Social impact through disability employment support

## 💰 Cost Optimization
- Monthly operational cost: ~¥280 ($2 USD)
- Pay-as-you-go serverless model
- Efficient resource utilization

## 🔄 Deployment Process
```bash
# Clone repository
git clone https://github.com/yourusername/inatom-portfolio.git

# Local development
open index.html

# Automated deployment via GitHub Actions
git push origin main
📈 Performance Metrics

Lighthouse Score: 95+ (Performance, Accessibility, Best Practices)
Load Time: < 2 seconds globally
Availability: 99.9%+ uptime via AWS infrastructure

🎯 Project Goals
This portfolio demonstrates:

Practical AWS infrastructure knowledge
Modern web development practices
Cost-conscious cloud architecture
DevOps automation skills
Technical communication abilities

📧 Contact
Inatom (伊奈 斗夢)
AWS Infrastructure Engineer
📍 Based in Japan

This site showcases real-world AWS experience gained through hands-on serverless system development and AWS Solutions Architect Associate certification.

## GitHub Repository Settings
**Repository Name**: `inatom-portfolio`
**Visibility**: Public
**Include README**: Yes
**License**: MIT License (recommended for portfolio projects)
**Topics**: `aws`, `serverless`, `portfolio`, `infrastructure`, `cloudfront`, `s3`, `github-actions`
