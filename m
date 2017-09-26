Return-Path: <ming.lei@redhat.com>
Date: Wed, 27 Sep 2017 06:23:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v4 5/7] scsi: Reduce suspend latency
Message-ID: <20170926222322.GA8050@ming.t460p>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
 <20170925202924.16603-6-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925202924.16603-6-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 01:29:22PM -0700, Bart Van Assche wrote:
> Avoid that it can take 200 ms too long to wait for requests to
> finish. Note: blk_mq_freeze_queue() uses a wait queue to wait
> for ongoing requests to finish.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/scsi_lib.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 62f905b22821..c261498606c4 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2927,6 +2927,7 @@ static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
>  int
>  scsi_device_quiesce(struct scsi_device *sdev)
>  {
> +	struct request_queue *q = sdev->request_queue;
>  	int err;
>  
>  	mutex_lock(&sdev->state_mutex);
> @@ -2936,11 +2937,8 @@ scsi_device_quiesce(struct scsi_device *sdev)
>  	if (err)
>  		return err;
>  
> -	scsi_run_queue(sdev->request_queue);
> -	while (atomic_read(&sdev->device_busy)) {
> -		msleep_interruptible(200);
> -		scsi_run_queue(sdev->request_queue);
> -	}
> +	blk_mq_freeze_queue(q);
> +	blk_mq_unfreeze_queue(q);
>  	return 0;

I see the serious issue now with this patch, and it should have
been found much earlier, just because the setting quiesce isn't
shown in the patch. Sorry for finding it so late.

Once the patch is applied, scsi_device_quiesce() becomes
the following shape:

        mutex_lock(&sdev->state_mutex);
        err = scsi_device_set_state(sdev, SDEV_QUIESCE);
        if (err == 0)
                blk_set_preempt_only(q, true);
        mutex_unlock(&sdev->state_mutex);

        if (err)
                return err;

        blk_mq_freeze_queue(q);
        blk_mq_unfreeze_queue(q);

Any requests allocated before scsi_device_set_state() and
dispatched after scsi_device_set_state() can't be drained up
any more, then blk_mq_freeze_queue() will wait forever for the
drain up, so not only this patchset can't fix the current quiesce
issue, but also introduces new I/O hang in scsi_device_quiesce().

Now this approach looks broken fundamentally.

NAK.

-- 
Ming
