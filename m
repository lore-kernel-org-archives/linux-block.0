Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>
Subject: [PATCH 07/19] scsi: Make scsi_ioctl_reset() pass the request queue pointer to blk_rq_init()
Date: Thu, 25 May 2017 11:43:15 -0700
Message-ID: <20170525184327.23570-8-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

A later patch will add a call to a request initialization function
into blk_rq_init(). Hence make sure that all blk_rq_init() calls
specify the request queue pointer. Since TMF callback functions in
SCSI LLD drivers do not use request.q, this patch does not change
the behavior of any SCSI driver.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/scsi/scsi_error.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index ecc07dab893d..97d5a0bb7061 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2274,7 +2274,12 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 			shost->hostt->cmd_size, GFP_KERNEL);
 	if (!rq)
 		goto out_put_autopm_host;
-	blk_rq_init(NULL, rq);
+	/*
+	 * Although blk_rq_init() is intended for single queue block
+	 * drivers, this code path even uses blk_rq_init() when @dev is
+	 * a scsi-mq device.
+	 */
+	blk_rq_init(dev->request_queue, rq);
 
 	scmd = (struct scsi_cmnd *)(rq + 1);
 	scsi_init_command(dev, scmd);
-- 
2.12.2
