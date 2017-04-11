Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Mike Snitzer <snitzer@redhat.com>, Ming Lei
	<tom.leiming@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH] blk-mq: Fix blk_execute_rq_nowait() handling of dying queues
Date: Tue, 11 Apr 2017 16:58:48 -0700
Message-ID: <20170411235848.8686-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Although blk_execute_rq_nowait() asks blk_mq_sched_insert_request()
to run the queue, the function that should run the queue
(__blk_mq_delay_run_hw_queue()) skips hardware queues for which
.tags == NULL. Since blk_mq_free_tag_set() clears .tags this means
if blk_execute_rq_nowait() is called after the tag set has been
freed that the request that has been queued will never be executed.
In my tests I noticed that every now and then an SG_IO request that
got queued by multipathd on a dm device did not get executed. This
resulted in either a memory leak complaint about the SG_IO code or
the dm device becoming unremovable with e.g. the following state:

$ grep busy= /sys/kernel/debug/block/dm*/mq/*
/sys/kernel/debug/block/dm-0/mq/state:SAME_COMP STACKABLE IO_STAT INIT_DONE POLL REGISTERED, pg_init_in_progress=0, nr_valid_paths=4, flags= RETAIN_ATTACHED_HW_HANDLER, paths: [0:0] active=1 busy=0 dying dead [1:0] active=1 busy=0 dying dead [2:0] active=1 busy=0 dying dead [3:0] active=1 busy=0 dying dead
$ multipath -ll
mpathu (3600140572616d6469736b32000000000) dm-0 ##,##
size=984M features='3 retain_attached_hw_handler queue_mode mq' hwhandler='1 alua' wp=rw
|-+- policy='service-time 0' prio=0 status=active
|-+- policy='service-time 0' prio=0 status=undef
|-+- policy='service-time 0' prio=0 status=undef
`-+- policy='service-time 0' prio=0 status=undef

Avoid that blk_execute_rq_nowait() is called to queue a request
onto a dying queue by changing the blk_freeze_queue_start() call
in blk_set_queue_dying() into a blk_freeze_queue() call.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: <stable@vger.kernel.org>
---
 block/blk-core.c | 9 +++++----
 block/blk-exec.c | 7 +++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8654aa0cef6d..21314b995887 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -501,11 +501,12 @@ void blk_set_queue_dying(struct request_queue *q)
 	spin_unlock_irq(q->queue_lock);
 
 	/*
-	 * When queue DYING flag is set, we need to block new req
-	 * entering queue, so we call blk_freeze_queue_start() to
-	 * prevent I/O from crossing blk_queue_enter().
+	 * When queue DYING flag is set, we need to block new requests
+	 * from being queued. Hence call blk_freeze_queue() to make
+	 * new blk_queue_enter() calls fail and to wait until all pending
+	 * I/O has finished.
 	 */
-	blk_freeze_queue_start(q);
+	blk_freeze_queue(q);
 
 	if (q->mq_ops)
 		blk_mq_wake_waiters(q);
diff --git a/block/blk-exec.c b/block/blk-exec.c
index 8cd0e9bc8dc8..f7d9bed2cb15 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -57,10 +57,13 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	rq->end_io = done;
 
 	/*
-	 * don't check dying flag for MQ because the request won't
-	 * be reused after dying flag is set
+	 * The blk_freeze_queue() call in blk_set_queue_dying() and the
+	 * test of the "dying" flag in blk_queue_enter() guarantee that
+	 * blk_execute_rq_nowait() won't be called anymore after the "dying"
+	 * flag has been set.
 	 */
 	if (q->mq_ops) {
+		WARN_ON_ONCE(blk_queue_dying(q));
 		blk_mq_sched_insert_request(rq, at_head, true, false, false);
 		return;
 	}
-- 
2.12.2
