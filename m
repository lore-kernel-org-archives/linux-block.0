Return-Path: <ming.lei@redhat.com>
Date: Sat, 7 Oct 2017 12:33:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v6 9/9] block, scsi: Make SCSI device suspend and resume
 work reliably
Message-ID: <20171007043314.GA16732@ming.t460p>
References: <20171005000110.15904-1-bart.vanassche@wdc.com>
 <20171005000110.15904-10-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171005000110.15904-10-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 04, 2017 at 05:01:10PM -0700, Bart Van Assche wrote:
> It is essential during suspend and resume that neither the filesystem
> state nor the filesystem metadata in RAM changes. This is why while
> the hibernation image is being written or restored that SCSI devices

quiesce isn't used only for suspend and resume, And the issue isn't
suspend/resume specific too. So please change the title/commit log
as sort of 'make SCSI quiesce more reliable/safe'. 

> are quiesced. The SCSI core quiesces devices through scsi_device_quiesce()
> and scsi_device_resume(). In the SDEV_QUIESCE state execution of
> non-preempt requests is deferred. This is realized by returning
> BLKPREP_DEFER from inside scsi_prep_state_check() for quiesced SCSI
> devices. Avoid that a full queue prevents power management requests
> to be submitted by deferring allocation of non-preempt requests for
> devices in the quiesced state. This patch has been tested by running
> the following commands and by verifying that after resume the fio job
> is still running:
> 
> for d in /sys/class/block/sd*[a-z]; do
>   hcil=$(readlink "$d/device")
>   hcil=${hcil#../../../}
>   echo 4 > "$d/queue/nr_requests"
>   echo 1 > "/sys/class/scsi_device/$hcil/device/queue_depth"
> done
> bdev=$(readlink /dev/disk/by-uuid/5217d83f-213e-4b42-b86e-20013325ba6c)
> bdev=${bdev#../../}
> hcil=$(readlink "/sys/block/$bdev/device")
> hcil=${hcil#../../../}
> fio --name="$bdev" --filename="/dev/$bdev" --buffered=0 --bs=512 --rw=randread \
>   --ioengine=libaio --numjobs=4 --iodepth=16 --iodepth_batch=1 --thread \
>   --loops=$((2**31)) &
> pid=$!
> sleep 1
> systemctl hibernate
> sleep 10
> kill $pid
> 
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> References: "I/O hangs after resuming from suspend-to-ram" (https://marc.info/?l=linux-block&m=150340235201348).
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-core.c        | 38 ++++++++++++++++++++++++++++++--------
>  block/blk-mq.c          |  4 ++--
>  block/blk-timeout.c     |  2 +-
>  drivers/scsi/scsi_lib.c | 27 +++++++++++++++++++--------
>  fs/block_dev.c          |  4 ++--
>  include/linux/blkdev.h  |  2 +-
>  6 files changed, 55 insertions(+), 22 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b8d90fc29b35..81a4bb119d50 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -371,6 +371,7 @@ void blk_clear_preempt_only(struct request_queue *q)
>  
>  	spin_lock_irqsave(q->queue_lock, flags);
>  	queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
> +	wake_up_all(&q->mq_freeze_wq);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
> @@ -792,15 +793,34 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(blk_alloc_queue);
>  
> -int blk_queue_enter(struct request_queue *q, bool nowait)
> +/**
> + * blk_queue_enter() - try to increase q->q_usage_counter
> + * @q: request queue pointer
> + * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PREEMPT
> + */
> +int blk_queue_enter(struct request_queue *q, unsigned int flags)
>  {
> +	const bool preempt = flags & BLK_MQ_REQ_PREEMPT;
> +
>  	while (true) {
>  		int ret;
>  
> -		if (percpu_ref_tryget_live(&q->q_usage_counter))
> -			return 0;
> +		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
> +			/*
> +			 * The code that sets the PREEMPT_ONLY flag is
> +			 * responsible for ensuring that that flag is globally
> +			 * visible before the queue is unfrozen.
> +			 */
> +			if (preempt || !blk_queue_preempt_only(q)) {

PREEMPT_ONLY flag is checked without RCU read lock held, so the
synchronize_rcu() may just wait for completion of pre-exit
percpu_ref_tryget_live(), which can be reordered with the
reading on blk_queue_preempt_only().

> +				return 0;
> +			} else {
> +				percpu_ref_put(&q->q_usage_counter);
> +				WARN_ONCE("%s: Attempt to allocate non-preempt request in preempt-only mode.\n",
> +					  kobject_name(q->kobj.parent));
> +			}
> +		}
>  
> -		if (nowait)
> +		if (flags & BLK_MQ_REQ_NOWAIT)
>  			return -EBUSY;
>  
>  		/*
> @@ -813,7 +833,8 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
>  		smp_rmb();
>  
>  		ret = wait_event_interruptible(q->mq_freeze_wq,
> -				!atomic_read(&q->mq_freeze_depth) ||
> +				(atomic_read(&q->mq_freeze_depth) == 0 &&
> +				 (preempt || !blk_queue_preempt_only(q))) ||
>  				blk_queue_dying(q));
>  		if (blk_queue_dying(q))
>  			return -ENODEV;
> @@ -1441,8 +1462,7 @@ static struct request *blk_old_get_request(struct request_queue *q,
>  	/* create ioc upfront */
>  	create_io_context(gfp_mask, q->node);
>  
> -	ret = blk_queue_enter(q, !(gfp_mask & __GFP_DIRECT_RECLAIM) ||
> -			      (op & REQ_NOWAIT));
> +	ret = blk_queue_enter(q, flags);
>  	if (ret)
>  		return ERR_PTR(ret);
>  	spin_lock_irq(q->queue_lock);
> @@ -2263,8 +2283,10 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	current->bio_list = bio_list_on_stack;
>  	do {
>  		struct request_queue *q = bio->bi_disk->queue;
> +		unsigned int flags = bio->bi_opf & REQ_NOWAIT ?
> +			BLK_MQ_REQ_NOWAIT : 0;
>  
> -		if (likely(blk_queue_enter(q, bio->bi_opf & REQ_NOWAIT) == 0)) {
> +		if (likely(blk_queue_enter(q, flags) == 0)) {
>  			struct bio_list lower, same;
>  
>  			/* Create a fresh bio_list for all subordinate requests */
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 271657992d1a..1604bc2d4a57 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -386,7 +386,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
>  	struct request *rq;
>  	int ret;
>  
> -	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
> +	ret = blk_queue_enter(q, flags);
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> @@ -425,7 +425,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	if (hctx_idx >= q->nr_hw_queues)
>  		return ERR_PTR(-EIO);
>  
> -	ret = blk_queue_enter(q, true);
> +	ret = blk_queue_enter(q, flags);
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index 17ec83bb0900..b75d975cc5a5 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -134,7 +134,7 @@ void blk_timeout_work(struct work_struct *work)
>  	struct request *rq, *tmp;
>  	int next_set = 0;
>  
> -	if (blk_queue_enter(q, true))
> +	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT))
>  		return;
>  	spin_lock_irqsave(q->queue_lock, flags);
>  
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 1c16a247fae6..0ba7af5debc7 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2926,21 +2926,30 @@ static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
>  int
>  scsi_device_quiesce(struct scsi_device *sdev)
>  {
> +	struct request_queue *q = sdev->request_queue;
>  	int err;
>  
> +	blk_mq_freeze_queue(q);
> +	if (blk_set_preempt_only(q)) {
> +		blk_mq_unfreeze_queue(q);
> +		return -EINVAL;
> +	}

This way is wrong, if blk_set_preempt_only() returns true
it means the queue has been in PREEMPT_ONLY already,
and failing scsi_device_quiesce() can break suspend/resume or
sending SCSI domain validation command.

The reasonable handling should be just going ahead if queue
is in PREEMPT_ONLY already.

> +	/*
> +	 * Ensure that the effect of blk_set_preempt_only() will be visible
> +	 * for percpu_ref_tryget() callers that occur after the queue
> +	 * unfreeze. See also https://lwn.net/Articles/573497/.
> +	 */
> +	synchronize_rcu();

This synchronize_rcu may be saved if we set the PREEMPT_ONLY flag
before freezing queue since blk_mq_freeze_queue() may implicate
one synchronize_rcu().

> +	blk_mq_unfreeze_queue(q);
> +
>  	mutex_lock(&sdev->state_mutex);
>  	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
>  	mutex_unlock(&sdev->state_mutex);
>  
>  	if (err)
> -		return err;
> +		blk_clear_preempt_only(q);
>  
> -	scsi_run_queue(sdev->request_queue);
> -	while (atomic_read(&sdev->device_busy)) {
> -		msleep_interruptible(200);
> -		scsi_run_queue(sdev->request_queue);
> -	}
> -	return 0;
> +	return err;
>  }
>  EXPORT_SYMBOL(scsi_device_quiesce);
>  
> @@ -2961,8 +2970,10 @@ void scsi_device_resume(struct scsi_device *sdev)
>  	 */
>  	mutex_lock(&sdev->state_mutex);
>  	if (sdev->sdev_state == SDEV_QUIESCE &&
> -	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0)
> +	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0) {
> +		blk_clear_preempt_only(sdev->request_queue);
>  		scsi_run_queue(sdev->request_queue);
> +	}
>  	mutex_unlock(&sdev->state_mutex);

scsi_run_queue() can be removed, and blk_clear_preempt_only() needn't
to be run with holding sdev->state_mutex, just like in quiesce path.

-- 
Ming
