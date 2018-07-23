Return-Path: <prvs=735483b7d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Roman Pen <roman.penyaev@profitbricks.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Jack Wang <jack.wang.usish@gmail.com>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH] blk-mq: Avoid that a request queue stalls when restarting a shared hctx
Date: Mon, 23 Jul 2018 08:50:38 -0700
Message-Id: <20180723155038.22062-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

From: Roman Pen <roman.penyaev@profitbricks.com>

The patch below fixes queue stalling when shared hctx marked for restart
(BLK_MQ_S_SCHED_RESTART bit) but q->shared_hctx_restart stays zero.  The
root cause is that hctxs are shared between queues, but 'shared_hctx_restart'
belongs to the particular queue, which in fact may not need to be restarted,
thus we return from blk_mq_sched_restart() and leave shared hctx of another
queue never restarted.

The fix is to make shared_hctx_restart counter belong not to the queue, but
to tags, thereby counter will reflect real number of shared hctx needed to
be restarted.

During tests 1 hctx (set->nr_hw_queues) was used and all stalled requests
were noticed in dd->fifo_list of mq-deadline scheduler.

Seeming possible sequence of events:

1. Request A of queue A is inserted into dd->fifo_list of the scheduler.

2. Request B of queue A bypasses scheduler and goes directly to
   hctx->dispatch.

3. Request C of queue B is inserted.

4. blk_mq_sched_dispatch_requests() is invoked, since hctx->dispatch is not
   empty (request B is in the list) hctx is only marked for for next restart
   and request A is left in a list (see comment "So it's best to leave them
   there for as long as we can. Mark the hw queue as needing a restart in
   that case." in blk-mq-sched.c)

5. Eventually request B is completed/freed and blk_mq_sched_restart() is
   called, but by chance hctx from queue B is chosen for restart and request C
   gets a chance to be dispatched.

6. Eventually request C is completed/freed and blk_mq_sched_restart() is
   called, but shared_hctx_restart for queue B is zero and we return without
   attempt to restart hctx from queue A, thus request A is stuck forever.

But stalling queue is not the only one problem with blk_mq_sched_restart().
My tests show that those loops thru all queues and hctxs can be very costly,
even with shared_hctx_restart counter, which aims to fix performance issue.
For my tests I create 128 devices with 64 hctx each, which share same tags
set.

The following is the fio and ftrace output for v4.14-rc4 kernel:

 READ: io=5630.3MB, aggrb=573208KB/s, minb=573208KB/s, maxb=573208KB/s, mint=10058msec, maxt=10058msec
WRITE: io=5650.9MB, aggrb=575312KB/s, minb=575312KB/s, maxb=575312KB/s, mint=10058msec, maxt=10058msec

root@pserver16:~/roman# cat /sys/kernel/debug/tracing/trace_stat/* | grep blk_mq
  Function                  Hit     Time            Avg             s^2
  --------                  ---     ----            ---             ---
  blk_mq_sched_restart     16347    9540759 us      583.639 us      8804801 us
  blk_mq_sched_restart      7884    6073471 us      770.354 us      8780054 us
  blk_mq_sched_restart     14176    7586794 us      535.185 us      2822731 us
  blk_mq_sched_restart      7843    6205435 us      791.206 us      12424960 us
  blk_mq_sched_restart      1490    4786107 us      3212.153 us     1949753 us
  blk_mq_sched_restart      7892    6039311 us      765.244 us      2994627 us
  blk_mq_sched_restart     15382    7511126 us      488.306 us      3090912 us
  [cut]

And here are results with two patches reverted:
   8e8320c9315c ("blk-mq: fix performance regression with shared tags")
   6d8c6c0f97ad ("blk-mq: Restart a single queue if tag sets are shared")

 READ: io=12884MB, aggrb=1284.3MB/s, minb=1284.3MB/s, maxb=1284.3MB/s, mint=10032msec, maxt=10032msec
WRITE: io=12987MB, aggrb=1294.6MB/s, minb=1294.6MB/s, maxb=1294.6MB/s, mint=10032msec, maxt=10032msec

root@pserver16:~/roman# cat /sys/kernel/debug/tracing/trace_stat/* | grep blk_mq
  Function                  Hit      Time            Avg             s^2
  --------                  ---      ----            ---             ---
  blk_mq_sched_restart      50699    8802.349 us     0.173 us        121.771 us
  blk_mq_sched_restart      50362    8740.470 us     0.173 us        161.494 us
  blk_mq_sched_restart      50402    9066.337 us     0.179 us        113.009 us
  blk_mq_sched_restart      50104    9366.197 us     0.186 us        188.645 us
  blk_mq_sched_restart      50375    9317.727 us     0.184 us        54.218 us
  blk_mq_sched_restart      50136    9311.657 us     0.185 us        446.790 us
  blk_mq_sched_restart      50103    9179.625 us     0.183 us        114.472 us
  [cut]

Timings and stdevs are terrible, which leads to significant difference:
570MB/s vs 1280MB/s.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jack Wang <jack.wang.usish@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
[ bvanassche: modified patch title, description and Cc-list ]
---
 block/blk-mq-sched.c   | 10 ++++------
 block/blk-mq-tag.c     |  1 +
 block/blk-mq-tag.h     |  1 +
 block/blk-mq.c         |  4 ++--
 include/linux/blkdev.h |  2 --
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 56c493c6cd90..d863b1b32b07 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -60,10 +60,10 @@ static void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 		return;
 
 	if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
-		struct request_queue *q = hctx->queue;
+		struct blk_mq_tags *tags = hctx->tags;
 
 		if (!test_and_set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-			atomic_inc(&q->shared_hctx_restart);
+			atomic_inc(&tags->shared_hctx_restart);
 	} else
 		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 }
@@ -74,10 +74,8 @@ static bool blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
 		return false;
 
 	if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
-		struct request_queue *q = hctx->queue;
-
 		if (test_and_clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-			atomic_dec(&q->shared_hctx_restart);
+			atomic_dec(&hctx->tags->shared_hctx_restart);
 	} else
 		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 
@@ -415,7 +413,7 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *const hctx)
 		 * If this is 0, then we know that no hardware queues
 		 * have RESTART marked. We're done.
 		 */
-		if (!atomic_read(&queue->shared_hctx_restart))
+		if (!atomic_read(&tags->shared_hctx_restart))
 			return;
 
 		rcu_read_lock();
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 09b2ee6694fb..82cd73631adc 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -379,6 +379,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	atomic_set(&tags->shared_hctx_restart, 0);
 
 	return blk_mq_init_bitmap_tags(tags, node, alloc_policy);
 }
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..477a9d67fb3d 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -12,6 +12,7 @@ struct blk_mq_tags {
 	unsigned int nr_reserved_tags;
 
 	atomic_t active_queues;
+	atomic_t shared_hctx_restart;
 
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d394cdd8d8c6..a0fdf80db8fd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2335,11 +2335,11 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (shared) {
 			if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-				atomic_inc(&q->shared_hctx_restart);
+				atomic_inc(&hctx->tags->shared_hctx_restart);
 			hctx->flags |= BLK_MQ_F_TAG_SHARED;
 		} else {
 			if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-				atomic_dec(&q->shared_hctx_restart);
+				atomic_dec(&hctx->tags->shared_hctx_restart);
 			hctx->flags &= ~BLK_MQ_F_TAG_SHARED;
 		}
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 79226ca8f80f..62b20da653ca 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -442,8 +442,6 @@ struct request_queue {
 	int			nr_rqs[2];	/* # allocated [a]sync rqs */
 	int			nr_rqs_elvpriv;	/* # allocated rqs w/ elvpriv */
 
-	atomic_t		shared_hctx_restart;
-
 	struct blk_queue_stats	*stats;
 	struct rq_wb		*rq_wb;
 
-- 
2.18.0
