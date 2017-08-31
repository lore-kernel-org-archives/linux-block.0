Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdHaMDv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 08:03:51 -0400
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
Subject: [PATCH V7 04/10] mmc: mmc: Enable CQE's
Date: Thu, 31 Aug 2017 14:56:50 +0300
Message-Id: <1504180616-14514-5-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Enable or disable CQE when a card is added or removed respectively.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/bus.c |  7 +++++++
 drivers/mmc/core/mmc.c | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 301246513a37..a4b49e25fe96 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -369,10 +369,17 @@ int mmc_add_card(struct mmc_card *card)
  */
 void mmc_remove_card(struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
+
 #ifdef CONFIG_DEBUG_FS
 	mmc_remove_card_debugfs(card);
 #endif
 
+	if (host->cqe_enabled) {
+		host->cqe_ops->cqe_disable(host);
+		host->cqe_enabled = false;
+	}
+
 	if (mmc_card_present(card)) {
 		if (mmc_host_is_spi(card->host)) {
 			pr_info("%s: SPI card removed\n",
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 194cf2082e73..0dcbd25126a1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1807,6 +1807,18 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	card->reenable_cmdq = card->ext_csd.cmdq_en;
 
+	if (card->ext_csd.cmdq_en && !host->cqe_enabled) {
+		err = host->cqe_ops->cqe_enable(host, card);
+		if (err) {
+			pr_err("%s: Failed to enable CQE, error %d\n",
+				mmc_hostname(host), err);
+		} else {
+			host->cqe_enabled = true;
+			pr_info("%s: Command Queue Engine enabled\n",
+				mmc_hostname(host));
+		}
+	}
+
 	if (!oldcard)
 		host->card = card;
 
-- 
1.9.1
