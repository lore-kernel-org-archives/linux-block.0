Return-Path: <ming.lei@redhat.com>
Date: Fri, 10 Nov 2017 14:30:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: fix issue with shared tag queue re-running
Message-ID: <20171110063026.GC9755@ming.t460p>
References: <98418e6d-2981-0fb7-dcdd-79b635955fcf@kernel.dk>
 <20171109034133.GA19098@ming.t460p>
 <20171109100036.GA17976@ming.t460p>
 <2d03b95b-580b-4cb7-0a84-c4fc069e5efd@kernel.dk>
 <2add8e70-f107-b8be-eefb-e6092d0effa6@kernel.dk>
 <20171110055311.GA9755@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110055311.GA9755@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 10, 2017 at 01:53:18PM +0800, Ming Lei wrote:
> On Thu, Nov 09, 2017 at 09:32:58AM -0700, Jens Axboe wrote:
> > On 11/09/2017 08:30 AM, Jens Axboe wrote:
> > > On 11/09/2017 03:00 AM, Ming Lei wrote:
> > >> On Thu, Nov 09, 2017 at 11:41:40AM +0800, Ming Lei wrote:
> > >>> On Wed, Nov 08, 2017 at 03:48:51PM -0700, Jens Axboe wrote:
> > >>>> This patch attempts to make the case of hctx re-running on driver tag
> > >>>> failure more robust. Without this patch, it's pretty easy to trigger a
> > >>>> stall condition with shared tags. An example is using null_blk like
> > >>>> this:
> > >>>>
> > >>>> modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1 submit_queues=1 hw_queue_depth=1
> > >>>>
> > >>>> which sets up 4 devices, sharing the same tag set with a depth of 1.
> > >>>> Running a fio job ala:
> > >>>>
> > >>>> [global]
> > >>>> bs=4k
> > >>>> rw=randread
> > >>>> norandommap
> > >>>> direct=1
> > >>>> ioengine=libaio
> > >>>> iodepth=4
> > >>>>
> > >>>> [nullb0]
> > >>>> filename=/dev/nullb0
> > >>>> [nullb1]
> > >>>> filename=/dev/nullb1
> > >>>> [nullb2]
> > >>>> filename=/dev/nullb2
> > >>>> [nullb3]
> > >>>> filename=/dev/nullb3
> > >>>>
> > >>>> will inevitably end with one or more threads being stuck waiting for a
> > >>>> scheduler tag. That IO is then stuck forever, until someone else
> > >>>> triggers a run of the queue.
> > >>>>
> > >>>> Ensure that we always re-run the hardware queue, if the driver tag we
> > >>>> were waiting for got freed before we added our leftover request entries
> > >>>> back on the dispatch list.
> > >>>>
> > >>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >>>>
> > >>>> ---
> > >>>>
> > >>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > >>>> index 7f4a1ba532af..bb7f08415203 100644
> > >>>> --- a/block/blk-mq-debugfs.c
> > >>>> +++ b/block/blk-mq-debugfs.c
> > >>>> @@ -179,7 +179,6 @@ static const char *const hctx_state_name[] = {
> > >>>>  	HCTX_STATE_NAME(STOPPED),
> > >>>>  	HCTX_STATE_NAME(TAG_ACTIVE),
> > >>>>  	HCTX_STATE_NAME(SCHED_RESTART),
> > >>>> -	HCTX_STATE_NAME(TAG_WAITING),
> > >>>>  	HCTX_STATE_NAME(START_ON_RUN),
> > >>>>  };
> > >>>>  #undef HCTX_STATE_NAME
> > >>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> > >>>> index 3d759bb8a5bb..8dc5db40df9d 100644
> > >>>> --- a/block/blk-mq.c
> > >>>> +++ b/block/blk-mq.c
> > >>>> @@ -998,49 +998,64 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
> > >>>>  	return rq->tag != -1;
> > >>>>  }
> > >>>>  
> > >>>> -static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
> > >>>> -				void *key)
> > >>>> +static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
> > >>>> +				int flags, void *key)
> > >>>>  {
> > >>>>  	struct blk_mq_hw_ctx *hctx;
> > >>>>  
> > >>>>  	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
> > >>>>  
> > >>>> -	list_del(&wait->entry);
> > >>>> -	clear_bit_unlock(BLK_MQ_S_TAG_WAITING, &hctx->state);
> > >>>> +	list_del_init(&wait->entry);
> > >>>>  	blk_mq_run_hw_queue(hctx, true);
> > >>>>  	return 1;
> > >>>>  }
> > >>>>  
> > >>>> -static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
> > >>>> +static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx **hctx,
> > >>>> +				     struct request *rq)
> > >>>>  {
> > >>>> +	struct blk_mq_hw_ctx *this_hctx = *hctx;
> > >>>> +	wait_queue_entry_t *wait = &this_hctx->dispatch_wait;
> > >>>>  	struct sbq_wait_state *ws;
> > >>>>  
> > >>>> +	if (!list_empty_careful(&wait->entry))
> > >>>> +		return false;
> > >>>> +
> > >>>> +	spin_lock(&this_hctx->lock);
> > >>>> +	if (!list_empty(&wait->entry)) {
> > >>>> +		spin_unlock(&this_hctx->lock);
> > >>>> +		return false;
> > >>>> +	}
> > >>>> +
> > >>>> +	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
> > >>>> +	add_wait_queue(&ws->wait, wait);
> > >>>> +
> > >>>>  	/*
> > >>>> -	 * The TAG_WAITING bit serves as a lock protecting hctx->dispatch_wait.
> > >>>> -	 * The thread which wins the race to grab this bit adds the hardware
> > >>>> -	 * queue to the wait queue.
> > >>>> +	 * It's possible that a tag was freed in the window between the
> > >>>> +	 * allocation failure and adding the hardware queue to the wait
> > >>>> +	 * queue.
> > >>>>  	 */
> > >>>> -	if (test_bit(BLK_MQ_S_TAG_WAITING, &hctx->state) ||
> > >>>> -	    test_and_set_bit_lock(BLK_MQ_S_TAG_WAITING, &hctx->state))
> > >>>> +	if (!blk_mq_get_driver_tag(rq, hctx, false)) {
> > >>>> +		spin_unlock(&this_hctx->lock);
> > >>>>  		return false;
> > >>>> -
> > >>>> -	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
> > >>>> -	ws = bt_wait_ptr(&hctx->tags->bitmap_tags, hctx);
> > >>>> +	}
> > >>>>  
> > >>>>  	/*
> > >>>> -	 * As soon as this returns, it's no longer safe to fiddle with
> > >>>> -	 * hctx->dispatch_wait, since a completion can wake up the wait queue
> > >>>> -	 * and unlock the bit.
> > >>>> +	 * We got a tag, remove outselves from the wait queue to ensure
> > >>>> +	 * someone else gets the wakeup.
> > >>>>  	 */
> > >>>> -	add_wait_queue(&ws->wait, &hctx->dispatch_wait);
> > >>>> +	spin_lock_irq(&ws->wait.lock);
> > >>>> +	list_del_init(&wait->entry);
> > >>>> +	spin_unlock_irq(&ws->wait.lock);
> > >>>> +	spin_unlock(&this_hctx->lock);
> > >>>>  	return true;
> > >>>>  }
> > >>>>  
> > >>>>  bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> > >>>> -		bool got_budget)
> > >>>> +			     bool got_budget)
> > >>>>  {
> > >>>>  	struct blk_mq_hw_ctx *hctx;
> > >>>>  	struct request *rq, *nxt;
> > >>>> +	bool no_tag = false;
> > >>>>  	int errors, queued;
> > >>>>  
> > >>>>  	if (list_empty(list))
> > >>>> @@ -1060,22 +1075,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> > >>>>  		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
> > >>>>  			/*
> > >>>>  			 * The initial allocation attempt failed, so we need to
> > >>>> -			 * rerun the hardware queue when a tag is freed.
> > >>>> +			 * rerun the hardware queue when a tag is freed. The
> > >>>> +			 * waitqueue takes care of that. If the queue is run
> > >>>> +			 * before we add this entry back on the dispatch list,
> > >>>> +			 * we'll re-run it below.
> > >>>>  			 */
> > >>>> -			if (!blk_mq_dispatch_wait_add(hctx)) {
> > >>>> -				if (got_budget)
> > >>>> -					blk_mq_put_dispatch_budget(hctx);
> > >>>> -				break;
> > >>>> -			}
> > >>>> -
> > >>>> -			/*
> > >>>> -			 * It's possible that a tag was freed in the window
> > >>>> -			 * between the allocation failure and adding the
> > >>>> -			 * hardware queue to the wait queue.
> > >>>> -			 */
> > >>>> -			if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
> > >>>> +			if (!blk_mq_dispatch_wait_add(&hctx, rq)) {
> > >>>>  				if (got_budget)
> > >>>>  					blk_mq_put_dispatch_budget(hctx);
> > >>>> +				no_tag = true;
> > >>>>  				break;
> > >>>>  			}
> > >>>>  		}
> > >>>> @@ -1140,10 +1148,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> > >>>>  		 * it is no longer set that means that it was cleared by another
> > >>>>  		 * thread and hence that a queue rerun is needed.
> > >>>>  		 *
> > >>>> -		 * If TAG_WAITING is set that means that an I/O scheduler has
> > >>>> -		 * been configured and another thread is waiting for a driver
> > >>>> -		 * tag. To guarantee fairness, do not rerun this hardware queue
> > >>>> -		 * but let the other thread grab the driver tag.
> > >>>> +		 * If 'no_tag' is set, that means that we failed getting
> > >>>> +		 * a driver tag with an I/O scheduler attached. If our dispatch
> > >>>> +		 * waitqueue is no longer active, ensure that we run the queue
> > >>>> +		 * AFTER adding our entries back to the list.
> > >>>>  		 *
> > >>>>  		 * If no I/O scheduler has been configured it is possible that
> > >>>>  		 * the hardware queue got stopped and restarted before requests
> > >>>> @@ -1156,7 +1164,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> > >>>>  		 *   and dm-rq.
> > >>>>  		 */
> > >>>>  		if (!blk_mq_sched_needs_restart(hctx) &&
> > >>>> -		    !test_bit(BLK_MQ_S_TAG_WAITING, &hctx->state))
> > >>>> +		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
> > >>>>  			blk_mq_run_hw_queue(hctx, true);
> > >>>
> > >>> If one rq is just completed after the check on list_empty_careful(&hctx->dispatch_wait.entry),
> > >>> the queue may not be run any more. May that be an issue?
> > >>
> > >> Looks that can be an issue.
> > >>
> > >> If I revert "Revert "blk-mq: don't handle TAG_SHARED in restart"", and
> > >> apply 'blk-mq: put driver tag if dispatch budget can't be got' against
> > >> for-4.15/block, I still can trigger IO hang in one or two minutes easily:
> > >>
> > >> 1) script
> > >> #!/bin/sh
> > >> modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1 submit_queues=1 hw_queue_depth=1
> > >> RUNTIME=10
> > >>
> > >> while true; do
> > >> 	fio --bs=4k --size=512G  --rw=randread --norandommap --direct=1 --ioengine=libaio --iodepth=4 --runtime=$RUNTIME --group_reporting=1  --name=nullb0 --filename=/dev/nullb0 --name=nullb1 --filename=/dev/nullb1 --name=nullb2 --filename=/dev/nullb2 --name=nullb3 --filename=/dev/nullb3
> > > 
> > > Did you apply my patch too? I had my test case running overnight, and it
> > > completed just fine. That's current for-4.15/block + the patch I posted.
> > > Previously that would hang in minutes as well.
> > > 
> > > I'm running your test case now here, but it looks identical to mine.
> > > It's been running for 5 min without issue so far, I'll leave it running
> > > for an hour or so.
> > 
> > It's been running happily for > 1 hour now, no issues observed.
> 
> Looks there was something wrong in yesterday's test, today I can't reproduce
> the issue by running latest for-4.15/block with revert a2820d1544c1, and observed
> IOPS is improved >20% compared yesterday's result meantime.

Actually my yesterday's test wasn't wrong, the in-tree patch is different with your
post:

1) posted patch

                if (!blk_mq_sched_needs_restart(hctx) &&
-                   !test_bit(BLK_MQ_S_TAG_WAITING, &hctx->state))
+                   (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
						blk_mq_run_hw_queue(hctx, true);

2) in-tree patch
-               if (!blk_mq_sched_needs_restart(hctx) &&
-                   !test_bit(BLK_MQ_S_TAG_WAITING, &hctx->state))
+               if (!blk_mq_sched_needs_restart(hctx) ||
+                   (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
						blk_mq_run_hw_queue(hctx, true);

I'd suggest you mention that or post a V2 for this case next time, :-)

-- 
Ming
