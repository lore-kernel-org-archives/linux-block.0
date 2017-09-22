Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:56322 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbdIVMnz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 08:43:55 -0400
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
Subject: [PATCH V9 01/15] mmc: core: Remove unnecessary host claim
Date: Fri, 22 Sep 2017 15:36:50 +0300
Message-Id: <1506083824-4024-2-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Callers already have the host claimed, so remove the unnecessary
calls to mmc_claim_host() and mmc_release_host().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_ops.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 54686ca4bfb7..a6b0a232f24a 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -977,7 +977,6 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	    from_exception)
 		return;
 
-	mmc_claim_host(card->host);
 	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
 		timeout = MMC_OPS_TIMEOUT_MS;
 		use_busy_signal = true;
@@ -995,7 +994,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
 		mmc_retune_release(card->host);
-		goto out;
+		return;
 	}
 
 	/*
@@ -1007,8 +1006,6 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 		mmc_card_set_doing_bkops(card);
 	else
 		mmc_retune_release(card->host);
-out:
-	mmc_release_host(card->host);
 }
 
 /*
-- 
1.9.1
