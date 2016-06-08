Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>,
	Jan Kara <jack@suse.com>
Subject: [PATCH 3/3] cfq-iosched: Convert to use highres timers
Date: Wed,  8 Jun 2016 15:11:39 +0200
Message-Id: <1465391499-27867-4-git-send-email-jack@suse.cz>
In-Reply-To: <1465391499-27867-1-git-send-email-jack@suse.cz>
References: <1465391499-27867-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

From: Jan Kara <jack@suse.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Jan Kara <jack@suse.com>
---
 block/cfq-iosched.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index afba86813f2a..dab606852e24 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -362,7 +362,7 @@ struct cfq_data {
 	/*
 	 * idle window management
 	 */
-	struct timer_list idle_slice_timer;
+	struct hrtimer idle_slice_timer;
 	struct work_struct unplug_work;
 
 	struct cfq_queue *active_queue;
@@ -2619,7 +2619,7 @@ static int cfq_allow_merge(struct request_queue *q, struct request *rq,
 
 static inline void cfq_del_timer(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
-	del_timer(&cfqd->idle_slice_timer);
+	hrtimer_try_to_cancel(&cfqd->idle_slice_timer);
 	cfqg_stats_update_idle_time(cfqq->cfqg);
 }
 
@@ -2981,7 +2981,8 @@ static void cfq_arm_slice_timer(struct cfq_data *cfqd)
 	else
 		sl = cfqd->cfq_slice_idle;
 
-	mod_timer(&cfqd->idle_slice_timer, now + sl);
+	hrtimer_start(&cfqd->idle_slice_timer, ns_to_ktime(sl),
+		      HRTIMER_MODE_REL);
 	cfqg_stats_set_start_idle_time(cfqq->cfqg);
 	cfq_log_cfqq(cfqd, cfqq, "arm_idle: %llu group_idle: %d", sl,
 			group_idle ? 1 : 0);
@@ -3300,7 +3301,7 @@ static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
 	 * flight or is idling for a new request, allow either of these
 	 * conditions to happen (or time out) before selecting a new queue.
 	 */
-	if (timer_pending(&cfqd->idle_slice_timer)) {
+	if (hrtimer_active(&cfqd->idle_slice_timer)) {
 		cfqq = NULL;
 		goto keep_queue;
 	}
@@ -4445,9 +4446,10 @@ static void cfq_kick_queue(struct work_struct *work)
 /*
  * Timer running if the active_queue is currently idling inside its time slice
  */
-static void cfq_idle_slice_timer(unsigned long data)
+static enum hrtimer_restart cfq_idle_slice_timer(struct hrtimer *timer)
 {
-	struct cfq_data *cfqd = (struct cfq_data *) data;
+	struct cfq_data *cfqd = container_of(timer, struct cfq_data,
+					     idle_slice_timer);
 	struct cfq_queue *cfqq;
 	unsigned long flags;
 	int timed_out = 1;
@@ -4496,11 +4498,12 @@ out_kick:
 	cfq_schedule_dispatch(cfqd);
 out_cont:
 	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
+	return HRTIMER_NORESTART;
 }
 
 static void cfq_shutdown_timer_wq(struct cfq_data *cfqd)
 {
-	del_timer_sync(&cfqd->idle_slice_timer);
+	hrtimer_cancel(&cfqd->idle_slice_timer);
 	cancel_work_sync(&cfqd->unplug_work);
 }
 
@@ -4596,9 +4599,9 @@ static int cfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	cfqg_put(cfqd->root_group);
 	spin_unlock_irq(q->queue_lock);
 
-	init_timer(&cfqd->idle_slice_timer);
+	hrtimer_init(&cfqd->idle_slice_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
 	cfqd->idle_slice_timer.function = cfq_idle_slice_timer;
-	cfqd->idle_slice_timer.data = (unsigned long) cfqd;
 
 	INIT_WORK(&cfqd->unplug_work, cfq_kick_queue);
 
-- 
2.6.6
