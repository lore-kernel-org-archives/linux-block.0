Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] block: Shorten interrupt disabled regions
Date: Fri,  4 May 2018 16:32:47 +0200
Message-Id: <20180504143247.5240-3-bigeasy@linutronix.de>
In-Reply-To: <20180504143247.5240-1-bigeasy@linutronix.de>
References: <20180504143247.5240-1-bigeasy@linutronix.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Commit 9c40cef2b799 ("sched: Move blk_schedule_flush_plug() out of
__schedule()") moved the blk_schedule_flush_plug() call out of the
interrupt/preempt disabled region in the scheduler. This allows to replace
local_irq_save/restore(flags) by local_irq_disable/enable() in
blk_flush_plug_list().

But it makes more sense to disable interrupts explicitly when the request
queue is locked end reenable them when the request to is unlocked. This
shortens the interrupt disabled section which is important when the plug
list contains requests for more than one queue. The comment which claims
that disabling interrupts around the loop is misleading as the called
functions can reenable interrupts unconditionally anyway and obfuscates the
scope badly:

 local_irq_save(flags);
   spin_lock(q->queue_lock);
   ...
   queue_unplugged(q...);
     scsi_request_fn();
       spin_unlock_irq(q->queue_lock);

-------------------^^^ ????

       spin_lock_irq(q->queue_lock);
     spin_unlock(q->queue_lock);
 local_irq_restore(flags);

Aside of that the detached interrupt disabling is a constant pain for
PREEMPT_RT as it requires patching and special casing when RT is enabled
while with the spin_*_irq() variants this happens automatically.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: http://lkml.kernel.org/r/20110622174919.025446432@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a3caccaa7d1f..0573f9226c2d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3629,7 +3629,7 @@ static void queue_unplugged(struct request_queue *q, =
unsigned int depth,
 		blk_run_queue_async(q);
 	else
 		__blk_run_queue(q);
-	spin_unlock(q->queue_lock);
+	spin_unlock_irq(q->queue_lock);
 }
=20
 static void flush_plug_callbacks(struct blk_plug *plug, bool from_schedule)
@@ -3677,7 +3677,6 @@ EXPORT_SYMBOL(blk_check_plugged);
 void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct request_queue *q;
-	unsigned long flags;
 	struct request *rq;
 	LIST_HEAD(list);
 	unsigned int depth;
@@ -3697,11 +3696,6 @@ void blk_flush_plug_list(struct blk_plug *plug, bool=
 from_schedule)
 	q =3D NULL;
 	depth =3D 0;
=20
-	/*
-	 * Save and disable interrupts here, to avoid doing it for every
-	 * queue lock we have to take.
-	 */
-	local_irq_save(flags);
 	while (!list_empty(&list)) {
 		rq =3D list_entry_rq(list.next);
 		list_del_init(&rq->queuelist);
@@ -3714,7 +3708,7 @@ void blk_flush_plug_list(struct blk_plug *plug, bool =
from_schedule)
 				queue_unplugged(q, depth, from_schedule);
 			q =3D rq->q;
 			depth =3D 0;
-			spin_lock(q->queue_lock);
+			spin_lock_irq(q->queue_lock);
 		}
=20
 		/*
@@ -3741,8 +3735,6 @@ void blk_flush_plug_list(struct blk_plug *plug, bool =
from_schedule)
 	 */
 	if (q)
 		queue_unplugged(q, depth, from_schedule);
-
-	local_irq_restore(flags);
 }
=20
 void blk_finish_plug(struct blk_plug *plug)
--=20
2.17.0
