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
Subject: [PATCH 3/6] mmc: block: Move DRV OP issue function
Date: Fri, 19 May 2017 15:37:29 +0200
Message-Id: <20170519133732.27470-4-linus.walleij@linaro.org>
In-Reply-To: <20170519133732.27470-1-linus.walleij@linaro.org>
References: <20170519133732.27470-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

We will need to access static functions above the pure block layer
operations in the file, so move the driver operations issue
function down so we can see all non-blocklayer symbols.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 74 ++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b24e7f5171c9..75b1baacf28b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -618,43 +618,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	return ioc_err ? ioc_err : err;
 }
 
-/*
- * The non-block commands come back from the block layer after it queued it and
- * processed it with all other requests and then they get issued in this
- * function.
- */
-static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
-{
-	struct mmc_queue_req *mq_rq;
-	struct mmc_card *card = mq->card;
-	struct mmc_blk_data *md = mq->blkdata;
-	int ioc_err;
-	int i;
-
-	mq_rq = req_to_mmc_queue_req(req);
-
-	switch (mq_rq->drv_op) {
-	case MMC_DRV_OP_IOCTL:
-		for (i = 0; i < mq_rq->ioc_count; i++) {
-			ioc_err =
-				__mmc_blk_ioctl_cmd(card, md, mq_rq->idata[i]);
-			if (ioc_err)
-				break;
-		}
-		mq_rq->ioc_result = ioc_err;
-
-		/* Always switch back to main area after RPMB access */
-		if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
-			mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
-
-		blk_end_request_all(req, ioc_err);
-		break;
-	default:
-		/* Unknown operation */
-		break;
-	}
-}
-
 static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 				   struct mmc_ioc_multi_cmd __user *user)
 {
@@ -1222,6 +1185,43 @@ int mmc_access_rpmb(struct mmc_queue *mq)
 	return false;
 }
 
+/*
+ * The non-block commands come back from the block layer after it queued it and
+ * processed it with all other requests and then they get issued in this
+ * function.
+ */
+static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mq_rq;
+	struct mmc_card *card = mq->card;
+	struct mmc_blk_data *md = mq->blkdata;
+	int ioc_err;
+	int i;
+
+	mq_rq = req_to_mmc_queue_req(req);
+
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
+
+		blk_end_request_all(req, ioc_err);
+		break;
+	default:
+		/* Unknown operation */
+		break;
+	}
+}
+
 static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
-- 
2.9.3
