Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: fix indefinite background writeback sleep
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0fa9cc9f-7d34-2490-cdaf-fe7a761e4790@kernel.dk>
 <20180622224301.GD2949@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <052ecf61-d38b-5750-0cb0-a40ad60c33ce@kernel.dk>
Date: Fri, 22 Jun 2018 16:51:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180622224301.GD2949@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/22/18 4:43 PM, Ming Lei wrote:
> On Fri, Jun 22, 2018 at 01:26:10PM -0600, Jens Axboe wrote:
>> blk-wbt adds waiters to the tail of the waitqueue, and factors in the
>> task placement in its decision making on whether or not the current task
>> can proceed. This can cause issues for the lowest class of writers,
>> since they can get woken up, denied access, and then put back to sleep
>> at the end of the waitqueue.
>>
>> Fix this so that we only utilize the tail add for the initial sleep, and
>> we don't factor in the wait queue placement after we've slept (and are
>> now using the head addition).
>>
>> Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index 4f89b28fa652..7beeabd05f4a 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -550,7 +550,7 @@ static inline bool may_queue(struct rq_wb *rwb, struct rq_wait *rqw,
>>  	 * If the waitqueue is already active and we are not the next
>>  	 * in line to be woken up, wait for our turn.
>>  	 */
>> -	if (waitqueue_active(&rqw->wait) &&
>> +	if (wait && waitqueue_active(&rqw->wait) &&
>>  	    rqw->wait.head.next != &wait->entry)
>>  		return false;
>>  
>> @@ -567,16 +567,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>>  	__acquires(lock)
>>  {
>>  	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
>> +	struct wait_queue_entry *waitptr = NULL;
>>  	DEFINE_WAIT(wait);
>>  
>> -	if (may_queue(rwb, rqw, &wait, rw))
>> +	if (may_queue(rwb, rqw, waitptr, rw))
>>  		return;
>>  
>> +	waitptr = &wait;
>>  	do {
>> -		prepare_to_wait_exclusive(&rqw->wait, &wait,
>> +		/*
>> +		 * Don't add ourselves to the wq tail if we've already
>> +		 * slept. Otherwise we can penalize background writes
>> +		 * indefinitely.
>> +		 */
> 
> I saw this indefinite wbt_wait() in systemd-journal when running
> aio-stress read test, but just once, not figured out one approach
> to reproduce it yet, just wondering if you have quick test case for
> reproducing and verifying this issue.

I've seen it in production, but I'm currently relying on someone else
to reproduce it synthetically. I'm just providing the patches for
testing.

>> +		if (waitptr)
>> +			prepare_to_wait_exclusive(&rqw->wait, &wait,
>> +							TASK_UNINTERRUPTIBLE);
>> +		else
>> +			prepare_to_wait(&rqw->wait, &wait,
>>  						TASK_UNINTERRUPTIBLE);
> 
> Could you explain a bit why the 'wait_entry' order matters wrt. this
> issue? Since other 'wait_entry' still may come at the head meantime to
> the same wq before checking in may_queue().

Let's say we have 10 tasks queued up. Each one gets added to the tail,
so when it's our turn, we've now reached the head. We fail to get a
queue token, so we go back to sleep. At that point we should add
back to the head, not the tail, for fairness purposes.

> Can we remove 'rqw->wait.head.next != &wait->entry' from may_queue()?
> I guess that should be one optimization, but seems quite dangerous since
> 'rqw->wait.head.next' may point to one freed stack variable.

I actually changed it somewhat, since the initial check wasn't great
still. See below. It doesn't matter if the contents are stale, we aren't
going to dereference them anyway.

commit e68d8e22a8b9712c47ead489394f75e9df5a02d1
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Jun 22 13:44:22 2018 -0600

    blk-wbt: fix indefinite background writeback sleep
    
    blk-wbt adds waiters to the tail of the waitqueue, and factors in the
    task placement in its decision making on whether or not the current task
    can proceed. This can cause issues for the lowest class of writers,
    since they can get woken up, denied access, and then put back to sleep
    at the end of the waitqueue.
    
    Fix this so that we only utilize the tail add for the initial sleep, and
    we don't factor in the wait queue placement after we've slept (and are
    now using the head addition).
    
    Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 4f89b28fa652..41607c0bd849 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -550,8 +550,7 @@ static inline bool may_queue(struct rq_wb *rwb, struct rq_wait *rqw,
 	 * If the waitqueue is already active and we are not the next
 	 * in line to be woken up, wait for our turn.
 	 */
-	if (waitqueue_active(&rqw->wait) &&
-	    rqw->wait.head.next != &wait->entry)
+	if (wait && rqw->wait.head.next != &wait->entry)
 		return false;
 
 	return atomic_inc_below(&rqw->inflight, get_limit(rwb, rw));
@@ -567,16 +566,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
+	struct wait_queue_entry *waitptr = NULL;
 	DEFINE_WAIT(wait);
 
-	if (may_queue(rwb, rqw, &wait, rw))
+	if (!waitqueue_active(&rqw->wait) && may_queue(rwb, rqw, waitptr, rw))
 		return;
 
+	waitptr = &wait;
 	do {
-		prepare_to_wait_exclusive(&rqw->wait, &wait,
+		/*
+		 * Don't add ourselves to the wq tail if we've already
+		 * slept. Otherwise we can penalize background writes
+		 * indefinitely.
+		 */
+		if (waitptr)
+			prepare_to_wait_exclusive(&rqw->wait, &wait,
+							TASK_UNINTERRUPTIBLE);
+		else
+			prepare_to_wait(&rqw->wait, &wait,
 						TASK_UNINTERRUPTIBLE);
 
-		if (may_queue(rwb, rqw, &wait, rw))
+		if (may_queue(rwb, rqw, waitptr, rw))
 			break;
 
 		if (lock) {
@@ -585,6 +595,12 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 			spin_lock_irq(lock);
 		} else
 			io_schedule();
+
+		/*
+		 * After we've slept, we don't want to factor in wq head
+		 * placement anymore for may_queue().
+		 */
+		waitptr = NULL;
 	} while (1);
 
 	finish_wait(&rqw->wait, &wait);

-- 
Jens Axboe
