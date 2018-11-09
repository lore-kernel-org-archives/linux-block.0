Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/9] mtip32xx: merge mtip_submit_request into mtip_queue_rq
Date: Fri,  9 Nov 2018 14:48:55 +0100
Message-Id: <20181109134902.32057-3-hch@lst.de>
In-Reply-To: <20181109134902.32057-1-hch@lst.de>
References: <20181109134902.32057-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Factor out a new is_stopped helper that matches the existing
is_se_active helper, and merge the trivial amount of remaining code
into the only caller.  This also allows better error handling by
returning a BLK_STS_* directly instead of explicitly calling
blk_mq_end_request, and moving blk_mq_start_request closer to the
actual issue to hardware.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 78 +++++++++++--------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 1964af8a187b..75a4ca0210f2 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3534,54 +3534,24 @@ static inline bool is_se_active(struct driver_data *dd)
 	return false;
 }
 
-/*
- * Block layer make request function.
- *
- * This function is called by the kernel to process a BIO for
- * the P320 device.
- *
- * @queue Pointer to the request queue. Unused other than to obtain
- *              the driver data structure.
- * @rq    Pointer to the request.
- *
- */
-static int mtip_submit_request(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static inline bool is_stopped(struct driver_data *dd, struct request *rq)
 {
-	struct driver_data *dd = hctx->queue->queuedata;
-	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
-
-	if (is_se_active(dd))
-		return -ENODATA;
-
-	if (unlikely(dd->dd_flag & MTIP_DDF_STOP_IO)) {
-		if (unlikely(test_bit(MTIP_DDF_REMOVE_PENDING_BIT,
-							&dd->dd_flag))) {
-			return -ENXIO;
-		}
-		if (unlikely(test_bit(MTIP_DDF_OVER_TEMP_BIT, &dd->dd_flag))) {
-			return -ENODATA;
-		}
-		if (unlikely(test_bit(MTIP_DDF_WRITE_PROTECT_BIT,
-							&dd->dd_flag) &&
-				rq_data_dir(rq))) {
-			return -ENODATA;
-		}
-		if (unlikely(test_bit(MTIP_DDF_SEC_LOCK_BIT, &dd->dd_flag) ||
-			test_bit(MTIP_DDF_REBUILD_FAILED_BIT, &dd->dd_flag)))
-			return -ENODATA;
-	}
-
-	if (req_op(rq) == REQ_OP_DISCARD) {
-		int err;
+	if (likely(!(dd->dd_flag & MTIP_DDF_STOP_IO)))
+		return false;
 
-		err = mtip_send_trim(dd, blk_rq_pos(rq), blk_rq_sectors(rq));
-		blk_mq_end_request(rq, err ? BLK_STS_IOERR : BLK_STS_OK);
-		return 0;
-	}
+	if (test_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag))
+		return true;
+	if (test_bit(MTIP_DDF_OVER_TEMP_BIT, &dd->dd_flag))
+		return true;
+	if (test_bit(MTIP_DDF_WRITE_PROTECT_BIT, &dd->dd_flag) &&
+	    rq_data_dir(rq))
+		return true;
+	if (test_bit(MTIP_DDF_SEC_LOCK_BIT, &dd->dd_flag))
+		return true;
+	if (test_bit(MTIP_DDF_REBUILD_FAILED_BIT, &dd->dd_flag))
+		return true;
 
-	/* Issue the read/write. */
-	mtip_hw_submit_io(dd, rq, cmd, hctx);
-	return 0;
+	return false;
 }
 
 static bool mtip_check_unal_depth(struct blk_mq_hw_ctx *hctx,
@@ -3647,8 +3617,9 @@ static blk_status_t mtip_issue_reserved_cmd(struct blk_mq_hw_ctx *hctx,
 static blk_status_t mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
+	struct driver_data *dd = hctx->queue->queuedata;
 	struct request *rq = bd->rq;
-	int ret;
+	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
 	mtip_init_cmd_header(rq);
 
@@ -3658,12 +3629,19 @@ static blk_status_t mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_STS_RESOURCE;
 
+	if (is_se_active(dd) || is_stopped(dd, rq))
+		return BLK_STS_IOERR;
+
 	blk_mq_start_request(rq);
 
-	ret = mtip_submit_request(hctx, rq);
-	if (likely(!ret))
-		return BLK_STS_OK;
-	return BLK_STS_IOERR;
+	if (req_op(rq) == REQ_OP_DISCARD) {
+		if (mtip_send_trim(dd, blk_rq_pos(rq), blk_rq_sectors(rq)) < 0)
+			return BLK_STS_IOERR;
+	} else {
+		mtip_hw_submit_io(dd, rq, cmd, hctx);
+	}
+
+	return BLK_STS_OK;
 }
 
 static void mtip_free_cmd(struct blk_mq_tag_set *set, struct request *rq,
-- 
2.19.1
