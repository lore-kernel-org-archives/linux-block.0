Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] queue stall with blk-mq-sched
To: Hannes Reinecke <hare@suse.de>
References: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
 <762cb508-1de0-93e2-5643-3fe946428eb5@fb.com>
 <8abc2430-e1fd-bece-ad52-c6d1d482c1e0@suse.de>
 <1663de5d-cdf7-a6ed-7539-c7d1f5e98f6c@fb.com>
 <717c595a-a3a6-0508-b537-8cf9e273271e@kernel.dk>
 <8178340b-dd64-c02d-0ef2-97ad5f928dc8@suse.de>
 <2b40b443-3bd6-717a-11ba-043886780adf@suse.de>
 <6035003f-029c-6cff-c35f-4e90496cab50@suse.de>
 <be2e5182-9cd8-5fea-77ac-4efd64e869ff@kernel.dk>
 <57539c5d-be3b-ab26-c6d4-a7ff554ded8b@suse.de>
 <3261ba64-cd7b-a7da-c407-c3b9828c3b57@kernel.dk>
 <262c4739-be6c-94e9-8e8c-6e97a602e881@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1447bc07-9336-14f2-8495-a109113050ec@kernel.dk>
Date: Wed, 25 Jan 2017 15:27:30 -0700
MIME-Version: 1.0
In-Reply-To: <262c4739-be6c-94e9-8e8c-6e97a602e881@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/25/2017 10:42 AM, Jens Axboe wrote:
> On 01/25/2017 10:03 AM, Jens Axboe wrote:
>> On 01/25/2017 09:57 AM, Hannes Reinecke wrote:
>>> On 01/25/2017 04:52 PM, Jens Axboe wrote:
>>>> On 01/25/2017 04:10 AM, Hannes Reinecke wrote:
>>> [ .. ]
>>>>> Bah.
>>>>>
>>>>> Not quite. I'm still seeing some queues with state 'restart'.
>>>>>
>>>>> I've found that I need another patch on top of that:
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index e872555..edcbb44 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -753,8 +754,10 @@ static void blk_mq_timeout_work(struct work_struct
>>>>> *work)
>>>>>
>>>>>                 queue_for_each_hw_ctx(q, hctx, i) {
>>>>>                         /* the hctx may be unmapped, so check it here */
>>>>> -                       if (blk_mq_hw_queue_mapped(hctx))
>>>>> +                       if (blk_mq_hw_queue_mapped(hctx)) {
>>>>>                                 blk_mq_tag_idle(hctx);
>>>>> +                               blk_mq_sched_restart(hctx);
>>>>> +                       }
>>>>>                 }
>>>>>         }
>>>>>         blk_queue_exit(q);
>>>>>
>>>>>
>>>>> Reasoning is that in blk_mq_get_tag() we might end up scheduling the
>>>>> request on another hctx, but the original hctx might still have the
>>>>> SCHED_RESTART bit set.
>>>>> Which will never cleared as we complete the request on a different hctx,
>>>>> so anything we do on the end_request side won't do us any good.
>>>>
>>>> I think you are right, it'll potentially trigger with shared tags and
>>>> multiple hardware queues. I'll debug this today and come up with a
>>>> decent fix.
>>>>
>>>> I committed the previous patch, fwiw.
>>>>
>>> THX.
>>>
>>> The above patch _does_ help in the sense that my testcase now completes 
>>> without stalls. And I even get a decent performance with the mq-sched 
>>> fixes: 82k IOPs sequential read with mq-deadline as compared to 44k IOPs 
>>> when running without I/O scheduling.
>>> Still some way off from the 132k IOPs I'm getting with CFQ, but we're 
>>> getting there.
>>>
>>> However, I do get a noticeable stall during the stonewall sequence 
>>> before the timeout handler kicks in, so the must be a better way for 
>>> handling this.
>>>
>>> But nevertheless, thanks for all your work here.
>>> Very much appreciated.
>>
>> Yeah, the fix isn't really a fix, unless you are willing to tolerate
>> potentially tens of seconds of extra latency until we idle it out :-)
>>
>> So we can't use the un-idling for this, but we can track it on the
>> shared state, which is the tags. The problem isn't that we are
>> switching to a new hardware queue, it's if we mark the hardware queue
>> as restart AND it has nothing pending. In that case, we'll never
>> get it restarted, since IO completion is what restarts it.
>>
>> I need to handle that case separately. Currently testing a patch, I
>> should have something for you to test later today.
> 
> Can you try this one?

And another variant, this one should be better in that it should result
in less queue runs and get better merging. Hope it works with your
stalls as well.


diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d05061f..6a1656d 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -300,6 +300,34 @@ bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx, struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_bypass_insert);
 
+static void blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
+{
+	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
+		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+		if (blk_mq_hctx_has_pending(hctx))
+			blk_mq_run_hw_queue(hctx, true);
+	}
+}
+
+void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx)
+{
+	unsigned int i;
+
+	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED))
+		blk_mq_sched_restart_hctx(hctx);
+	else {
+		struct request_queue *q = hctx->queue;
+
+		if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
+			return;
+
+		clear_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
+
+		queue_for_each_hw_ctx(q, hctx, i)
+			blk_mq_sched_restart_hctx(hctx);
+	}
+}
+
 static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
 				   struct blk_mq_hw_ctx *hctx,
 				   unsigned int hctx_idx)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 6b465bc..becbc78 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -19,6 +19,7 @@ bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx, struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
+void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
@@ -123,11 +124,6 @@ blk_mq_sched_completed_request(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	BUG_ON(rq->internal_tag == -1);
 
 	blk_mq_put_tag(hctx, hctx->sched_tags, rq->mq_ctx, rq->internal_tag);
-
-	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
-		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
-		blk_mq_run_hw_queue(hctx, true);
-	}
 }
 
 static inline void blk_mq_sched_started_request(struct request *rq)
@@ -160,8 +156,15 @@ static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
 
 static inline void blk_mq_sched_mark_restart(struct blk_mq_hw_ctx *hctx)
 {
-	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
 		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+		if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
+			struct request_queue *q = hctx->queue;
+
+			if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
+				set_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
+		}
+	}
 }
 
 static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c3e667..4eb732a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,7 +40,7 @@ static LIST_HEAD(all_q_list);
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
-static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
 	return sbitmap_any_bit_set(&hctx->ctx_map) ||
 			!list_empty_careful(&hctx->dispatch) ||
@@ -345,6 +345,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
 		blk_mq_sched_completed_request(hctx, rq);
+	blk_mq_sched_restart_queues(hctx);
 	blk_queue_exit(q);
 }
 
@@ -879,6 +880,21 @@ static bool blk_mq_get_driver_tag(struct request *rq,
 	return false;
 }
 
+static void blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
+				  struct request *rq)
+{
+	if (rq->tag == -1 || rq->internal_tag == -1)
+		return;
+
+	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
+	rq->tag = -1;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
+		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
+		atomic_dec(&hctx->nr_active);
+	}
+}
+
 /*
  * If we fail getting a driver tag because all the driver tags are already
  * assigned and on the dispatch list, BUT the first entry does not have a
@@ -928,8 +944,16 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
 			if (!queued && reorder_tags_to_front(list))
 				continue;
+
+			/*
+			 * We failed getting a driver tag. Mark the queue(s)
+			 * as needing a restart. Retry getting a tag again,
+			 * in case the needed IO completed right before we
+			 * marked the queue as needing a restart.
+			 */
 			blk_mq_sched_mark_restart(hctx);
-			break;
+			if (!blk_mq_get_driver_tag(rq, &hctx, false))
+				break;
 		}
 		list_del_init(&rq->queuelist);
 
@@ -943,6 +967,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 			queued++;
 			break;
 		case BLK_MQ_RQ_QUEUE_BUSY:
+			blk_mq_put_driver_tag(hctx, rq);
 			list_add(&rq->queuelist, list);
 			__blk_mq_requeue_request(rq);
 			break;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 6c24b90..077a400 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -33,6 +33,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *, struct list_head *);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
 
 /*
  * Internal helpers for allocating/freeing the request map
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ee1fb59..40ce491 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -607,6 +607,7 @@ struct request_queue {
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
 #define QUEUE_FLAG_STATS       27	/* track rq completion times */
+#define QUEUE_FLAG_RESTART     28
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\

-- 
Jens Axboe
