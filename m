Return-Path: <ming.lei@redhat.com>
Date: Thu, 27 Sep 2018 10:28:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Zach Marano <zmarano@google.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: complete req in softirq context in case of
 single queue
Message-ID: <20180927022833.GB23735@ming.t460p>
References: <20180926160851.21929-1-ming.lei@redhat.com>
 <71a5dc4c-c0bd-2ff5-545c-d58da05fd1e0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <71a5dc4c-c0bd-2ff5-545c-d58da05fd1e0@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Dongli,

On Thu, Sep 27, 2018 at 10:00:28AM +0800, Dongli Zhang wrote:
> Hi Ming,
> 
> On 09/27/2018 12:08 AM, Ming Lei wrote:
> > Lot of controllers may have only one irq vector for completing IO
> > request. And usually affinity of the only irq vector is all possible
> > CPUs, however, on most of ARCH, there may be only one specific CPU
> > for handling this interrupt.
> 
> Does this indicate the hardware would always notify the same cpu even if several
> cpu are set in the affinity? Is this the case in virtio or all hardwares?

It should be in all hardware, please see the following explanation from Thomas
Gleixner:

https://lkml.org/lkml/2018/4/4/734

> 
> xen pv driver is in this case. No matter how many cpu are set in affinity, the
> xen hypervisor only notifies the 1st cpu in the affinity (via xen event channel).

That is understood, since emulated devices actually follow the hardware
interrupt model in reality.

> 
> 
> I have an extra basic question perhaps not related to this patch:
> 
> Why not delay other cases in softirq as well? (perhaps this is a question about
> mq but not for patch).

In case of multiple hw queues, such as NVMe, one hw queue is mapped to
one single CPU usually, so it is fine to just complete the IO in hw irq
context.

Thanks,
Ming

> 
> 
> 
> > 
> > So if all IOs are completed in hardirq context, it is inevitable to
> > degrade IO performance because of increased irq latency.
> > 
> > This patch tries to address this issue by allowing to complete request
> > in softirq context, like the legacy IO path.
> > 
> > IOPS is observed as ~13%+ in the following randread test on raid0 over
> > virtio-scsi.
> > 
> > mdadm --create --verbose /dev/md0 --level=0 --chunk=1024 --raid-devices=8 /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh /dev/sdi
> > 
> > fio --time_based --name=benchmark --runtime=30 --filename=/dev/md0 --nrfiles=1 --ioengine=libaio --iodepth=32 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 --numjobs=32 --rw=randread --blocksize=4k
> > 
> > Cc: Zach Marano <zmarano@google.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c      | 14 ++++++++++++++
> >  block/blk-softirq.c |  7 +++++--
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 85a1c1a59c72..d4792c3ac983 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -565,6 +565,20 @@ static void __blk_mq_complete_request(struct request *rq)
> >  	if (rq->internal_tag != -1)
> >  		blk_mq_sched_completed_request(rq);
> >  
> > +	/*
> > +	 * Most of single queue controllers, there is only one irq vector
> > +	 * for handling IO completion, and the only irq's affinity is set
> > +	 * as all possible CPUs. On most of ARCHs, this affinity means the
> > +	 * irq is handled on one specific CPU.
> > +	 *
> > +	 * So complete IO reqeust in softirq context in case of single queue
> > +	 * for not degrading IO performance by irqsoff latency.
> > +	 */
> > +	if (rq->q->nr_hw_queues == 1) {
> > +		__blk_complete_request(rq);
> > +		return;
> > +	}
> > +
> >  	if (!test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags)) {
> >  		rq->q->softirq_done_fn(rq);
> >  		return;
> > diff --git a/block/blk-softirq.c b/block/blk-softirq.c
> > index 15c1f5e12eb8..b1df9b6c1731 100644
> > --- a/block/blk-softirq.c
> > +++ b/block/blk-softirq.c
> > @@ -101,17 +101,20 @@ void __blk_complete_request(struct request *req)
> >  	struct request_queue *q = req->q;
> >  	unsigned long flags;
> >  	bool shared = false;
> > +	int rq_cpu;
> >  
> >  	BUG_ON(!q->softirq_done_fn);
> >  
> > +	rq_cpu = q->mq_ops ? req->mq_ctx->cpu : req->cpu;
> > +
> >  	local_irq_save(flags);
> >  	cpu = smp_processor_id();
> >  
> >  	/*
> >  	 * Select completion CPU
> >  	 */
> > -	if (req->cpu != -1) {
> > -		ccpu = req->cpu;
> > +	if (rq_cpu != -1) {
> > +		ccpu = q->mq_ops ? req->mq_ctx->cpu : req->cpu;
> >  		if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
> >  			shared = cpus_share_cache(cpu, ccpu);
> >  	} else
> > 

-- 
Ming
