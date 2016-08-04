Return-Path: <BATV+b244dc37f40e53d0e5a9+4729+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: ming.lei@canonical.com,
	mchristi@redhat.com,
	david@fromorbit.com,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] loop: make do_req_filebacked more robust
Date: Thu,  4 Aug 2016 16:10:01 +0200
Message-Id: <1470319801-20594-3-git-send-email-hch@lst.de>
In-Reply-To: <1470319801-20594-1-git-send-email-hch@lst.de>
References: <1470319801-20594-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Use a switch statement to iterate over the possible operations and
error out if it's an incorrect one.
---
 drivers/block/loop.c | 55 +++++++++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 91c2c88..c9f2107 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -510,14 +510,10 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	return 0;
 }
 
-
-static inline int lo_rw_simple(struct loop_device *lo,
-		struct request *rq, loff_t pos, bool rw)
+static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
-
-	if (cmd->use_aio)
-		return lo_rw_aio(lo, cmd, pos, rw);
+	loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
 
 	/*
 	 * lo_write_simple and lo_read_simple should have been covered
@@ -528,37 +524,30 @@ static inline int lo_rw_simple(struct loop_device *lo,
 	 * of the req at one time. And direct read IO doesn't need to
 	 * run flush_dcache_page().
 	 */
-	if (rw == WRITE)
-		return lo_write_simple(lo, rq, pos);
-	else
-		return lo_read_simple(lo, rq, pos);
-}
-
-static int do_req_filebacked(struct loop_device *lo, struct request *rq)
-{
-	loff_t pos;
-	int ret;
-
-	pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
-
-	if (op_is_write(req_op(rq))) {
-		if (req_op(rq) == REQ_OP_FLUSH)
-			ret = lo_req_flush(lo, rq);
-		else if (req_op(rq) == REQ_OP_DISCARD)
-			ret = lo_discard(lo, rq, pos);
-		else if (lo->transfer)
-			ret = lo_write_transfer(lo, rq, pos);
+	switch (req_op(rq)) {
+	case REQ_OP_FLUSH:
+		return lo_req_flush(lo, rq);
+	case REQ_OP_DISCARD:
+		return lo_discard(lo, rq, pos);
+	case REQ_OP_WRITE:
+		if (lo->transfer)
+			return lo_write_transfer(lo, rq, pos);
+		else if (cmd->use_aio)
+			return lo_rw_aio(lo, cmd, pos, WRITE);
 		else
-			ret = lo_rw_simple(lo, rq, pos, WRITE);
-
-	} else {
+			return lo_write_simple(lo, rq, pos);
+	case REQ_OP_READ:
 		if (lo->transfer)
-			ret = lo_read_transfer(lo, rq, pos);
+			return lo_read_transfer(lo, rq, pos);
+		else if (cmd->use_aio)
+			return lo_rw_aio(lo, cmd, pos, READ);
 		else
-			ret = lo_rw_simple(lo, rq, pos, READ);
+			return lo_read_simple(lo, rq, pos);
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
+		break;
 	}
-
-	return ret;
 }
 
 struct switch_request {
-- 
2.1.4
