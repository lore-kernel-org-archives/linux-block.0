Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13823 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751944AbdKUNn5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 08:43:57 -0500
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
Subject: [PATCH V14 09/24] mmc: block: Make card_busy_detect() accumulate all response error bits
Date: Tue, 21 Nov 2017 15:42:35 +0200
Message-Id: <1511271770-3444-10-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make card_busy_detect() accumulate all response error bits. Later patches
will make use of this.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 130ce94fdaf2..607774fcb9f5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -959,7 +959,7 @@ static inline bool mmc_blk_in_tran_state(u32 status)
 }
 
 static int card_busy_detect(struct mmc_card *card, bool hw_busy_detect,
-			    struct request *req, bool *gen_err)
+			    struct request *req, u32 *resp_errs)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_data *data = &mqrq->brq.data;
@@ -979,11 +979,9 @@ static int card_busy_detect(struct mmc_card *card, bool hw_busy_detect,
 			return err;
 		}
 
-		if (status & R1_ERROR) {
-			pr_err("%s: %s: error sending status cmd, status %#x\n",
-				req->rq_disk->disk_name, __func__, status);
-			*gen_err = true;
-		}
+		/* Accumulate any response error bits seen */
+		if (resp_errs)
+			*resp_errs |= status;
 
 		/* We may rely on the host hw to handle busy detection.*/
 		if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
@@ -1011,6 +1009,22 @@ static int card_busy_detect(struct mmc_card *card, bool hw_busy_detect,
 	return err;
 }
 
+static int card_busy_detect_err(struct mmc_card *card, bool hw_busy_detect,
+				struct request *req, bool *gen_err)
+{
+	u32 resp_errs = 0;
+	int err;
+
+	err = card_busy_detect(card, hw_busy_detect, req, &resp_errs);
+	if (resp_errs & R1_ERROR) {
+		pr_err("%s: %s: error sending status cmd, status %#x\n",
+		       req->rq_disk->disk_name, __func__, resp_errs);
+		*gen_err = true;
+	}
+
+	return err;
+}
+
 static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
 		struct request *req, bool *gen_err, u32 *stop_status)
 {
@@ -1053,7 +1067,7 @@ static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
 		*gen_err = true;
 	}
 
-	return card_busy_detect(card, use_r1b_resp, req, gen_err);
+	return card_busy_detect_err(card, use_r1b_resp, req, gen_err);
 }
 
 #define ERR_NOMEDIUM	3
@@ -1588,7 +1602,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 			gen_err = true;
 		}
 
-		err = card_busy_detect(card, false, req, &gen_err);
+		err = card_busy_detect_err(card, false, req, &gen_err);
 		if (err)
 			return MMC_BLK_CMD_ERR;
 	}
-- 
1.9.1
