Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, "=Oleksandr Natalenko" <oleksandr@natalenko.name>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v7 9/9] block, scsi: Make SCSI quiesce and resume work reliably
Date: Tue, 10 Oct 2017 09:57:02 +0200
Message-ID: <2538545.nE4DvSpPT1@merkaba>
In-Reply-To: <20171009231400.562-10-bart.vanassche@wdc.com>
References: <20171009231400.562-1-bart.vanassche@wdc.com> <20171009231400.562-10-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Bart Van Assche - 09.10.17, 16:14:
> The contexts from which a SCSI device can be quiesced or resumed are:
> * Writing into /sys/class/scsi_device/*/device/state.
> * SCSI parallel (SPI) domain validation.
> * The SCSI device power management methods. See also scsi_bus_pm_ops.
>=20
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
>=20
> for d in /sys/class/block/sd*[a-z]; do
>   hcil=3D$(readlink "$d/device")
>   hcil=3D${hcil#../../../}
>   echo 4 > "$d/queue/nr_requests"
>   echo 1 > "/sys/class/scsi_device/$hcil/device/queue_depth"
> done
> bdev=3D$(readlink /dev/disk/by-uuid/5217d83f-213e-4b42-b86e-20013325ba6c)
> bdev=3D${bdev#../../}
> hcil=3D$(readlink "/sys/block/$bdev/device")
> hcil=3D${hcil#../../../}
> fio --name=3D"$bdev" --filename=3D"/dev/$bdev" --buffered=3D0 --bs=3D512
> --rw=3Drandread \ --ioengine=3Dlibaio --numjobs=3D4 --iodepth=3D16
> --iodepth_batch=3D1 --thread \ --loops=3D$((2**31)) &
> pid=3D$!
> sleep 1
> systemctl hibernate
> sleep 10
> kill $pid
>=20
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> References: "I/O hangs after resuming from suspend-to-ram"
> (https://marc.info/?l=3Dlinux-block&m=3D150340235201348). Signed-off-by: =
Bart
> Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>

Does this as reliably fix the issue as the patches from Ming? I mean in *re=
al=20
world* scenarios? Or is it just about the same approach as Ming has taken.

I ask cause I don=B4t see any Tested-By:=B4s here? I know I tested Ming=B4s=
 patch=20
series and I know it fixes the hang after resume from suspend with blk-mq +=
 BFQ=20
issue for me. I have an uptime of 7 days and I didn=B4t see any uptime even=
=20
remotely like that in a long time (before that issue Intel gfx drivers caus=
ed=20
hangs, but thankfully that seems fixed meanwhile).

I=B4d be willing to test. Do you have a 4.14.x tree available with these pa=
tches=20
applied I can just add as a remote and fetch from?

Thanks,
Martin

> ---
>  block/blk-core.c        | 42 +++++++++++++++++++++++++++++++++++-------
>  block/blk-mq.c          |  4 ++--
>  block/blk-timeout.c     |  2 +-
>  drivers/scsi/scsi_lib.c | 28 ++++++++++++++++++----------
>  fs/block_dev.c          |  4 ++--
>  include/linux/blkdev.h  |  2 +-
>  6 files changed, 59 insertions(+), 23 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ed992cbd107f..3847ea42e341 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -372,6 +372,7 @@ void blk_clear_preempt_only(struct request_queue *q)
>=20
>  	spin_lock_irqsave(q->queue_lock, flags);
>  	queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
> +	wake_up_all(&q->mq_freeze_wq);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
> @@ -793,15 +794,40 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mas=
k)
>  }
>  EXPORT_SYMBOL(blk_alloc_queue);
>=20
> -int blk_queue_enter(struct request_queue *q, bool nowait)
> +/**
> + * blk_queue_enter() - try to increase q->q_usage_counter
> + * @q: request queue pointer
> + * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PREEMPT
> + */
> +int blk_queue_enter(struct request_queue *q, unsigned int flags)
>  {
> +	const bool preempt =3D flags & BLK_MQ_REQ_PREEMPT;
> +
>  	while (true) {
> +		bool success =3D false;
>  		int ret;
>=20
> -		if (percpu_ref_tryget_live(&q->q_usage_counter))
> +		rcu_read_lock_sched();
> +		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
> +			/*
> +			 * The code that sets the PREEMPT_ONLY flag is
> +			 * responsible for ensuring that that flag is globally
> +			 * visible before the queue is unfrozen.
> +			 */
> +			if (preempt || !blk_queue_preempt_only(q)) {
> +				success =3D true;
> +			} else {
> +				percpu_ref_put(&q->q_usage_counter);
> +				WARN_ONCE("%s: Attempt to allocate non-preempt request in=20
preempt-only
> mode.\n", +					  kobject_name(q->kobj.parent));
> +			}
> +		}
> +		rcu_read_unlock_sched();
> +
> +		if (success)
>  			return 0;
>=20
> -		if (nowait)
> +		if (flags & BLK_MQ_REQ_NOWAIT)
>  			return -EBUSY;
>=20
>  		/*
> @@ -814,7 +840,8 @@ int blk_queue_enter(struct request_queue *q, bool
> nowait) smp_rmb();
>=20
>  		ret =3D wait_event_interruptible(q->mq_freeze_wq,
> -				!atomic_read(&q->mq_freeze_depth) ||
> +				(atomic_read(&q->mq_freeze_depth) =3D=3D 0 &&
> +				 (preempt || !blk_queue_preempt_only(q))) ||
>  				blk_queue_dying(q));
>  		if (blk_queue_dying(q))
>  			return -ENODEV;
> @@ -1442,8 +1469,7 @@ static struct request *blk_old_get_request(struct
> request_queue *q, /* create ioc upfront */
>  	create_io_context(gfp_mask, q->node);
>=20
> -	ret =3D blk_queue_enter(q, !(gfp_mask & __GFP_DIRECT_RECLAIM) ||
> -			      (op & REQ_NOWAIT));
> +	ret =3D blk_queue_enter(q, flags);
>  	if (ret)
>  		return ERR_PTR(ret);
>  	spin_lock_irq(q->queue_lock);
> @@ -2264,8 +2290,10 @@ blk_qc_t generic_make_request(struct bio *bio)
>  	current->bio_list =3D bio_list_on_stack;
>  	do {
>  		struct request_queue *q =3D bio->bi_disk->queue;
> +		unsigned int flags =3D bio->bi_opf & REQ_NOWAIT ?
> +			BLK_MQ_REQ_NOWAIT : 0;
>=20
> -		if (likely(blk_queue_enter(q, bio->bi_opf & REQ_NOWAIT) =3D=3D 0)) {
> +		if (likely(blk_queue_enter(q, flags) =3D=3D 0)) {
>  			struct bio_list lower, same;
>=20
>  			/* Create a fresh bio_list for all subordinate requests */
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index bdbfe760bda0..44a06e8541f2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -386,7 +386,7 @@ struct request *blk_mq_alloc_request(struct
> request_queue *q, unsigned int op, struct request *rq;
>  	int ret;
>=20
> -	ret =3D blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
> +	ret =3D blk_queue_enter(q, flags);
>  	if (ret)
>  		return ERR_PTR(ret);
>=20
> @@ -425,7 +425,7 @@ struct request *blk_mq_alloc_request_hctx(struct
> request_queue *q, if (hctx_idx >=3D q->nr_hw_queues)
>  		return ERR_PTR(-EIO);
>=20
> -	ret =3D blk_queue_enter(q, true);
> +	ret =3D blk_queue_enter(q, flags);
>  	if (ret)
>  		return ERR_PTR(ret);
>=20
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index e3e9c9771d36..1eba71486716 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -134,7 +134,7 @@ void blk_timeout_work(struct work_struct *work)
>  	struct request *rq, *tmp;
>  	int next_set =3D 0;
>=20
> -	if (blk_queue_enter(q, true))
> +	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT))
>  		return;
>  	spin_lock_irqsave(q->queue_lock, flags);
>=20
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 1c16a247fae6..a3cf36c8079b 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2926,21 +2926,29 @@ static void scsi_wait_for_queuecommand(struct
> scsi_device *sdev) int
>  scsi_device_quiesce(struct scsi_device *sdev)
>  {
> +	struct request_queue *q =3D sdev->request_queue;
>  	int err;
>=20
> +	/* If the SCSI device already has been quiesced, do nothing. */
> +	if (blk_set_preempt_only(q))
> +		return 0;
> +
> +	/*
> +	 * Since blk_mq_freeze_queue() calls synchronize_rcu() indirectly the
> +	 * effect of blk_set_preempt_only() will be visible for
> +	 * percpu_ref_tryget() callers that occur after the queue
> +	 * unfreeze. See also https://lwn.net/Articles/573497/.
> +	 */
> +	blk_mq_freeze_queue(q);
> +	blk_mq_unfreeze_queue(q);
> +
>  	mutex_lock(&sdev->state_mutex);
>  	err =3D scsi_device_set_state(sdev, SDEV_QUIESCE);
> -	mutex_unlock(&sdev->state_mutex);
> -
>  	if (err)
> -		return err;
> +		blk_clear_preempt_only(q);
> +	mutex_unlock(&sdev->state_mutex);
>=20
> -	scsi_run_queue(sdev->request_queue);
> -	while (atomic_read(&sdev->device_busy)) {
> -		msleep_interruptible(200);
> -		scsi_run_queue(sdev->request_queue);
> -	}
> -	return 0;
> +	return err;
>  }
>  EXPORT_SYMBOL(scsi_device_quiesce);
>=20
> @@ -2962,7 +2970,7 @@ void scsi_device_resume(struct scsi_device *sdev)
>  	mutex_lock(&sdev->state_mutex);
>  	if (sdev->sdev_state =3D=3D SDEV_QUIESCE &&
>  	    scsi_device_set_state(sdev, SDEV_RUNNING) =3D=3D 0)
> -		scsi_run_queue(sdev->request_queue);
> +		blk_clear_preempt_only(sdev->request_queue);
>  	mutex_unlock(&sdev->state_mutex);
>  }
>  EXPORT_SYMBOL(scsi_device_resume);
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 93d088ffc05c..98cf2d7ee9d3 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -674,7 +674,7 @@ int bdev_read_page(struct block_device *bdev, sector_t
> sector, if (!ops->rw_page || bdev_get_integrity(bdev))
>  		return result;
>=20
> -	result =3D blk_queue_enter(bdev->bd_queue, false);
> +	result =3D blk_queue_enter(bdev->bd_queue, 0);
>  	if (result)
>  		return result;
>  	result =3D ops->rw_page(bdev, sector + get_start_sect(bdev), page, fals=
e);
> @@ -710,7 +710,7 @@ int bdev_write_page(struct block_device *bdev, sector=
_t
> sector,
>=20
>  	if (!ops->rw_page || bdev_get_integrity(bdev))
>  		return -EOPNOTSUPP;
> -	result =3D blk_queue_enter(bdev->bd_queue, false);
> +	result =3D blk_queue_enter(bdev->bd_queue, 0);
>  	if (result)
>  		return result;
>=20
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 89555eea742b..0a4638cf0687 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -967,7 +967,7 @@ extern int scsi_cmd_ioctl(struct request_queue *, str=
uct
> gendisk *, fmode_t, extern int sg_scsi_ioctl(struct request_queue *, stru=
ct
> gendisk *, fmode_t, struct scsi_ioctl_command __user *);
>=20
> -extern int blk_queue_enter(struct request_queue *q, bool nowait);
> +extern int blk_queue_enter(struct request_queue *q, unsigned int flags);
>  extern void blk_queue_exit(struct request_queue *q);
>  extern void blk_start_queue(struct request_queue *q);
>  extern void blk_start_queue_async(struct request_queue *q);


=2D-=20
Martin
