Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13823 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdKUNnR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 08:43:17 -0500
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
Subject: [PATCH V14 01/24] mmc: block: Fix missing blk_put_request()
Date: Tue, 21 Nov 2017 15:42:27 +0200
Message-Id: <1511271770-3444-2-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ensure blk_get_request() is paired with blk_put_request().

Fixes: 0493f6fe5bde ("mmc: block: Move boot partition locking into a driver op")
Fixes: 627c3ccfb46a ("mmc: debugfs: Move block debugfs into block module")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ea80ff4cd7f9..f60939858586 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -236,6 +236,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
+	blk_put_request(req);
 
 	if (!ret) {
 		pr_info("%s: Locking boot partition ro until next power on\n",
@@ -2557,6 +2558,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 		*val = ret;
 		ret = 0;
 	}
+	blk_put_request(req);
 
 	return ret;
 }
@@ -2587,6 +2589,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	err = req_to_mmc_queue_req(req)->drv_op_result;
+	blk_put_request(req);
 	if (err) {
 		pr_err("FAILED %d\n", err);
 		goto out_free;
-- 
1.9.1
