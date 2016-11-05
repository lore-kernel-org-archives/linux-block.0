Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
To: Ming Lei <tom.leiming@gmail.com>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com>
 <CACVXFVME3jpraUR8cp_i-YFYu4rk4gUCZqOi86PpCHGRrh9c_g@mail.gmail.com>
 <bd83d2b6-3e7f-18c0-45d6-7b9f6c015722@fb.com>
 <CACVXFVM0atkprhvin8CXaxMJhx+p_hJtpbkJfxQDskojSSNHGQ@mail.gmail.com>
 <f1a797b7-6cbd-d3b9-3b33-d38b554c1227@fb.com>
 <CACVXFVNnZoXOjVmfaCk+qhTf6W3UG6feUPsHWHYin2q0ELK4Ww@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c0444b09-3f50-cb36-52f2-6e3860c9f0b7@kernel.dk>
Date: Sat, 5 Nov 2016 14:49:57 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVNnZoXOjVmfaCk+qhTf6W3UG6feUPsHWHYin2q0ELK4Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/04/2016 05:13 PM, Ming Lei wrote:
>>> Even though it is true, the statistics still may become a mess with rare
>>> collisons.
>>
>>
>> How so? Not saying we could not improve it, but we're trading off
>> precision for scalability. My claim is that the existing code is good
>> enough. I've run a TON of testing on it, since I've used it for multiple
>> projects, and it's been solid.
>
> +static void blk_stat_flush_batch(struct blk_rq_stat *stat)
> +{
> +       if (!stat->nr_batch)
> +               return;
> +       if (!stat->nr_samples)
> +               stat->mean = div64_s64(stat->batch, stat->nr_batch);
>
> For example, two reqs(A & B) are completed at the same time, and A is
> on CPU0, and B is on CPU1.
>
> If the two last writting in the function is reordered observed from
> CPU1, for B, CPU1 runs the above branch when it just sees stat->batch
> is set as zero, but nr_samples isn't updated yet, then div_zero is
> triggered.

We should probably just have the nr_batch be a READ_ONCE(). I'm fine
with the stats being a bit off in the rare case of a collision, but we
can't have a divide-by-zero, obviously.

>
> +       else {
> +               stat->mean = div64_s64((stat->mean * stat->nr_samples) +
> +                                       stat->batch,
> +                                       stat->nr_samples + stat->nr_batch);
> +       }
>
> BTW, the above 'if else' can be removed, and 'stat->mean' can be computed
> in the 2nd way.

True, they could be collapsed.

>> Yes, that might be a good idea, since it doesn't cost us anything. For
>> the mq case, I'm hard pressed to think of areas where we could complete
>> IO in parallel on the same software queue. You'll never have a software
>> queue mapped to multiple hardware queues. So we should essentially be
>> serialized.
>
> For blk-mq, blk_mq_stat_add() is called in __blk_mq_complete_request()
> which is often run from interrupt handler, and the CPU serving the interrupt
> can be different with the submitting CPU for rq->mq_ctx. And there can be
> several CPUs handling the interrupts originating from same sw queue.
>
> BTW, I don't object to this patch actually, but maybe we should add
> comment about this kind of race. Cause in the future someone might find
> the statistics becomes not accurate, and they may understand or
> try to improve.

I'm fine with documenting it. For the two use cases I have, I'm fine
with it not being 100% stable. For by far the majority of the windows,
it'll be just fine. I'll fix the divide-by-zero, though.

-- 
Jens Axboe
