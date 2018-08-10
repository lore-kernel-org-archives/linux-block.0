Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v6 08/12] block, scsi: Introduce blk_pm_runtime_exit()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
 <20180809194149.15285-9-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <be4d4011-efba-c866-e9a8-c14743eb0a1a@oracle.com>
Date: Fri, 10 Aug 2018 10:39:34 +0800
MIME-Version: 1.0
In-Reply-To: <20180809194149.15285-9-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 08/10/2018 03:41 AM, Bart Van Assche wrote:
> +void blk_pm_runtime_exit(struct request_queue *q)
> +{
> +	if (!q->dev)
> +		return;
> +
> +	pm_runtime_get_sync(q->dev);
> +	q->dev = NULL;
> +}
> +EXPORT_SYMBOL(blk_pm_runtime_exit);
> +
>  /**
>   * blk_pre_runtime_suspend - Pre runtime suspend check
>   * @q: the queue of the device
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 69ab459abb98..5537762dfcfd 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3420,12 +3420,11 @@ static int sd_probe(struct device *dev)
>   **/
>  static int sd_remove(struct device *dev)
>  {
> -	struct scsi_disk *sdkp;
> -	dev_t devt;
> +	struct scsi_disk *sdkp = dev_get_drvdata(dev);
> +	struct scsi_device *sdp = sdkp->device;
> +	dev_t devt = disk_devt(sdkp->disk);
>  
> -	sdkp = dev_get_drvdata(dev);
> -	devt = disk_devt(sdkp->disk);
> -	scsi_autopm_get_device(sdkp->device);
> +	blk_pm_runtime_exit(sdp->request_queue)


Based on __scsi_device_remove, sd_remove will be invoked before blk_cleanup_queue.
So it should be not safe that we set the q->dev to NULL here.

We have following operations in followed patch:
+static inline void blk_pm_mark_last_busy(struct request *rq)
+{
+	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
+		pm_runtime_mark_last_busy(rq->q->dev);
+}

Thanks
Jianchao
