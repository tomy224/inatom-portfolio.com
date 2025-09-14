import json
import boto3
import requests
from datetime import datetime

cloudwatch = boto3.client('cloudwatch')

def handler(event, context):
    """
    15分間隔でのサイト監視（コスト最適化版）
    """
    
    try:
        # サイトの可用性チェック
        response = requests.get('https://inatom-portfolio.com', timeout=5)
        response_time = response.elapsed.total_seconds() * 1000
        
        # 可用性判定（200番台のみOK）
        availability = 1 if 200 <= response.status_code < 300 else 0
        
        # 重要なメトリクスのみ送信（コスト削減）
        cloudwatch.put_metric_data(
            Namespace='Portfolio/Health',
            MetricData=[
                {
                    'MetricName': 'SiteAvailability',
                    'Value': availability,
                    'Unit': 'Count'
                },
                {
                    'MetricName': 'ResponseTime',
                    'Value': response_time,
                    'Unit': 'Milliseconds'
                }
            ]
        )
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'status': 'healthy' if availability else 'unhealthy',
                'response_time_ms': response_time
            })
        }
        
    except Exception as e:
        # エラー時のみ記録
        cloudwatch.put_metric_data(
            Namespace='Portfolio/Health',
            MetricData=[{
                'MetricName': 'SiteAvailability',
                'Value': 0,
                'Unit': 'Count'
            }]
        )
        
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }