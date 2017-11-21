Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13823 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbdKUNnr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 08:43:47 -0500
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
Subject: [PATCH V14 07/24] mmc: block: Use data timeout in card_busy_detect()
Date: Tue, 21 Nov 2017 15:42:33 +0200
Message-Id: <1511271770-3444-8-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

card_busy_detect() has a 10 minute timeout. However the correct timeout is
the data timeout. Change card_busy_detect() to use the data timeout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e44f6d90aeb4..0874ab3e5c92 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -63,7 +63,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "mmcblk."
 
-#define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
 #define MMC_SANITIZE_REQ_TIMEOUT 240000
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
 
@@ -921,14 +920,48 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	return 0;
 }
 
-static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-		bool hw_busy_detect, struct request *req, bool *gen_err)
+static unsigned int mmc_blk_clock_khz(struct mmc_host *host)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	if (host->actual_clock)
+		return host->actual_clock / 1000;
+
+	/* Clock may be subject to a divisor, fudge it by a factor of 2. */
+	if (host->ios.clock)
+		return host->ios.clock / 2000;
+
+	/* How can there be no clock */
+	WARN_ON_ONCE(1);
+	return 100; /* 100 kHz is minimum possible value */
+}
+
+static unsigned long mmc_blk_data_timeout_jiffies(struct mmc_host *host,
+						  struct mmc_data *data)
+{
+	unsigned int ms = DIV_ROUND_UP(data->timeout_ns, 1000000);
+	unsigned int khz;
+
+	if (data->timeout_clks) {
+		khz = mmc_blk_clock_khz(host);
+		ms += DIV_ROUND_UP(data->timeout_clks, khz);
+	}
+
+	return msecs_to_jiffies(ms);
+}
+
+static int card_busy_detect(struct mmc_card *card, bool hw_busy_detect,
+			    struct request *req, bool *gen_err)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_data *data = &mqrq->brq.data;
+	unsigned long timeout;
 	int err = 0;
 	u32 status;
 
+	timeout = jiffies + mmc_blk_data_timeout_jiffies(card->host, data);
+
 	do {
+		bool done = time_after(jiffies, timeout);
+
 		err = __mmc_send_status(card, &status, 5);
 		if (err) {
 			pr_err("%s: error %d requesting status\n",
@@ -951,7 +984,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 		 * Timeout if the device never becomes ready for data and never
 		 * leaves the program state.
 		 */
-		if (time_after(jiffies, timeout)) {
+		if (done) {
 			pr_err("%s: Card stuck in programming state! %s %s\n",
 				mmc_hostname(card->host),
 				req->rq_disk->disk_name, __func__);
@@ -1011,7 +1044,7 @@ static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
 		*gen_err = true;
 	}
 
-	return card_busy_detect(card, timeout_ms, use_r1b_resp, req, gen_err);
+	return card_busy_detect(card, use_r1b_resp, req, gen_err);
 }
 
 #define ERR_NOMEDIUM	3
@@ -1546,8 +1579,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 			gen_err = true;
 		}
 
-		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
-					&gen_err);
+		err = card_busy_detect(card, false, req, &gen_err);
 		if (err)
 			return MMC_BLK_CMD_ERR;
 	}
-- 
1.9.1
