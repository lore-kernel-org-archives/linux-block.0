Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33828 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbdCTJu1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2017 05:50:27 -0400
Received: by mail-qt0-f172.google.com with SMTP id n21so102067381qta.1
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2017 02:49:02 -0700 (PDT)
From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
To: linux-block@vger.kernel.org
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH] blk-mq: Add NULL pointer check for HW dispatch queue
Date: Mon, 20 Mar 2017 15:10:01 +0530
Message-Id: <1490002801-16280-1-git-send-email-jitendra.bhivare@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As part of blk_mq_realloc_hw_ctx(), if the init_hctx() ops is
failed by the underyling transport, the hctx pointer is freed and
initialized to NULL.
However, functions down the line, access this hwctx pointer without
a NULL pointer check, which could lead to a kernel crash.

Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a4546f0..9cb2d2e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2048,6 +2048,8 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 			continue;
 
 		hctx = blk_mq_map_queue(q, i);
+		if (!hctx)
+			continue;
 
 		/*
 		 * Set local node, IFF we have more than one hw queue. If
@@ -2128,6 +2130,8 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
 		hctx = blk_mq_map_queue(q, i);
+		if (!hctx)
+			continue;
 
 		cpumask_set_cpu(i, hctx->cpumask);
 		ctx->index_hw = hctx->nr_ctx;
-- 
1.8.3.1
