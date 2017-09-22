Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36798 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbdIVMoM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 08:44:12 -0400
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V9 04/15] mmc: mmc: Enable Command Queuing
Date: Fri, 22 Sep 2017 15:36:53 +0300
Message-Id: <1506083824-4024-5-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Enable the Command Queue if the host controller supports a command queue
engine. It is not compatible with Packed Commands, so make a note of that in the
comment.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3927157207b9..454a5079a90f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1784,6 +1784,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * Enable Command Queue if supported. Note that Packed Commands cannot
+	 * be used with Command Queue.
+	 */
+	card->ext_csd.cmdq_en = false;
+	if (card->ext_csd.cmdq_support && host->caps2 & MMC_CAP2_CQE) {
+		err = mmc_cmdq_enable(card);
+		if (err && err != -EBADMSG)
+			goto free_card;
+		if (err) {
+			pr_warn("%s: Enabling CMDQ failed\n",
+				mmc_hostname(card->host));
+			card->ext_csd.cmdq_support = false;
+			card->ext_csd.cmdq_depth = 0;
+			err = 0;
+		}
+	}
+	/*
 	 * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
 	 * disabled for a time, so a flag is needed to indicate to re-enable the
 	 * Command Queue.
-- 
1.9.1
