Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36659 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbdBVKOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 05:14:32 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 4/4] blk-mq: free hctx->cpumask in release handler of hctx's kobject
Date: Wed, 22 Feb 2017 18:14:02 +0800
Message-Id: <1487758442-5855-5-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
References: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It is obviously that hctx->cpumask is per hctx, and both
share same lifetime, so this patch moves freeing of hctx->cpumask
into release handler of hctx's kobject.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-mq-sysfs.c |  1 +
 block/blk-mq.c       | 12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index cb19ec16a7fc..d745ab81033a 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -21,6 +21,7 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 {
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
+	free_cpumask_var(hctx->cpumask);
 	kfree(hctx->ctxs);
 	kfree(hctx);
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 993bb4d4d909..db97f53e99d0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1851,16 +1851,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	}
 }
 
-static void blk_mq_free_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		free_cpumask_var(hctx->cpumask);
-}
-
 static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
@@ -2229,7 +2219,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			if (hctx->tags)
 				blk_mq_free_map_and_requests(set, j);
 			blk_mq_exit_hctx(q, set, hctx, j);
-			free_cpumask_var(hctx->cpumask);
 			kobject_put(&hctx->kobj);
 			hctxs[j] = NULL;
 
@@ -2342,7 +2331,6 @@ void blk_mq_free_queue(struct request_queue *q)
 	blk_mq_del_queue_tag_set(q);
 
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
-	blk_mq_free_hw_queues(q, set);
 }
 
 /* Basically redo blk_mq_init_queue with queue frozen */
-- 
2.7.4
