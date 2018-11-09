Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 2/7] scsi: simplify scsi_prep_state_check
Date: Fri,  9 Nov 2018 14:42:36 +0100
Message-Id: <20181109134241.29346-3-hch@lst.de>
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Return a blk_status_t directly, and make the code a little more compact
by handling the fast path in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_lib.c | 102 +++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 54 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ed81b8e74cfe..5ecabb3e77b7 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1240,60 +1240,48 @@ static int scsi_setup_cmnd(struct scsi_device *sdev, struct request *req)
 		return scsi_setup_fs_cmnd(sdev, req);
 }
 
-static int
+static blk_status_t
 scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 {
-	int ret = BLKPREP_OK;
-
-	/*
-	 * If the device is not in running state we will reject some
-	 * or all commands.
-	 */
-	if (unlikely(sdev->sdev_state != SDEV_RUNNING)) {
-		switch (sdev->sdev_state) {
-		case SDEV_OFFLINE:
-		case SDEV_TRANSPORT_OFFLINE:
-			/*
-			 * If the device is offline we refuse to process any
-			 * commands.  The device must be brought online
-			 * before trying any recovery commands.
-			 */
-			sdev_printk(KERN_ERR, sdev,
-				    "rejecting I/O to offline device\n");
-			ret = BLKPREP_KILL;
-			break;
-		case SDEV_DEL:
-			/*
-			 * If the device is fully deleted, we refuse to
-			 * process any commands as well.
-			 */
-			sdev_printk(KERN_ERR, sdev,
-				    "rejecting I/O to dead device\n");
-			ret = BLKPREP_KILL;
-			break;
-		case SDEV_BLOCK:
-		case SDEV_CREATED_BLOCK:
-			ret = BLKPREP_DEFER;
-			break;
-		case SDEV_QUIESCE:
-			/*
-			 * If the devices is blocked we defer normal commands.
-			 */
-			if (req && !(req->rq_flags & RQF_PREEMPT))
-				ret = BLKPREP_DEFER;
-			break;
-		default:
-			/*
-			 * For any other not fully online state we only allow
-			 * special commands.  In particular any user initiated
-			 * command is not allowed.
-			 */
-			if (req && !(req->rq_flags & RQF_PREEMPT))
-				ret = BLKPREP_KILL;
-			break;
-		}
+	switch (sdev->sdev_state) {
+	case SDEV_OFFLINE:
+	case SDEV_TRANSPORT_OFFLINE:
+		/*
+		 * If the device is offline we refuse to process any
+		 * commands.  The device must be brought online
+		 * before trying any recovery commands.
+		 */
+		sdev_printk(KERN_ERR, sdev,
+			    "rejecting I/O to offline device\n");
+		return BLK_STS_IOERR;
+	case SDEV_DEL:
+		/*
+		 * If the device is fully deleted, we refuse to
+		 * process any commands as well.
+		 */
+		sdev_printk(KERN_ERR, sdev,
+			    "rejecting I/O to dead device\n");
+		return BLK_STS_IOERR;
+	case SDEV_BLOCK:
+	case SDEV_CREATED_BLOCK:
+		return BLK_STS_RESOURCE;
+	case SDEV_QUIESCE:
+		/*
+		 * If the devices is blocked we defer normal commands.
+		 */
+		if (req && !(req->rq_flags & RQF_PREEMPT))
+			return BLK_STS_RESOURCE;
+		return BLK_STS_OK;
+	default:
+		/*
+		 * For any other not fully online state we only allow
+		 * special commands.  In particular any user initiated
+		 * command is not allowed.
+		 */
+		if (req && !(req->rq_flags & RQF_PREEMPT))
+			return BLK_STS_IOERR;
+		return BLK_STS_OK;
 	}
-	return ret;
 }
 
 /*
@@ -1700,9 +1688,15 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret;
 	int reason;
 
-	ret = prep_to_mq(scsi_prep_state_check(sdev, req));
-	if (ret != BLK_STS_OK)
-		goto out_put_budget;
+	/*
+	 * If the device is not in running state we will reject some or all
+	 * commands.
+	 */
+	if (unlikely(sdev->sdev_state != SDEV_RUNNING)) {
+		ret = scsi_prep_state_check(sdev, req);
+		if (ret != BLK_STS_OK)
+			goto out_put_budget;
+	}
 
 	ret = BLK_STS_RESOURCE;
 	if (!scsi_target_queue_ready(shost, sdev))
-- 
2.19.1
