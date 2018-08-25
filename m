Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
From: Jens Axboe <axboe@kernel.dk>
To: Anchal Agarwal <anchalag@amzn.com>
Cc: fllinden@amazon.com, Jianchao Wang <jianchao.w.wang@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
 <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
Message-ID: <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
Date: Sat, 25 Aug 2018 09:41:10 -0600
MIME-Version: 1.0
In-Reply-To: <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/24/18 2:41 PM, Jens Axboe wrote:
> On 8/24/18 2:33 PM, Anchal Agarwal wrote:
>> On Fri, Aug 24, 2018 at 12:50:44PM -0600, Jens Axboe wrote:
>>> On 8/24/18 12:12 PM, Anchal Agarwal wrote:
>>>> That's totally fair. As compared to before the patch it was way too high
>>>> and my test case wasn't even running due to the thunderign herd issues and
>>>> queue re-ordering. Anyways as I also mentioned before 10 times 
>>>> contention is not too bad since its not really affecting much the number of
>>>> files read in my applciation. Also, you are right waking up N tasks seems 
>>>> plausible. 
>>>
>>> OK, I'm going to take that as a positive response. I'm going to propose
>>> the last patch as the final addition in this round, since it does fix a
>>> gap in the previous. And I do think that we need to wake as many tasks
>>> as can make progress, otherwise we're deliberately running the device at
>>> a lower load than we should.
>>>
>>>> My application is somewhat similar to database workload. It does uses fsync 
>>>> internally also. So what it does is it creates files of random sizes with 
>>>> random contents. It stores the hash of those files in memory. During the 
>>>> test it reads those files back from storage and checks their hashes. 
>>>
>>> How many tasks are running for your test?
>>>
>>> -- 
>>> Jens Axboe
>>>
>>>
>>
>> So there are 128 Concurrent reads/writes happening. Max files written before
>> reads start is 16384 and each file is of size 512KB. Does that answer your
>> question?
> 
> Yes it does, thanks. That's not a crazy amount of tasks or threads.
> 
>> BTW, I still have to test the last patch you send but by looking at the patch 
>> I assumed it will work anyways!
> 
> Thanks for the vote of confidence, I'd appreciate if you would give it a
> whirl. Your workload seems nastier than what I test with, so would be
> great to have someone else test it too.

This is what I have come up with, this actually survives some torture
testing. We do need to have the wait as a loop, since we can't rely on
just being woken from the ->func handler we set. It also handles the
prep token get race.


diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 84507d3e9a98..2442b2b141b8 100644
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
@@ -481,6 +489,33 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	return limit;
 }
 
+struct wbt_wait_data {
+	struct wait_queue_entry wq;
+	struct task_struct *curr;
+	struct rq_wb *rwb;
+	struct rq_wait *rqw;
+	unsigned long rw;
+	unsigned long flags;
+};
+
+static int wbt_wake_function(struct wait_queue_entry *curr, unsigned int mode,
+			     int wake_flags, void *key)
+{
+	struct wbt_wait_data *data = container_of(curr, struct wbt_wait_data, wq);
+
+	/*
+	 * If we fail to get a budget, return -1 to interrupt the wake up
+	 * loop in __wake_up_common.
+	 */
+	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
+		return -1;
+
+	set_bit(0, &data->flags);
+	wake_up_process(data->curr);
+	list_del_init(&curr->entry);
+	return 1;
+}
+
 /*
  * Block if we will exceed our limit, or if we are currently waiting for
  * the timer to kick off queuing again.
@@ -491,19 +526,42 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
-	DECLARE_WAITQUEUE(wait, current);
+	struct wbt_wait_data data = {
+		.wq = {
+			.func	= wbt_wake_function,
+			.entry	= LIST_HEAD_INIT(data.wq.entry),
+		},
+		.curr = current,
+		.rwb = rwb,
+		.rqw = rqw,
+		.rw = rw,
+	};
 	bool has_sleeper;
 
 	has_sleeper = wq_has_sleeper(&rqw->wait);
 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
-	add_wait_queue_exclusive(&rqw->wait, &wait);
+	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (test_bit(0, &data.flags))
+			break;
 
-		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
+		WARN_ON_ONCE(list_empty(&data.wq.entry));
+
+		if (!has_sleeper &&
+		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
+			finish_wait(&rqw->wait, &data.wq);
+
+			/*
+			 * We raced with wbt_wake_function() getting a token,
+			 * which means we now have two. Put ours and wake
+			 * anyone else potentially waiting for one.
+			 */
+			if (test_bit(0, &data.flags))
+				wbt_rqw_done(rwb, rqw, wb_acct);
 			break;
+		}
 
 		if (lock) {
 			spin_unlock_irq(lock);
@@ -511,11 +569,11 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 			spin_lock_irq(lock);
 		} else
 			io_schedule();
+
 		has_sleeper = false;
 	} while (1);
 
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&rqw->wait, &wait);
+	finish_wait(&rqw->wait, &data.wq);
 }
 
 static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)

-- 
Jens Axboe
