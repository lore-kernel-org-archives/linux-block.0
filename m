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
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] mmc: block: move single ioctl() commands to block requests
Date: Wed, 10 May 2017 10:24:17 +0200
Message-Id: <20170510082418.10513-5-linus.walleij@linaro.org>
In-Reply-To: <20170510082418.10513-1-linus.walleij@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This wraps single ioctl() commands into block requests using
the custom block layer request types REQ_OP_DRV_IN and
REQ_OP_DRV_OUT.

By doing this we are loosening the grip on the big host lock,
since two calls to mmc_get_card()/mmc_put_card() are removed.

We are storing the ioctl() in/out argument as a pointer in
the per-request struct mmc_blk_request container. Since we
now let the block layer allocate this data, blk_get_request()
will allocate it for us and we can immediately dereference
it and use it to pass the argument into the block layer.

Tested on the ux500 with the userspace:
mmc extcsd read /dev/mmcblk3
resulting in a successful EXTCSD info dump back to the
console.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 56 ++++++++++++++++++++++++++++++++++++++----------
 drivers/mmc/core/queue.h |  3 +++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 323f3790b629..640db4f57a31 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -564,8 +564,10 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 {
 	struct mmc_blk_ioc_data *idata;
 	struct mmc_blk_data *md;
+	struct mmc_queue *mq;
 	struct mmc_card *card;
 	int err = 0, ioc_err = 0;
+	struct request *req;
 
 	/*
 	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
@@ -591,17 +593,18 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		goto cmd_done;
 	}
 
-	mmc_get_card(card);
-
-	ioc_err = __mmc_blk_ioctl_cmd(card, md, idata);
-
-	/* Always switch back to main area after RPMB access */
-	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
-		mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
-
-	mmc_put_card(card);
-
+	/*
+	 * Dispatch the ioctl() into the block request queue.
+	 */
+	mq = &md->queue;
+	req = blk_get_request(mq->queue,
+		idata->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
+		__GFP_RECLAIM);
+	req_to_mq_rq(req)->idata = idata;
+	blk_execute_rq(mq->queue, NULL, req, 0);
+	ioc_err = req_to_mq_rq(req)->ioc_result;
 	err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
+	blk_put_request(req);
 
 cmd_done:
 	mmc_blk_put(md);
@@ -611,6 +614,31 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	return ioc_err ? ioc_err : err;
 }
 
+/*
+ * The ioctl commands come back from the block layer after it queued it and
+ * processed it with all other requests and then they get issued in this
+ * function.
+ */
+static void mmc_blk_ioctl_cmd_issue(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mq_rq;
+	struct mmc_blk_ioc_data *idata;
+	struct mmc_card *card = mq->card;
+	struct mmc_blk_data *md = mq->blkdata;
+	int ioc_err;
+
+	mq_rq = req_to_mq_rq(req);
+	idata = mq_rq->idata;
+	ioc_err = __mmc_blk_ioctl_cmd(card, md, idata);
+	mq_rq->ioc_result = ioc_err;
+
+	/* Always switch back to main area after RPMB access */
+	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
+		mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
+
+	blk_end_request_all(req, ioc_err);
+}
+
 static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 				   struct mmc_ioc_multi_cmd __user *user)
 {
@@ -1854,7 +1882,13 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		goto out;
 	}
 
-	if (req && req_op(req) == REQ_OP_DISCARD) {
+	if (req &&
+	    (req_op(req) == REQ_OP_DRV_IN || req_op(req) == REQ_OP_DRV_OUT)) {
+		/* complete ongoing async transfer before issuing ioctl()s */
+		if (mq->qcnt)
+			mmc_blk_issue_rw_rq(mq, NULL);
+		mmc_blk_ioctl_cmd_issue(mq, req);
+	} else if (req && req_op(req) == REQ_OP_DISCARD) {
 		/* complete ongoing async transfer before issuing discard */
 		if (mq->qcnt)
 			mmc_blk_issue_rw_rq(mq, NULL);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 8aa10ffdf622..aeb3408dc85e 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -22,6 +22,7 @@ static inline bool mmc_req_is_special(struct request *req)
 
 struct task_struct;
 struct mmc_blk_data;
+struct mmc_blk_ioc_data;
 
 struct mmc_blk_request {
 	struct mmc_request	mrq;
@@ -40,6 +41,8 @@ struct mmc_queue_req {
 	struct scatterlist	*bounce_sg;
 	unsigned int		bounce_sg_len;
 	struct mmc_async_req	areq;
+	int			ioc_result;
+	struct mmc_blk_ioc_data	*idata;
 };
 
 struct mmc_queue {
-- 
2.9.3
