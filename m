Return-Path: <ming.lei@redhat.com>
Date: Thu, 18 Jan 2018 00:14:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@infradead.org>,
	"jianchao . wang" <jianchao.w.wang@oracle.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] blk-mq: make sure hctx->next_cpu is set correctly
Message-ID: <20180117161359.GB21896@ming.t460p>
References: <20180117123444.18393-1-ming.lei@redhat.com>
 <20180117123444.18393-2-ming.lei@redhat.com>
 <19f12f79-2402-df02-0910-7e675fa343c8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19f12f79-2402-df02-0910-7e675fa343c8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 17, 2018 at 08:45:44AM -0700, Jens Axboe wrote:
> On 1/17/18 5:34 AM, Ming Lei wrote:
> > When hctx->next_cpu is set from possible online CPUs, there is one
> > race in which hctx->next_cpu may be set as >= nr_cpu_ids, and finally
> > break workqueue.
> > 
> > The race is triggered when one CPU is becoming DEAD, blk_mq_hctx_notify_dead()
> > is called to dispatch requests from the DEAD cpu context, but at that
> > time, this DEAD CPU has been cleared from 'cpu_online_mask', so all
> > CPUs in hctx->cpumask may become offline, and cause hctx->next_cpu set
> > a bad value.
> > 
> > This patch deals with this issue by re-selecting next CPU, and make
> > sure it is set correctly.
> > 
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Reported-by: "jianchao.wang" <jianchao.w.wang@oracle.com>
> > Tested-by: "jianchao.wang" <jianchao.w.wang@oracle.com>
> > Fixes: 20e4d81393 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index c376d1b6309a..dc4066d28323 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1416,21 +1416,48 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> >   */
> >  static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
> >  {
> > +	bool tried = false;
> > +
> >  	if (hctx->queue->nr_hw_queues == 1)
> >  		return WORK_CPU_UNBOUND;
> >  
> >  	if (--hctx->next_cpu_batch <= 0) {
> >  		int next_cpu;
> > -
> > +select_cpu:
> >  		next_cpu = cpumask_next_and(hctx->next_cpu, hctx->cpumask,
> >  				cpu_online_mask);
> >  		if (next_cpu >= nr_cpu_ids)
> >  			next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);
> >  
> > -		hctx->next_cpu = next_cpu;
> > +		/*
> > +		 * No online CPU is found here, and this may happen when
> > +		 * running from blk_mq_hctx_notify_dead(), and make sure
> > +		 * hctx->next_cpu is set correctly for not breaking workqueue.
> > +		 */
> > +		if (next_cpu >= nr_cpu_ids)
> > +			hctx->next_cpu = cpumask_first(hctx->cpumask);
> > +		else
> > +			hctx->next_cpu = next_cpu;
> >  		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
> 
> Since this should _only_ happen from the offline notification, why don't
> we move the reset/update logic in that path and out of the hot path?

This way is clean, and the only cost introduced is the following two
'if' in hot path:

	if (next_cpu >= nr_cpu_ids)

	and 

	if (!cpu_online(hctx->next_cpu))

Now I think it can be triggered not only in CPU dead path, but also
in normal run queue, and it is just easy to trigger it in CPU dead
path in Jianchao's test:

- blk_mq_delay_run_hw_queue() is called from CPU B, and found the queue
should be run on other CPUs

- then blk_mq_hctx_next_cpu() is called, and we have to check if
the destination CPU(the computed hctx->next_cpu) is still online.

Then the check is required in hot path too, but given the cost is
small enough, so it shouldn't be a bid deal.

Or we have to introduce CPU hotplug handler to update hctx->cpumask,
and it should be doable with help of RCU. We can work towards to
this direction if you don't mind.

Thanks,
Ming
