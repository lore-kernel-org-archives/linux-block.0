Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13823 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdKUNnW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 08:43:22 -0500
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V14 02/24] mmc: block: Check return value of blk_get_request()
Date: Tue, 21 Nov 2017 15:42:28 +0200
Message-Id: <1511271770-3444-3-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_get_request() can fail, always check the return value.

Fixes: 0493f6fe5bde ("mmc: block: Move boot partition locking into a driver op")
Fixes: 3ecd8cf23f88 ("mmc: block: move multi-ioctl() to use block layer")
Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
Fixes: 627c3ccfb46a ("mmc: debugfs: Move block debugfs into block module")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f60939858586..4a319ddbd956 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -233,6 +233,10 @@ static ssize_t power_ro_lock_store(struct device *dev,
 
 	/* Dispatch locking to the block layer */
 	req = blk_get_request(mq->queue, REQ_OP_DRV_OUT, __GFP_RECLAIM);
+	if (IS_ERR(req)) {
+		count = PTR_ERR(req);
+		goto out_put;
+	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
@@ -249,7 +253,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 				set_disk_ro(part_md->disk, 1);
 			}
 	}
-
+out_put:
 	mmc_blk_put(md);
 	return count;
 }
@@ -625,6 +629,10 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 	req = blk_get_request(mq->queue,
 		idata->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 		__GFP_RECLAIM);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto cmd_done;
+	}
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
@@ -692,6 +700,10 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 	req = blk_get_request(mq->queue,
 		idata[0]->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 		__GFP_RECLAIM);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto cmd_err;
+	}
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
@@ -2551,6 +2563,8 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 
 	/* Ask the block layer about the card status */
 	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
@@ -2585,6 +2599,10 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 
 	/* Ask the block layer for the EXT CSD */
 	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out_free;
+	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(mq->queue, NULL, req, 0);
-- 
1.9.1
