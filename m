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
Subject: [PATCH 3/5] mmc: block: Reparametrize mmc_blk_ioctl_[multi]_cmd()
Date: Thu, 15 Jun 2017 14:12:57 +0200
Message-Id: <20170615121259.8281-4-linus.walleij@linaro.org>
In-Reply-To: <20170615121259.8281-1-linus.walleij@linaro.org>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Instead of passing a block device to
mmc_blk_ioctl[_multi]_cmd(), let's pass struct mmc_blk_data()
so we operate ioctl()s on the MMC block device representation
rather than the vanilla block device.

This saves a little duplicated code and makes it possible to
issue ioctl()s not targeted for a specific block device but
rather for a specific partition/area.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 94b97f97be1a..b8c71fdb6ed4 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -555,12 +555,11 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	return err;
 }
 
-static int mmc_blk_ioctl_cmd(struct block_device *bdev,
+static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 			     struct mmc_ioc_cmd __user *ic_ptr)
 {
 	struct mmc_blk_ioc_data *idata;
 	struct mmc_blk_ioc_data *idatas[1];
-	struct mmc_blk_data *md;
 	struct mmc_queue *mq;
 	struct mmc_card *card;
 	int err = 0, ioc_err = 0;
@@ -570,12 +569,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	if (IS_ERR(idata))
 		return PTR_ERR(idata);
 
-	md = mmc_blk_get(bdev->bd_disk);
-	if (!md) {
-		err = -EINVAL;
-		goto cmd_err;
-	}
-
 	card = md->queue.card;
 	if (IS_ERR(card)) {
 		err = PTR_ERR(card);
@@ -599,20 +592,17 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	blk_put_request(req);
 
 cmd_done:
-	mmc_blk_put(md);
-cmd_err:
 	kfree(idata->buf);
 	kfree(idata);
 	return ioc_err ? ioc_err : err;
 }
 
-static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
+static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 				   struct mmc_ioc_multi_cmd __user *user)
 {
 	struct mmc_blk_ioc_data **idata = NULL;
 	struct mmc_ioc_cmd __user *cmds = user->cmds;
 	struct mmc_card *card;
-	struct mmc_blk_data *md;
 	struct mmc_queue *mq;
 	int i, err = 0, ioc_err = 0;
 	__u64 num_of_cmds;
@@ -638,16 +628,10 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 		}
 	}
 
-	md = mmc_blk_get(bdev->bd_disk);
-	if (!md) {
-		err = -EINVAL;
-		goto cmd_err;
-	}
-
 	card = md->queue.card;
 	if (IS_ERR(card)) {
 		err = PTR_ERR(card);
-		goto cmd_done;
+		goto cmd_err;
 	}
 
 
@@ -670,8 +654,6 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 
 	blk_put_request(req);
 
-cmd_done:
-	mmc_blk_put(md);
 cmd_err:
 	for (i = 0; i < num_of_cmds; i++) {
 		kfree(idata[i]->buf);
@@ -696,6 +678,7 @@ static int mmc_blk_check_blkdev(struct block_device *bdev)
 static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
+	struct mmc_blk_data *md;
 	int ret;
 
 	switch (cmd) {
@@ -703,14 +686,24 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 		ret = mmc_blk_check_blkdev(bdev);
 		if (ret)
 			return ret;
-		return mmc_blk_ioctl_cmd(bdev,
-				(struct mmc_ioc_cmd __user *)arg);
+		md = mmc_blk_get(bdev->bd_disk);
+		if (!md)
+			return -EINVAL;
+		ret = mmc_blk_ioctl_cmd(md,
+					(struct mmc_ioc_cmd __user *)arg);
+		mmc_blk_put(md);
+		return ret;
 	case MMC_IOC_MULTI_CMD:
 		ret = mmc_blk_check_blkdev(bdev);
 		if (ret)
 			return ret;
-		return mmc_blk_ioctl_multi_cmd(bdev,
-				(struct mmc_ioc_multi_cmd __user *)arg);
+		md = mmc_blk_get(bdev->bd_disk);
+		if (!md)
+			return -EINVAL;
+		ret = mmc_blk_ioctl_multi_cmd(md,
+					(struct mmc_ioc_multi_cmd __user *)arg);
+		mmc_blk_put(md);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.9.4
