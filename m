Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11293 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757922AbdJMLTR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 07:19:17 -0400
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
Subject: [PATCH V11 1/4] mmc: core: Add parameter use_blk_mq
Date: Fri, 13 Oct 2017 14:12:16 +0300
Message-Id: <1507893139-11969-2-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1507893139-11969-1-git-send-email-adrian.hunter@intel.com>
References: <1507893139-11969-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Until mmc has blk-mq support fully implemented and tested, add a
parameter use_blk_mq, default to false unless config option MMC_MQ_DEFAULT
is selected.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/Kconfig      | 11 +++++++++++
 drivers/mmc/core/core.c  |  7 +++++++
 drivers/mmc/core/core.h  |  2 ++
 drivers/mmc/core/host.c  |  2 ++
 drivers/mmc/core/host.h  |  4 ++++
 include/linux/mmc/host.h |  1 +
 6 files changed, 27 insertions(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index ec21388311db..98202934bd29 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -12,6 +12,17 @@ menuconfig MMC
 	  If you want MMC/SD/SDIO support, you should say Y here and
 	  also to your specific host controller driver.
 
+config MMC_MQ_DEFAULT
+	bool "MMC: use blk-mq I/O path by default"
+	depends on MMC && BLOCK
+	---help---
+	  This option enables the new blk-mq based I/O path for MMC block
+	  devices by default.  With the option the mmc_core.use_blk_mq
+	  module/boot option defaults to Y, without it to N, but it can
+	  still be overridden either way.
+
+	  If unsure say N.
+
 if MMC
 
 source "drivers/mmc/core/Kconfig"
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 12b271c2a912..c287d297710a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -66,6 +66,13 @@
 bool use_spi_crc = 1;
 module_param(use_spi_crc, bool, 0);
 
+#ifdef CONFIG_MMC_MQ_DEFAULT
+bool mmc_use_blk_mq = true;
+#else
+bool mmc_use_blk_mq = false;
+#endif
+module_param_named(use_blk_mq, mmc_use_blk_mq, bool, S_IWUSR | S_IRUGO);
+
 static int mmc_schedule_delayed_work(struct delayed_work *work,
 				     unsigned long delay)
 {
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 71e6c6d7ceb7..8c5dd8d31400 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -35,6 +35,8 @@ struct mmc_bus_ops {
 	int (*reset)(struct mmc_host *);
 };
 
+extern bool mmc_use_blk_mq;
+
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
 void mmc_detach_bus(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e58be39b1568..1539ce0da196 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -393,6 +393,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->max_blk_size = 512;
 	host->max_blk_count = PAGE_SIZE / 512;
 
+	host->use_blk_mq = mmc_use_blk_mq;
+
 	return host;
 }
 
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index fb689a1065ed..6eaf558e62d6 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -74,6 +74,10 @@ static inline bool mmc_card_hs400es(struct mmc_card *card)
 	return card->host->ios.enhanced_strobe;
 }
 
+static inline bool mmc_host_use_blk_mq(struct mmc_host *host)
+{
+	return host->use_blk_mq;
+}
 
 #endif
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c296f4351c1d..9109265fe529 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -378,6 +378,7 @@ struct mmc_host {
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
+	unsigned int		use_blk_mq:1;	/* use blk-mq */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
1.9.1
