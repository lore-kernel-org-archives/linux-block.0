Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14527 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbdHQUO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 16:14:58 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Akhil Bhansali <Akhil.Bhansali@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 38/55] skd: Rework request failing code path
Date: Thu, 17 Aug 2017 13:13:21 -0700
Message-Id: <20170817201338.16537-39-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Move the skd_fail_all_pending() call out of skd_request_fn_not_online()
such that this function can be reused in the blk-mq code path.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index ff2ea37b8fd3..8040500ba09c 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -506,7 +506,10 @@ skd_prep_zerosize_flush_cdb(struct skd_scsi_request *scsi_req,
 	scsi_req->cdb[9] = 0;
 }
 
-static void skd_request_fn_not_online(struct request_queue *q)
+/*
+ * Return true if and only if all pending requests should be failed.
+ */
+static bool skd_fail_all(struct request_queue *q)
 {
 	struct skd_device *skdev = q->queuedata;
 
@@ -530,7 +533,7 @@ static void skd_request_fn_not_online(struct request_queue *q)
 	case SKD_DRVR_STATE_BUSY_IMMINENT:
 	case SKD_DRVR_STATE_BUSY_ERASE:
 	case SKD_DRVR_STATE_DRAINING_TIMEOUT:
-		return;
+		return false;
 
 	case SKD_DRVR_STATE_BUSY_SANITIZE:
 	case SKD_DRVR_STATE_STOPPING:
@@ -538,14 +541,8 @@ static void skd_request_fn_not_online(struct request_queue *q)
 	case SKD_DRVR_STATE_FAULT:
 	case SKD_DRVR_STATE_DISAPPEARED:
 	default:
-		break;
+		return true;
 	}
-
-	/* If we get here, terminate all pending block requeusts
-	 * with EIO and any scsi pass thru with appropriate sense
-	 */
-
-	skd_fail_all_pending(skdev);
 }
 
 static void skd_request_fn(struct request_queue *q)
@@ -566,7 +563,8 @@ static void skd_request_fn(struct request_queue *q)
 	int flush, fua;
 
 	if (skdev->state != SKD_DRVR_STATE_ONLINE) {
-		skd_request_fn_not_online(q);
+		if (skd_fail_all(q))
+			skd_fail_all_pending(skdev);
 		return;
 	}
 
-- 
2.14.0
