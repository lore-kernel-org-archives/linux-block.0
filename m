Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33297 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932116AbdBVKO0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 05:14:26 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 2/4] blk-mq: make lifetime consitent between q/ctx and its kobject
Date: Wed, 22 Feb 2017 18:14:00 +0800
Message-Id: <1487758442-5855-3-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
References: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently from kobject view, both q->mq_kobj and ctx->kobj can
be released during one cycle of blk_mq_register_dev() and
blk_mq_unregister_dev(). Actually, sw queue's lifetime is
same with its request queue's, which is covered by request_queue->kobj.

So we don't need to call kobject_put() for the two kinds of
kobject in __blk_mq_unregister_dev(), instead we do that
in release handler of request queue.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-mq-sysfs.c | 20 +++++++++++++-------
 block/blk-mq.c       |  7 ++++++-
 block/blk-mq.h       |  1 +
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 124305407c80..77fb238af2be 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -242,15 +242,11 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
-	int i, j;
+	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		blk_mq_unregister_hctx(hctx);
 
-		hctx_for_each_ctx(hctx, ctx, j)
-			kobject_put(&ctx->kobj);
-
 		kobject_put(&hctx->kobj);
 	}
 
@@ -258,8 +254,6 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(&q->mq_kobj);
-	kobject_put(&q->mq_kobj);
-
 	kobject_put(&dev->kobj);
 
 	q->mq_sysfs_init_done = false;
@@ -277,6 +271,18 @@ void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
 	kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
 }
 
+void blk_mq_sysfs_deinit(struct request_queue *q)
+{
+	struct blk_mq_ctx *ctx;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		ctx = per_cpu_ptr(q->queue_ctx, cpu);
+		kobject_put(&ctx->kobj);
+	}
+	kobject_put(&q->mq_kobj);
+}
+
 void blk_mq_sysfs_init(struct request_queue *q)
 {
 	struct blk_mq_ctx *ctx;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ade1d7cde37e..bc45736d70ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2160,7 +2160,12 @@ void blk_mq_release(struct request_queue *q)
 
 	kfree(q->queue_hw_ctx);
 
-	/* ctx kobj stays in queue_ctx */
+	/*
+	 * release .mq_kobj and sw queue's kobject now because
+	 * both share lifetime with request queue.
+	 */
+	blk_mq_sysfs_deinit(q);
+
 	free_percpu(q->queue_ctx);
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 445343425f6d..2cd73b762351 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -78,6 +78,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
  * sysfs helpers
  */
 extern void blk_mq_sysfs_init(struct request_queue *q);
+extern void blk_mq_sysfs_deinit(struct request_queue *q);
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
-- 
2.7.4
