Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755018AbdHYMvJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 08:51:09 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH V6 09/12] mmc: block: Prepare CQE data
Date: Fri, 25 Aug 2017 15:43:52 +0300
Message-Id: <1503665035-16231-10-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Enhance mmc_blk_data_prep() to support CQE requests. That means adding
some things that for non-CQE requests would be encoded into the command
arguments - such as the block address, reliable-write flag, and data tag
flag. Also the request tag is needed to provide the command queue task id,
and a comment is added to explain the future possibility of defining a
priority.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index cc950cb1cfd7..f9ead0701e8d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1554,6 +1554,7 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 
 	brq->mrq.data = &brq->data;
+	brq->mrq.tag = req->tag;
 
 	brq->stop.opcode = MMC_STOP_TRANSMISSION;
 	brq->stop.arg = 0;
@@ -1568,6 +1569,14 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 
 	brq->data.blksz = 512;
 	brq->data.blocks = blk_rq_sectors(req);
+	brq->data.blk_addr = blk_rq_pos(req);
+
+	/*
+	 * The command queue supports 2 priorities: "high" (1) and "simple" (0).
+	 * The eMMC will give "high" priority tasks priority over "simple"
+	 * priority tasks. Here we always set "simple" priority by not setting
+	 * MMC_DATA_PRIO.
+	 */
 
 	/*
 	 * The block layer doesn't support all sector count
@@ -1597,8 +1606,10 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 						brq->data.blocks);
 	}
 
-	if (do_rel_wr)
+	if (do_rel_wr) {
 		mmc_apply_rel_rw(brq, card, req);
+		brq->data.flags |= MMC_DATA_REL_WR;
+	}
 
 	/*
 	 * Data tag is used only during writing meta data to speed
@@ -1610,6 +1621,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		      ((brq->data.blocks * brq->data.blksz) >=
 		       card->ext_csd.data_tag_unit_size);
 
+	if (do_data_tag)
+		brq->data.flags |= MMC_DATA_DAT_TAG;
+
 	mmc_set_data_timeout(&brq->data, card);
 
 	brq->data.sg = mqrq->sg;
-- 
1.9.1
