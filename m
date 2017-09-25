Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753200AbdIYC2a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Sep 2017 22:28:30 -0400
Date: Mon, 25 Sep 2017 10:28:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        =Oleksandr Natalenko <oleksandr@natalenko.name>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 6/6] scsi-mq: Reduce suspend latency
Message-ID: <20170925022816.GC6434@ming.t460p>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
 <20170922221405.22091-7-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922221405.22091-7-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 22, 2017 at 03:14:05PM -0700, Bart Van Assche wrote:
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
>  drivers/scsi/scsi_lib.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index ca84fd2d93ea..c5e66bb0c94d 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2939,10 +2939,20 @@ scsi_device_quiesce(struct scsi_device *sdev)
>  	if (err)
>  		return err;
>  
> -	scsi_run_queue(q);
> -	while (atomic_read(&sdev->device_busy)) {
> -		msleep_interruptible(200);
> +	if (q->mq_ops) {
> +		/*
> +		 * Ensure write order of the PREEMPT_ONLY queue flag and
> +		 * q_usage_counter. See also blk_queue_enter().
> +		 */
> +		smp_wmb();
> +		blk_mq_freeze_queue(q);
> +		blk_mq_unfreeze_queue(q);
> +	} else {
>  		scsi_run_queue(q);
> +		while (atomic_read(&sdev->device_busy)) {
> +			msleep_interruptible(200);
> +			scsi_run_queue(q);
> +		}

Again, your patch doesn't fix scsi quiesce issue
on block legacy, either on suspend path or revalidate
path of transport spi.

-- 
Ming
