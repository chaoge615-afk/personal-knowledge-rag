#!/usr/bin/env python3
"""
非交互式知识库加载入口
用于后台运行加载，输出日志到文件
"""
from rag_engine import KnowledgeRAG
import logging
import sys


def main():
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        stream=sys.stdout
    )
    logger = logging.getLogger(__name__)

    logger.info("=== 开始后台加载知识库 ===")

    try:
        logger.info("初始化RAG引擎...")
        rag = KnowledgeRAG()
        logger.info("RAG引擎初始化完成")

        count = rag.load_knowledge()

        if count > 0:
            logger.info(f"=== 加载完成成功，共 {count} 个文本块 ===")
        else:
            logger.warning("=== 加载完成，未找到任何文档 ===")
        sys.exit(0)
    except Exception as e:
        logger.error(f"=== 加载失败: {str(e)} ===", exc_info=True)
        sys.exit(1)


if __name__ == "__main__":
    main()
