Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbeAQGXK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 01:23:10 -0500
Date: Wed, 17 Jan 2018 14:22:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
Message-ID: <20180117062251.GC9487@ming.t460p>
References: <20180112025306.28004-1-ming.lei@redhat.com>
 <20180112025306.28004-3-ming.lei@redhat.com>
 <0d36c16b-cb4b-6088-fdf3-2fe5d8f33cd7@oracle.com>
 <20180116121010.GA26429@ming.t460p>
 <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
 <20180116153248.GA3018@ming.t460p>
 <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
 <20180117035159.GA9487@ming.t460p>
 <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jianchao,

On Wed, Jan 17, 2018 at 01:24:23PM +0800, jianchao.wang wrote:
> Hi ming
> 
> Thanks for your kindly response.
> 
> On 01/17/2018 11:52 AM, Ming Lei wrote:
> >> It is here.
> >> __blk_mq_run_hw_queue()
> >> ....
> >>     WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> >>         cpu_online(hctx->next_cpu));
> > I think this warning is triggered after the CPU of hctx->next_cpu becomes
> > online again, and it should have been dealt with by the following trick,
> > and this patch is against the previous one, please test it and see if
> > the warning can be fixed.
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 23f0f3ddffcf..0620ccb65e4e 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1452,6 +1452,9 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
> >  			tried = true;
> >  			goto select_cpu;
> >  		}
> > +
> > +		/* handle after this CPU of hctx->next_cpu becomes online again */
> > +		hctx->next_cpu_batch = 1;
> >  		return WORK_CPU_UNBOUND;
> >  	}
> >  	return hctx->next_cpu;
> > 
> 
> The WARNING still could be triggered.
> 
> [  282.194532] WARNING: CPU: 0 PID: 222 at /home/will/u04/source_code/linux-block/block/blk-mq.c:1315 __blk_mq_run_hw_queue+0x92/0xa0
> [  282.194534] Modules linked in: ....
> [  282.194561] CPU: 0 PID: 222 Comm: kworker/2:1H Tainted: G        W        4.15.0-rc7+ #17
> 

This warning can't be removed completely, for example, the CPU figured
in blk_mq_hctx_next_cpu(hctx) can be put on again just after the
following call returns and before __blk_mq_run_hw_queue() is scheduled
to run.

	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work, msecs_to_jiffies(msecs))

Just be curious how you trigger this issue? And is it triggered in CPU
hotplug stress test? Or in a normal use case?

> >> ....
> >>
> >> To eliminate this risk totally, we could blk_mq_hctx_next_cpu return the cpu  even if the cpu is offlined and modify the cpu_online above to cpu_active.
> >> The kworkers of the per-cpu pool must have be migrated back when the cpu is set active.
> >> But there seems to be issues in DASD as your previous comment.
> > Yes, we can't break DASD.
> > 
> >> That is the original version of this patch, and both Christian and Stefan
> >> reported that system can't boot from DASD in this way[2], and I changed
> >> to AND with cpu_online_mask, then their system can boot well
> >> On the other hand, there is also risk in 
> >>
> >> @@ -440,7 +440,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >>  		blk_queue_exit(q);
> >>  		return ERR_PTR(-EXDEV);
> >>  	}
> >> -	cpu = cpumask_first(alloc_data.hctx->cpumask);
> >> +	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
> >>  	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
> >>
> >> what if the cpus in alloc_data.hctx->cpumask are all offlined ?
> > This one is crazy, and is used by NVMe only, it should be fine if
> > the passed 'hctx_idx' is retrieved by the current running CPU, such
> > as the way of blk_mq_map_queue(). But if not, bad thing may happen.
> Even if retrieved by current running cpu, the task still could be migrated away when the cpu is offlined.
> 

I just checked NVMe code, looks only nvmf_connect_io_queue() passes
one specific 'qid' and calls blk_mq_alloc_request_hctx(); and for others,
NVME_QID_ANY is passed, then blk_mq_alloc_request() is called in
nvme_alloc_request().

CC NVMe list and guys.

Hello James, Keith, Christoph and Sagi,

Looks nvmf_connect_io_queue() is run in the following fragile way:

	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
		...
		nvmf_connect_io_queue(&ctrl->ctrl, i);
		...
	}

The hardware queue idx is passed to nvmf_connect_io_queue() directly
and finally blk_mq_alloc_request_hctx() is called to allocate request
for the queue, but all CPUs mapped to this hw queue may become offline
when running in blk_mq_alloc_request_hctx(), so what is the supposed way
to handle this situation?

Is it fine to return failure simply in blk_mq_alloc_request_hctx()
under this situation? But the CPU may become online later...

Thanks,
Ming
