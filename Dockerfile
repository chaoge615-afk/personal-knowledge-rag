# 个人知识库RAG - Docker 构建文件
FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码（排除 .env 和敏感文件）
COPY rag_engine.py .
COPY api.py .
COPY main.py .
COPY load_cli.py .
COPY templates/ ./templates/

# 创建数据目录
RUN mkdir -p knowledge chroma_db logs

# 暴露端口
EXPOSE 8000

# 环境变量（容器内运行时可通过 -e 覆盖）
ENV KNOWLEDGE_DIR=/app/knowledge
ENV CHROMA_PERSIST_DIR=/app/chroma_db

# 启动命令
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]
