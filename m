Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/29] blk-cgroup: remove legacy queue bypassing
Date: Mon, 29 Oct 2018 10:34:32 -0600
Message-Id: <20181029163444.9940-18-axboe@kernel.dk>
In-Reply-To: <20181029163444.9940-1-axboe@kernel.dk>
References: <20181029163444.9940-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We only support mq devices now.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 992da5592c6e..5f10d755ec52 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1446,8 +1446,6 @@ int blkcg_activate_policy(struct request_queue *q,
 
 	if (q->mq_ops)
 		blk_mq_freeze_queue(q);
-	else
-		blk_queue_bypass_start(q);
 pd_prealloc:
 	if (!pd_prealloc) {
 		pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q->node);
@@ -1487,8 +1485,6 @@ int blkcg_activate_policy(struct request_queue *q,
 out_bypass_end:
 	if (q->mq_ops)
 		blk_mq_unfreeze_queue(q);
-	else
-		blk_queue_bypass_end(q);
 	if (pd_prealloc)
 		pol->pd_free_fn(pd_prealloc);
 	return ret;
@@ -1513,8 +1509,6 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 	if (q->mq_ops)
 		blk_mq_freeze_queue(q);
-	else
-		blk_queue_bypass_start(q);
 
 	spin_lock_irq(q->queue_lock);
 
@@ -1533,8 +1527,6 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 	if (q->mq_ops)
 		blk_mq_unfreeze_queue(q);
-	else
-		blk_queue_bypass_end(q);
 }
 EXPORT_SYMBOL_GPL(blkcg_deactivate_policy);
 
-- 
2.17.1
