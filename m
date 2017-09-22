Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36143 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752564AbdIVMoz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 08:44:55 -0400
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
Subject: [PATCH V9 12/15] mmc: core: Export mmc_retune_hold_now() and mmc_retune_release()
Date: Fri, 22 Sep 2017 15:37:01 +0300
Message-Id: <1506083824-4024-13-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Export mmc_retune_hold_now() and mmc_retune_release() so they can be used
by the block driver.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/host.c | 7 +------
 drivers/mmc/core/host.h | 7 ++++++-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b624dbb6cd15..1539ce0da196 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -111,12 +111,6 @@ void mmc_retune_hold(struct mmc_host *host)
 	host->hold_retune += 1;
 }
 
-void mmc_retune_hold_now(struct mmc_host *host)
-{
-	host->retune_now = 0;
-	host->hold_retune += 1;
-}
-
 void mmc_retune_release(struct mmc_host *host)
 {
 	if (host->hold_retune)
@@ -124,6 +118,7 @@ void mmc_retune_release(struct mmc_host *host)
 	else
 		WARN_ON(1);
 }
+EXPORT_SYMBOL(mmc_retune_release);
 
 int mmc_retune(struct mmc_host *host)
 {
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 170fe5947087..6eaf558e62d6 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -19,12 +19,17 @@
 void mmc_retune_enable(struct mmc_host *host);
 void mmc_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
-void mmc_retune_hold_now(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 void mmc_retune_pause(struct mmc_host *host);
 void mmc_retune_unpause(struct mmc_host *host);
 
+static inline void mmc_retune_hold_now(struct mmc_host *host)
+{
+	host->retune_now = 0;
+	host->hold_retune += 1;
+}
+
 static inline void mmc_retune_recheck(struct mmc_host *host)
 {
 	if (host->hold_retune <= 1)
-- 
1.9.1
