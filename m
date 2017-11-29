Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39581 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932321AbdK2Nmy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Nov 2017 08:42:54 -0500
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
Subject: [PATCH V15 14/22] mmc: block: Check the timeout correctly in card_busy_detect()
Date: Wed, 29 Nov 2017 15:41:11 +0200
Message-Id: <1511962879-24262-15-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Pedantically, ensure the status is checked for the last time after the full
timeout has passed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c446d17b48c4..f7c387c27ac0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -931,6 +931,8 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 	u32 status;
 
 	do {
+		bool done = time_after(jiffies, timeout);
+
 		err = __mmc_send_status(card, &status, 5);
 		if (err) {
 			pr_err("%s: error %d requesting status\n",
@@ -951,7 +953,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 		 * Timeout if the device never becomes ready for data and never
 		 * leaves the program state.
 		 */
-		if (time_after(jiffies, timeout)) {
+		if (done) {
 			pr_err("%s: Card stuck in programming state! %s %s\n",
 				mmc_hostname(card->host),
 				req->rq_disk->disk_name, __func__);
-- 
1.9.1
