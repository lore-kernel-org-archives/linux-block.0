Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65339 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752454AbdKUNot (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 08:44:49 -0500
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
Subject: [PATCH V14 19/24] mmc: block: blk-mq: Check error bits and save the exception bit when polling card busy
Date: Tue, 21 Nov 2017 15:42:45 +0200
Message-Id: <1511271770-3444-20-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Check error bits and save the exception bit when polling card busy.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7eb55f2dffa9..ac976c84571f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1495,15 +1495,18 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	}
 }
 
-#define CMD_ERRORS							\
-	(R1_OUT_OF_RANGE |	/* Command argument out of range */	\
-	 R1_ADDRESS_ERROR |	/* Misaligned address */		\
+#define CMD_ERRORS_EXCL_OOR						\
+	(R1_ADDRESS_ERROR |	/* Misaligned address */		\
 	 R1_BLOCK_LEN_ERROR |	/* Transferred block length incorrect */\
 	 R1_WP_VIOLATION |	/* Tried to write to protected block */	\
 	 R1_CARD_ECC_FAILED |	/* Card ECC failed */			\
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
 
+#define CMD_ERRORS							\
+	(CMD_ERRORS_EXCL_OOR |						\
+	 R1_OUT_OF_RANGE)	/* Command argument out of range */	\
+
 static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
 {
 	u32 val;
@@ -2162,20 +2165,39 @@ static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
 	       brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
 }
 
+static inline bool mmc_blk_oor_valid(struct mmc_blk_request *brq)
+{
+	return !!brq->mrq.sbc;
+}
+
+static inline u32 mmc_blk_stop_err_bits(struct mmc_blk_request *brq)
+{
+	return mmc_blk_oor_valid(brq) ? CMD_ERRORS : CMD_ERRORS_EXCL_OOR;
+}
+
 static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
-	bool gen_err = false;
+	u32 status = 0;
 	int err;
 
 	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
 		return 0;
 
-	err = card_busy_detect_err(card, true, req, &gen_err);
+	err = card_busy_detect(card, true, req, &status);
+
+	/*
+	 * Do not assume data transferred correctly if there are any error bits
+	 * set.
+	 */
+	if (!err && status & mmc_blk_stop_err_bits(&mqrq->brq)) {
+		mqrq->brq.data.bytes_xfered = 0;
+		err = -EIO;
+	}
 
-	/* Copy the general error bit so it will be seen later on */
-	if (gen_err)
-		mqrq->brq.stop.resp[0] |= R1_ERROR;
+	/* Copy the exception bit so it will be seen later on */
+	if (mmc_card_mmc(card) && status & R1_EXCEPTION_EVENT)
+		mqrq->brq.cmd.resp[0] |= R1_EXCEPTION_EVENT;
 
 	return err;
 }
-- 
1.9.1
