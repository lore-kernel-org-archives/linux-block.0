Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:46706 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbdIUL2g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:28:36 -0400
Date: Thu, 21 Sep 2017 14:28:34 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 6/6] lightnvm: include NVM Express driver if OCSSD is
 selected for build
Message-ID: <20170921112832.GA28582@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Because NVM needs BLK_DEV_NVME, select it automatically if we mark NVM
in config file before building kernel.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index ead61a9..b3c00cb 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -5,6 +5,7 @@
 menuconfig NVM
 	bool "Open-Channel SSD target support"
 	depends on BLOCK && HAS_DMA
+	select BLK_DEV_NVME
 	help
 	  Say Y here to get to enable Open-channel SSDs.
 
-- 
2.5.0
