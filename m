Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: loop: handle short DIO reads
Message-ID: <e6ce722c-56d0-3519-a22b-0e40967425f5@kernel.dk>
Date: Fri, 13 Apr 2018 12:39:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

We ran into an issue with loop and btrfs, where btrfs would complain about
checksum errors. It turns out that is because we don't handle short reads
at all, we just zero fill the remainder. Worse than that, we don't handle
the filling properly, which results in loop trying to advance a single
bio by much more than its size, since it doesn't take chaining into
account.

Handle short reads appropriately, by simply retrying at the new correct
offset. End the remainder of the request with EIO, if we get a 0 read.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c9d04497a415..66975c4fb6f1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -451,16 +451,28 @@ static int lo_req_flush(struct loop_device *lo, struct request *rq)
 static void lo_complete_rq(struct request *rq)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	blk_status_t ret = BLK_STS_OK;
 
-	if (unlikely(req_op(cmd->rq) == REQ_OP_READ && cmd->use_aio &&
-		     cmd->ret >= 0 && cmd->ret < blk_rq_bytes(cmd->rq))) {
-		struct bio *bio = cmd->rq->bio;
-
-		bio_advance(bio, cmd->ret);
-		zero_fill_bio(bio);
+	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
+	    req_op(cmd->rq) != REQ_OP_READ) {
+		if (cmd->ret < 0)
+			ret = BLK_STS_IOERR;
+		goto end_io;
 	}
 
-	blk_mq_end_request(rq, cmd->ret < 0 ? BLK_STS_IOERR : BLK_STS_OK);
+	/*
+	 * Short READ - if we got some data, advance our request and
+	 * retry it. If we got no data, end the rest with EIO.
+	 */
+	if (cmd->ret) {
+		blk_update_request(cmd->rq, BLK_STS_OK, cmd->ret);
+		cmd->ret = 0;
+		blk_mq_requeue_request(cmd->rq, true);
+	} else {
+		ret = BLK_STS_IOERR;
+end_io:
+		blk_mq_end_request(rq, ret);
+	}
 }
 
 static void lo_rw_aio_do_completion(struct loop_cmd *cmd)

-- 
Jens Axboe
