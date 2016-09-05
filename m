Return-Path: <linux-block-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:60156 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbcIELQC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2016 07:16:02 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lightnvm: NVM should depend on HAS_DMA
Date: Mon,  5 Sep 2016 13:15:58 +0200
Message-Id: <1473074158-15985-1-git-send-email-geert@linux-m68k.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If NO_DMA=y:

    drivers/built-in.o: In function `nvme_nvm_dev_dma_free':
    lightnvm.c:(.text+0x23df1a): undefined reference to `dma_pool_free'
    drivers/built-in.o: In function `nvme_nvm_dev_dma_alloc':
    lightnvm.c:(.text+0x23df38): undefined reference to `dma_pool_alloc'
    drivers/built-in.o: In function `nvme_nvm_destroy_dma_pool':
    lightnvm.c:(.text+0x23df4c): undefined reference to `dma_pool_destroy'
    drivers/built-in.o: In function `nvme_nvm_create_dma_pool':
    lightnvm.c:(.text+0x23df7e): undefined reference to `dma_pool_create'

and

    ERROR: "dma_pool_destroy" [drivers/nvme/host/nvme-core.ko] undefined!
    ERROR: "dma_pool_free" [drivers/nvme/host/nvme-core.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/nvme/host/nvme-core.ko] undefined!
    ERROR: "dma_pool_create" [drivers/nvme/host/nvme-core.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/lightnvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 61c68a1f054ae58e..2f5d5f4a4c75b37d 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig NVM
 	bool "Open-Channel SSD target support"
-	depends on BLOCK
+	depends on BLOCK && HAS_DMA
 	help
 	  Say Y here to get to enable Open-channel SSDs.
 
-- 
1.9.1

