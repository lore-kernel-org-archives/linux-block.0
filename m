Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30641 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbdHQUO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 16:14:59 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Akhil Bhansali <Akhil.Bhansali@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 37/55] skd: Move a function definition
Date: Thu, 17 Aug 2017 13:13:20 -0700
Message-Id: <20170817201338.16537-38-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch does not change any functionality but makes the next
patch in this series easier to read.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 84 +++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 49e7097dd409..ff2ea37b8fd3 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -506,7 +506,47 @@ skd_prep_zerosize_flush_cdb(struct skd_scsi_request *scsi_req,
 	scsi_req->cdb[9] = 0;
 }
 
-static void skd_request_fn_not_online(struct request_queue *q);
+static void skd_request_fn_not_online(struct request_queue *q)
+{
+	struct skd_device *skdev = q->queuedata;
+
+	SKD_ASSERT(skdev->state != SKD_DRVR_STATE_ONLINE);
+
+	skd_log_skdev(skdev, "req_not_online");
+	switch (skdev->state) {
+	case SKD_DRVR_STATE_PAUSING:
+	case SKD_DRVR_STATE_PAUSED:
+	case SKD_DRVR_STATE_STARTING:
+	case SKD_DRVR_STATE_RESTARTING:
+	case SKD_DRVR_STATE_WAIT_BOOT:
+	/* In case of starting, we haven't started the queue,
+	 * so we can't get here... but requests are
+	 * possibly hanging out waiting for us because we
+	 * reported the dev/skd0 already.  They'll wait
+	 * forever if connect doesn't complete.
+	 * What to do??? delay dev/skd0 ??
+	 */
+	case SKD_DRVR_STATE_BUSY:
+	case SKD_DRVR_STATE_BUSY_IMMINENT:
+	case SKD_DRVR_STATE_BUSY_ERASE:
+	case SKD_DRVR_STATE_DRAINING_TIMEOUT:
+		return;
+
+	case SKD_DRVR_STATE_BUSY_SANITIZE:
+	case SKD_DRVR_STATE_STOPPING:
+	case SKD_DRVR_STATE_SYNCING:
+	case SKD_DRVR_STATE_FAULT:
+	case SKD_DRVR_STATE_DISAPPEARED:
+	default:
+		break;
+	}
+
+	/* If we get here, terminate all pending block requeusts
+	 * with EIO and any scsi pass thru with appropriate sense
+	 */
+
+	skd_fail_all_pending(skdev);
+}
 
 static void skd_request_fn(struct request_queue *q)
 {
@@ -810,48 +850,6 @@ static void skd_postop_sg_list(struct skd_device *skdev,
 	pci_unmap_sg(skdev->pdev, &skreq->sg[0], skreq->n_sg, skreq->data_dir);
 }
 
-static void skd_request_fn_not_online(struct request_queue *q)
-{
-	struct skd_device *skdev = q->queuedata;
-
-	SKD_ASSERT(skdev->state != SKD_DRVR_STATE_ONLINE);
-
-	skd_log_skdev(skdev, "req_not_online");
-	switch (skdev->state) {
-	case SKD_DRVR_STATE_PAUSING:
-	case SKD_DRVR_STATE_PAUSED:
-	case SKD_DRVR_STATE_STARTING:
-	case SKD_DRVR_STATE_RESTARTING:
-	case SKD_DRVR_STATE_WAIT_BOOT:
-	/* In case of starting, we haven't started the queue,
-	 * so we can't get here... but requests are
-	 * possibly hanging out waiting for us because we
-	 * reported the dev/skd0 already.  They'll wait
-	 * forever if connect doesn't complete.
-	 * What to do??? delay dev/skd0 ??
-	 */
-	case SKD_DRVR_STATE_BUSY:
-	case SKD_DRVR_STATE_BUSY_IMMINENT:
-	case SKD_DRVR_STATE_BUSY_ERASE:
-	case SKD_DRVR_STATE_DRAINING_TIMEOUT:
-		return;
-
-	case SKD_DRVR_STATE_BUSY_SANITIZE:
-	case SKD_DRVR_STATE_STOPPING:
-	case SKD_DRVR_STATE_SYNCING:
-	case SKD_DRVR_STATE_FAULT:
-	case SKD_DRVR_STATE_DISAPPEARED:
-	default:
-		break;
-	}
-
-	/* If we get here, terminate all pending block requeusts
-	 * with EIO and any scsi pass thru with appropriate sense
-	 */
-
-	skd_fail_all_pending(skdev);
-}
-
 /*
  *****************************************************************************
  * TIMER
-- 
2.14.0
