# AWS Infrastructure Engineer Portfolio

AWS認定ソリューションアーキテクトとして構築した、セキュアで高性能なWebポートフォリオサイトです。  
最新のAWSベストプラクティスを学習し、コスト効率とセキュリティを両立させたクラウドアーキテクチャを実装しました。

## 🌐 Live Demo
**[https://inatom-portfolio.com](https://inatom-portfolio.com)**

## 📋 プロジェクト概要

静的WebサイトをAWSクラウドで安全かつ高速に配信するための、フルマネージドサーバーレス構成を構築しました。  
学習目的でありながら、実用性とセキュリティを重視した実装を行っています。

## 🏗️ システム構成

### AWSサーバーレスアーキテクチャ
![AWS Architecture - Amazon Product Research Pipeline](assets/portfolio-architecture.webp)  
📖 **[高解像度版（SVG）はこちら](assets/portfolio-architecture.svg)**

### データフロー概要

```
[ユーザー] → [Route53] → [CloudFront] → [S3 (非公開)]
                           ↓
                       [ACM SSL証明書]
                           ↓
                   [GitHub Actions CI/CD]
```

## 💻 使用技術・サービス

### AWS インフラストラクチャ
| サービス | 役割 | 学習・選定理由 |
|----------|------|----------|
| **Amazon S3** | 静的ファイルホスティング | 高可用性・低コスト・管理の簡単さを学習 |
| **CloudFront** | CDN・SSL終端 | 世界規模での配信・セキュリティ機能を習得 |
| **Route53** | DNS管理 | DNSの仕組み・AWSサービス統合を理解 |
| **ACM** | SSL証明書管理 | HTTPS化・証明書ライフサイクルを学習 |
| **IAM** | 権限管理 | 最小権限の原則・セキュリティ設計を実践 |

### 開発・運用
| 技術 | 用途 | 学習内容 |
|------|------|----------|
| **GitHub Actions** | CI/CD | 自動化の重要性・YAML設定・AWS連携を習得 |
| **HTML5/CSS3** | フロントエンド | 基本的なWeb構造・レスポンシブデザインを学習 |
| **JavaScript** | インタラクション | DOM操作・イベント処理の基礎を実装 |

## 🔒 セキュリティ実装

### Origin Access Control (OAC)
- **S3バケット完全非公開化**: パブリックアクセス設定の危険性を理解し回避
- **CloudFrontのみアクセス許可**: OACによる安全なアクセス制御を学習・実装
- **最新のAWS推奨方式**: 従来のOAIとOACの違いを理解

### HTTPS・SSL対応
- **ACM証明書使用**: SSL証明書の仕組み・CloudFrontとの連携を学習
- **HTTPS強制リダイレクト**: セキュアな通信の重要性を理解
- **DNS設定**: 独自ドメインでのHTTPS化プロセスを習得

## ⚡ パフォーマンス設計

### CDN活用による高速化
- **グローバル配信**: エッジロケーションの仕組みを学習
- **キャッシュ戦略**: 静的コンテンツ配信の最適化を理解
- **データ圧縮**: 転送効率化の重要性を実感

### 実測パフォーマンス
*実際の測定結果*
- **PageSpeed Insights**: [[**[100/100]**]](https://pagespeed.web.dev/analysis/https-inatom-portfolio-com/qf5wz9srz6?form_factor=mobile)
- **Lighthouse Score**: **[93/100]**
- **実際のロード時間**: **[326ms]**
  
Captured at 2025年8月26日 15:02 JST

## 💰 コスト最適化

### 月額運用費（実績）
```
Route53 (ホストゾーン): ¥75
ドメイン名 (.com): ¥150
S3 ストレージ・リクエスト: ¥10
CloudFront 配信: ¥250
ACM証明書: ¥0 (無料)
合計: 約¥485/月
```

### コスト設計の学習ポイント
- **サーバーレス構成**: 固定費削減・従量課金制度の理解
- **リージョン選択**: データ保存場所とコストの関係を学習
- **サービス連携**: 各AWSサービスの料金体系を把握

## 🚀 CI/CDパイプライン

### 実装した自動化フロー
```
Git Push → GitHub Actions → AWS認証 → S3同期 → CloudFront無効化 → デプロイ完了
```

### セキュリティ学習ポイント
- **IAMベストプラクティス**: ルートユーザー使用の危険性を理解
- **GitHub Secrets**: 認証情報管理の重要性を学習
- **最小権限の原則**: 必要最小限の権限設定を実践

## 📈 学習成果・実装経験

### 習得した技術要素
- **AWSクラウド基礎**: 主要サービスの役割・連携方法を理解
- **Web基礎技術**: HTML・CSS・JavaScriptの基本構造を学習
- **DevOps入門**: 自動化の重要性・CI/CDの概念を実践
- **セキュリティ意識**: クラウド環境での適切な権限管理を習得

### 開発アプローチ
- **効率的学習**: AIツールを活用した技術習得・問題解決
- **実践的実装**: 実際に動作するシステムを構築・運用
- **継続改善**: 問題発生時の原因分析・解決プロセスを経験

## 🛠️ 開発・デプロイ手順

### ローカル開発環境
```bash
# リポジトリクローン
git clone https://github.com/tomy224/inatom-portfolio.git
cd inatom-portfolio

# ローカル確認
open index.html
```

### 自動デプロイメント
```bash
# 変更をプッシュ（GitHub Actionsが自動実行）
git add .
git commit -m "Update portfolio content"
git push origin main
```

## 🎯 プロジェクトの学習価値

### インフラエンジニアとしての基礎習得
- **AWSサービス理解**: 各サービスの特徴・適用場面を学習
- **コスト意識**: 効率的な構成での運用費削減を実践
- **運用自動化**: 手動作業削減の重要性を実感

### 技術学習・問題解決能力
- **要件整理**: 個人サイトに必要な機能を明確化
- **技術選択**: 複数選択肢から適切な技術を選択する経験
- **トラブルシューティング**: エラー発生時の原因分析・解決手法を習得

### 現代的な開発手法の理解
- **Infrastructure as Code**: 設定の自動化・再現性の重要性を学習
- **セキュリティファースト**: セキュアな設計の必要性を理解
- **AIツール活用**: 効率的な学習・開発での適切な活用方法を習得

---

## 📧 Contact

**伊奈 斗夢 (Inatom)**  
AWS Infrastructure Engineer  
🔗 GitHub: [tomy224](https://github.com/tomy224)  
📍 Location: 愛知県

---

*このポートフォリオサイトは、AWS Solutions Architect Associate資格取得の学習成果と、実際のクラウドシステム開発経験を活用して構築されています。AIツールを効率的に活用しながら、実践的な技術習得を目指しました。*
