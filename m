Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 3/4] blk-mq: prepare for supporting runtime PM
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
References: <20180711162906.14271-1-ming.lei@redhat.com>
 <20180711162906.14271-4-ming.lei@redhat.com>
 <20180712095828.GA2422@ming.t460p> <20180712122836.GC2422@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a0be8ebf-e556-34c9-5985-6cda8992cd61@kernel.dk>
Date: Thu, 12 Jul 2018 08:00:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180712122836.GC2422@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/12/18 6:28 AM, Ming Lei wrote:
> On Thu, Jul 12, 2018 at 05:58:28PM +0800, Ming Lei wrote:
>> On Thu, Jul 12, 2018 at 12:29:05AM +0800, Ming Lei wrote:
>>> This patch introduces blk_mq_pm_add_request() which is called after
>>> allocating one request. Also blk_mq_pm_put_request() is introduced
>>> and called after one request is freed.
>>>
>>> For blk-mq, it can be quite expensive to accounting in-flight IOs,
>>> so this patch calls pm_runtime_mark_last_busy() simply after each IO
>>> is done, instead of doing that only after the last in-flight IO is done.
>>> This way is still workable, since the active non-PM IO will be checked
>>> in blk_pre_runtime_suspend(), and runtime suspend will be prevented
>>> if there is any active non-PM IO.
>>>
>>> Also makes blk_post_runtime_resume() to cover blk-mq.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Bart Van Assche <bart.vanassche@wdc.com>
>>> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
>>> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
>>> Cc: linux-scsi@vger.kernel.org
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-core.c | 12 ++++++++++--
>>>  block/blk-mq.c   | 24 ++++++++++++++++++++++++
>>>  2 files changed, 34 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index c4b57d8806fe..bf66d561980d 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -3804,12 +3804,17 @@ EXPORT_SYMBOL(blk_pm_runtime_init);
>>>  int blk_pre_runtime_suspend(struct request_queue *q)
>>>  {
>>>  	int ret = 0;
>>> +	bool active;
>>>  
>>>  	if (!q->dev)
>>>  		return ret;
>>>  
>>>  	spin_lock_irq(q->queue_lock);
>>> -	if (q->nr_pending) {
>>> +	if (!q->mq_ops)
>>> +		active = !!q->nr_pending;
>>> +	else
>>> +		active = !blk_mq_pm_queue_idle(q);
>>> +	if (active) {
>>>  		ret = -EBUSY;
>>>  		pm_runtime_mark_last_busy(q->dev);
>>>  	} else {
>>
>> Looks there is one big issue, one new IO may come just after reading
>> 'active' and before writing RPM_SUSPENDING to q->rpm_status, and both
>> the suspending and the new IO may be in-progress at the same time.
> 
> One idea I thought of is to use seqlock to sync changing & reading q->rpm_status,
> and looks read lock(read_seqcount_begin/read_seqcount_retry) shouldn't introduce
> big cost in fast path.

Let's please keep in mind that this is runtime pm stuff. Better to
make the rules relaxed around it, instead of adding synchronization.

-- 
Jens Axboe
