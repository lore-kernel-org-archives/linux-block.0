Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: Jens Axboe <axboe@kernel.dk>, Anchal Agarwal <anchalag@amzn.com>,
        "van der Linden, Frank" <fllinden@amazon.com>
Cc: "mlinux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <969389e7-b1bc-0559-6cc9-9461b034a24f@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8af76974-08b2-f4ef-91b9-7bd42291b8d9@oracle.com>
Date: Fri, 24 Aug 2018 13:55:58 +0800
MIME-Version: 1.0
In-Reply-To: <969389e7-b1bc-0559-6cc9-9461b034a24f@kernel.dk>
Content-Type: multipart/mixed;
 boundary="------------60947739C932B1E68CF44B25"
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.
--------------60947739C932B1E68CF44B25
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



On 08/24/2018 07:14 AM, Jens Axboe wrote:
> On 8/23/18 5:03 PM, Jens Axboe wrote:
>>> Hi Jens, This patch looks much cleaner for sure as Frank pointed out
>>> too. Basically this looks similar to wake_up_nr only making sure that
>>> those woken up requests won't get reordered. This does solves the
>>> thundering herd issue. However, I tested the patch against my
>>> application and lock contention numbers rose to around 10 times from
>>> what I had from your last 3 patches.  Again this did add to drop in
>>> of total files read by 0.12% and rate at which they were read by
>>> 0.02% but this is not a very significant drop. Is lock contention
>>> worth the tradeoff?  I also added missing
>>> __set_current_state(TASK_RUNNING) to the patch for testing.
>>
>> Can you try this variant? I don't think we need a
>> __set_current_state() after io_schedule(), should be fine as-is.
>>
>> I'm not surprised this will raise contention a bit, since we're now
>> waking N tasks potentially, if N can queue. With the initial change,
>> we'd always just wake one.  That is arguably incorrect. You say it's
>> 10 times higher contention, how does that compare to before your
>> patch?
>>
>> Is it possible to run something that looks like your workload?
> 
> Additionally, is the contention you are seeing the wait queue, or the
> atomic counter? When you say lock contention, I'm inclined to think it's
> the rqw->wait.lock.
> 

I guess the increased lock contend is due to:
when the wake up is ongoing with wait head lock is held, there is still waiter
on wait queue, and __wbt_wait will go to wait and try to require the wait head lock.
This is necessary to keep the order on the rqw->wait queue.

The attachment does following thing to try to avoid the scenario above.
"
Introduce wait queue rqw->delayed. Try to lock rqw->wait.lock firstly, if fails, add
the waiter on rqw->delayed. __wbt_done will pick the waiters on rqw->delayed up and
queue them on the tail of rqw->wait before it do wake up operation.
"

Thanks
Jianchao

--------------60947739C932B1E68CF44B25
Content-Type: text/x-patch;
 name="0001-blk-wbt-get-back-the-missed-wakeup-from-__wbt_done.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-blk-wbt-get-back-the-missed-wakeup-from-__wbt_done.patc";
 filename*1="h"

>From c410983b85d5624a9b4ff579240818dfaab2f5db Mon Sep 17 00:00:00 2001
From: Jianchao Wang <jianchao.w.wang@oracle.com>
Date: Fri, 24 Aug 2018 02:10:21 +0800
Subject: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done

2887e41 (blk-wbt: Avoid lock contention and thundering herd
issue in wbt_wait) introduces two cases that could miss wakeup:
 - __wbt_done only wakes up one waiter one time. There could be
   multiple waiters and (limit - inflight) > 1 at the moment.

 - When the waiter is waked up, it is still on wait queue and set
   to TASK_UNINTERRUPTIBLE immediately, so this waiter could be
   waked up one more time. If a __wbt_done comes and wakes up
   again, the prevous waiter may waste a wakeup.

To fix them, we introduce our own wake up func wbt_wake_function
in __wbt_wait and use wake_up_all in __wbt_done. wbt_wake_function
will try to get wbt budget firstly, if sucesses, wake up
the process, otherwise, return -1 to interrupt the wake up loop.

To prevent disorder on rqw->wait, __wbt_wait will firstly check
whether there is sleeper on it before try to get wbt budget, if
has sleeper, it will go to wait directly. Because the wake up
operations which holds rqw->wait.lock could take a relatively long
time, extra lock contention could be introduced when __wbt_wait try
to add itself on rqw->wait.

To avoid this, introduce wait queue rqw->delayed. We will try to
lock rqw->wait.lock firstly, if fails, add the waiter on
rqw->delayed. __wbt_done will pick the waiters on rqw->delayed up
and queue them on the tail of rqw->wait before it do wake up
operation.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Fixes: 2887e41 (blk-wbt: Avoid lock contention and thundering herd issue in wbt_wait)
Cc: Anchal Agarwal <anchalag@amazon.com>
Cc: Frank van der Linden <fllinden@amazon.com>
---
 block/blk-rq-qos.h |   2 +
 block/blk-wbt.c    | 130 ++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 105 insertions(+), 27 deletions(-)

diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 32b02ef..a6111eb 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,6 +14,7 @@ enum rq_qos_id {
 
 struct rq_wait {
 	wait_queue_head_t wait;
+	wait_queue_head_t delayed;
 	atomic_t inflight;
 };
 
@@ -70,6 +71,7 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
 	init_waitqueue_head(&rq_wait->wait);
+	init_waitqueue_head(&rq_wait->delayed);
 }
 
 static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index c9358f1..7fa61fe 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -111,6 +111,23 @@ static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb,
 	return &rwb->rq_wait[WBT_RWQ_BG];
 }
 
+static void wbt_check_delayed(struct rq_wait *rqw)
+{
+	unsigned long flags;
+
+	if (!wq_has_sleeper(&rqw->delayed))
+		return;
+	/*
+	 * Avoid to require wait->lock holding delayed->lock, that will
+	 * introduce undesire contending on delayed->lock.
+	 */
+	spin_lock_irqsave(&rqw->wait.lock, flags);
+	spin_lock(&rqw->delayed.lock);
+	list_splice_tail_init(&rqw->delayed.head, &rqw->wait.head);
+	spin_unlock(&rqw->delayed.lock);
+	spin_unlock_irqrestore(&rqw->wait.lock, flags);
+}
+
 static void rwb_wake_all(struct rq_wb *rwb)
 {
 	int i;
@@ -118,8 +135,11 @@ static void rwb_wake_all(struct rq_wb *rwb)
 	for (i = 0; i < WBT_NUM_RWQ; i++) {
 		struct rq_wait *rqw = &rwb->rq_wait[i];
 
-		if (wq_has_sleeper(&rqw->wait))
+		if (wq_has_sleeper(&rqw->wait) ||
+				waitqueue_active(&rqw->delayed)) {
+			wbt_check_delayed(rqw);
 			wake_up_all(&rqw->wait);
+		}
 	}
 }
 
@@ -162,11 +182,14 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
 	if (inflight && inflight >= limit)
 		return;
 
-	if (wq_has_sleeper(&rqw->wait)) {
+	if (wq_has_sleeper(&rqw->wait) ||
+			waitqueue_active(&rqw->delayed)) {
 		int diff = limit - inflight;
 
-		if (!inflight || diff >= rwb->wb_background / 2)
-			wake_up(&rqw->wait);
+		if (!inflight || diff >= rwb->wb_background / 2) {
+			wbt_check_delayed(rqw);
+			wake_up_all(&rqw->wait);
+		}
 	}
 }
 
@@ -481,6 +504,64 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	return limit;
 }
 
+struct wbt_wait_data {
+	struct task_struct *curr;
+	struct rq_wb *rwb;
+	struct rq_wait *rqw;
+	unsigned long rw;
+};
+
+static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
+		int wake_flags, void *key)
+{
+	struct wbt_wait_data *data = curr->private;
+
+	/*
+	 * If fail to get budget, return -1 to interrupt the wake up
+	 * loop in __wake_up_common.
+	 */
+	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
+		return -1;
+
+	wake_up_process(data->curr);
+
+	list_del_init(&curr->entry);
+	return 1;
+}
+
+static inline void wbt_init_wait(struct wait_queue_entry *wait,
+		struct wbt_wait_data *data)
+{
+	INIT_LIST_HEAD(&wait->entry);
+	wait->flags = 0;
+	wait->func = wbt_wake_function;
+	wait->private = data;
+}
+
+static void wbt_add_wait(struct rq_wait *rqw, struct wait_queue_entry *wq_entry)
+{
+	unsigned long flags;
+
+	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
+
+	if (spin_trylock_irqsave(&rqw->wait.lock, flags)) {
+		if (list_empty(&wq_entry->entry))
+			__add_wait_queue_entry_tail(&rqw->wait, wq_entry);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		spin_unlock_irqrestore(&rqw->wait.lock, flags);
+	} else {
+		/*
+		 * __wbt_done will pick the delayed waiters up and add them on
+		 * the tail of rqw->wait queue.
+		 */
+		spin_lock_irqsave(&rqw->delayed.lock, flags);
+		if (list_empty(&wq_entry->entry))
+			__add_wait_queue_entry_tail(&rqw->delayed, wq_entry);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		spin_unlock_irqrestore(&rqw->delayed.lock, flags);
+	}
+}
+
 /*
  * Block if we will exceed our limit, or if we are currently waiting for
  * the timer to kick off queuing again.
@@ -491,31 +572,26 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
-	DECLARE_WAITQUEUE(wait, current);
-	bool has_sleeper;
-
-	has_sleeper = wq_has_sleeper(&rqw->wait);
-	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
+	struct wait_queue_entry wait;
+	struct wbt_wait_data data = {
+		.curr = current,
+		.rwb = rwb,
+		.rqw = rqw,
+		.rw = rw,
+	};
+
+	if (!wq_has_sleeper(&rqw->wait) &&
+			rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
-	add_wait_queue_exclusive(&rqw->wait, &wait);
-	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-
-		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
-			break;
-
-		if (lock) {
-			spin_unlock_irq(lock);
-			io_schedule();
-			spin_lock_irq(lock);
-		} else
-			io_schedule();
-		has_sleeper = false;
-	} while (1);
-
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&rqw->wait, &wait);
+	wbt_init_wait(&wait, &data);
+	wbt_add_wait(rqw, &wait);
+	if (lock) {
+		spin_unlock_irq(lock);
+		io_schedule();
+		spin_lock_irq(lock);
+	} else
+		io_schedule();
 }
 
 static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
-- 
2.7.4


--------------60947739C932B1E68CF44B25--
