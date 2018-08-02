Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35957 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbeHBM5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Aug 2018 08:57:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so873768plb.3
        for <linux-block@vger.kernel.org>; Thu, 02 Aug 2018 04:06:37 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: remove dependencies on BLK_DEV_NVME and PCI
Date: Thu,  2 Aug 2018 13:06:25 +0200
Message-Id: <20180802110625.12463-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No need to force NVMe device driver to be compiled in if the
lightnvm subsystem is selected. Also no need for PCI to be selected
as well, as it would be selected by the device driver that hooks into
the subsystem.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 439bf90d084d..a872cd720967 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,8 +4,7 @@
 
 menuconfig NVM
 	bool "Open-Channel SSD target support"
-	depends on BLOCK && PCI
-	select BLK_DEV_NVME
+	depends on BLOCK
 	help
 	  Say Y here to get to enable Open-channel SSDs.
 
-- 
2.11.0
