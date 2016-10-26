Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: flush: fix IO hang in case of flood fua req
Date: Wed, 26 Oct 2016 16:57:15 +0800
Message-Id: <1477472235-22845-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

This patch fixes one issue reported by Kent, which can
be triggered in bcachefs over sata disk. Actually it
is a generic issue in block flush vs. blk-tag.

Cc: Christoph Hellwig <hch@infradead.org>
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-flush.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6a14b68b9135..3c882cbc7541 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -343,6 +343,34 @@ static void flush_data_end_io(struct request *rq, int error)
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, NULL);
 
 	/*
+	 * Updating q->in_flight[] here for making this tag usable
+	 * early. Because in blk_queue_start_tag(),
+	 * q->in_flight[BLK_RW_ASYNC] is used to limit async I/O and
+	 * reserve tags for sync I/O.
+	 *
+	 * More importantly this way can avoid the following I/O
+	 * deadlock:
+	 *
+	 * - suppose there are 40 fua requests comming to flush queue
+	 *   and queue depth is 31
+	 * - 30 rqs are scheduled then blk_queue_start_tag() can't alloc
+	 *   tag for async I/O any more
+	 * - all the 30 rqs are completed before FLUSH_PENDING_TIMEOUT
+	 *   and flush_data_end_io() is called
+	 * - the other rqs still can't go ahead if not updating
+	 *   q->in_flight[BLK_RW_ASYNC] here, meantime these rqs
+	 *   are held in flush data queue and make no progress of
+	 *   handling post flush rq
+	 * - only after the post flush rq is handled, all these rqs
+	 *   can be completed
+	 */
+
+	elv_completed_request(q, rq);
+
+	/* for avoiding double accounting */
+	rq->cmd_flags &= ~REQ_STARTED;
+
+	/*
 	 * After populating an empty queue, kick it to avoid stall.  Read
 	 * the comment in flush_end_io().
 	 */
-- 
2.7.4
