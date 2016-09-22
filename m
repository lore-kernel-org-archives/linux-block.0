Return-Path: <prvs=80731d7bfe=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <jbacik@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/2] blk-mq: add flag for drivers wanting blocking ->queue_rq()
Date: Thu, 22 Sep 2016 08:53:00 -0600
Message-ID: <1474555980-2787-3-git-send-email-axboe@fb.com>
In-Reply-To: <1474555980-2787-1-git-send-email-axboe@fb.com>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

If a driver sets BLK_MQ_F_BLOCKING, it is allowed to block in its
->queue_rq() handler. For that case, blk-mq ensures that we always
calls it from a safe context.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c         | 2 +-
 include/linux/blk-mq.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c29700010b5c..eae2f12f011f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -908,7 +908,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	    !blk_mq_hw_queue_mapped(hctx)))
 		return;
 
-	if (!async) {
+	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		int cpu = get_cpu();
 		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fbcfdf323243..5daa0ef756dd 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -155,6 +155,7 @@ enum {
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
+	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
-- 
2.7.4
