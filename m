Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: core: make block layer non-optional
Date: Wed, 15 Feb 2017 10:53:53 +0100
Message-Id: <20170215095353.23888-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

I do not know at what point people have wanted to have a system
with MMC/SD support without the block layer. We are anyway now
so tightly integrated with the block layer that this is onlt
teoretical and it makes no sense to have the block layer interface
as optional.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/Kconfig  | 12 ------------
 drivers/mmc/core/Makefile |  5 ++---
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index cdfa8520a4b1..2920bc4351ed 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -23,19 +23,8 @@ config PWRSEQ_SIMPLE
 	  This driver can also be built as a module. If so, the module
 	  will be called pwrseq_simple.
 
-config MMC_BLOCK
-	tristate "MMC block device driver"
-	depends on BLOCK
-	default y
-	help
-	  Say Y here to enable the MMC block device driver support.
-	  This provides a block device driver, which you can use to
-	  mount the filesystem. Almost everyone wishing MMC support
-	  should say Y or M here.
-
 config MMC_BLOCK_MINORS
 	int "Number of minors per block device"
-	depends on MMC_BLOCK
 	range 4 256
 	default 8
 	help
@@ -53,7 +42,6 @@ config MMC_BLOCK_MINORS
 
 config MMC_BLOCK_BOUNCE
 	bool "Use bounce buffer for simple hosts"
-	depends on MMC_BLOCK
 	default y
 	help
 	  SD/MMC is a high latency protocol where it is crucial to
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index b2a257dc644f..42f0d781d911 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -7,12 +7,11 @@ mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
-				   quirks.o slot-gpio.o
+				   quirks.o slot-gpio.o \
+				   block.o queue.o
 mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
 obj-$(CONFIG_PWRSEQ_EMMC)	+= pwrseq_emmc.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
-obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
-mmc_block-objs			:= block.o queue.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
-- 
2.9.3
