Return-Path: <prvs=396ff485d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] skd: Remove driver version information
Date: Fri, 18 Aug 2017 08:22:28 -0700
Message-Id: <20170818152228.7236-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Remove the driver version information because this information
is not useful in an upstream kernel driver.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a61c7a3a5557..9b99081a623c 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -53,13 +53,11 @@ static int skd_isr_comp_limit = 4;
 	} while (0)
 
 #define DRV_NAME "skd"
-#define DRV_VERSION "3.0.0"
 #define PFX DRV_NAME ": "
 
 MODULE_LICENSE("GPL");
 
 MODULE_DESCRIPTION("STEC s1120 PCIe SSD block driver");
-MODULE_VERSION(DRV_VERSION);
 
 #define PCI_VENDOR_ID_STEC      0x1B39
 #define PCI_DEVICE_ID_S1120     0x0001
-- 
2.14.0
