Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755018AbdHYMur (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 08:50:47 -0400
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
Subject: [PATCH V6 04/12] mmc: core: Turn off CQE before sending commands
Date: Fri, 25 Aug 2017 15:43:47 +0300
Message-Id: <1503665035-16231-5-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CQE needs to be off for the host controller to accept non-CQ commands. Turn
off the CQE before sending commands, and ensure it is off in any reset or
power management paths, or re-tuning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5dd1c00d95f5..66c9cf49ad2f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -260,6 +260,9 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	trace_mmc_request_start(host, mrq);
 
+	if (host->cqe_on)
+		host->cqe_ops->cqe_off(host);
+
 	host->ops->request(host, mrq);
 }
 
@@ -979,6 +982,9 @@ int mmc_execute_tuning(struct mmc_card *card)
 	if (!host->ops->execute_tuning)
 		return 0;
 
+	if (host->cqe_on)
+		host->cqe_ops->cqe_off(host);
+
 	if (mmc_card_mmc(card))
 		opcode = MMC_SEND_TUNING_BLOCK_HS200;
 	else
@@ -1018,6 +1024,9 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
  */
 void mmc_set_initial_state(struct mmc_host *host)
 {
+	if (host->cqe_on)
+		host->cqe_ops->cqe_off(host);
+
 	mmc_retune_disable(host);
 
 	if (mmc_host_is_spi(host))
-- 
1.9.1
