Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/30] mspro_block: convert to blk-mq
Date: Wed, 31 Oct 2018 11:58:55 -0600
Message-Id: <20181031175922.8849-4-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Straight forward conversion, there's room for improvement.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/memstick/core/mspro_block.c | 121 +++++++++++++++-------------
 1 file changed, 66 insertions(+), 55 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 0cd30dcb6801..aba50ec98b4d 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -12,7 +12,7 @@
  *
  */
 
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/idr.h>
 #include <linux/hdreg.h>
 #include <linux/kthread.h>
@@ -142,6 +142,7 @@ struct mspro_block_data {
 	struct gendisk        *disk;
 	struct request_queue  *queue;
 	struct request        *block_req;
+	struct blk_mq_tag_set tag_set;
 	spinlock_t            q_lock;
 
 	unsigned short        page_size;
@@ -152,7 +153,6 @@ struct mspro_block_data {
 	unsigned char         system;
 	unsigned char         read_only:1,
 			      eject:1,
-			      has_request:1,
 			      data_dir:1,
 			      active:1;
 	unsigned char         transfer_cmd;
@@ -694,13 +694,12 @@ static void h_mspro_block_setup_cmd(struct memstick_dev *card, u64 offset,
 
 /*** Data transfer ***/
 
-static int mspro_block_issue_req(struct memstick_dev *card, int chunk)
+static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
 {
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
 	u64 t_off;
 	unsigned int count;
 
-try_again:
 	while (chunk) {
 		msb->current_page = 0;
 		msb->current_seg = 0;
@@ -709,9 +708,17 @@ static int mspro_block_issue_req(struct memstick_dev *card, int chunk)
 					       msb->req_sg);
 
 		if (!msb->seg_count) {
-			chunk = __blk_end_request_cur(msb->block_req,
-					BLK_STS_RESOURCE);
-			continue;
+			unsigned int bytes = blk_rq_cur_bytes(msb->block_req);
+
+			chunk = blk_update_request(msb->block_req,
+							BLK_STS_RESOURCE,
+							bytes);
+			if (chunk)
+				continue;
+			__blk_mq_end_request(msb->block_req,
+						BLK_STS_RESOURCE);
+			msb->block_req = NULL;
+			break;
 		}
 
 		t_off = blk_rq_pos(msb->block_req);
@@ -729,30 +736,22 @@ static int mspro_block_issue_req(struct memstick_dev *card, int chunk)
 		return 0;
 	}
 
-	dev_dbg(&card->dev, "blk_fetch\n");
-	msb->block_req = blk_fetch_request(msb->queue);
-	if (!msb->block_req) {
-		dev_dbg(&card->dev, "issue end\n");
-		return -EAGAIN;
-	}
-
-	dev_dbg(&card->dev, "trying again\n");
-	chunk = 1;
-	goto try_again;
+	return 1;
 }
 
 static int mspro_block_complete_req(struct memstick_dev *card, int error)
 {
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
-	int chunk, cnt;
+	int cnt;
+	bool chunk;
 	unsigned int t_len = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msb->q_lock, flags);
-	dev_dbg(&card->dev, "complete %d, %d\n", msb->has_request ? 1 : 0,
+	dev_dbg(&card->dev, "complete %d, %d\n", msb->block_req ? 1 : 0,
 		error);
 
-	if (msb->has_request) {
+	if (msb->block_req) {
 		/* Nothing to do - not really an error */
 		if (error == -EAGAIN)
 			error = 0;
@@ -777,15 +776,17 @@ static int mspro_block_complete_req(struct memstick_dev *card, int error)
 		if (error && !t_len)
 			t_len = blk_rq_cur_bytes(msb->block_req);
 
-		chunk = __blk_end_request(msb->block_req,
+		chunk = blk_update_request(msb->block_req,
 				errno_to_blk_status(error), t_len);
-
-		error = mspro_block_issue_req(card, chunk);
-
-		if (!error)
-			goto out;
-		else
-			msb->has_request = 0;
+		if (chunk) {
+			error = mspro_block_issue_req(card, chunk);
+			if (!error)
+				goto out;
+		} else {
+			__blk_mq_end_request(msb->block_req,
+						errno_to_blk_status(error));
+			msb->block_req = NULL;
+		}
 	} else {
 		if (!error)
 			error = -EAGAIN;
@@ -806,8 +807,8 @@ static void mspro_block_stop(struct memstick_dev *card)
 
 	while (1) {
 		spin_lock_irqsave(&msb->q_lock, flags);
-		if (!msb->has_request) {
-			blk_stop_queue(msb->queue);
+		if (!msb->block_req) {
+			blk_mq_stop_hw_queues(msb->queue);
 			rc = 1;
 		}
 		spin_unlock_irqrestore(&msb->q_lock, flags);
@@ -822,32 +823,37 @@ static void mspro_block_stop(struct memstick_dev *card)
 static void mspro_block_start(struct memstick_dev *card)
 {
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
-	unsigned long flags;
 
-	spin_lock_irqsave(&msb->q_lock, flags);
-	blk_start_queue(msb->queue);
-	spin_unlock_irqrestore(&msb->q_lock, flags);
+	blk_mq_start_hw_queues(msb->queue);
 }
 
-static void mspro_block_submit_req(struct request_queue *q)
+static blk_status_t mspro_queue_rq(struct blk_mq_hw_ctx *hctx,
+				   const struct blk_mq_queue_data *bd)
 {
-	struct memstick_dev *card = q->queuedata;
+	struct memstick_dev *card = hctx->queue->queuedata;
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
-	struct request *req = NULL;
 
-	if (msb->has_request)
-		return;
+	spin_lock_irq(&msb->q_lock);
 
-	if (msb->eject) {
-		while ((req = blk_fetch_request(q)) != NULL)
-			__blk_end_request_all(req, BLK_STS_IOERR);
+	if (msb->block_req) {
+		spin_unlock_irq(&msb->q_lock);
+		return BLK_STS_DEV_RESOURCE;
+	}
 
-		return;
+	if (msb->eject) {
+		spin_unlock_irq(&msb->q_lock);
+		blk_mq_start_request(bd->rq);
+		return BLK_STS_IOERR;
 	}
 
-	msb->has_request = 1;
-	if (mspro_block_issue_req(card, 0))
-		msb->has_request = 0;
+	msb->block_req = bd->rq;
+	blk_mq_start_request(bd->rq);
+
+	if (mspro_block_issue_req(card, true))
+		msb->block_req = NULL;
+
+	spin_unlock_irq(&msb->q_lock);
+	return BLK_STS_OK;
 }
 
 /*** Initialization ***/
@@ -1167,6 +1173,10 @@ static int mspro_block_init_card(struct memstick_dev *card)
 
 }
 
+static const struct blk_mq_ops mspro_mq_ops = {
+	.queue_rq	= mspro_queue_rq,
+};
+
 static int mspro_block_init_disk(struct memstick_dev *card)
 {
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
@@ -1206,9 +1216,11 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 		goto out_release_id;
 	}
 
-	msb->queue = blk_init_queue(mspro_block_submit_req, &msb->q_lock);
-	if (!msb->queue) {
-		rc = -ENOMEM;
+	msb->queue = blk_mq_init_sq_queue(&msb->tag_set, &mspro_mq_ops, 2,
+						BLK_MQ_F_SHOULD_MERGE);
+	if (IS_ERR(msb->queue)) {
+		rc = PTR_ERR(msb->queue);
+		msb->queue = NULL;
 		goto out_put_disk;
 	}
 
@@ -1318,13 +1330,14 @@ static void mspro_block_remove(struct memstick_dev *card)
 
 	spin_lock_irqsave(&msb->q_lock, flags);
 	msb->eject = 1;
-	blk_start_queue(msb->queue);
 	spin_unlock_irqrestore(&msb->q_lock, flags);
+	blk_mq_start_hw_queues(msb->queue);
 
 	del_gendisk(msb->disk);
 	dev_dbg(&card->dev, "mspro block remove\n");
 
 	blk_cleanup_queue(msb->queue);
+	blk_mq_free_tag_set(&msb->tag_set);
 	msb->queue = NULL;
 
 	sysfs_remove_group(&card->dev.kobj, &msb->attr_group);
@@ -1344,8 +1357,9 @@ static int mspro_block_suspend(struct memstick_dev *card, pm_message_t state)
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
 	unsigned long flags;
 
+	blk_mq_stop_hw_queues(msb->queue);
+
 	spin_lock_irqsave(&msb->q_lock, flags);
-	blk_stop_queue(msb->queue);
 	msb->active = 0;
 	spin_unlock_irqrestore(&msb->q_lock, flags);
 
@@ -1355,7 +1369,6 @@ static int mspro_block_suspend(struct memstick_dev *card, pm_message_t state)
 static int mspro_block_resume(struct memstick_dev *card)
 {
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
-	unsigned long flags;
 	int rc = 0;
 
 #ifdef CONFIG_MEMSTICK_UNSAFE_RESUME
@@ -1401,9 +1414,7 @@ static int mspro_block_resume(struct memstick_dev *card)
 
 #endif /* CONFIG_MEMSTICK_UNSAFE_RESUME */
 
-	spin_lock_irqsave(&msb->q_lock, flags);
-	blk_start_queue(msb->queue);
-	spin_unlock_irqrestore(&msb->q_lock, flags);
+	blk_mq_start_hw_queues(msb->queue);
 	return rc;
 }
 
-- 
2.17.1
