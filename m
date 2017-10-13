Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52968 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758036AbdJMMrN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id k4so21547307wmc.1
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:12 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 06/58] lightnvm: include NVM Express driver if OCSSD is selected for build
Date: Fri, 13 Oct 2017 14:45:55 +0200
Message-Id: <20171013124647.32668-7-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

Because NVM needs BLK_DEV_NVME, select it automatically if we mark NVM
in config file before building kernel.  Also append PCI to depends as
select doesn't automatically add dependencies.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index ead61a9..2a953ef 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,7 +4,8 @@
 
 menuconfig NVM
 	bool "Open-Channel SSD target support"
-	depends on BLOCK && HAS_DMA
+	depends on BLOCK && HAS_DMA && PCI
+	select BLK_DEV_NVME
 	help
 	  Say Y here to get to enable Open-channel SSDs.
 
-- 
2.9.3
