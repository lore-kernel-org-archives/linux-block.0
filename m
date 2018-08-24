Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
From: Jens Axboe <axboe@kernel.dk>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
 <d28bca3a-196d-1520-35cf-bec1e1872d34@oracle.com>
 <1f2d5ab0-2322-56b7-3544-3cf733a22dd8@kernel.dk>
Message-ID: <2f83f994-2734-17b2-3c74-b6869ba18184@kernel.dk>
Date: Fri, 24 Aug 2018 08:58:09 -0600
MIME-Version: 1.0
In-Reply-To: <1f2d5ab0-2322-56b7-3544-3cf733a22dd8@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/24/18 8:40 AM, Jens Axboe wrote:
> On 8/23/18 8:06 PM, jianchao.wang wrote:
>> Hi Jens
>>
>> On 08/23/2018 11:42 PM, Jens Axboe wrote:
>>>> -
>>>> -	__set_current_state(TASK_RUNNING);
>>>> -	remove_wait_queue(&rqw->wait, &wait);
>>>> +	wbt_init_wait(&wait, &data);
>>>> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
>>>> +			TASK_UNINTERRUPTIBLE);
>>>> +	if (lock) {
>>>> +		spin_unlock_irq(lock);
>>>> +		io_schedule();
>>>> +		spin_lock_irq(lock);
>>>> +	} else
>>>> +		io_schedule();
>>> Aren't we still missing a get-token attempt after adding to the
>>> waitqueue? For the case where someone frees the token after your initial
>>> check, but before you add yourself to the waitqueue.
>>
>> I used to think about this.
>> However, there is a very tricky scenario here:
>> We will try get the wbt budget in wbt_wake_function.
>> After add a task into the wait queue, wbt_wake_function has been able to
>> be invoked for this task. If we get the wbt budget after prepare_to_wait_exclusive,
>> we may get wbt budget twice.
> 
> Ah yes good point. But without it, you've got another race that will
> potentially put you to sleep forever.
> 
> How about something like the below? That should take care of both
> situations. Totally untested.

Slightly better/cleaner one below. Still totally untested.


diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 84507d3e9a98..bc13544943ff 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -123,16 +123,11 @@ static void rwb_wake_all(struct rq_wb *rwb)
 	}
 }
 
-static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
+static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
+			 enum wbt_flags wb_acct)
 {
-	struct rq_wb *rwb = RQWB(rqos);
-	struct rq_wait *rqw;
 	int inflight, limit;
 
-	if (!(wb_acct & WBT_TRACKED))
-		return;
-
-	rqw = get_rq_wait(rwb, wb_acct);
 	inflight = atomic_dec_return(&rqw->inflight);
 
 	/*
@@ -166,8 +161,21 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
 		int diff = limit - inflight;
 
 		if (!inflight || diff >= rwb->wb_background / 2)
-			wake_up(&rqw->wait);
+			wake_up_all(&rqw->wait);
 	}
+
+}
+
+static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
+{
+	struct rq_wb *rwb = RQWB(rqos);
+	struct rq_wait *rqw;
+
+	if (!(wb_acct & WBT_TRACKED))
+		return;
+
+	rqw = get_rq_wait(rwb, wb_acct);
+	wbt_rqw_done(rwb, rqw, wb_acct);
 }
 
 /*
@@ -481,6 +489,32 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	return limit;
 }
 
+struct wbt_wait_data {
+	struct task_struct *curr;
+	struct rq_wb *rwb;
+	struct rq_wait *rqw;
+	unsigned long rw;
+	bool got_token;
+};
+
+static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
+			     int wake_flags, void *key)
+{
+	struct wbt_wait_data *data = curr->private;
+
+	/*
+	 * If we fail to get a budget, return -1 to interrupt the wake up
+	 * loop in __wake_up_common.
+	 */
+	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
+		return -1;
+
+	data->got_token = true;
+	wake_up_process(data->curr);
+	list_del_init(&curr->entry);
+	return 1;
+}
+
 /*
  * Block if we will exceed our limit, or if we are currently waiting for
  * the timer to kick off queuing again.
@@ -491,31 +525,44 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
-	DECLARE_WAITQUEUE(wait, current);
+	struct wbt_wait_data data = {
+		.curr = current,
+		.rwb = rwb,
+		.rqw = rqw,
+		.rw = rw,
+	};
+	struct wait_queue_entry wait = {
+		.func		= wbt_wake_function,
+		.private	= &data,
+		.entry		= LIST_HEAD_INIT(wait.entry),
+	};
 	bool has_sleeper;
 
 	has_sleeper = wq_has_sleeper(&rqw->wait);
 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
-	add_wait_queue_exclusive(&rqw->wait, &wait);
-	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+	prepare_to_wait_exclusive(&rqw->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
-			break;
+	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
+		finish_wait(&rqw->wait, &wait);
 
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
+		/*
+		 * We raced with wbt_wake_function() getting a token, which
+		 * means we now have two. Put ours and wake anyone else
+		 * potentially waiting for one.
+		 */
+		if (data.got_token)
+			wbt_rqw_done(rwb, rqw, wb_acct);
+		return;
+	}
+
+	if (lock) {
+		spin_unlock_irq(lock);
+		io_schedule();
+		spin_lock_irq(lock);
+	} else
+		io_schedule();
 }
 
 static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)

-- 
Jens Axboe
