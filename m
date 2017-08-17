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
Subject: [PATCH 54/55] skd: Optimize locking
Date: Thu, 17 Aug 2017 13:13:37 -0700
Message-Id: <20170817201338.16537-55-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Only take skdev->lock if necessary.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a732bb8040f4..bcd8df0bf203 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -490,7 +490,7 @@ static void skd_process_request(struct request *req, bool last)
 	const u32 tag = blk_mq_unique_tag(req);
 	struct skd_request_context *const skreq = blk_mq_rq_to_pdu(req);
 	struct skd_scsi_request *scsi_req;
-	unsigned long flags;
+	unsigned long flags = 0;
 	const u32 lba = blk_rq_pos(req);
 	const u32 count = blk_rq_sectors(req);
 	const int data_dir = rq_data_dir(req);
@@ -525,9 +525,13 @@ static void skd_process_request(struct request *req, bool last)
 				   sizeof(struct fit_sg_descriptor),
 				   DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&skdev->lock, flags);
 	/* Either a FIT msg is in progress or we have to start one. */
-	skmsg = skdev->skmsg;
+	if (skd_max_req_per_msg == 1) {
+		skmsg = NULL;
+	} else {
+		spin_lock_irqsave(&skdev->lock, flags);
+		skmsg = skdev->skmsg;
+	}
 	if (!skmsg) {
 		skmsg = &skdev->skmsg_table[tag];
 		skdev->skmsg = skmsg;
@@ -574,11 +578,16 @@ static void skd_process_request(struct request *req, bool last)
 	/*
 	 * If the FIT msg buffer is full send it.
 	 */
-	if (last || fmh->num_protocol_cmds_coalesced >= skd_max_req_per_msg) {
+	if (skd_max_req_per_msg == 1) {
 		skd_send_fitmsg(skdev, skmsg);
-		skdev->skmsg = NULL;
+	} else {
+		if (last ||
+		    fmh->num_protocol_cmds_coalesced >= skd_max_req_per_msg) {
+			skd_send_fitmsg(skdev, skmsg);
+			skdev->skmsg = NULL;
+		}
+		spin_unlock_irqrestore(&skdev->lock, flags);
 	}
-	spin_unlock_irqrestore(&skdev->lock, flags);
 }
 
 static blk_status_t skd_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.14.0
