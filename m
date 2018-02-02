Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: [PATCH v2 2/2] block: Fix a race between the throttling code and
 request queue initialization
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
References: <20180131235300.12773-1-bart.vanassche@wdc.com>
 <20180131235300.12773-3-bart.vanassche@wdc.com>
 <1ff1b2fa-ffe1-20f4-6be9-919c6a5b8227@linux.alibaba.com>
 <1517501761.2746.21.camel@wdc.com>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <26f758cf-430c-aa7f-0d21-75fbad6db260@gmail.com>
Date: Fri, 2 Feb 2018 09:02:46 +0800
MIME-Version: 1.0
In-Reply-To: <1517501761.2746.21.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

On 18/2/2 00:16, Bart Van Assche wrote:
> On Thu, 2018-02-01 at 09:53 +0800, Joseph Qi wrote:
>> I'm afraid the risk may also exist in blk_cleanup_queue, which will
>> set queue_lock to to the default internal lock.
>>
>> spin_lock_irq(lock);
>> if (q->queue_lock != &q->__queue_lock)
>> 	q->queue_lock = &q->__queue_lock;
>> spin_unlock_irq(lock);
>>
>> I'm thinking of getting blkg->q->queue_lock to local first, but this
>> will result in still using driver lock even the queue_lock has already
>> been set to the default internal lock.
> 
> Hello Joseph,
> 
> I think the race between the queue_lock assignment in blk_cleanup_queue()
> and the use of that pointer by cgroup attributes could be solved by
> removing the visibility of these attributes from blk_cleanup_queue() instead
> of __blk_release_queue(). However, last time I proposed to move code from
> __blk_release_queue() into blk_cleanup_queue() I received the feedback that
> from some kernel developers that they didn't like this.
> 
> Is the block driver that triggered the race on the q->queue_lock assignment
> using legacy (single queue) or multiqueue (blk-mq) mode? If that driver is
> using legacy mode, are you aware that there are plans to remove legacy mode
> from the upstream kernel? And if your driver is using multiqueue mode, how
> about the following change instead of the two patches in this patch series:
> 
We triggered this race when using single queue. I'm not sure if it
exists in multi-queue.
Do you mean upstream won't fix bugs any more in single queue?

Thanks,
Joseph

> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1093,7 +1093,7 @@ blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int node_id)
>  		return NULL;
>  
>  	q->request_fn = rfn;
> -	if (lock)
> +	if (!q->mq_ops && lock)
>  		q->queue_lock = lock;
>  	if (blk_init_allocated_queue(q) < 0) {
>  		blk_cleanup_queue(q);
> 
> Thanks,
> 
> Bart.
> 
