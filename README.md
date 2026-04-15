# 个人知识库RAG问答系统

把你所有的markdown笔记做成可问答的知识库，随时提问找内容，不用自己翻文件。

## 功能特性

- 本地纯Python运行，数据存在自己电脑，隐私安全
- 自动加载 `knowledge/` 目录下所有markdown文件
- 基于 Minimax API，性价比高，国内直接调用不翻墙
- 使用 ChromaDB 做向量存储，无需额外部署服务
- 自定义适配 Minimax Embedding 接口，支持 GroupID 认证

## 快速开始

### 1. 安装依赖

```bash
pip install -r requirements.txt
```

### 2. 配置API Key

```bash
cp .env.example .env
```

编辑 `.env` 文件，填入你的 [Minimax API Key](https://platform.minimaxi.com/):

```
DASHSCOPE_API_KEY=你的-minimax-api-key在这里
MINIMAX_GROUP_ID=你的-group-id在这里
```

**说明**：Minimax 需要同时提供 API Key 和 Group ID，两个都可以从 Minimax 控制台获取。

### 3. 添加你的知识库

把你的markdown文件放到 `knowledge/` 目录下，支持子目录。

### 4. 运行

```bash
python main.py
```

### 5. 第一次使用

进入程序后，先输入 `load` 加载所有markdown文件：
```
> load
正在加载知识库...
找到 X 个markdown文件
分割为 Y 个文本块
知识库更新完成，当前总共有 Z 个文档块
```

加载完成就可以直接提问了！

## 使用说明

### 常用命令

| 命令 | 作用 |
|------|------|
| `load` | 重新加载所有markdown文件更新索引 |
| `clear` | 清空知识库索引 |
| `stats` | 查看知识库统计信息 |
| `help` | 显示帮助 |
| `exit` | 退出 |

### 调优参数

在 `.env` 文件中可以调整：

```
# 分块大小，根据你的文档长度调整
CHUNK_SIZE=500
# 重叠大小，避免内容被从中间切开丢失上下文
CHUNK_OVERLAP=50
```

如果发现回答找不到正确内容：
- 如果文档都比较长，可以试试 `CHUNK_SIZE=1000`
- 如果切分得不对，可以调大 `CHUNK_OVERLAP` 到 100

## 项目结构

```
personal-knowledge-rag/
├── main.py              # 交互式命令行入口
├── rag_engine.py        # RAG核心引擎
├── requirements.txt     # 依赖列表
├── .env.example         # 环境变量示例
├── knowledge/           # 你的markdown知识库放这里
└── chroma_db/           # 向量数据库持久化存储（自动生成）
```

## 技术栈

- **LangChain**: RAG框架
- **ChromaDB**: 本地向量数据库
- **Minimax**: 大语言模型 + Embedding
- **OpenAI SDK**: 兼容 Minimax API 接口

## 成本说明

Minimax 价格非常便宜：
- 输入: 约 0.1-0.3 元/百万tokens
- 输出: 约 0.3-0.6 元/百万tokens
- Embedding: 约 0.02 元/百万tokens

100篇markdown文章，大概也就几分钱成本。
