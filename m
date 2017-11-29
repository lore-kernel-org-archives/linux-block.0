Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39581 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754931AbdK2NnX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Nov 2017 08:43:23 -0500
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
Subject: [PATCH V15 20/22] mmc: core: Remove option not to use blk-mq
Date: Wed, 29 Nov 2017 15:41:17 +0200
Message-Id: <1511962879-24262-21-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
References: <1511962879-24262-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove config option MMC_MQ_DEFAULT and parameter mmc_use_blk_mq, so that
blk-mq must be used always.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/Kconfig     | 10 ----------
 drivers/mmc/core/core.c |  7 -------
 drivers/mmc/core/core.h |  2 --
 drivers/mmc/core/host.c |  2 --
 drivers/mmc/core/host.h |  2 +-
 5 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 42565562577c..ec21388311db 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -12,16 +12,6 @@ menuconfig MMC
 	  If you want MMC/SD/SDIO support, you should say Y here and
 	  also to your specific host controller driver.
 
-config MMC_MQ_DEFAULT
-	bool "MMC: use blk-mq I/O path by default"
-	depends on MMC && BLOCK
-	default y
-	---help---
-	  This option enables the new blk-mq based I/O path for MMC block
-	  devices by default.  With the option the mmc_core.use_blk_mq
-	  module/boot option defaults to Y, without it to N, but it can
-	  still be overridden either way.
-
 if MMC
 
 source "drivers/mmc/core/Kconfig"
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 617802f45386..7ca6e4866a8b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -66,13 +66,6 @@
 bool use_spi_crc = 1;
 module_param(use_spi_crc, bool, 0);
 
-#ifdef CONFIG_MMC_MQ_DEFAULT
-bool mmc_use_blk_mq = true;
-#else
-bool mmc_use_blk_mq = false;
-#endif
-module_param_named(use_blk_mq, mmc_use_blk_mq, bool, S_IWUSR | S_IRUGO);
-
 static int mmc_schedule_delayed_work(struct delayed_work *work,
 				     unsigned long delay)
 {
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 136617d2f971..3e3d21304e5f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -35,8 +35,6 @@ struct mmc_bus_ops {
 	int (*reset)(struct mmc_host *);
 };
 
-extern bool mmc_use_blk_mq;
-
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
 void mmc_detach_bus(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 409a68a96a0a..64b03d6eaf18 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -404,8 +404,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	host->fixed_drv_type = -EINVAL;
 
-	host->use_blk_mq = mmc_use_blk_mq;
-
 	return host;
 }
 
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 8ca284e079e3..6d896869e5c6 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -81,7 +81,7 @@ static inline bool mmc_card_hs400es(struct mmc_card *card)
 
 static inline bool mmc_host_use_blk_mq(struct mmc_host *host)
 {
-	return host->use_blk_mq;
+	return true;
 }
 
 #endif
-- 
1.9.1
