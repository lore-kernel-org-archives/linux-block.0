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
Subject: [PATCH 6/6] mmc: debugfs: Move EXT CSD debugfs acces to block layer
Date: Fri, 19 May 2017 15:37:32 +0200
Message-Id: <20170519133732.27470-7-linus.walleij@linaro.org>
In-Reply-To: <20170519133732.27470-1-linus.walleij@linaro.org>
References: <20170519133732.27470-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Just like the previous commit moving status retriveal for
MMC and SD cards into the block layer (when active), this
moves the retrieveal of the EXT CSD from the card from
the special ext_csd file into the block stack as well.

Again special care is taken to make the debugfs work even
with the block layer disabled. Again this solves a
starvation issue during heavy block workloads.

It has been tested with and without the block layer and
during heavy load from dd.

Since we can't keep adding weirdo data pointers into
struct mmc_queue_req this converts the
struct mmc_blk_ioc_data **idata pointer to a simple
void *drv_op_data that gets casted into whatever data
the driver-specific command needs to pass, and then I
cast it to the right target type in the sending and
receiving functions.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c   | 30 +++++++++++++++++++++++++++---
 drivers/mmc/core/block.h   | 12 ++++++++++++
 drivers/mmc/core/debugfs.c |  4 +---
 drivers/mmc/core/queue.h   |  4 +++-
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8858798d1349..5be7f06d4ecd 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -599,7 +599,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		__GFP_RECLAIM);
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
-	req_to_mmc_queue_req(req)->idata = idatas;
+	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
@@ -675,7 +675,7 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 		idata[0]->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 		__GFP_RECLAIM);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
-	req_to_mmc_queue_req(req)->idata = idata;
+	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
@@ -1191,6 +1191,8 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mq_rq;
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_blk_ioc_data	**idata;
+	u8 **ext_csd;
 	u32 status;
 	int ret;
 	int i;
@@ -1199,8 +1201,9 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 
 	switch (mq_rq->drv_op) {
 	case MMC_DRV_OP_IOCTL:
+		idata = mq_rq->drv_op_data;
 		for (i = 0; i < mq_rq->ioc_count; i++) {
-			ret = __mmc_blk_ioctl_cmd(card, md, mq_rq->idata[i]);
+			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
 			if (ret)
 				break;
 		}
@@ -1225,6 +1228,10 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		if (!ret)
 			ret = status;
 		break;
+	case MMC_DRV_OP_GET_EXT_CSD:
+		ext_csd = mq_rq->drv_op_data;
+		ret = mmc_get_ext_csd(card, ext_csd);
+		break;
 	default:
 		pr_err("%s: unknown driver specific operation\n",
 		       md->disk->disk_name);
@@ -1996,6 +2003,23 @@ int mmc_blk_card_status_get(struct mmc_card *card, u64 *val)
 }
 EXPORT_SYMBOL(mmc_blk_card_status_get);
 
+
+/* Called from debugfs for MMC cards */
+int mmc_blk_get_ext_csd(struct mmc_card *card, u8 **ext_csd)
+{
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+	struct mmc_queue *mq = &md->queue;
+	struct request *req;
+
+	/* Ask the block layer about the EXT CSD */
+	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
+	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_data = ext_csd;
+	blk_execute_rq(mq->queue, NULL, req, 0);
+	return req_to_mmc_queue_req(req)->drv_op_result;
+}
+EXPORT_SYMBOL(mmc_blk_get_ext_csd);
+
 static inline int mmc_blk_readonly(struct mmc_card *card)
 {
 	return mmc_card_readonly(card) ||
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 1e26755a864b..c85c3b71dcad 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -12,6 +12,7 @@ struct request;
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
 int mmc_blk_card_status_get(struct mmc_card *card, u64 *val);
+int mmc_blk_get_ext_csd(struct mmc_card *card, u8 **ext_csd);
 
 #else
 
@@ -41,6 +42,17 @@ static inline int mmc_blk_card_status_get(struct mmc_card *card, u64 *val)
 	return ret;
 }
 
+static inline int mmc_blk_get_ext_csd(struct mmc_card *card, u8 **ext_csd)
+{
+	int ret;
+
+	mmc_get_card(card);
+	ret = mmc_get_ext_csd(card, ext_csd);
+	mmc_put_card(card);
+
+	return ret;
+}
+
 #endif /* IS_ENABLED(CONFIG_MMC_BLOCK) */
 
 #endif
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index ce5b921c7d96..85e058120e3b 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -303,9 +303,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	if (!buf)
 		return -ENOMEM;
 
-	mmc_get_card(card);
-	err = mmc_get_ext_csd(card, &ext_csd);
-	mmc_put_card(card);
+	err = mmc_blk_get_ext_csd(card, &ext_csd);
 	if (err)
 		goto out_free;
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 2b39717453a5..2f67856661da 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -37,11 +37,13 @@ struct mmc_blk_request {
  * @MMC_DRV_OP_IOCTL: ioctl operation
  * @MMC_DRV_OP_BOOT_WP: write protect boot partitions
  * @MMC_DRV_OP_GET_CARD_STATUS: get card status
+ * @MMC_DRV_OP_GET_EXT_CSD: get extended card descriptor
  */
 enum mmc_drv_op {
 	MMC_DRV_OP_IOCTL,
 	MMC_DRV_OP_BOOT_WP,
 	MMC_DRV_OP_GET_CARD_STATUS,
+	MMC_DRV_OP_GET_EXT_CSD,
 };
 
 struct mmc_queue_req {
@@ -53,7 +55,7 @@ struct mmc_queue_req {
 	struct mmc_async_req	areq;
 	enum mmc_drv_op		drv_op;
 	int			drv_op_result;
-	struct mmc_blk_ioc_data	**idata;
+	void			*drv_op_data;
 	unsigned int		ioc_count;
 };
 
-- 
2.9.3
