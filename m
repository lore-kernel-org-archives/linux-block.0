Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751831AbeAPMKc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 07:10:32 -0500
Date: Tue, 16 Jan 2018 20:10:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
Message-ID: <20180116121010.GA26429@ming.t460p>
References: <20180112025306.28004-1-ming.lei@redhat.com>
 <20180112025306.28004-3-ming.lei@redhat.com>
 <0d36c16b-cb4b-6088-fdf3-2fe5d8f33cd7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d36c16b-cb4b-6088-fdf3-2fe5d8f33cd7@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jianchao,

On Tue, Jan 16, 2018 at 06:12:09PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 01/12/2018 10:53 AM, Ming Lei wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > The previous patch assigns interrupt vectors to all possible CPUs, so
> > now hctx can be mapped to possible CPUs, this patch applies this fact
> > to simplify queue mapping & schedule so that we don't need to handle
> > CPU hotplug for dealing with physical CPU plug & unplug. With this
> > simplication, we can work well on physical CPU plug & unplug, which
> > is a normal use case for VM at least.
> > 
> > Make sure we allocate blk_mq_ctx structures for all possible CPUs, and
> > set hctx->numa_node for possible CPUs which are mapped to this hctx. And
> > only choose the online CPUs for schedule.
> > 
> > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Tested-by: Stefan Haberland <sth@linux.vnet.ibm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > (merged the three into one because any single one may not work, and fix
> > selecting online CPUs for scheduler)
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 19 ++++++++-----------
> >  1 file changed, 8 insertions(+), 11 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 8000ba6db07d..ef9beca2d117 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -440,7 +440,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >  		blk_queue_exit(q);
> >  		return ERR_PTR(-EXDEV);
> >  	}
> > -	cpu = cpumask_first(alloc_data.hctx->cpumask);
> > +	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> >  	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
> >  
> >  	rq = blk_mq_get_request(q, NULL, op, &alloc_data);
> > @@ -1323,9 +1323,10 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
> >  	if (--hctx->next_cpu_batch <= 0) {
> >  		int next_cpu;
> >  
> > -		next_cpu = cpumask_next(hctx->next_cpu, hctx->cpumask);
> > +		next_cpu = cpumask_next_and(hctx->next_cpu, hctx->cpumask,
> > +				cpu_online_mask);
> >  		if (next_cpu >= nr_cpu_ids)
> > -			next_cpu = cpumask_first(hctx->cpumask);
> > +			next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);
> 
> the next_cpu here could be >= nr_cpu_ids when the none of on hctx->cpumask is online.

That supposes not happen because storage device(blk-mq hw queue) is
generally C/S model, that means the queue becomes only active when
there is online CPU mapped to it.

But it won't be true for non-block-IO queue, such as HPSA's queues[1], and
network controller RX queues.

[1] https://marc.info/?l=linux-kernel&m=151601867018444&w=2

One thing I am still not sure(but generic irq affinity supposes to deal with
well) is that the CPU may become offline after the IO is just submitted,
then where the IRQ controller delivers the interrupt of this hw queue
to?

> This could be reproduced on NVMe with a patch that could hold some rqs on ctx->rq_list,
> meanwhile a script online and offline the cpus. Then a panic occurred in __queue_work().

That shouldn't happen, when CPU offline happens the rqs in ctx->rq_list
are dispatched directly, please see blk_mq_hctx_notify_dead().

> 
> maybe cpu_possible_mask here, the workers in the pool of the offlined cpu has been unbound.
> It should be ok to queue on them.

That is the original version of this patch, and both Christian and Stefan
reported that system can't boot from DASD in this way[2], and I changed
to AND with cpu_online_mask, then their system can boot well.

[2] https://marc.info/?l=linux-kernel&m=151256312722285&w=2

-- 
Ming
