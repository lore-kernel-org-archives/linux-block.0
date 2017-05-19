Return-Path: <Steven.Hill@cavium.com>
Subject: [RFC PATCH] mmc: core: Remove CONFIG_MMC_BLOCK_BOUNCE option.
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <CGME20170510082450epcas1p148987e484907660670e2f875530c31c8@epcas1p1.samsung.com>
 <20170510082418.10513-2-linus.walleij@linaro.org>
 <3202707.f2tzK1cxd8@amdc3058>
 <CACRpkdZp3JtnNrxsvtNT7hDB1w5KJomngs-=J8PG5fbDF=e+0w@mail.gmail.com>
From: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Arnd Bergmann <arnd@arndb.de>, Paolo Valente <paolo.valente@linaro.org>,
 Daniel Mack <daniel@zonque.org>, Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <cc8694f6-4955-51d3-6342-107cfbb50ed2@cavium.com>
Date: Fri, 19 May 2017 02:30:10 -0500
MIME-Version: 1.0
In-Reply-To: <CACRpkdZp3JtnNrxsvtNT7hDB1w5KJomngs-=J8PG5fbDF=e+0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Return-Path: Steven.Hill@cavium.com
List-ID: <linux-block@vger.kernel.org>

Remove MMC bounce buffer config option and associated code. This
is proposed in addition to Linus' changes to remove the config
option. I have tested this on our Octeon hardware platforms.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/arm/configs/colibri_pxa300_defconfig |   1 -
 arch/arm/configs/davinci_all_defconfig    |   1 -
 arch/arm/configs/lpc32xx_defconfig        |   1 -
 arch/arm/configs/nhk8815_defconfig        |   1 -
 arch/arm/configs/sama5_defconfig          |   1 -
 arch/arm/configs/u300_defconfig           |   1 -
 arch/arm/configs/zeus_defconfig           |   1 -
 arch/blackfin/configs/CM-BF533_defconfig  |   1 -
 arch/blackfin/configs/CM-BF537E_defconfig |   1 -
 arch/mips/configs/cavium_octeon_defconfig |   1 -
 arch/mips/configs/qi_lb60_defconfig       |   1 -
 drivers/mmc/core/Kconfig                  |  18 -----
 drivers/mmc/core/queue.c                  | 109 +++---------------------------
 drivers/mmc/host/davinci_mmc.c            |   6 +-
 include/linux/mmc/card.h                  |   1 -
 15 files changed, 9 insertions(+), 136 deletions(-)

diff --git a/arch/arm/configs/colibri_pxa300_defconfig b/arch/arm/configs/colibri_pxa300_defconfig
index be02fe2..10c940c 100644
--- a/arch/arm/configs/colibri_pxa300_defconfig
+++ b/arch/arm/configs/colibri_pxa300_defconfig
@@ -51,7 +51,6 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_PXA=y
 CONFIG_EXT3_FS=y
 CONFIG_INOTIFY=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 67db829..8a8f086 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -188,7 +188,6 @@ CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_DAVINCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 6ba430d..655edfd 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -146,7 +146,6 @@ CONFIG_USB_LPC32XX=y
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SPI=y
 CONFIG_NEW_LEDS=y
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 7d2ad30..e113d4a 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -95,7 +95,6 @@ CONFIG_GPIO_STMPE=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 777c9e9..c330071 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -180,7 +180,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ATMEL_USBA=y
 CONFIG_USB_G_SERIAL=y
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_AT91=y
diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index aaa95ab..d6eb9fe 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -50,7 +50,6 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index cd11da8..a126f7b 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -146,7 +146,6 @@ CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_PXA=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
diff --git a/arch/blackfin/configs/CM-BF533_defconfig b/arch/blackfin/configs/CM-BF533_defconfig
index 9a5716d..7a40109 100644
--- a/arch/blackfin/configs/CM-BF533_defconfig
+++ b/arch/blackfin/configs/CM-BF533_defconfig
@@ -59,7 +59,6 @@ CONFIG_SPI_BFIN5XX=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_SPI=m
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
diff --git a/arch/blackfin/configs/CM-BF537E_defconfig b/arch/blackfin/configs/CM-BF537E_defconfig
index 6845928..b47ced8 100644
--- a/arch/blackfin/configs/CM-BF537E_defconfig
+++ b/arch/blackfin/configs/CM-BF537E_defconfig
@@ -83,7 +83,6 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_USB_GADGET=m
 CONFIG_USB_ETH=m
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_SPI=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index d4fda41..7f337cf 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -130,7 +130,6 @@ CONFIG_USB_OHCI_HCD_PLATFORM=m
 CONFIG_MMC=y
 # CONFIG_PWRSEQ_EMMC is not set
 # CONFIG_PWRSEQ_SIMPLE is not set
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_CAVIUM_OCTEON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index d7bb8cc..df067bc 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -110,7 +110,6 @@ CONFIG_USB_ETH=y
 # CONFIG_USB_ETH_RNDIS is not set
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_JZ4740=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_JZ4740=y
diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index fc1ecda..42e8906 100644
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
index 5c37b6b..0dcf31d 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -23,8 +23,6 @@
 #include "core.h"
 #include "card.h"

-#define MMC_QUEUE_BOUNCESZ	65536
-
 /*
  * Prepare a MMC request. This just filters out odd stuff.
  */
@@ -219,73 +217,6 @@ static struct mmc_queue_req *mmc_queue_alloc_mqrqs(int qdepth)
 	return mqrq;
 }

-#ifdef CONFIG_MMC_BLOCK_BOUNCE
-static int mmc_queue_alloc_bounce_bufs(struct mmc_queue_req *mqrq, int qdepth,
-				       unsigned int bouncesz)
-{
-	int i;
-
-	for (i = 0; i < qdepth; i++) {
-		mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-		if (!mqrq[i].bounce_buf)
-			return -ENOMEM;
-
-		mqrq[i].sg = mmc_alloc_sg(1);
-		if (!mqrq[i].sg)
-			return -ENOMEM;
-
-		mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512);
-		if (!mqrq[i].bounce_sg)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static bool mmc_queue_alloc_bounce(struct mmc_queue_req *mqrq, int qdepth,
-				   unsigned int bouncesz)
-{
-	int ret;
-
-	ret = mmc_queue_alloc_bounce_bufs(mqrq, qdepth, bouncesz);
-	if (ret)
-		mmc_queue_reqs_free_bufs(mqrq, qdepth);
-
-	return !ret;
-}
-
-static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
-{
-	unsigned int bouncesz = MMC_QUEUE_BOUNCESZ;
-
-	if (host->max_segs != 1)
-		return 0;
-
-	if (bouncesz > host->max_req_size)
-		bouncesz = host->max_req_size;
-	if (bouncesz > host->max_seg_size)
-		bouncesz = host->max_seg_size;
-	if (bouncesz > host->max_blk_count * 512)
-		bouncesz = host->max_blk_count * 512;
-
-	if (bouncesz <= 512)
-		return 0;
-
-	return bouncesz;
-}
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
-
 static int mmc_queue_alloc_sgs(struct mmc_queue_req *mqrq, int qdepth,
 			       int max_segs)
 {
@@ -312,7 +243,6 @@ static int __mmc_queue_alloc_shared_queue(struct mmc_card *card, int qdepth)
 {
 	struct mmc_host *host = card->host;
 	struct mmc_queue_req *mqrq;
-	unsigned int bouncesz;
 	int ret = 0;

 	if (card->mqrq)
@@ -325,26 +255,10 @@ static int __mmc_queue_alloc_shared_queue(struct mmc_card *card, int qdepth)
 	card->mqrq = mqrq;
 	card->qdepth = qdepth;

-	bouncesz = mmc_queue_calc_bouncesz(host);
-
-	if (bouncesz && !mmc_queue_alloc_bounce(mqrq, qdepth, bouncesz)) {
-		bouncesz = 0;
-		pr_warn("%s: unable to allocate bounce buffers\n",
-			mmc_card_name(card));
-	}
-
-	card->bouncesz = bouncesz;
-
-	if (!bouncesz) {
-		ret = mmc_queue_alloc_sgs(mqrq, qdepth, host->max_segs);
-		if (ret)
-			goto out_err;
-	}
-
-	return ret;
+	ret = mmc_queue_alloc_sgs(mqrq, qdepth, host->max_segs);
+	if (ret)
+		mmc_queue_free_shared_queue(card);

-out_err:
-	mmc_queue_free_shared_queue(card);
 	return ret;
 }

@@ -387,18 +301,11 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);

-	if (card->bouncesz) {
-		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_ANY);
-		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segments(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segment_size(mq->queue, card->bouncesz);
-	} else {
-		blk_queue_bounce_limit(mq->queue, limit);
-		blk_queue_max_hw_sectors(mq->queue,
-			min(host->max_blk_count, host->max_req_size / 512));
-		blk_queue_max_segments(mq->queue, host->max_segs);
-		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
-	}
+	blk_queue_bounce_limit(mq->queue, limit);
+	blk_queue_max_hw_sectors(mq->queue,
+		min(host->max_blk_count, host->max_req_size / 512));
+	blk_queue_max_segments(mq->queue, host->max_segs);
+	blk_queue_max_segment_size(mq->queue, host->max_seg_size);

 	sema_init(&mq->thread_sem, 1);

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 621ce47..2c6d131 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -149,11 +149,7 @@

 /*
  * One scatterlist dma "segment" is at most MAX_CCNT rw_threshold units,
- * and we handle up to MAX_NR_SG segments.  MMC_BLOCK_BOUNCE kicks in only
- * for drivers with max_segs == 1, making the segments bigger (64KB)
- * than the page or two that's otherwise typical. nr_sg (passed from
- * platform data) == 16 gives at least the same throughput boost, using
- * EDMA transfer linkage instead of spending CPU time copying pages.
+ * and we handle up to MAX_NR_SG segments.
  */
 #define MAX_CCNT	((1 << 16) - 1)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index aad015e..23653c7 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -306,7 +306,6 @@ struct mmc_card {
 	unsigned int    nr_parts;

 	struct mmc_queue_req	*mqrq;		/* Shared queue structure */
-	unsigned int		bouncesz;	/* Bounce buffer size */
 	int			qdepth;		/* Shared queue depth */
 };

-- 
2.1.4
