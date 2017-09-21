Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:19207 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbdIUNl1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 09:41:27 -0400
Date: Thu, 21 Sep 2017 16:41:25 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH V2] lightnvm: include NVM Express driver if OCSSD is selected
 for build
Message-ID: <20170921134123.GA29325@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Because NVM needs BLK_DEV_NVME, select it automatically if we mark NVM
in config file before building kernel.  Also append PCI to depends as
select doesn't automatically add dependencies.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---

V2: appends 'depends' with PCI

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
2.5.0
