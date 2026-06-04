---
name: bid-proposal-skill-zh
description: Use this skill when the user needs to generate, review, or assemble Chinese bid documents, proposal documents, tender responses, sales solution documents, or pre-sales technical方案书.
---

# 标书/方案书 Skill（中文增强版）

## 目标
帮助 Agent 将招标文件、客户需求、公司资料、产品资料和报价信息，整理成可检查、可交付的投标材料或方案书初稿。

## 使用时机
当用户要求生成：标书、投标文件、客户方案书、售前技术方案、商务响应、技术响应、项目实施方案、服务承诺、投标检查清单时，使用本 Skill。

## 工作流
1. 识别材料类型：招标文件、客户需求、公司资料、产品资料、报价表、资质证书。
2. 提取要求：资格条件、技术参数、商务条款、评分点、提交材料、格式要求。
3. 生成响应矩阵：每个要求必须对应到章节或待补充项。
4. 生成方案结构：商务部分、技术部分、实施计划、售后服务、案例证明、附件清单。
5. 生成正文：优先围绕评分点与客户痛点展开，而不是泛泛介绍。
6. 输出人工确认项：报价、资质、案例真实性、签章、授权、日期、附件完整性必须提醒人工确认。
7. 交付前检查：目录、页码、文件名、签章、报价一致性、附件完整性、格式要求。

## 输出要求
- 不确定的信息必须标记为“需人工确认”。
- 不允许伪造资质、案例、证书、授权、报价。
- 输出必须包含：响应矩阵、方案目录、正文初稿、资料缺口、提交前检查表。

## 参考文件
- references/bid_review_checklist.md：提交前检查清单
- references/scoring_response_matrix.md：评分点响应矩阵模板
- references/proposal_outline_template.md：方案书目录模板
- assets/proposal_brief_template.md：客户需求简报模板
