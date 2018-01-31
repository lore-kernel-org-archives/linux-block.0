Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [RFC] hard LOCKUP caused by race between blk_init_queue_node and
 blkcg_print_blkgs
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "gavin.dg@linux.alibaba.com" <gavin.dg@linux.alibaba.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <5ac9562b-b20a-9f5a-90c5-2187552b6f09@linux.alibaba.com>
 <1517347168.2589.56.camel@wdc.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <e34840cd-d317-b195-aad8-f32668608f1f@linux.alibaba.com>
Date: Wed, 31 Jan 2018 09:53:21 +0800
MIME-Version: 1.0
In-Reply-To: <1517347168.2589.56.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart,
Thanks very much for the quick response.

On 18/1/31 05:19, Bart Van Assche wrote:
> On Tue, 2018-01-30 at 19:21 +0800, Joseph Qi wrote:
>> Hi Jens and Folks,
>>
>> Recently we've gotten a hard LOCKUP issue. After investigating the issue
>> we've found a race between blk_init_queue_node and blkcg_print_blkgs.
>> The race is described below.
>>
>> blk_init_queue_node                 blkcg_print_blkgs
>>   blk_alloc_queue_node (1)
>>     q->queue_lock = &q->__queue_lock (2)
>>     blkcg_init_queue(q) (3)
>>                                     spin_lock_irq(blkg->q->queue_lock) (4)
>>   q->queue_lock = lock (5)
>>                                     spin_unlock_irq(blkg->q->queue_lock) (6)
>>
>> (1) allocate an uninitialized queue;
>> (2) initialize queue_lock to its default internal lock;
>> (3) initialize blkcg part of request queue, which will create blkg and
>> then insert it to blkg_list;
>> (4) traverse blkg_list and find the created blkg, and then take its
>> queue lock, here it is the default *internal lock*;
>> (5) *race window*, now queue_lock is overridden with *driver specified
>> lock*;
>> (6) now unlock *driver specified lock*, not the locked *internal lock*,
>> unlock balance breaks.
>>
>> For the issue above, I think blkcg_init_queue is a bit earlier. We
>> can't allow a further use before request queue is fully initialized.
>> Since blk_init_queue_node is a really common path and it allows driver
>> to override the default internal lock, I'm afraid several other places
>> may also have the same issue.
>> Am I missing something here?
> 
> What code triggered the blkcg_print_blkgs() call? Was it perhaps a function
> related to throttling? If so, I think there are two possible ways to fix this
> race:
Yes, it is from block throttle.

> 1. Moving the .queue_lock initialization from blk_init_queue_node() into
>    blk_alloc_queue_node() such that it happens before the blkcg_init_queue()
>    call. This however will require a tree-wide change of the blk_alloc_queue()
>    and all blk_alloc_queue_node() calls in all block drivers.
> 2. Splitting the blk_throtl_init() function such that the blkcg_activate_policy()
>    call can occur after the .queue_lock pointer has been initialized, e.g. from
>    inside blk_init_allocated_queue() or from inside blk_register_queue() instead
>    of from inside blkcg_init_queue().
> 
At the first glance, I'm thinking of moving the blkcg_init_queue after
the queue_lock is overridden. But I don't have an idea yet to avoid the
risk during cleanup.
Since the initialization of request queue is so fundamental, I'm not
sure if there is the same risk in several other places.

Thanks,
Joseph

> I'm not sure what the best approach is. Maybe there is even a third approach
> that is better than the two approaches mentioned above.
> 
> Bart.
> 
