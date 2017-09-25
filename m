Return-Path: <ming.lei@redhat.com>
Date: Mon, 25 Sep 2017 10:26:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 5/6] block: Make SCSI device suspend and resume work
 reliably
Message-ID: <20170925022621.GB6434@ming.t460p>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
 <20170922221405.22091-6-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922221405.22091-6-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 22, 2017 at 03:14:04PM -0700, Bart Van Assche wrote:
> It is essential during suspend and resume that neither the filesystem
> state nor the filesystem metadata in RAM changes. This is why while
> the hibernation image is being written or restored that SCSI devices
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
>  block/blk-core.c       | 37 ++++++++++++++++++++++++++++---------
>  block/blk-mq.c         |  4 ++--
>  block/blk-timeout.c    |  2 +-
>  fs/block_dev.c         |  4 ++--
>  include/linux/blkdev.h |  2 +-
>  5 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 45cf3f56a730..971825bd4462 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -351,10 +351,12 @@ void blk_set_preempt_only(struct request_queue *q, bool preempt_only)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(q->queue_lock, flags);
> -	if (preempt_only)
> +	if (preempt_only) {
>  		queue_flag_set(QUEUE_FLAG_PREEMPT_ONLY, q);
> -	else
> +	} else {
>  		queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
> +		wake_up_all(&q->mq_freeze_wq);
> +	}
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }
>  EXPORT_SYMBOL(blk_set_preempt_only);
> @@ -773,13 +775,29 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(blk_alloc_queue);
>  
> -int blk_queue_enter(struct request_queue *q, bool nowait)
> +/**
> + * blk_queue_enter() - try to increase q->q_usage_counter
> + * @q: request queue pointer
> + * @nowait: if the queue is frozen, do not wait until it is unfrozen
> + * @preempt: if QUEUE_FLAG_PREEMPT_ONLY has been set, do not wait until that
> + *	flag has been cleared
> + */
> +int blk_queue_enter(struct request_queue *q, bool nowait, bool preempt)
>  {
>  	while (true) {
>  		int ret;
>  
> -		if (percpu_ref_tryget_live(&q->q_usage_counter))
> -			return 0;
> +		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
> +			/*
> +			 * Ensure read order of q_usage_counter and the
> +			 * PREEMPT_ONLY queue flag.
> +			 */
> +			smp_rmb();
> +			if (preempt || !blk_queue_preempt_only(q))
> +				return 0;
> +			else
> +				percpu_ref_put(&q->q_usage_counter);
> +		}

Now you introduce one smp_rmb() and test on preempt flag on
blk-mq's fast path, which should have been avoided, so I
think this way is worse than my patchset.

On some systems(even a system with SCSI, or system without
SCSI), SCSI quiesce may never be used at all, so it is unfair
to introduce the cost in fast path for this system.

We can avoid that, why not do that?

-- 
Ming
