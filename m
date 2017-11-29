Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39581 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754203AbdK2NnD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Nov 2017 08:43:03 -0500
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
Subject: [PATCH V15 16/22] mmc: block: Add timeout_clks when calculating timeout
Date: Wed, 29 Nov 2017 15:41:13 +0200
Message-Id: <1511962879-24262-17-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

According to the specification, total access time is derived from both TAAC
and NSAC, which means the timeout should add both timeout_ns and
timeout_clks. Host drivers do that, so make the block driver do that too.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0b40fc2ebf77..46e63aec1fcb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -922,6 +922,34 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	return 0;
 }
 
+static unsigned int mmc_blk_clock_khz(struct mmc_host *host)
+{
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
+static unsigned int mmc_blk_data_timeout_ms(struct mmc_host *host,
+					    struct mmc_data *data)
+{
+	unsigned int ms = DIV_ROUND_UP(data->timeout_ns, 1000000);
+	unsigned int khz;
+
+	if (data->timeout_clks) {
+		khz = mmc_blk_clock_khz(host);
+		ms += DIV_ROUND_UP(data->timeout_clks, khz);
+	}
+
+	return ms;
+}
+
 static inline bool mmc_blk_in_tran_state(u32 status)
 {
 	/*
@@ -1169,9 +1197,10 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	 */
 	if (R1_CURRENT_STATE(status) == R1_STATE_DATA ||
 	    R1_CURRENT_STATE(status) == R1_STATE_RCV) {
-		err = send_stop(card,
-			DIV_ROUND_UP(brq->data.timeout_ns, 1000000),
-			req, gen_err, &stop_status);
+		unsigned int timeout;
+
+		timeout = mmc_blk_data_timeout_ms(card->host, &brq->data);
+		err = send_stop(card, timeout, req, gen_err, &stop_status);
 		if (err) {
 			pr_err("%s: error %d sending stop command\n",
 			       req->rq_disk->disk_name, err);
@@ -1977,6 +2006,7 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 	struct mmc_host *host = card->host;
 	blk_status_t error = BLK_STS_OK;
 	int retries = 0;
+	unsigned int timeout = mmc_blk_data_timeout_ms(host, mrq->data);
 
 	do {
 		u32 status;
@@ -1995,10 +2025,8 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 			u32 stop_status = 0;
 			bool gen_err = false;
 
-			err = send_stop(card,
-					DIV_ROUND_UP(mrq->data->timeout_ns,
-						     1000000),
-					req, &gen_err, &stop_status);
+			err = send_stop(card, timeout, req, &gen_err,
+					&stop_status);
 			if (err)
 				goto error_exit;
 		}
-- 
1.9.1
