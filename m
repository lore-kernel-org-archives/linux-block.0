Return-Path: <ming.lei@redhat.com>
Date: Mon, 24 Jul 2017 18:42:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, tomi.p.sarvela@intel.com, evangelos@foutrelis.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH for-4.13] block: disable runtime-pm for blk-mq
Message-ID: <20170724104246.GA2505@ming.t460p>
References: <20170721114610.25582-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170721114610.25582-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 21, 2017 at 01:46:10PM +0200, Christoph Hellwig wrote:
> The blk-mq code lacks support for looking at the rpm_status field, tracking
> active requests and the RQF_PM flag.
> 
> Due to the default switch to blk-mq for scsi people start to run into
> suspend / resume issue due to this fact, so make sure we disable the runtime
> PM functionality until it is properly implemented.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 970b9c9638c5..dbecbf4a64e0 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3421,6 +3421,10 @@ EXPORT_SYMBOL(blk_finish_plug);
>   */
>  void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
>  {
> +	/* not support for RQF_PM and ->rpm_status in blk-mq yet */

The big problem should be that the SCSI device can be runtime suspended,
but never to get back in case of blk-mq.

> +	if (q->mq_ops)
> +		return;
> +
>  	q->dev = dev;
>  	q->rpm_status = RPM_ACTIVE;
>  	pm_runtime_set_autosuspend_delay(q->dev, -1);
> -- 
> 2.11.0
> 

Either blk-mq or scsi-mq isn't ready for runtime PM, so
we can't enable runtime PM until both are ready.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
