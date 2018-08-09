Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 02/12] scsi: Alter handling of RQF_DV requests
Date: Thu,  9 Aug 2018 12:41:39 -0700
Message-Id: <20180809194149.15285-3-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Process all requests in state SDEV_CREATED instead of only RQF_DV
requests. This does not change the behavior of the SCSI core because
the SCSI device state is modified into another state before SCSI
devices become visible in sysfs and before any device nodes are
created in /dev. Do not process RQF_DV requests in state SDEV_CANCEL
because only power management requests should be processed in this
state. Handle all SCSI device states explicitly in
scsi_prep_state_check() instead of using a default case in the
switch/case statement in scsi_prep_state_check(). This allows the
compiler to verify whether all states have been handled.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/scsi/scsi_lib.c | 78 +++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index a65a03e2bcc4..8685704f6c8b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1331,49 +1331,43 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 	 * If the device is not in running state we will reject some
 	 * or all commands.
 	 */
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
+	switch (sdev->sdev_state) {
+	case SDEV_RUNNING:
+	case SDEV_CREATED:
+		break;
+	case SDEV_OFFLINE:
+	case SDEV_TRANSPORT_OFFLINE:
+		/*
+		 * If the device is offline we refuse to process any commands.
+		 * The device must be brought online before trying any
+		 * recovery commands.
+		 */
+		sdev_printk(KERN_ERR, sdev,
+			    "rejecting I/O to offline device\n");
+		ret = BLKPREP_KILL;
+		break;
+	case SDEV_DEL:
+		/*
+		 * If the device is fully deleted, we refuse to process any
+		 * commands as well.
+		 */
+		sdev_printk(KERN_ERR, sdev, "rejecting I/O to dead device\n");
+		ret = BLKPREP_KILL;
+		break;
+	case SDEV_BLOCK:
+	case SDEV_CREATED_BLOCK:
+		ret = BLKPREP_DEFER;
+		break;
+	case SDEV_QUIESCE:
+		/* Only allow RQF_PM and RQF_DV requests. */
+		if (!(req->rq_flags & (RQF_PM | RQF_DV)))
 			ret = BLKPREP_DEFER;
-			break;
-		case SDEV_QUIESCE:
-			/*
-			 * If the devices is blocked we defer normal commands.
-			 */
-			if (req && !(req->rq_flags & (RQF_PM | RQF_DV)))
-				ret = BLKPREP_DEFER;
-			break;
-		default:
-			/*
-			 * For any other not fully online state we only allow
-			 * special commands.  In particular any user initiated
-			 * command is not allowed.
-			 */
-			if (req && !(req->rq_flags & (RQF_PM | RQF_DV)))
-				ret = BLKPREP_KILL;
-			break;
-		}
+		break;
+	case SDEV_CANCEL:
+		/* Only allow RQF_PM requests. */
+		if (!(req->rq_flags & RQF_PM))
+			ret = BLKPREP_KILL;
+		break;
 	}
 	return ret;
 }
-- 
2.18.0
