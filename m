Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61290 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935106AbeAHQsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jan 2018 11:48:02 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] block: Fix kernel-doc warnings reported when building with W=1
Date: Mon,  8 Jan 2018 08:48:02 -0800
Message-Id: <20180108164802.13752-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit 3a025e1d1c2e ("Add optional check for bad kernel-doc comments")
causes W=1 the kernel-doc script to be run and thereby causes several
new warnings to appear when building the kernel with W=1. Fix the
block layer kernel-doc headers such that the block layer again builds
cleanly with W=1.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bsg-lib.c    | 3 ++-
 block/scsi_ioctl.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 15d25ccd51a5..1474153f73e3 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -30,7 +30,7 @@
 
 /**
  * bsg_teardown_job - routine to teardown a bsg job
- * @job: bsg_job that is to be torn down
+ * @kref: kref inside bsg_job that is to be torn down
  */
 static void bsg_teardown_job(struct kref *kref)
 {
@@ -251,6 +251,7 @@ static void bsg_exit_rq(struct request_queue *q, struct request *req)
  * @name: device to give bsg device
  * @job_fn: bsg job handler
  * @dd_job_size: size of LLD data needed for each job
+ * @release: @dev release function
  */
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 		bsg_job_fn *job_fn, int dd_job_size,
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index edcfff974527..5cddff44a2f8 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -384,9 +384,10 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 
 /**
  * sg_scsi_ioctl  --  handle deprecated SCSI_IOCTL_SEND_COMMAND ioctl
- * @file:	file this ioctl operates on (optional)
  * @q:		request queue to send scsi commands down
  * @disk:	gendisk to operate on (option)
+ * @mode:	mode used to open the file through which the ioctl has been
+ *		submitted
  * @sic:	userspace structure describing the command to perform
  *
  * Send down the scsi command described by @sic to the device below
@@ -415,10 +416,10 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
  *      Positive numbers returned are the compacted SCSI error codes (4
  *      bytes in one int) where the lowest byte is the SCSI status.
  */
-#define OMAX_SB_LEN 16          /* For backward compatibility */
 int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 		struct scsi_ioctl_command __user *sic)
 {
+	enum { OMAX_SB_LEN = 16 };	/* For backward compatibility */
 	struct request *rq;
 	struct scsi_request *req;
 	int err;
-- 
2.15.1
