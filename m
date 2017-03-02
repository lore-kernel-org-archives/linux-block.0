Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755006AbdCBSRW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Mar 2017 13:17:22 -0500
Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
To: Paolo Valente <paolo.valente@linaro.org>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
 <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org>
 <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com>
 <9fe1b3a9-2a80-8891-1044-f83558e28d15@fb.com>
 <1720FEB5-FBBA-4EAA-8292-E820AA15389D@linaro.org>
 <dc4dc011-7038-2c05-b1c0-f6f7a07fa9ae@fb.com>
 <80de4554-a14b-4ce6-7c6e-ec66f70b14b1@fb.com>
 <6C03BF2A-0902-431A-A545-933F56D3E134@linaro.org>
CC: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <75978d1d-8022-75c2-7799-aa65132fdcdd@fb.com>
Date: Thu, 2 Mar 2017 09:13:30 -0700
MIME-Version: 1.0
In-Reply-To: <6C03BF2A-0902-431A-A545-933F56D3E134@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/02/2017 09:07 AM, Paolo Valente wrote:
> 
>> Il giorno 02 mar 2017, alle ore 16:13, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> On 03/02/2017 08:00 AM, Jens Axboe wrote:
>>> On 03/02/2017 03:28 AM, Paolo Valente wrote:
>>>>
>>>>> Il giorno 15 feb 2017, alle ore 19:04, Jens Axboe <axboe@fb.com> ha scritto:
>>>>>
>>>>> On 02/15/2017 10:58 AM, Jens Axboe wrote:
>>>>>> On 02/15/2017 10:24 AM, Paolo Valente wrote:
>>>>>>>
>>>>>>>> Il giorno 10 feb 2017, alle ore 19:32, Omar Sandoval <osandov@osandov.com> ha scritto:
>>>>>>>>
>>>>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>>>>
>>>>>>>> None of the other blk-mq elevator hooks are called with this lock held.
>>>>>>>> Additionally, it can lead to circular locking dependencies between
>>>>>>>> queue_lock and the private scheduler lock.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Omar,
>>>>>>> I'm sorry but it seems that a new potential deadlock has showed up.
>>>>>>> See lockdep splat below.
>>>>>>>
>>>>>>> I've tried to think about different solutions than turning back to
>>>>>>> deferring the body of exit_icq, but at no avail.
>>>>>>
>>>>>> Looks like a interaction between bfqd->lock and q->queue_lock. Since the
>>>>>> core has no notion of you bfqd->lock, the naturally dependency here
>>>>>> would be to nest bfqd->lock inside q->queue_lock. Is that possible for
>>>>>> you?
>>>>>>
>>>>>> Looking at the code a bit, maybe it'd just be simpler to get rid of
>>>>>> holding the queue lock for that spot. For the mq scheduler, we really
>>>>>> don't want places where we invoke with that held already. Does the below
>>>>>> work for you?
>>>>>
>>>>> Would need to remove one more lockdep assert. And only test this for
>>>>> the mq parts, we'd need to spread a bit of love on the classic
>>>>> scheduling icq exit path for this to work on that side.
>>>>>
>>>>
>>>>
>>>> Jens,
>>>> here is the reply I anticipated in my previous email: after rebasing
>>>> against master, I'm getting again the deadlock that this patch of
>>>> yours solved (together with some changes in bfq-mq).  I thought you added a
>>>> sort of equivalent commit (now) to the mainline branch.  Am I wrong?
>>>
>>> The patch I posted was never pulled to completion, it wasn't clear
>>> to me if it fixed your issue or not. Maybe I missed a reply on
>>> that?
>>>
>>> Let me take another stab at it today, I'll send you a version to test
>>> on top of my for-linus branch.
>>
>> I took at look at my last posting, and I think it was only missing a
>> lock grab in cfq, since we don't hold that for icq exit anymore.  Paolo,
>> it'd be great if you could verify that this works. Not for bfq-mq (we
>> already know it does), but for CFQ.
> 
> No luck, sorry :(
> 
> It looks like to have just not to take q->queue_lock in cfq_exit_icq.

I was worried about that. How about the below? We need to grab the lock
at some point for legacy scheduling, but the ordering should be correct.


diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index b12f9c87b4c3..6fd633b5d567 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -54,7 +54,7 @@ static void ioc_exit_icq(struct io_cq *icq)
 	icq->flags |= ICQ_EXITED;
 }
 
-/* Release an icq.  Called with both ioc and q locked. */
+/* Release an icq.  Called with ioc locked. */
 static void ioc_destroy_icq(struct io_cq *icq)
 {
 	struct io_context *ioc = icq->ioc;
@@ -62,7 +62,6 @@ static void ioc_destroy_icq(struct io_cq *icq)
 	struct elevator_type *et = q->elevator->type;
 
 	lockdep_assert_held(&ioc->lock);
-	lockdep_assert_held(q->queue_lock);
 
 	radix_tree_delete(&ioc->icq_tree, icq->q->id);
 	hlist_del_init(&icq->ioc_node);
@@ -222,24 +221,40 @@ void exit_io_context(struct task_struct *task)
 	put_io_context_active(ioc);
 }
 
+static void __ioc_clear_queue(struct list_head *icq_list)
+{
+	unsigned long flags;
+
+	while (!list_empty(icq_list)) {
+		struct io_cq *icq = list_entry(icq_list->next,
+					       struct io_cq, q_node);
+		struct io_context *ioc = icq->ioc;
+
+		spin_lock_irqsave(&ioc->lock, flags);
+		ioc_destroy_icq(icq);
+		spin_unlock_irqrestore(&ioc->lock, flags);
+	}
+}
+
 /**
  * ioc_clear_queue - break any ioc association with the specified queue
  * @q: request_queue being cleared
  *
- * Walk @q->icq_list and exit all io_cq's.  Must be called with @q locked.
+ * Walk @q->icq_list and exit all io_cq's.
  */
 void ioc_clear_queue(struct request_queue *q)
 {
-	lockdep_assert_held(q->queue_lock);
+	LIST_HEAD(icq_list);
 
-	while (!list_empty(&q->icq_list)) {
-		struct io_cq *icq = list_entry(q->icq_list.next,
-					       struct io_cq, q_node);
-		struct io_context *ioc = icq->ioc;
+	spin_lock_irq(q->queue_lock);
+	list_splice_init(&q->icq_list, &icq_list);
 
-		spin_lock(&ioc->lock);
-		ioc_destroy_icq(icq);
-		spin_unlock(&ioc->lock);
+	if (q->mq_ops) {
+		spin_unlock_irq(q->queue_lock);
+		__ioc_clear_queue(&icq_list);
+	} else {
+		__ioc_clear_queue(&icq_list);
+		spin_unlock_irq(q->queue_lock);
 	}
 }
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 002af836aa87..c44b321335f3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -815,9 +815,7 @@ static void blk_release_queue(struct kobject *kobj)
 	blkcg_exit_queue(q);
 
 	if (q->elevator) {
-		spin_lock_irq(q->queue_lock);
 		ioc_clear_queue(q);
-		spin_unlock_irq(q->queue_lock);
 		elevator_exit(q->elevator);
 	}
 
diff --git a/block/elevator.c b/block/elevator.c
index ac1c9f481a98..01139f549b5b 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -983,9 +983,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 		if (old_registered)
 			elv_unregister_queue(q);
 
-		spin_lock_irq(q->queue_lock);
 		ioc_clear_queue(q);
-		spin_unlock_irq(q->queue_lock);
 	}
 
 	/* allocate, init and register new elevator */

-- 
Jens Axboe
