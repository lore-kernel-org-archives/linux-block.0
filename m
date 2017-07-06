Return-Path: <BATV+49f9428214963ec94ced+5065+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Meelis Roos <mroos@linux.ee>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	linux-block@vger.kernel.org
Subject: [PATCH] cciss: initialize struct scsi_req
Date: Thu,  6 Jul 2017 10:32:20 -0700
Message-Id: <20170706173220.22129-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

The changes in "block: Make most scsi_req_init() calls implicit" mean
that every driver that supports the generic scsi ioctls needs to
call scsi_req_init on newly allocated requests, but that commit didn't
add the call to the ccіss driver.  Fix that to avoid crashes when
udev issues SG_IO commands.

Fixes: ca18d6f7 ("block: Make most scsi_req_init() calls implicit")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Meelis Roos <mroos@linux.ee>
---
 drivers/block/cciss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 02a611993bb4..678af946be30 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1944,6 +1944,13 @@ static void cciss_get_serial_no(ctlr_info_t *h, int logvol,
 	return;
 }
 
+static void cciss_initialize_rq(struct request *rq)
+{
+	struct scsi_request *sreq = blk_mq_rq_to_pdu(rq);
+
+	scsi_req_init(sreq);
+}
+
 /*
  * cciss_add_disk sets up the block device queue for a logical drive
  */
@@ -1956,6 +1963,7 @@ static int cciss_add_disk(ctlr_info_t *h, struct gendisk *disk,
 
 	disk->queue->cmd_size = sizeof(struct scsi_request);
 	disk->queue->request_fn = do_cciss_request;
+	disk->queue->initialize_rq_fn = cciss_initialize_rq;
 	disk->queue->queue_lock = &h->lock;
 	queue_flag_set_unlocked(QUEUE_FLAG_SCSI_PASSTHROUGH, disk->queue);
 	if (blk_init_allocated_queue(disk->queue) < 0)
-- 
2.11.0
