Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33434 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934217AbcIPMZa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2016 08:25:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id q2so935777pfj.0
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2016 05:25:30 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com
Cc: keith.busch@intel.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 1/7] lightnvm: NVM should depend on HAS_DMA
Date: Fri, 16 Sep 2016 14:25:03 +0200
Message-Id: <1474028709-30260-2-git-send-email-m@bjorling.me>
In-Reply-To: <1474028709-30260-1-git-send-email-m@bjorling.me>
References: <1474028709-30260-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

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
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 61c68a1..2f5d5f4 100644
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
2.1.4

