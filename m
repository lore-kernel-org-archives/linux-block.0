Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
To: Paolo Valente <paolo.valente@linaro.org>,
 Omar Sandoval <osandov@osandov.com>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
 <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com>
Date: Wed, 15 Feb 2017 10:58:12 -0700
MIME-Version: 1.0
In-Reply-To: <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/15/2017 10:24 AM, Paolo Valente wrote:
> 
>> Il giorno 10 feb 2017, alle ore 19:32, Omar Sandoval <osandov@osandov.com> ha scritto:
>>
>> From: Omar Sandoval <osandov@fb.com>
>>
>> None of the other blk-mq elevator hooks are called with this lock held.
>> Additionally, it can lead to circular locking dependencies between
>> queue_lock and the private scheduler lock.
>>
> 
> Hi Omar,
> I'm sorry but it seems that a new potential deadlock has showed up.
> See lockdep splat below.
> 
> I've tried to think about different solutions than turning back to
> deferring the body of exit_icq, but at no avail.

Looks like a interaction between bfqd->lock and q->queue_lock. Since the
core has no notion of you bfqd->lock, the naturally dependency here
would be to nest bfqd->lock inside q->queue_lock. Is that possible for
you?

Looking at the code a bit, maybe it'd just be simpler to get rid of
holding the queue lock for that spot. For the mq scheduler, we really
don't want places where we invoke with that held already. Does the below
work for you?


diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index b12f9c87b4c3..0f50b1296cf9 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -222,25 +222,34 @@ void exit_io_context(struct task_struct *task)
 	put_io_context_active(ioc);
 }
 
+static void __ioc_clear_queue(struct list_head *icq_list)
+{
+	while (!list_empty(icq_list)) {
+		struct io_cq *icq = list_entry(icq_list->next,
+					       struct io_cq, q_node);
+		struct io_context *ioc = icq->ioc;
+
+		spin_lock_irq(&ioc->lock);
+		ioc_destroy_icq(icq);
+		spin_unlock_irq(&ioc->lock);
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
+	spin_unlock_irq(q->queue_lock);
 
-		spin_lock(&ioc->lock);
-		ioc_destroy_icq(icq);
-		spin_unlock(&ioc->lock);
-	}
+	__ioc_clear_queue(&icq_list);
 }
 
 int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 070d81bae1d5..1944aa1cb899 100644
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
index a25bdd90b270..aaa1e9836512 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -985,9 +985,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 		if (old_registered)
 			elv_unregister_queue(q);
 
-		spin_lock_irq(q->queue_lock);
 		ioc_clear_queue(q);
-		spin_unlock_irq(q->queue_lock);
 	}
 
 	/* allocate, init and register new elevator */

-- 
Jens Axboe
