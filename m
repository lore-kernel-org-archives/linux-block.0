Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6] mmc: block: Tag DRV_OPs with a driver operation type
Date: Fri, 19 May 2017 15:37:28 +0200
Message-Id: <20170519133732.27470-3-linus.walleij@linaro.org>
In-Reply-To: <20170519133732.27470-1-linus.walleij@linaro.org>
References: <20170519133732.27470-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

We will expand the DRV_OP usage, so we need to know which
operation we're performing. Tag the operations with an
enum:ed type and rename the function so it is clear that
it deals with any command and put a switch statement in
it. Currently only ioctls are supported.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 37 ++++++++++++++++++++++++-------------
 drivers/mmc/core/queue.h |  9 +++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 553ab4d1db94..b24e7f5171c9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -602,6 +602,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		idata->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 		__GFP_RECLAIM);
 	idatas[0] = idata;
+	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->idata = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(mq->queue, NULL, req, 0);
@@ -618,11 +619,11 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 }
 
 /*
- * The ioctl commands come back from the block layer after it queued it and
+ * The non-block commands come back from the block layer after it queued it and
  * processed it with all other requests and then they get issued in this
  * function.
  */
-static void mmc_blk_ioctl_cmd_issue(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_queue_req *mq_rq;
 	struct mmc_card *card = mq->card;
@@ -631,18 +632,27 @@ static void mmc_blk_ioctl_cmd_issue(struct mmc_queue *mq, struct request *req)
 	int i;
 
 	mq_rq = req_to_mmc_queue_req(req);
-	for (i = 0; i < mq_rq->ioc_count; i++) {
-		ioc_err = __mmc_blk_ioctl_cmd(card, md, mq_rq->idata[i]);
-		if (ioc_err)
-			break;
-	}
-	mq_rq->ioc_result = ioc_err;
 
-	/* Always switch back to main area after RPMB access */
-	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
-		mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
+	switch (mq_rq->drv_op) {
+	case MMC_DRV_OP_IOCTL:
+		for (i = 0; i < mq_rq->ioc_count; i++) {
+			ioc_err =
+				__mmc_blk_ioctl_cmd(card, md, mq_rq->idata[i]);
+			if (ioc_err)
+				break;
+		}
+		mq_rq->ioc_result = ioc_err;
+
+		/* Always switch back to main area after RPMB access */
+		if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
+			mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
 
-	blk_end_request_all(req, ioc_err);
+		blk_end_request_all(req, ioc_err);
+		break;
+	default:
+		/* Unknown operation */
+		break;
+	}
 }
 
 static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
@@ -705,6 +715,7 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 	req = blk_get_request(mq->queue,
 		idata[0]->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 		__GFP_RECLAIM);
+	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->idata = idata;
 	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
 	blk_execute_rq(mq->queue, NULL, req, 0);
@@ -1904,7 +1915,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 			 */
 			if (mq->qcnt)
 				mmc_blk_issue_rw_rq(mq, NULL);
-			mmc_blk_ioctl_cmd_issue(mq, req);
+			mmc_blk_issue_drv_op(mq, req);
 			break;
 		case REQ_OP_DISCARD:
 			/*
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 2793020a3c8c..1e6062eb3e07 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -32,6 +32,14 @@ struct mmc_blk_request {
 	int			retune_retry_done;
 };
 
+/**
+ * enum mmc_drv_op - enumerates the operations in the mmc_queue_req
+ * @MMC_DRV_OP_IOCTL: ioctl operation
+ */
+enum mmc_drv_op {
+	MMC_DRV_OP_IOCTL,
+};
+
 struct mmc_queue_req {
 	struct mmc_blk_request	brq;
 	struct scatterlist	*sg;
@@ -39,6 +47,7 @@ struct mmc_queue_req {
 	struct scatterlist	*bounce_sg;
 	unsigned int		bounce_sg_len;
 	struct mmc_async_req	areq;
+	enum mmc_drv_op		drv_op;
 	int			ioc_result;
 	struct mmc_blk_ioc_data	**idata;
 	unsigned int		ioc_count;
-- 
2.9.3
