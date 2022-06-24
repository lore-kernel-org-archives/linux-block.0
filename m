Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF8AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 03:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiFXDbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 23:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiFXDbD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 23:31:03 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD76361A;
        Thu, 23 Jun 2022 20:31:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VHFAdO9_1656041424;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VHFAdO9_1656041424)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 11:30:58 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: remove unnecessary variables in blk_mq_init_cpu_queues
Date:   Fri, 24 Jun 2022 11:30:24 +0800
Message-Id: <1656041424-50894-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

Remove unnecessary variables and adjust code style to be the same as
other functions in blk-mq.c, no functional modification involved.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bf950..c71119d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3579,19 +3579,18 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 				   unsigned int nr_hw_queues)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
+	struct blk_mq_ctx *ctx;
+	struct blk_mq_hw_ctx *hctx;
 	unsigned int i, j;
 
 	for_each_possible_cpu(i) {
-		struct blk_mq_ctx *__ctx = per_cpu_ptr(q->queue_ctx, i);
-		struct blk_mq_hw_ctx *hctx;
-		int k;
-
-		__ctx->cpu = i;
-		spin_lock_init(&__ctx->lock);
-		for (k = HCTX_TYPE_DEFAULT; k < HCTX_MAX_TYPES; k++)
-			INIT_LIST_HEAD(&__ctx->rq_lists[k]);
+		ctx = per_cpu_ptr(q->queue_ctx, i);
+		ctx->cpu = i;
+		ctx->queue = q;
 
-		__ctx->queue = q;
+		spin_lock_init(&ctx->lock);
+		for (j = HCTX_TYPE_DEFAULT; j < HCTX_MAX_TYPES; j++)
+			INIT_LIST_HEAD(&ctx->rq_lists[j]);
 
 		/*
 		 * Set local node, IFF we have more than one hw queue. If
-- 
1.8.3.1

