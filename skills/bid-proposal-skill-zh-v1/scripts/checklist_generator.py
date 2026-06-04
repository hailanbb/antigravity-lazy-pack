#!/usr/bin/env python3
import json, sys
items = [
    "资格条件是否逐项响应",
    "评分点是否有对应章节",
    "报价金额是否前后一致",
    "技术参数是否逐项响应",
    "签字盖章与附件是否完整",
    "不确定项是否标记为需人工确认",
]
print("# 提交前检查清单")
for i, item in enumerate(items, 1):
    print(f"{i}. [ ] {item}")
