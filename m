Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29880 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752454AbdIMLrr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2017 07:47:47 -0400
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
Subject: [PATCH V8 10/14] mmc: core: Export mmc_start_bkops()
Date: Wed, 13 Sep 2017 14:40:10 +0300
Message-Id: <1505302814-19313-11-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Export mmc_start_bkops() so that the block driver can use it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index a6b0a232f24a..908e4db03535 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1007,6 +1007,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	else
 		mmc_retune_release(card->host);
 }
+EXPORT_SYMBOL(mmc_start_bkops);
 
 /*
  * Flush the cache to the non-volatile storage.
-- 
1.9.1
