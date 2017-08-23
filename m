Return-Path: <prvs=401b34db8=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/5] skd: Inline skd_process_request()
Date: Wed, 23 Aug 2017 10:56:31 -0700
Message-Id: <20170823175633.12680-4-bart.vanassche@wdc.com>
In-Reply-To: <20170823175633.12680-1-bart.vanassche@wdc.com>
References: <20170823175633.12680-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality but makes the skd
driver code more similar to that of other blk-mq kernel drivers.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index d21fc76c5ed9..0d6340884009 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -478,8 +478,10 @@ static bool skd_fail_all(struct request_queue *q)
 	}
 }
 
-static void skd_process_request(struct request *req, bool last)
+static blk_status_t skd_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
+				    const struct blk_mq_queue_data *mqd)
 {
+	struct request *const req = mqd->rq;
 	struct request_queue *const q = req->q;
 	struct skd_device *skdev = q->queuedata;
 	struct skd_fitmsg_context *skmsg;
@@ -492,6 +494,11 @@ static void skd_process_request(struct request *req, bool last)
 	const u32 count = blk_rq_sectors(req);
 	const int data_dir = rq_data_dir(req);
 
+	if (unlikely(skdev->state != SKD_DRVR_STATE_ONLINE))
+		return skd_fail_all(q) ? BLK_STS_IOERR : BLK_STS_RESOURCE;
+
+	blk_mq_start_request(req);
+
 	WARN_ONCE(tag >= skd_max_queue_depth, "%#x > %#x (nr_requests = %lu)\n",
 		  tag, skd_max_queue_depth, q->nr_requests);
 
@@ -514,7 +521,7 @@ static void skd_process_request(struct request *req, bool last)
 		dev_dbg(&skdev->pdev->dev, "error Out\n");
 		skd_end_request(skdev, blk_mq_rq_from_pdu(skreq),
 				BLK_STS_RESOURCE);
-		return;
+		return BLK_STS_OK;
 	}
 
 	dma_sync_single_for_device(&skdev->pdev->dev, skreq->sksg_dma_address,
@@ -578,30 +585,13 @@ static void skd_process_request(struct request *req, bool last)
 	if (skd_max_req_per_msg == 1) {
 		skd_send_fitmsg(skdev, skmsg);
 	} else {
-		if (last ||
+		if (mqd->last ||
 		    fmh->num_protocol_cmds_coalesced >= skd_max_req_per_msg) {
 			skd_send_fitmsg(skdev, skmsg);
 			skdev->skmsg = NULL;
 		}
 		spin_unlock_irqrestore(&skdev->lock, flags);
 	}
-}
-
-static blk_status_t skd_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
-				    const struct blk_mq_queue_data *mqd)
-{
-	struct request *req = mqd->rq;
-	struct request_queue *q = req->q;
-	struct skd_device *skdev = q->queuedata;
-
-	if (skdev->state == SKD_DRVR_STATE_ONLINE) {
-		blk_mq_start_request(req);
-		skd_process_request(req, mqd->last);
-
-		return BLK_STS_OK;
-	} else {
-		return skd_fail_all(q) ? BLK_STS_IOERR : BLK_STS_RESOURCE;
-	}
 
 	return BLK_STS_OK;
 }
-- 
2.14.0
