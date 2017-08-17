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
Subject: [PATCH 18/55] skd: Introduce the symbolic constant SKD_MAX_REQ_PER_MSG
Date: Thu, 17 Aug 2017 13:13:01 -0700
Message-Id: <20170817201338.16537-19-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 5c69e9210a62..98dc16073072 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -31,6 +31,7 @@
 #include <linux/aer.h>
 #include <linux/wait.h>
 #include <linux/uio.h>
+#include <linux/stringify.h>
 #include <scsi/scsi.h>
 #include <scsi/sg.h>
 #include <linux/io.h>
@@ -86,6 +87,7 @@ MODULE_VERSION(DRV_VERSION "-" DRV_BUILD_ID);
 #define SKD_PAUSE_TIMEOUT       (5 * 1000)
 
 #define SKD_N_FITMSG_BYTES      (512u)
+#define SKD_MAX_REQ_PER_MSG	14
 
 #define SKD_N_SPECIAL_CONTEXT   32u
 #define SKD_N_SPECIAL_FITMSG_BYTES      (128u)
@@ -377,7 +379,7 @@ static int skd_max_req_per_msg = SKD_MAX_REQ_PER_MSG_DEFAULT;
 module_param(skd_max_req_per_msg, int, 0444);
 MODULE_PARM_DESC(skd_max_req_per_msg,
 		 "Maximum SCSI requests packed in a single message."
-		 " (1-14, default==1)");
+		 " (1-" __stringify(SKD_MAX_REQ_PER_MSG) ", default==1)");
 
 #define SKD_MAX_QUEUE_DEPTH_DEFAULT 64
 #define SKD_MAX_QUEUE_DEPTH_DEFAULT_STR "64"
@@ -5016,6 +5018,9 @@ static void skd_log_skreq(struct skd_device *skdev,
 
 static int __init skd_init(void)
 {
+	BUILD_BUG_ON(sizeof(struct fit_msg_hdr) + SKD_MAX_REQ_PER_MSG *
+		     sizeof(struct skd_scsi_request) != SKD_N_FITMSG_BYTES);
+
 	pr_info(PFX " v%s-b%s loaded\n", DRV_VERSION, DRV_BUILD_ID);
 
 	switch (skd_isr_type) {
@@ -5036,7 +5041,8 @@ static int __init skd_init(void)
 		skd_max_queue_depth = SKD_MAX_QUEUE_DEPTH_DEFAULT;
 	}
 
-	if (skd_max_req_per_msg < 1 || skd_max_req_per_msg > 14) {
+	if (skd_max_req_per_msg < 1 ||
+	    skd_max_req_per_msg > SKD_MAX_REQ_PER_MSG) {
 		pr_err(PFX "skd_max_req_per_msg %d invalid, re-set to %d\n",
 		       skd_max_req_per_msg, SKD_MAX_REQ_PER_MSG_DEFAULT);
 		skd_max_req_per_msg = SKD_MAX_REQ_PER_MSG_DEFAULT;
-- 
2.14.0
