Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5] mmc: block: Refactor mmc_blk_part_switch()
Date: Thu, 15 Jun 2017 14:12:56 +0200
Message-Id: <20170615121259.8281-3-linus.walleij@linaro.org>
In-Reply-To: <20170615121259.8281-1-linus.walleij@linaro.org>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Instead of passing a struct mmc_blk_data * to mmc_blk_part_switch()
let's pass the actual partition type we want to switch to. This
is necessary in order not to have a block device with a backing
mmc_blk_data and request queue and all for every hardware partition,
such as RPMB.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d1b824e65590..94b97f97be1a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -127,7 +127,7 @@ module_param(perdev_minors, int, 0444);
 MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
 static inline int mmc_blk_part_switch(struct mmc_card *card,
-				      struct mmc_blk_data *md);
+				      unsigned int part_type);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -490,7 +490,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	mrq.cmd = &cmd;
 
-	err = mmc_blk_part_switch(card, md);
+	err = mmc_blk_part_switch(card, md->part_type);
 	if (err)
 		return err;
 
@@ -767,29 +767,29 @@ static int mmc_blk_part_switch_post(struct mmc_card *card,
 }
 
 static inline int mmc_blk_part_switch(struct mmc_card *card,
-				      struct mmc_blk_data *md)
+				      unsigned int part_type)
 {
 	int ret = 0;
 	struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
 
-	if (main_md->part_curr == md->part_type)
+	if (main_md->part_curr == part_type)
 		return 0;
 
 	if (mmc_card_mmc(card)) {
 		u8 part_config = card->ext_csd.part_config;
 
-		ret = mmc_blk_part_switch_pre(card, md->part_type);
+		ret = mmc_blk_part_switch_pre(card, part_type);
 		if (ret)
 			return ret;
 
 		part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
-		part_config |= md->part_type;
+		part_config |= part_type;
 
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_PART_CONFIG, part_config,
 				 card->ext_csd.part_time);
 		if (ret) {
-			mmc_blk_part_switch_post(card, md->part_type);
+			mmc_blk_part_switch_post(card, part_type);
 			return ret;
 		}
 
@@ -798,7 +798,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 		ret = mmc_blk_part_switch_post(card, main_md->part_curr);
 	}
 
-	main_md->part_curr = md->part_type;
+	main_md->part_curr = part_type;
 	return ret;
 }
 
@@ -1141,7 +1141,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 		int part_err;
 
 		main_md->part_curr = main_md->part_type;
-		part_err = mmc_blk_part_switch(host->card, md);
+		part_err = mmc_blk_part_switch(host->card, md->part_type);
 		if (part_err) {
 			/*
 			 * We have failed to get back into the correct
@@ -1180,6 +1180,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mq_rq;
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
 	struct mmc_blk_ioc_data **idata;
 	u8 **ext_csd;
 	u32 status;
@@ -1198,7 +1199,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		}
 		/* Always switch back to main area after RPMB access */
 		if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
-			mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
+			mmc_blk_part_switch(card, main_md->part_type);
 		break;
 	case MMC_DRV_OP_BOOT_WP:
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
@@ -1906,7 +1907,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		/* claim host only for the first request */
 		mmc_get_card(card);
 
-	ret = mmc_blk_part_switch(card, md);
+	ret = mmc_blk_part_switch(card, md->part_type);
 	if (ret) {
 		if (req) {
 			blk_end_request_all(req, -EIO);
@@ -2436,7 +2437,7 @@ static void mmc_blk_remove(struct mmc_card *card)
 	mmc_blk_remove_parts(card, md);
 	pm_runtime_get_sync(&card->dev);
 	mmc_claim_host(card->host);
-	mmc_blk_part_switch(card, md);
+	mmc_blk_part_switch(card, md->part_type);
 	mmc_release_host(card->host);
 	if (card->type != MMC_TYPE_SD_COMBO)
 		pm_runtime_disable(&card->dev);
-- 
2.9.4
