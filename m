Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57355 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758090AbdAKVkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:14 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 04/10] blk-mq: un-export blk_mq_free_hctx_request()
Date: Wed, 11 Jan 2017 14:39:57 -0700
Message-ID: <1484170803-9311-5-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It's only used in blk-mq, kill it from the main exported header
and kill the symbol export as well.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c         | 5 ++---
 include/linux/blk-mq.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 79e1cb0f7b15..f49f6325b332 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -337,15 +337,14 @@ static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
 	blk_queue_exit(q);
 }
 
-void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *hctx,
+				     struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
 	ctx->rq_completed[rq_is_sync(rq)]++;
 	__blk_mq_free_request(hctx, ctx, rq);
-
 }
-EXPORT_SYMBOL_GPL(blk_mq_free_hctx_request);
 
 void blk_mq_free_request(struct request *rq)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index afc81d77e471..2686f9e7302a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -181,7 +181,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
 
 void blk_mq_insert_request(struct request *, bool, bool, bool);
 void blk_mq_free_request(struct request *rq);
-void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *, struct request *rq);
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
 
 enum {
-- 
2.7.4

