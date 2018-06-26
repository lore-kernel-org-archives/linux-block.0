Return-Path: <prvs=708eb8c04=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] block: Fix blk_end_request_all() for WRITE SAME requests
Date: Mon, 25 Jun 2018 17:10:09 -0700
Message-Id: <20180626001009.16557-4-bart.vanassche@wdc.com>
In-Reply-To: <20180626001009.16557-1-bart.vanassche@wdc.com>
References: <20180626001009.16557-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Most REQ_OP_WRITE_SAME requests have a data buffer size that differs
from the number of bytes affected on the storage medium. Since
blk_update_request() expects that its third argument is the number of
bytes that have been completed from the data out buffer, pass that
number fo blk_update_request(). This patch avoids that removing a
path controlled by the dm-mpath driver while mkfs is running triggers
the following kernel bug:

-----------[ cut here ]------------
kernel BUG at block/blk-core.c:3347!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 20 PID: 24369 Comm: mkfs.ext4 Not tainted 4.18.0-rc1-dbg+ #2
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.0.0-prebuilt.qemu-pro
ject.org 04/01/2014
RIP: 0010:blk_end_request_all+0x68/0x70
Call Trace:
 <IRQ>
 dm_softirq_done+0x326/0x3d0 [dm_mod]
 blk_done_softirq+0x19b/0x1e0
 __do_softirq+0x128/0x60d
 irq_exit+0x100/0x110
 smp_call_function_single_interrupt+0x90/0x330
 call_function_single_interrupt+0xf/0x20
 </IRQ>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 31 ++++++++++++++++++++++++-------
 block/blk-mq.c   |  2 +-
 block/blk.h      |  2 ++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 81936b9d6d26..6f9483d4b988 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2686,6 +2686,21 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
+/**
+ * blk_rq_bio_bytes - sum of all bytes in all bios associated with a request
+ * @rq: request pointer.
+ */
+unsigned int blk_rq_bio_bytes(const struct request *rq)
+{
+	unsigned int bytes = 0;
+	struct bio *bio;
+
+	for (bio = rq->bio; bio; bio = bio->bi_next)
+		bytes += bio->bi_iter.bi_size;
+
+	return bytes;
+}
+
 /**
  * blk_rq_err_bytes - determine number of bytes till the next failure boundary
  * @rq: request to examine
@@ -3080,8 +3095,8 @@ EXPORT_SYMBOL_GPL(blk_steal_bios);
  *     (e.g. request-based dm) so that they can handle partial completion.
  *     Actual device drivers should use blk_end_request instead.
  *
- *     Passing the result of blk_rq_bytes() as @nr_bytes guarantees
- *     %false return from this function.
+ *     Passing the result of blk_rq_bio_bytes() as @nr_bytes guarantees that
+ *     this function will return %false.
  *
  * Return:
  *     %false - this request doesn't have any more data
@@ -3152,7 +3167,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		 * If total number of sectors is less than the first segment
 		 * size, something has gone terribly wrong.
 		 */
-		if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
+		if (blk_rq_bio_bytes(req) < blk_rq_cur_bytes(req)) {
 			blk_dump_rq_flags(req, "request botched");
 			req->__data_len = blk_rq_cur_bytes(req);
 		}
@@ -3341,9 +3356,10 @@ void blk_end_request_all(struct request *rq, blk_status_t error)
 	unsigned int bidi_bytes = 0;
 
 	if (unlikely(blk_bidi_rq(rq)))
-		bidi_bytes = blk_rq_bytes(rq->next_rq);
+		bidi_bytes = blk_rq_bio_bytes(rq->next_rq);
 
-	pending = blk_end_bidi_request(rq, error, blk_rq_bytes(rq), bidi_bytes);
+	pending = blk_end_bidi_request(rq, error, blk_rq_bio_bytes(rq),
+				       bidi_bytes);
 	BUG_ON(pending);
 }
 EXPORT_SYMBOL(blk_end_request_all);
@@ -3388,9 +3404,10 @@ void __blk_end_request_all(struct request *rq, blk_status_t error)
 	WARN_ON_ONCE(rq->q->mq_ops);
 
 	if (unlikely(blk_bidi_rq(rq)))
-		bidi_bytes = blk_rq_bytes(rq->next_rq);
+		bidi_bytes = blk_rq_bio_bytes(rq->next_rq);
 
-	pending = __blk_end_bidi_request(rq, error, blk_rq_bytes(rq), bidi_bytes);
+	pending = __blk_end_bidi_request(rq, error, blk_rq_bio_bytes(rq),
+					 bidi_bytes);
 	BUG_ON(pending);
 }
 EXPORT_SYMBOL(__blk_end_request_all);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8c00fcd300b9..852a87895b90 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -543,7 +543,7 @@ EXPORT_SYMBOL(__blk_mq_end_request);
 
 void blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	if (blk_update_request(rq, error, blk_rq_bytes(rq)))
+	if (blk_update_request(rq, error, blk_rq_bio_bytes(rq)))
 		BUG();
 	__blk_mq_end_request(rq, error);
 }
diff --git a/block/blk.h b/block/blk.h
index a8f0f7986cfd..37a31d992c83 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -149,6 +149,8 @@ static inline void blk_queue_enter_live(struct request_queue *q)
 	percpu_ref_get(&q->q_usage_counter);
 }
 
+unsigned int blk_rq_bio_bytes(const struct request *rq);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
-- 
2.17.1
