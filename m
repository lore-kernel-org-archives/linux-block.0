Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5] mmc: core: Delete bounce buffer Kconfig option
Date: Wed, 10 May 2017 10:24:14 +0200
Message-Id: <20170510082418.10513-2-linus.walleij@linaro.org>
In-Reply-To: <20170510082418.10513-1-linus.walleij@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This option is activated by all multiplatform configs and what
not so we almost always have it turned on, and the memory it
saves is negligible, even more so moving forward. The actual
bounce buffer only gets allocated only when used, the only
thing the ifdefs are saving is a little bit of code.

It is highly improper to have this as a Kconfig option that
get turned on by Kconfig, make this a pure runtime-thing and
let the host decide whether we use bounce buffers. We add a
new property "disable_bounce" to the host struct.

Notice that mmc_queue_calc_bouncesz() already disables the
bounce buffers if host->max_segs != 1, so any arch that has a
maximum number of segments higher than 1 will have bounce
buffers disabled.

The option CONFIG_MMC_BLOCK_BOUNCE is default y so the
majority of platforms in the kernel already have it on, and
it then gets turned off at runtime since most of these have
a host->max_segs > 1. The few exceptions that have
host->max_segs == 1 and still turn off the bounce buffering
are those that disable it in their defconfig.

Those are the following:

arch/arm/configs/colibri_pxa300_defconfig
arch/arm/configs/zeus_defconfig
- Uses MMC_PXA, drivers/mmc/host/pxamci.c
- Sets host->max_segs = NR_SG, which is 1
- This needs its bounce buffer deactivated so we set
  host->disable_bounce to true in the host driver

arch/arm/configs/davinci_all_defconfig
- Uses MMC_DAVINCI, drivers/mmc/host/davinci_mmc.c
- This driver sets host->max_segs to MAX_NR_SG, which is 16
- That means this driver anyways disabled bounce buffers
- No special action needed for this platform

arch/arm/configs/lpc32xx_defconfig
arch/arm/configs/nhk8815_defconfig
arch/arm/configs/u300_defconfig
- Uses MMC_ARMMMCI, drivers/mmc/host/mmci.[c|h]
- This driver by default sets host->max_segs to NR_SG,
  which is 128, unless a DMA engine is used, and in that case
  the number of segments are also > 1
- That means this driver already disables bounce buffers
- No special action needed for these platforms

arch/arm/configs/sama5_defconfig
- Uses MMC_SDHCI, MMC_SDHCI_PLTFM, MMC_SDHCI_OF_AT91, MMC_ATMELMCI
- Uses drivers/mmc/host/sdhci.c
- Normally sets host->max_segs to SDHCI_MAX_SEGS which is 128 and
  thus disables bounce buffers
- Sets host->max_segs to 1 if SDHCI_USE_SDMA is set
- SDHCI_USE_SDMA is only set by SDHCI on PCI adapers
- That means that for this platform bounce buffers are already
  disabled at runtime
- No special action needed for this platform

arch/blackfin/configs/CM-BF533_defconfig
arch/blackfin/configs/CM-BF537E_defconfig
- Uses MMC_SPI (a simple MMC card connected on SPI pins)
- Uses drivers/mmc/host/mmc_spi.c
- Sets host->max_segs to MMC_SPI_BLOCKSATONCE which is 128
- That means this platform already disables bounce buffers at
  runtime
- No special action needed for these platforms

arch/mips/configs/cavium_octeon_defconfig
- Uses MMC_CAVIUM_OCTEON, drivers/mmc/host/cavium.c
- Sets host->max_segs to 16 or 1
- Setting host->disable_bounce to be sure for the 1 case

arch/mips/configs/qi_lb60_defconfig
- Uses MMC_JZ4740, drivers/mmc/host/jz4740_mmc.c
- This sets host->max_segs to 128 so bounce buffers are
  already runtime disabled
- No action needed for this platform

It would be interesting to come up with a list of the platforms
that actually end up using bounce buffers. I have not been
able to infer such a list, but it occurs when
host->max_segs == 1 and the bounce buffering is not explicitly
disabled.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/Kconfig  | 18 ------------------
 drivers/mmc/core/queue.c  | 15 +--------------
 drivers/mmc/host/cavium.c |  3 +++
 drivers/mmc/host/pxamci.c |  6 ++++++
 include/linux/mmc/host.h  |  1 +
 5 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index fc1ecdaaa9ca..42e89060cd41 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -61,24 +61,6 @@ config MMC_BLOCK_MINORS
 
 	  If unsure, say 8 here.
 
-config MMC_BLOCK_BOUNCE
-	bool "Use bounce buffer for simple hosts"
-	depends on MMC_BLOCK
-	default y
-	help
-	  SD/MMC is a high latency protocol where it is crucial to
-	  send large requests in order to get high performance. Many
-	  controllers, however, are restricted to continuous memory
-	  (i.e. they can't do scatter-gather), something the kernel
-	  rarely can provide.
-
-	  Say Y here to help these restricted hosts by bouncing
-	  requests back and forth from a large buffer. You will get
-	  a big performance gain at the cost of up to 64 KiB of
-	  physical memory.
-
-	  If unsure, say Y here.
-
 config SDIO_UART
 	tristate "SDIO UART/GPS class support"
 	depends on TTY
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 5c37b6be3e7b..545466342fb1 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -219,7 +219,6 @@ static struct mmc_queue_req *mmc_queue_alloc_mqrqs(int qdepth)
 	return mqrq;
 }
 
-#ifdef CONFIG_MMC_BLOCK_BOUNCE
 static int mmc_queue_alloc_bounce_bufs(struct mmc_queue_req *mqrq, int qdepth,
 				       unsigned int bouncesz)
 {
@@ -258,7 +257,7 @@ static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
 {
 	unsigned int bouncesz = MMC_QUEUE_BOUNCESZ;
 
-	if (host->max_segs != 1)
+	if (host->max_segs != 1 || host->disable_bounce)
 		return 0;
 
 	if (bouncesz > host->max_req_size)
@@ -273,18 +272,6 @@ static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
 
 	return bouncesz;
 }
-#else
-static inline bool mmc_queue_alloc_bounce(struct mmc_queue_req *mqrq,
-					  int qdepth, unsigned int bouncesz)
-{
-	return false;
-}
-
-static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
-{
-	return 0;
-}
-#endif
 
 static int mmc_queue_alloc_sgs(struct mmc_queue_req *mqrq, int qdepth,
 			       int max_segs)
diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 58b51ba6aabd..66066f73e477 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -1050,6 +1050,9 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	else
 		mmc->max_segs = 1;
 
+	/* Disable bounce buffers for max_segs = 1 */
+	mmc->disable_bounce = true;
+
 	/* DMA size field can address up to 8 MB */
 	mmc->max_seg_size = 8 * 1024 * 1024;
 	mmc->max_req_size = mmc->max_seg_size;
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c763b404510f..d3b5e6376504 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -666,6 +666,12 @@ static int pxamci_probe(struct platform_device *pdev)
 	mmc->max_segs = NR_SG;
 
 	/*
+	 * This architecture used to disable bounce buffers through its
+	 * defconfig, now it is done at runtime as a host property.
+	 */
+	mmc->disable_bounce = true;
+
+	/*
 	 * Our hardware DMA can handle a maximum of one page per SG entry.
 	 */
 	mmc->max_seg_size = PAGE_SIZE;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 21385ac0c9b1..b53c0e18a33b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -310,6 +310,7 @@ struct mmc_host {
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_segs;	/* see blk_queue_max_segments */
+	bool			disable_bounce; /* disable bounce buffers */
 	unsigned short		unused;
 	unsigned int		max_req_size;	/* maximum number of bytes in one req */
 	unsigned int		max_blk_size;	/* maximum size of one mmc block */
-- 
2.9.3
