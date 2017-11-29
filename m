Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:42160 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932091AbdK2Nlr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Nov 2017 08:41:47 -0500
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
Subject: [PATCH V15 01/22] mmc: block: No need to export mmc_cleanup_queue()
Date: Wed, 29 Nov 2017 15:40:58 +0200
Message-Id: <1511962879-24262-2-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

mmc_cleanup_queue() is not used by a different module. Do not export it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4f33d277b125..26f8da30ebe5 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -270,7 +270,6 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 
 	mq->card = NULL;
 }
-EXPORT_SYMBOL(mmc_cleanup_queue);
 
 /**
  * mmc_queue_suspend - suspend a MMC request queue
-- 
1.9.1
