Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: Omar Sandoval <osandov@osandov.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
Date: Wed, 23 May 2018 09:47:05 +0800
MIME-Version: 1.0
In-Reply-To: <20180522200214.GF9536@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Omar

Thanks for your kindly response.

On 05/23/2018 04:02 AM, Omar Sandoval wrote:
> On Tue, May 22, 2018 at 10:48:29PM +0800, Jianchao Wang wrote:
>> Currently, kyber is very unfriendly with merging. kyber depends
>> on ctx rq_list to do merging, however, most of time, it will not
>> leave any requests in ctx rq_list. This is because even if tokens
>> of one domain is used up, kyber will try to dispatch requests
>> from other domain and flush the rq_list there.
> 
> That's a great catch, I totally missed this.
> 
> This approach does end up duplicating a lot of code with the blk-mq core
> even after Jens' change, so I'm curious if you tried other approaches.
> One idea I had is to try the bio merge against the kqd->rqs lists. Since
> that's per-queue, the locking overhead might be too high. Alternatively,

Yes, I used to make a patch as you say, try the bio merge against kqd->rqs directly.
The patch looks even simpler. However, because the khd->lock is needed every time 
when try bio merge, there maybe high contending overhead on hkd->lock when cpu-hctx
mapping is not 1:1. 

> you could keep the software queues as-is but add our own version of
> flush_busy_ctxs() that only removes requests of the domain that we want.
> If one domain gets backed up, that might get messy with long iterations,
> though.

Yes, I also considered this approach :)
But the long iterations on every ctx->rq_list looks really inefficient.

> 
> Regarding this approach, a couple of comments below.
...
>>  }
>> @@ -379,12 +414,33 @@ static void kyber_exit_sched(struct elevator_queue *e)
>>  static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>>  {
>>  	struct kyber_hctx_data *khd;
>> +	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
>>  	int i;
>> +	int sd;
>>  
>>  	khd = kmalloc_node(sizeof(*khd), GFP_KERNEL, hctx->numa_node);
>>  	if (!khd)
>>  		return -ENOMEM;
>>  
>> +	khd->kcqs = kmalloc_array_node(nr_cpu_ids, sizeof(void *),
>> +					GFP_KERNEL, hctx->numa_node);
>> +	if (!khd->kcqs)
>> +		goto err_khd;
> 
> Why the double indirection of a percpu allocation per hardware queue
> here? With, say, 56 cpus and that many hardware queues, that's 3136
> pointers, which seems like overkill. Can't you just use the percpu array
> in the kqd directly, or make it per-hardware queue instead?

oops, I forgot to change the nr_cpu_ids to hctx->nr_ctx.
The mapping between cpu and hctx has been setup when kyber_init_hctx is invoked,
so just need to allocate hctx->nr_ctx * struct kyber_ctx_queue per khd.

...
>> +static int bio_sched_domain(const struct bio *bio)
>> +{
>> +	unsigned int op = bio->bi_opf;
>> +
>> +	if ((op & REQ_OP_MASK) == REQ_OP_READ)
>> +		return KYBER_READ;
>> +	else if ((op & REQ_OP_MASK) == REQ_OP_WRITE && op_is_sync(op))
>> +		return KYBER_SYNC_WRITE;
>> +	else
>> +		return KYBER_OTHER;
>> +}
> 
> Please add a common helper for rq_sched_domain() and bio_sched_domain()
> instead of duplicating the logic.
> 

Yes, I will do it in next version.

Thanks
Jianchao
