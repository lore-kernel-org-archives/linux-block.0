Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40477 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754082AbdK2Nmg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Nov 2017 08:42:36 -0500
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
Subject: [PATCH V15 11/22] mmc: block: blk-mq: Separate card polling from recovery
Date: Wed, 29 Nov 2017 15:41:08 +0200
Message-Id: <1511962879-24262-12-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Recovery is simpler to understand if it is only used for errors. Create a
separate function for card polling.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a710a6e95307..6d2c42c1c33a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2139,6 +2139,26 @@ static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
 	       brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
 }
 
+static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	bool gen_err = false;
+	int err;
+
+	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
+		return 0;
+
+	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req, &gen_err);
+
+	/* Copy the general error bit so it will be seen later on */
+	if (gen_err) {
+		mqrq->brq.stop.resp[0] |= R1_ERROR;
+		err = err ? err : -EIO;
+	}
+
+	return err;
+}
+
 static inline void mmc_blk_rw_reset_success(struct mmc_queue *mq,
 					    struct request *req)
 {
@@ -2197,8 +2217,15 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 				       struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_host *host = mq->card->host;
 
-	mmc_blk_mq_rw_recovery(mq, req);
+	if (mmc_blk_rq_error(&mqrq->brq) ||
+	    mmc_blk_card_busy(mq->card, req)) {
+		mmc_blk_mq_rw_recovery(mq, req);
+	} else {
+		mmc_blk_rw_reset_success(mq, req);
+		mmc_retune_release(host);
+	}
 
 	mmc_blk_urgent_bkops(mq, mqrq);
 }
-- 
1.9.1
