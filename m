Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33163 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbdC0MH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 08:07:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id 79so12401391pgf.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 05:07:28 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v3 3/4] block: rename blk_mq_freeze_queue_start()
Date: Mon, 27 Mar 2017 20:06:57 +0800
Message-Id: <20170327120658.29864-4-tom.leiming@gmail.com>
In-Reply-To: <20170327120658.29864-1-tom.leiming@gmail.com>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As the .q_usage_counter is used by both legacy and
mq path, we need to block new I/O if queue becomes
dead in blk_queue_enter().

So rename it and we can use this function in both
paths.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-core.c                  |  2 +-
 block/blk-mq.c                    | 10 +++++-----
 drivers/block/mtip32xx/mtip32xx.c |  2 +-
 drivers/nvme/host/core.c          |  2 +-
 include/linux/blk-mq.h            |  2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5e8963bc98d9..60f364e1d36b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -670,7 +670,7 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
 			return -EBUSY;
 
 		/*
-		 * read pair of barrier in blk_mq_freeze_queue_start(),
+		 * read pair of barrier in blk_freeze_queue_start(),
 		 * we need to order reading __PERCPU_REF_DEAD flag of
 		 * .q_usage_counter and reading .mq_freeze_depth,
 		 * otherwise the following wait may never return if the
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b36f0481ba0e..5370b4f750ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -68,7 +68,7 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 	sbitmap_clear_bit(&hctx->ctx_map, ctx->index_hw);
 }
 
-void blk_mq_freeze_queue_start(struct request_queue *q)
+void blk_freeze_queue_start(struct request_queue *q)
 {
 	int freeze_depth;
 
@@ -78,7 +78,7 @@ void blk_mq_freeze_queue_start(struct request_queue *q)
 		blk_mq_run_hw_queues(q, false);
 	}
 }
-EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_start);
+EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
 void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
@@ -108,7 +108,7 @@ void blk_freeze_queue(struct request_queue *q)
 	 * no blk_unfreeze_queue(), and blk_freeze_queue() is not
 	 * exported to drivers as the only user for unfreeze is blk_mq.
 	 */
-	blk_mq_freeze_queue_start(q);
+	blk_freeze_queue_start(q);
 	blk_mq_freeze_queue_wait(q);
 }
 
@@ -746,7 +746,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	 * percpu_ref_tryget directly, because we need to be able to
 	 * obtain a reference even in the short window between the queue
 	 * starting to freeze, by dropping the first reference in
-	 * blk_mq_freeze_queue_start, and the moment the last request is
+	 * blk_freeze_queue_start, and the moment the last request is
 	 * consumed, marked by the instant q_usage_counter reaches
 	 * zero.
 	 */
@@ -2376,7 +2376,7 @@ static void blk_mq_queue_reinit_work(void)
 	 * take place in parallel.
 	 */
 	list_for_each_entry(q, &all_q_list, all_q_node)
-		blk_mq_freeze_queue_start(q);
+		blk_freeze_queue_start(q);
 	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_freeze_queue_wait(q);
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index f96ab717534c..c96c35ab39df 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4162,7 +4162,7 @@ static int mtip_block_remove(struct driver_data *dd)
 		dev_info(&dd->pdev->dev, "device %s surprise removal\n",
 						dd->disk->disk_name);
 
-	blk_mq_freeze_queue_start(dd->queue);
+	blk_freeze_queue_start(dd->queue);
 	blk_mq_stop_hw_queues(dd->queue);
 	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b3b57fef446..4a6d7f408769 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2386,7 +2386,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_freeze_queue_start(ns->queue);
+		blk_freeze_queue_start(ns->queue);
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5b3e201c8d4f..ea2e9dcd3aef 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -243,7 +243,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
-void blk_mq_freeze_queue_start(struct request_queue *q);
+void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
-- 
2.9.3
