#!/usr/bin/env python3
# 简单示例：将多行文本整理为去空行列表
import sys
text = sys.stdin.read()
lines = [x.strip() for x in text.splitlines() if x.strip()]
print('\n'.join(lines))
