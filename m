Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39987 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJIS3o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:29:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so671952pfj.7
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:13:18 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/45] lightnvm: remove dependencies on BLK_DEV_NVME and PCI
Date: Tue,  9 Oct 2018 13:11:31 +0200
Message-Id: <20181009111215.7653-2-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No need to force NVMe device driver to be compiled in if the
lightnvm subsystem is selected. Also no need for PCI to be selected
as well, as it would be selected by the device driver that hooks into
the subsystem.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
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
2.17.1
