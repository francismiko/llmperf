#!/bin/bash

export $(grep -v '^#' .env | xargs)

python token_benchmark_ray.py \
  --model "deepseek-chat" \
  --mean-input-tokens 550 \
  --stddev-input-tokens 150 \
  --mean-output-tokens 150 \
  --stddev-output-tokens 10 \
  --max-num-completed-requests 1000 \
  --timeout 600 \
  --num-concurrent-requests 100 \
  --results-dir "result_outputs" \
  --llm-api openai \
  --additional-sampling-params '{}'

if [ $? -eq 0 ]; then
  echo "✅ Benchmark completed. Results saved to results.json"
else
  echo "❌ Benchmark failed. Check stderr.log for details"
fi

# --mean-input-tokens 输入 Token 的平均长度，模拟典型用户输入文本的规模
# --stddev-input-tokens 输入 Token 的标准差，模拟用户输入文本的多样性
# --mean-output-tokens 输出 Token 的平均长度，模拟典型用户输入文本的规模
# --stddev-output-tokens 输出 Token 的标准差，模拟用户输入文本的多样性
# --max-num-completed-requests 最大完成的请求数，模拟并发请求的规模
# --timeout 测试超时时间，单位秒
# --num-concurrent-requests 并发请求数，模拟并发请求的规模

# 典型调整场景：
# 压力测试：增大 --num-concurrent-requests（如 10/50/100）
# 稳定性测试：增大 --max-num-completed-requests（如 1000+）
