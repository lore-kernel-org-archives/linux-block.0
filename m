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
Subject: [PATCH 06/55] skd: Remove unneeded #include directives
Date: Thu, 17 Aug 2017 13:12:49 -0700
Message-Id: <20170817201338.16537-7-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a77a6550d6ea..06544f58dc73 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -20,7 +20,6 @@
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
 #include <linux/workqueue.h>
-#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/hdreg.h>
@@ -30,7 +29,6 @@
 #include <linux/version.h>
 #include <linux/err.h>
 #include <linux/aer.h>
-#include <linux/ctype.h>
 #include <linux/wait.h>
 #include <linux/uio.h>
 #include <scsi/scsi.h>
-- 
2.14.0
