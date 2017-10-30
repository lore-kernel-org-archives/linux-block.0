Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix a race between blk_cleanup_queue() and timeout
 handling
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20171019170048.16044-1-bart.vanassche@wdc.com>
 <c91fcb5c-9699-d2e0-0a92-c6656624566a@kernel.dk>
 <1509388630.27259.6.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2e965818-8173-dd49-62ec-99a386d82912@kernel.dk>
Date: Mon, 30 Oct 2017 13:27:55 -0600
MIME-Version: 1.0
In-Reply-To: <1509388630.27259.6.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/2017 12:37 PM, Bart Van Assche wrote:
> On Mon, 2017-10-30 at 12:16 -0600, Jens Axboe wrote:
>> On 10/19/2017 11:00 AM, Bart Van Assche wrote:
>>> Make sure that if the timeout timer fires after a queue has been
>>> marked "dying" that the affected requests are finished.
>>>
>>> Reported-by: chenxiang (M) <chenxiang66@hisilicon.com>
>>> Fixes: commit 287922eb0b18 ("block: defer timeouts to a workqueue")
>>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>>> Tested-by: chenxiang (M) <chenxiang66@hisilicon.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Keith Busch <keith.busch@intel.com>
>>> Cc: Hannes Reinecke <hare@suse.com>
>>> Cc: Ming Lei <ming.lei@redhat.com>
>>> Cc: Johannes Thumshirn <jthumshirn@suse.de>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>  block/blk-core.c    | 2 ++
>>>  block/blk-timeout.c | 3 ---
>>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index e8e149ccc86b..bb4fce694a60 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -333,6 +333,7 @@ EXPORT_SYMBOL(blk_stop_queue);
>>>  void blk_sync_queue(struct request_queue *q)
>>>  {
>>>  	del_timer_sync(&q->timeout);
>>> +	cancel_work_sync(&q->timeout_work);
>>>  
>>>  	if (q->mq_ops) {
>>>  		struct blk_mq_hw_ctx *hctx;
>>> @@ -844,6 +845,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>>>  	setup_timer(&q->backing_dev_info->laptop_mode_wb_timer,
>>>  		    laptop_mode_timer_fn, (unsigned long) q);
>>>  	setup_timer(&q->timeout, blk_rq_timed_out_timer, (unsigned long) q);
>>> +	INIT_WORK(&q->timeout_work, NULL);
>>>  	INIT_LIST_HEAD(&q->queue_head);
>>>  	INIT_LIST_HEAD(&q->timeout_list);
>>>  	INIT_LIST_HEAD(&q->icq_list);
>>
>> This part looks like a no-brainer.
>>
>>> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
>>> index e3e9c9771d36..764ecf9aeb30 100644
>>> --- a/block/blk-timeout.c
>>> +++ b/block/blk-timeout.c
>>> @@ -134,8 +134,6 @@ void blk_timeout_work(struct work_struct *work)
>>>  	struct request *rq, *tmp;
>>>  	int next_set = 0;
>>>  
>>> -	if (blk_queue_enter(q, true))
>>> -		return;
>>>  	spin_lock_irqsave(q->queue_lock, flags);
>>>  
>>>  	list_for_each_entry_safe(rq, tmp, &q->timeout_list, timeout_list)
>>> @@ -145,7 +143,6 @@ void blk_timeout_work(struct work_struct *work)
>>>  		mod_timer(&q->timeout, round_jiffies_up(next));
>>>  
>>>  	spin_unlock_irqrestore(q->queue_lock, flags);
>>> -	blk_queue_exit(q);
>>>  }
>>
>> And this should be fine too, if we have requests that timeout (as they
>> hold a queue enter reference). Is it safe if there are no requests left?
>> Previously we would fail the enter if the queue was dying, now we won't.
>>
>> Doesn't look required for the change, should probably be a separate
>> patch.
> 
> Hello Jens,
> 
> This patch was developed as follows:
> - In order to avoid that request timeouts do not get processed, I removed
>   the blk_queue_enter() and blk_queue_exit() calls from blk_timeout_work().
> - To avoid that calling blk_timeout_work() while a queue is dying would
>   cause trouble, I added the cancel_work_sync() call in blk_sync_queue().
> - After I noticed that the cancel_work_sync() call added by this patch
>   triggers a kernel warning when unloading the brd driver I added the
>   INIT_WORK() call.
> 
> I hope this makes it clear that removing the blk_queue_enter() and
> blk_queue_exit() calls is essential and also that all changes in this patch
> are necessary.

2/3 was the first part that I have absolutely no concerns with, looks
fine. For #1, I guess the issue is exactly that if the queue is dying
AND we have requests pending for timeout, we can't let that make us
fail to enter the timeout handling. With the sync of the workqueue
timeout handler, this does look safe.

I'll apply it for 4.15, thanks Bart.

-- 
Jens Axboe
