Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 05/55] skd: Update maintainer information
Date: Thu, 17 Aug 2017 13:12:48 -0700
Message-Id: <20170817201338.16537-6-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

E-mails sent to support@stec-inc.com bounce. Hence remove that
e-mail address from the driver. Add an entry to the MAINTAINERS
file instead.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 MAINTAINERS              | 6 ++++++
 drivers/block/skd_main.c | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f66488dfdbc9..1164f93a19f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12482,6 +12482,12 @@ M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
 F:	drivers/net/ethernet/adaptec/starfire*
 
+STEC S1220 SKD DRIVER
+M:	Bart Van Assche <bart.vanassche@wdc.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/skd*[ch]
+
 STI CEC DRIVER
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 S:	Maintained
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 95a528f1fb9c..a77a6550d6ea 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -72,7 +72,6 @@ enum {
 #define DRV_BIN_VERSION 0x100
 #define DRV_VER_COMPL   "2.2.1." DRV_BUILD_ID
 
-MODULE_AUTHOR("bug-reports: support@stec-inc.com");
 MODULE_LICENSE("GPL");
 
 MODULE_DESCRIPTION("STEC s1120 PCIe SSD block driver (b" DRV_BUILD_ID ")");
-- 
2.14.0
