Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D20C43461
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 08:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E5D208C7
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 08:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgIGIge (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:36:34 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45936 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727874AbgIGIge (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Sep 2020 04:36:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U88-1PX_1599467791;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U88-1PX_1599467791)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Sep 2020 16:36:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: Remove unused blk_mq_sched_free_hctx_data()
Date:   Mon,  7 Sep 2020 16:36:17 +0800
Message-Id: <0b736d64c0546c292ae8f1bcbe9d801c28e12583.1599467604.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we usually free the hctx->sched_data by e->type->ops.exit_hctx(),
and no users will use blk_mq_sched_free_hctx_data() function.
Remove it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-mq-sched.c | 15 ---------------
 block/blk-mq-sched.h |  3 ---
 2 files changed, 18 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 86d5545..3e95967 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -18,21 +18,6 @@
 #include "blk-mq-tag.h"
 #include "blk-wbt.h"
 
-void blk_mq_sched_free_hctx_data(struct request_queue *q,
-				 void (*exit)(struct blk_mq_hw_ctx *))
-{
-	struct blk_mq_hw_ctx *hctx;
-	int i;
-
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (exit && hctx->sched_data)
-			exit(hctx);
-		kfree(hctx->sched_data);
-		hctx->sched_data = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
-
 void blk_mq_sched_assign_ioc(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 126021f..fe62e7c 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -5,9 +5,6 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
-void blk_mq_sched_free_hctx_data(struct request_queue *q,
-				 void (*exit)(struct blk_mq_hw_ctx *));
-
 void blk_mq_sched_assign_ioc(struct request *rq);
 
 void blk_mq_sched_request_inserted(struct request *rq);
-- 
1.8.3.1

