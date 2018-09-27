Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: complete req in softirq context in case of single
 queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Zach Marano <zmarano@google.com>,
        Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
References: <20180926160851.21929-1-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <cba00f12-340f-fbb8-2ed0-98255a05291f@oracle.com>
Date: Thu, 27 Sep 2018 11:30:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180926160851.21929-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 09/27/2018 12:08 AM, Ming Lei wrote:
> Lot of controllers may have only one irq vector for completing IO
> request. And usually affinity of the only irq vector is all possible
> CPUs, however, on most of ARCH, there may be only one specific CPU
> for handling this interrupt.
> 
> So if all IOs are completed in hardirq context, it is inevitable to
> degrade IO performance because of increased irq latency.
> 
> This patch tries to address this issue by allowing to complete request
> in softirq context, like the legacy IO path.
> 
> IOPS is observed as ~13%+ in the following randread test on raid0 over
> virtio-scsi.
> 
> mdadm --create --verbose /dev/md0 --level=0 --chunk=1024 --raid-devices=8 /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh /dev/sdi
> 
> fio --time_based --name=benchmark --runtime=30 --filename=/dev/md0 --nrfiles=1 --ioengine=libaio --iodepth=32 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 --numjobs=32 --rw=randread --blocksize=4k
> 
> Cc: Zach Marano <zmarano@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c      | 14 ++++++++++++++
>  block/blk-softirq.c |  7 +++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 85a1c1a59c72..d4792c3ac983 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -565,6 +565,20 @@ static void __blk_mq_complete_request(struct request *rq)
>  	if (rq->internal_tag != -1)
>  		blk_mq_sched_completed_request(rq);
>  
> +	/*
> +	 * Most of single queue controllers, there is only one irq vector
> +	 * for handling IO completion, and the only irq's affinity is set
> +	 * as all possible CPUs. On most of ARCHs, this affinity means the
> +	 * irq is handled on one specific CPU.
> +	 *
> +	 * So complete IO reqeust in softirq context in case of single queue
> +	 * for not degrading IO performance by irqsoff latency.
> +	 */
> +	if (rq->q->nr_hw_queues == 1) {
> +		__blk_complete_request(rq);
> +		return;
> +	}
> +
>  	if (!test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags)) {
>  		rq->q->softirq_done_fn(rq);
>  		return;
> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
> index 15c1f5e12eb8..b1df9b6c1731 100644
> --- a/block/blk-softirq.c
> +++ b/block/blk-softirq.c
> @@ -101,17 +101,20 @@ void __blk_complete_request(struct request *req)
>  	struct request_queue *q = req->q;
>  	unsigned long flags;
>  	bool shared = false;
> +	int rq_cpu;
>  
>  	BUG_ON(!q->softirq_done_fn);
>  
> +	rq_cpu = q->mq_ops ? req->mq_ctx->cpu : req->cpu;
> +
>  	local_irq_save(flags);
>  	cpu = smp_processor_id();
>  
>  	/*
>  	 * Select completion CPU
>  	 */
> -	if (req->cpu != -1) {
> -		ccpu = req->cpu;
> +	if (rq_cpu != -1) {
> +		ccpu = q->mq_ops ? req->mq_ctx->cpu : req->cpu;
>  		if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
>  			shared = cpus_share_cache(cpu, ccpu);
>  	} else
> 
;

Only QUEUE_FLAG_SAME_COMP is set, we will try to complete the request on the cpu
where it is allocated.

For the blk-legacy, the req->cpu is -1 when QUEUE_FLAG_SAME_COMP is not set.

blk_queue_bio

	if (test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags))
		req->cpu = raw_smp_processor_id()

But for the blk-mq, the req->mq_ctx->cpu must be valid.
So we should check the QUEUE_FLAG_SAME_COMP for the blk-mq case.

On the other hand, how about split the softirq completion part out of
__blk_complete_request ？ It is confused when find __blk_complete_request
in __blk_mq_complete_request.

Thanks
Jianchao
