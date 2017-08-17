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
Subject: [PATCH 46/55] skd: Split skd_recover_requests()
Date: Thu, 17 Aug 2017 13:13:29 -0700
Message-Id: <20170817201338.16537-47-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality but makes the blk-mq
conversion patch easier to read.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 1d10373b0da3..451974138b32 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2031,31 +2031,36 @@ static void skd_isr_fwstate(struct skd_device *skdev)
 		skd_skdev_state_to_str(skdev->state), skdev->state);
 }
 
-static void skd_recover_requests(struct skd_device *skdev)
+static void skd_recover_request(struct skd_device *skdev,
+				struct skd_request_context *skreq)
 {
-	int i;
+	struct request *req = skreq->req;
 
-	for (i = 0; i < skdev->num_req_context; i++) {
-		struct skd_request_context *skreq = &skdev->skreq_table[i];
-		struct request *req = skreq->req;
+	if (skreq->state != SKD_REQ_STATE_BUSY)
+		return;
+
+	skd_log_skreq(skdev, skreq, "recover");
+
+	SKD_ASSERT(req != NULL);
 
-		if (skreq->state == SKD_REQ_STATE_BUSY) {
-			skd_log_skreq(skdev, skreq, "recover");
+	/* Release DMA resources for the request. */
+	if (skreq->n_sg > 0)
+		skd_postop_sg_list(skdev, skreq);
 
-			SKD_ASSERT((skreq->id & SKD_ID_INCR) != 0);
-			SKD_ASSERT(req != NULL);
+	skreq->req = NULL;
+	skreq->state = SKD_REQ_STATE_IDLE;
 
-			/* Release DMA resources for the request. */
-			if (skreq->n_sg > 0)
-				skd_postop_sg_list(skdev, skreq);
+	skd_end_request(skdev, req, BLK_STS_IOERR);
+}
 
-			skreq->req = NULL;
+static void skd_recover_requests(struct skd_device *skdev)
+{
+	int i;
 
-			skreq->state = SKD_REQ_STATE_IDLE;
-			skreq->id += SKD_ID_INCR;
+	for (i = 0; i < skdev->num_req_context; i++) {
+		struct skd_request_context *skreq = &skdev->skreq_table[i];
 
-			skd_end_request(skdev, req, BLK_STS_IOERR);
-		}
+		skd_recover_request(skdev, skreq);
 	}
 
 	for (i = 0; i < SKD_N_TIMEOUT_SLOT; i++)
-- 
2.14.0
