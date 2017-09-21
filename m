Return-Path: <ming.lei@redhat.com>
Date: Fri, 22 Sep 2017 06:06:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 4/4] scsi-mq: Reduce suspend latency
Message-ID: <20170921220652.GD6854@ming.t460p>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
 <20170921212255.12788-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170921212255.12788-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 02:22:55PM -0700, Bart Van Assche wrote:
> Avoid that it can take 200 ms too long to wait for ongoing requests
> to finish. Note: blk_mq_freeze_queue() uses a wait queue to wait
> for ongoing requests to finish.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/scsi_lib.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index e76fd6e89a81..34e5f0f95d01 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2901,10 +2901,15 @@ scsi_device_quiesce(struct scsi_device *sdev)
>  	if (err)
>  		return err;
>  
> -	scsi_run_queue(q);
> -	while (atomic_read(&sdev->device_busy)) {
> -		msleep_interruptible(200);
> +	if (q->mq_ops) {
> +		blk_mq_freeze_queue(q);
> +		blk_mq_unfreeze_queue(q);

As I commented in another patch, you don't check the 'preempt only'
flag in normal I/O path, then from now on, any I/O can come.


> +	} else {
>  		scsi_run_queue(q);
> +		while (atomic_read(&sdev->device_busy)) {
> +			msleep_interruptible(200);
> +			scsi_run_queue(q);
> +		}

Are you sure only blk-mq need to drain queue? We need
to do that for block legacy too.


-- 
Ming
