Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16740 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdHXHnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 03:43:46 -0400
Subject: Re: [PATCH V2 11/20] blk-mq: introduce helpers for operating
 ->dispatch list
To: Ming Lei <ming.lei@redhat.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-12-ming.lei@redhat.com>
 <1503434591.2508.20.camel@wdc.com>
 <12634573-89fa-90cc-f481-464a490f7915@wdc.com>
 <20170824071053.GN12966@ming.t460p>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <3a493567-7623-f56b-c166-16109823498e@wdc.com>
Date: Thu, 24 Aug 2017 16:42:11 +0900
MIME-Version: 1.0
In-Reply-To: <20170824071053.GN12966@ming.t460p>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 8/24/17 16:10, Ming Lei wrote:
> On Thu, Aug 24, 2017 at 09:59:13AM +0900, Damien Le Moal wrote:
>>
>> On 8/23/17 05:43, Bart Van Assche wrote:
>>> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
>>>> +static inline bool blk_mq_has_dispatch_rqs(struct blk_mq_hw_ctx *hctx)
>>>> +{
>>>> +	return !list_empty_careful(&hctx->dispatch);
>>>> +}
>>>> +
>>>> +static inline void blk_mq_add_rq_to_dispatch(struct blk_mq_hw_ctx *hctx,
>>>> +		struct request *rq)
>>>> +{
>>>> +	spin_lock(&hctx->lock);
>>>> +	list_add(&rq->queuelist, &hctx->dispatch);
>>>> +	blk_mq_hctx_set_dispatch_busy(hctx);
>>>> +	spin_unlock(&hctx->lock);
>>>> +}
>>>> +
>>>> +static inline void blk_mq_add_list_to_dispatch(struct blk_mq_hw_ctx *hctx,
>>>> +		struct list_head *list)
>>>> +{
>>>> +	spin_lock(&hctx->lock);
>>>> +	list_splice_init(list, &hctx->dispatch);
>>>> +	blk_mq_hctx_set_dispatch_busy(hctx);
>>>> +	spin_unlock(&hctx->lock);
>>>> +}
>>>> +
>>>> +static inline void blk_mq_add_list_to_dispatch_tail(struct blk_mq_hw_ctx *hctx,
>>>> +						    struct list_head *list)
>>>> +{
>>>> +	spin_lock(&hctx->lock);
>>>> +	list_splice_tail_init(list, &hctx->dispatch);
>>>> +	blk_mq_hctx_set_dispatch_busy(hctx);
>>>> +	spin_unlock(&hctx->lock);
>>>> +}
>>>> +
>>>> +static inline void blk_mq_take_list_from_dispatch(struct blk_mq_hw_ctx *hctx,
>>>> +		struct list_head *list)
>>>> +{
>>>> +	spin_lock(&hctx->lock);
>>>> +	list_splice_init(&hctx->dispatch, list);
>>>> +	spin_unlock(&hctx->lock);
>>>> +}
>>>
>>> Same comment for this patch: these helper functions are so short that I'm not
>>> sure it is useful to introduce these helper functions.
>>>
>>> Bart.
>>
>> Personally, I like those very much as they give a place to hook up
>> different dispatch_list handling without having to change blk-mq.c and
>> blk-mq-sched.c all over the place.
>>
>> I am thinking of SMR (zoned block device) support here since we need to
>> to sort insert write requests in blk_mq_add_rq_to_dispatch() and
>> blk_mq_add_list_to_dispatch_tail(). For this last one, the name would
> 
> Could you explain a bit why you sort insert write rq in these two
> helpers? which are only triggered in case of dispatch busy.

For host-managed zoned block devices (SMR disks), writes have to be
sequential per zone of the device, otherwise an "unaligned write error"
is returned by the device. This constraint is exposed to the user (FS,
device mapper or applications doing raw I/Os to the block device). So a
well behaved user (f2fs and dm-zoned in the kernel) will issue
sequential writes to zones (this includes write same and write zeroes).
However, the current current blk-mq code does not guarantee that this
issuing order will be respected at dispatch time. There are multiple
reasons:

1) On submit, requests first go into per CPU context list. So if the
issuer thread is moved from one CPU to another in the middle of a
sequential write request sequence, the sequence would be broken in two
parts into different lists. When a scheduler is used, this can get fixed
by a nice LBA ordering (mq-deadline would do that), but in the "nonw"
scheduler case, the requests in the CPU lists are merged into the hctx
dispatch queue in CPU number order, so potentially reordering write
sequence. Hence the sort to fix that.

2) Dispatch may happen in parallel with multiple contexts getting
requests from the scheduler (or the CPU context lists) and again break
write sequences. I think your patch partly addresses this with the BUSY
flag, but when requests are in the dispatch queue already. However, at
dispatch time, requests go directly from the scheduler (or CPU context
lists) into the dispatch caller local list, bypassing the hctx dispatch
queue. Write ordering gets broken again here.

3) SCSI layer locks a device zone when it sees a write to prevent
subsequent write to the same zone. This is to avoid reordering at the
HBA level (AHCI has a 100% chance of doing it). In effect, this is a
write QD=1 per zone implementation, and that causes requeue of write
requests. In that case, this is a requeue happening after ->queue_rq()
call, so using the dispatch context local list. Combine that with (2)
and reordering can happen here too.

I have a series implementing a "dispatcher", which is basically a set of
operations that a device driver can specify to handle the dispatch
queue. The operations are basically "insert" and "get", so what you have
as helpers. The default dispatcher uses operations very similar to your
helpers minus the busy bit. That is, the default dispatcher does not
change the current behavior. But a ZBC dispatcher can be installed by
the scsi layer for a ZBC drive at device scan time and do the sort
insert of write requests to address all the potential reordering.

That series goes beyond what you did, and I was waiting for your series
to stabilize to rebase (or rework) what I did on top of your changes
which look like they would simplify handling of ZBC drives.

Note: ZBC drives are single queue devices, so they always only have a
single hctx.

> 
>> become a little awkward though. This sort insert would be to avoid
>> breaking a sequential write request sequence sent by the disk user. This
>> is needed since this reordering breakage cannot be solved only from the
>> SCSI layer.
> 
> Basically this patchset tries to flush hctx->dispatch first, then
> fetch requests from scheduler queue after htct->dispatch is flushed.
> 
> But it isn't strictly in this way because the implementation is lockless.
> 
> So looks the request from hctx->dispatch won't break one coming
> requests from scheduler.

Yes, I understood that. The result would be the requests staying longer
in the scheduler, increasing chances of merge. I think this is a good
idea. But unfortunately, I do not think that it will solve the ZBC
sequential write case in its own. In particular, this does not change
much to what happens to write request order without a scheduler, nor the
potential reordering on requeue. But I may be completely wrong here. I
need to look at your code more carefully.

I have not yet tested your code on ZBC drives. I will do it as soon as I
can.

Thanks.

Best regards.

-- 
Damien Le Moal,
Western Digital Research
