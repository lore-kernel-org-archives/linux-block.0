Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45773 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937518AbdJRKW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 06:22:27 -0400
Received: by mail-wr0-f182.google.com with SMTP id k7so4451922wre.2
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2017 03:22:26 -0700 (PDT)
From: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/1] [RFC] blk-mq: fix queue stalling on shared hctx restart
Date: Wed, 18 Oct 2017 12:22:06 +0200
Message-Id: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

the patch below fixes queue stalling when shared hctx marked for restart
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

This is RFC since current patch fixes queue stalling but performance issue
still remains and for me is not clear is it better to improve commit
6d8c6c0f97ad ("blk-mq: Restart a single queue if tag sets are shared")
making percpu restart lists (to avoid looping and to dequeue hctx immediately)
or revert it (frankly I did not notice any difference on small number of
devices and hctxs, when looping issue does not impact much).

--
Roman

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-sched.c   | 10 +++++-----
 block/blk-mq-tag.c     |  1 +
 block/blk-mq-tag.h     |  1 +
 block/blk-mq.c         |  4 ++--
 include/linux/blkdev.h |  2 --
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4ab69435708c..a19a7f275173 100644
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
@@ -74,10 +74,10 @@ static bool blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
 		return false;
 
 	if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
-		struct request_queue *q = hctx->queue;
+		struct blk_mq_tags *tags = hctx->tags;
 
 		if (test_and_clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-			atomic_dec(&q->shared_hctx_restart);
+			atomic_dec(&tags->shared_hctx_restart);
 	} else
 		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 
@@ -312,7 +312,7 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *const hctx)
 		 * If this is 0, then we know that no hardware queues
 		 * have RESTART marked. We're done.
 		 */
-		if (!atomic_read(&queue->shared_hctx_restart))
+		if (!atomic_read(&tags->shared_hctx_restart))
 			return;
 
 		rcu_read_lock();
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d0be72ccb091..598f8e0095ff 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -385,6 +385,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	atomic_set(&tags->shared_hctx_restart, 0);
 
 	return blk_mq_init_bitmap_tags(tags, node, alloc_policy);
 }
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 5cb51e53cc03..adf05c8811cd 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -11,6 +11,7 @@ struct blk_mq_tags {
 	unsigned int nr_reserved_tags;
 
 	atomic_t active_queues;
+	atomic_t shared_hctx_restart;
 
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4603b115e234..7639f978ea2c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2120,11 +2120,11 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
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
index 2a5d52fa90f5..3852a9ea87d0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -393,8 +393,6 @@ struct request_queue {
 	int			nr_rqs[2];	/* # allocated [a]sync rqs */
 	int			nr_rqs_elvpriv;	/* # allocated rqs w/ elvpriv */
 
-	atomic_t		shared_hctx_restart;
-
 	struct blk_queue_stats	*stats;
 	struct rq_wb		*rq_wb;
 
-- 
2.13.1
