Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>
Subject: [PATCH] scsi: scsi_debug: introduce module parameter of 'use_blk_mq'
Date: Mon,  2 Jul 2018 13:06:42 +0800
Message-Id: <20180702050642.26265-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

With the introduced module parameter of 'use_blk_mq', it is easy
to switch between 'blk_mq' and 'non_blk_mq' by reloading scsi_debug
module, so that we can test scsi_mq/blk_mq related regressions easily.

Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 24d7496cd9e2..236cfb669df3 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -144,6 +144,7 @@ static const char *sdebug_version_date = "20180128";
 #define DEF_SUBMIT_QUEUES 1
 #define DEF_UUID_CTL 0
 #define JDELAY_OVERRIDDEN -9999
+#define DEF_USE_BLK_MQ  0
 
 #define SDEBUG_LUN_0_VAL 0
 
@@ -671,6 +672,7 @@ static bool sdebug_verbose;
 static bool have_dif_prot;
 static bool write_since_sync;
 static bool sdebug_statistics = DEF_STATISTICS;
+static bool sdebug_use_blk_mq = DEF_USE_BLK_MQ;
 
 static unsigned int sdebug_store_sectors;
 static sector_t sdebug_capacity;	/* in sectors */
@@ -4537,6 +4539,7 @@ module_param_named(vpd_use_hostno, sdebug_vpd_use_hostno, int,
 		   S_IRUGO | S_IWUSR);
 module_param_named(write_same_length, sdebug_write_same_length, int,
 		   S_IRUGO | S_IWUSR);
+module_param_named(use_blk_mq, sdebug_use_blk_mq, bool, S_IRUGO | S_IWUSR);
 
 MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
 MODULE_DESCRIPTION("SCSI debug adapter driver");
@@ -5849,6 +5852,8 @@ static int sdebug_driver_probe(struct device *dev)
 	sdebug_driver_template.can_queue = sdebug_max_queue;
 	if (sdebug_clustering)
 		sdebug_driver_template.use_clustering = ENABLE_CLUSTERING;
+	if (sdebug_use_blk_mq)
+		sdebug_driver_template.force_blk_mq = 1;
 	hpnt = scsi_host_alloc(&sdebug_driver_template, sizeof(sdbg_host));
 	if (NULL == hpnt) {
 		pr_err("scsi_host_alloc failed\n");
-- 
2.9.5
