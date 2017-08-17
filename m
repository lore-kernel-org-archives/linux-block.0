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
Subject: [PATCH 21/55] skd: Reorder the code in skd_process_request()
Date: Thu, 17 Aug 2017 13:13:04 -0700
Message-Id: <20170817201338.16537-22-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Prepare the S/G-list before allocating a FIT msg such that the FIT
msg always contains at least one request after the for-loop is
finished.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index ab344bfa91c9..cbebaf4b0878 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -612,6 +612,15 @@ static void skd_request_fn(struct request_queue *q)
 		skreq->req = req;
 		skreq->fitmsg_id = 0;
 
+		skreq->sg_data_dir = data_dir == READ ?
+			SKD_DATA_DIR_CARD_TO_HOST : SKD_DATA_DIR_HOST_TO_CARD;
+
+		if (req->bio && !skd_preop_sg_list(skdev, skreq)) {
+			dev_dbg(&skdev->pdev->dev, "error Out\n");
+			skd_end_request(skdev, skreq, BLK_STS_RESOURCE);
+			continue;
+		}
+
 		/* Either a FIT msg is in progress or we have to start one. */
 		if (skmsg == NULL) {
 			/* Are there any FIT msg buffers available? */
@@ -639,15 +648,6 @@ static void skd_request_fn(struct request_queue *q)
 
 		skreq->fitmsg_id = skmsg->id;
 
-		/*
-		 * Note that a FIT msg may have just been started
-		 * but contains no SoFIT requests yet.
-		 */
-
-		/*
-		 * Transcode the request, checking as we go. The outcome of
-		 * the transcoding is represented by the error variable.
-		 */
 		cmd_ptr = &skmsg->msg_buf[skmsg->length];
 		memset(cmd_ptr, 0, 32);
 
@@ -658,11 +658,6 @@ static void skd_request_fn(struct request_queue *q)
 		scsi_req->hdr.tag = cmdctxt;
 		scsi_req->hdr.sg_list_dma_address = be_dmaa;
 
-		if (data_dir == READ)
-			skreq->sg_data_dir = SKD_DATA_DIR_CARD_TO_HOST;
-		else
-			skreq->sg_data_dir = SKD_DATA_DIR_HOST_TO_CARD;
-
 		if (flush == SKD_FLUSH_ZERO_SIZE_FIRST) {
 			skd_prep_zerosize_flush_cdb(scsi_req, skreq);
 			SKD_ASSERT(skreq->flush_cmd == 1);
@@ -673,25 +668,6 @@ static void skd_request_fn(struct request_queue *q)
 		if (fua)
 			scsi_req->cdb[1] |= SKD_FUA_NV;
 
-		if (!req->bio)
-			goto skip_sg;
-
-		if (!skd_preop_sg_list(skdev, skreq)) {
-			/*
-			 * Complete the native request with error.
-			 * Note that the request context is still at the
-			 * head of the free list, and that the SoFIT request
-			 * was encoded into the FIT msg buffer but the FIT
-			 * msg length has not been updated. In short, the
-			 * only resource that has been allocated but might
-			 * not be used is that the FIT msg could be empty.
-			 */
-			dev_dbg(&skdev->pdev->dev, "error Out\n");
-			skd_end_request(skdev, skreq, BLK_STS_RESOURCE);
-			continue;
-		}
-
-skip_sg:
 		scsi_req->hdr.sg_list_len_bytes =
 			cpu_to_be32(skreq->sg_byte_count);
 
-- 
2.14.0
