Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: blk-wbt: handle O_DIRECT writes like high priority writes
Message-ID: <b58ca65a-0064-f138-80c4-4f1021a0213a@kernel.dk>
Date: Fri, 14 Sep 2018 11:34:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Currently we don't limit O_DIRECT writes at all, we just let them queue
up as many as possible. As max priority writes should be able to get
full bandwidth, handle O_DIRECT writes just like we would high priority
buffered writes.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8e20a0677dcf..9b17161b5668 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -450,6 +450,12 @@ static bool close_io(struct rq_wb *rwb)
 		time_before(now, rwb->last_comp + HZ / 10);
 }
 
+static bool is_odirect_write(unsigned long rw)
+{
+	return op_is_write(rw) &&
+		((rw & (REQ_SYNC | REQ_IDLE)) == (REQ_SYNC | REQ_IDLE));
+}
+
 #define REQ_HIPRIO	(REQ_SYNC | REQ_META | REQ_PRIO)
 
 static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
@@ -474,7 +480,8 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	 * the idle limit, or go to normal if we haven't had competing
 	 * IO for a bit.
 	 */
-	if ((rw & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd())
+	if ((rw & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd() ||
+	    is_odirect_write(rw))
 		limit = rwb->rq_depth.max_depth;
 	else if ((rw & REQ_BACKGROUND) || close_io(rwb)) {
 		/*
@@ -578,12 +585,6 @@ static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
 {
 	switch (bio_op(bio)) {
 	case REQ_OP_WRITE:
-		/*
-		 * Don't throttle WRITE_ODIRECT
-		 */
-		if ((bio->bi_opf & (REQ_SYNC | REQ_IDLE)) ==
-		    (REQ_SYNC | REQ_IDLE))
-			return false;
 		/* fallthrough */
 	case REQ_OP_DISCARD:
 		return true;


-- 
Jens Axboe
