# AWS Infrastructure Engineer Portfolio

AWS認定ソリューションアーキテクトとして構築した、Infrastructure as Code（Terraform）による高性能なWebポートフォリオサイトです。GitHub Actionsを活用した自動デプロイパイプラインにより、コード変更から本番反映までを完全自動化しています。

## 🌐 Live Demo
**[https://inatom-portfolio.com](https://inatom-portfolio.com)**

## 📋 プロジェクト概要

AWSクラウドでのサーバーレス静的ウェブサイトホスティングを、Infrastructure as Code（Terraform）で管理するポートフォリオサイト。セキュアで高可用性なアーキテクチャを実装し、CI/CDパイプラインによる運用自動化を実現しています。

## 🏗️ システム構成

### AWSサーバーレスアーキテクチャ
![AWS Architecture - Portfolio Infrastructure](assets/portfolio-architecture.svg)  

### インフラフロー概要

```
[Developer] → [GitHub Repository] → [GitHub Actions]
                                          ↓
[ユーザー] → [Route53] → [CloudFront] → [S3] ← [Terraform]
                          ↓                     ↑
                      [ACM SSL証明書]           ↓
                                           [tfstate S3]
```

## 💻 使用技術・サービス

### AWS インフラストラクチャ
| サービス | 役割 | 技術選定理由 |
|----------|------|----------|
| **Amazon S3** | 静的ファイルホスティング | 高可用性・低コスト・スケーラビリティ |
| **CloudFront** | CDN・SSL終端 | グローバル配信・セキュリティ強化 |
| **Route53** | DNS管理 | 高信頼性・AWS統合・100%SLA |
| **ACM** | SSL証明書管理 | 自動更新・運用コスト削減 |
| **IAM** | 権限管理 | 最小権限原則・セキュア設計 |

### Infrastructure as Code
| 技術 | 用途 | 実装内容 |
|------|------|----------|
| **Terraform** | インフラ管理 | 全AWSリソースのコード化・バージョン管理 |
| **GitHub Actions** | CI/CD | 自動デプロイ・インフラ更新の自動化 |

### 開発・運用
| 技術 | 用途 | 活用方法 |
|------|------|----------|
| **HTML5/CSS3** | フロントエンド | レスポンシブデザイン・セマンティック構造 |
| **JavaScript** | インタラクション | DOM操作・UI/UX向上 |
| **Git** | バージョン管理 | ソースコード・インフラコードの統合管理 |

## 🔒 セキュリティ実装

### Infrastructure Security
- **Origin Access Control (OAC)**: S3バケット完全非公開化
- **HTTPS強制**: ACM証明書によるエンドツーエンド暗号化
- **最小権限IAM**: 必要最小限のアクセス権限設定
- **tfstate暗号化**: Terraform状態ファイルのセキュア管理

### CI/CD Security
- **GitHub Secrets**: AWS認証情報の暗号化保存
- **自動デプロイ**: 手動操作によるヒューマンエラー防止

## ⚡ パフォーマンス設計

### CDN最適化
- **グローバル配信**: エッジロケーションでのキャッシュ配信
- **データ圧縮**: 転送効率化による高速読み込み
- **IPv6対応**: 次世代プロトコル対応

### 実測パフォーマンス
*最新の測定結果*
- **PageSpeed Insights**: **[100/100]**
- **Lighthouse Score**: **[93/100]**
- **実際のロード時間**: **[326ms]**
  
測定日時: 2025年8月26日 15:02 JST

## 💰 コスト最適化

### 月額運用費（実績）
```
Route53 (ホストゾーン): ¥75
ドメイン名 (.com): ¥150
S3 ストレージ・リクエスト: ¥10
CloudFront 配信: ¥250
ACM証明書: ¥0 (無料)
Terraform tfstate管理: ¥5
合計: 約¥490/月
```

### コスト設計の考慮点
- **サーバーレス構成**: 固定費削減・従量課金制度活用
- **リージョン最適化**: データ保存場所とコスト効率の両立
- **リソース効率化**: 各AWSサービスの料金体系に基づく最適化

## 🚀 CI/CDパイプライン

### 自動化フロー
```
Git Push → GitHub Actions → Terraform Validation → AWS Deploy → CloudFront Invalidation
```

### Infrastructure as Code ワークフロー
- **terraform plan**: インフラ変更の事前確認
- **terraform apply**: 本番環境への安全な反映
- **状態管理**: S3によるtfstateファイル共有
- **ロールバック**: Git履歴による変更追跡・復旧

### セキュリティワークフロー
- **認証管理**: GitHub Secretsによる安全な認証情報管理
- **最小権限**: 専用IAMユーザーによる権限制御
- **変更追跡**: 全インフラ変更のコード履歴管理

## 📈 技術的な学習成果

### Infrastructure as Code習得
- **Terraformによるインフラ管理**: 手動構築からコード管理への移行
- **状態管理**: tfstateファイルによるインフラ状態の一元管理
- **CI/CD統合**: GitHub Actionsとの連携による運用自動化

### AWSクラウド基盤理解
- **サーバーレスアーキテクチャ**: 主要サービスの特徴・適用場面の理解
- **セキュリティ設計**: クラウド環境での適切な権限管理・暗号化
- **コスト意識**: 効率的な構成での運用費最適化

### DevOps実践
- **自動化の価値**: 手動作業削減・品質向上の実現
- **Infrastructure as Code**: 再現性・保守性の向上
- **継続的改善**: 監視・最適化による継続的な改善

## 🛠️ 開発・デプロイ手順

### ローカル開発環境
```bash
# リポジトリクローン
git clone https://github.com/tomy224/inatom-portfolio.git
cd inatom-portfolio

# Terraformでインフラ確認
cd terraform
terraform plan
```

### 自動デプロイメント
```bash
# 変更をプッシュ（GitHub Actionsが自動実行）
git add .
git commit -m "Update infrastructure configuration"
git push origin main
```

### インフラ管理
```bash
# Terraform操作
terraform init    # 初期化
terraform plan    # 変更確認
terraform apply   # 変更適用
```

## 🎯 技術的価値・学習効果

### インフラエンジニアとしての基礎習得
- **AWSサービス理解**: 各サービスの特徴・ベストプラクティス習得
- **Infrastructure as Code**: Terraformによるインフラのコード管理
- **CI/CD構築**: GitHub Actionsによる自動化パイプライン構築
- **セキュリティ意識**: クラウド環境でのセキュア設計

### 実務応用可能なスキル
- **コスト最適化**: 効率的なアーキテクチャ設計による運用費削減
- **運用自動化**: 手動作業の排除・ヒューマンエラー防止
- **スケーラビリティ設計**: 将来的な拡張性を考慮したアーキテクチャ

### 現代的な開発手法の実践
- **Infrastructure as Code**: 設定の自動化・再現性確保
- **GitOps**: Git履歴による変更管理・ロールバック対応
- **継続的改善**: 監視・最適化による品質向上

---

## 📧 Contact

**伊奈 斗夢 (Inatom)**  
AWS Infrastructure Engineer  
🔗 GitHub: [tomy224](https://github.com/tomy224)  
📍 Location: 愛知県

---

*このポートフォリオサイトは、AWS Solutions Architect Associate資格取得の学習成果と、Terraformによる実際のクラウドシステム開発経験を組み合わせて構築されています。Infrastructure as Codeの実践により、再現性とメンテナンス性を重視した設計となっています。*

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

学習目的での利用や改良は自由です。お役に立てば幸いです！
