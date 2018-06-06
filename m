Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: pass failfast and driver-specific flags to flush requests
Date: Wed,  6 Jun 2018 16:21:40 +0200
Message-Id: <20180606142140.64146-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

If flush requests are being sent to the device we need to inherit the
failfast and driver-specific flags, too, otherwise I/O will fail.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-flush.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index f17170675917..058abdb50f31 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -94,7 +94,7 @@ enum {
 };
 
 static bool blk_kick_flush(struct request_queue *q,
-			   struct blk_flush_queue *fq);
+			   struct blk_flush_queue *fq, unsigned int flags);
 
 static unsigned int blk_flush_policy(unsigned long fflags, struct request *rq)
 {
@@ -212,7 +212,7 @@ static bool blk_flush_complete_seq(struct request *rq,
 		BUG();
 	}
 
-	kicked = blk_kick_flush(q, fq);
+	kicked = blk_kick_flush(q, fq, rq->cmd_flags);
 	return kicked | queued;
 }
 
@@ -281,6 +281,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
  * blk_kick_flush - consider issuing flush request
  * @q: request_queue being kicked
  * @fq: flush queue
+ * @flags: cmd_flags of the original request
  *
  * Flush related states of @q have changed, consider issuing flush request.
  * Please read the comment at the top of this file for more info.
@@ -291,7 +292,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
  * RETURNS:
  * %true if flush was issued, %false otherwise.
  */
-static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
+static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
+			   unsigned int flags)
 {
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	struct request *first_rq =
@@ -346,6 +348,7 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 	}
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
+	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->rq_disk = first_rq->rq_disk;
 	flush_rq->end_io = flush_end_io;
-- 
2.12.3
