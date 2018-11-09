Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Subject: Re: [PATCH 3/6] skd_main: don't use req->special
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20181109183208.19879-1-hch@lst.de>
 <20181109183208.19879-4-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <866424b7-4649-a765-a24f-43423a4d538f@acm.org>
Date: Fri, 9 Nov 2018 11:09:20 -0800
MIME-Version: 1.0
In-Reply-To: <20181109183208.19879-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 10:32 AM, Christoph Hellwig wrote:
> Add a retries field to the internal request structure instead, which gets
> set to zero on the first submission.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/skd_main.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> index a0196477165f..88f29b06d90e 100644
> --- a/drivers/block/skd_main.c
> +++ b/drivers/block/skd_main.c
> @@ -181,6 +181,7 @@ struct skd_request_context {
>   	struct fit_completion_entry_v1 completion;
>   
>   	struct fit_comp_error_info err_info;
> +	int retries;
>   
>   	blk_status_t status;
>   };
> @@ -495,6 +496,11 @@ static blk_status_t skd_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	if (unlikely(skdev->state != SKD_DRVR_STATE_ONLINE))
>   		return skd_fail_all(q) ? BLK_STS_IOERR : BLK_STS_RESOURCE;
>   
> +	if (!(req->rq_flags & RQF_DONTPREP)) {
> +		skreq->retries = 0;
> +		req->rq_flags |= RQF_DONTPREP;
> +	}
> +
>   	blk_mq_start_request(req);
>   
>   	WARN_ONCE(tag >= skd_max_queue_depth, "%#x > %#x (nr_requests = %lu)\n",
> @@ -1426,7 +1432,7 @@ static void skd_resolve_req_exception(struct skd_device *skdev,
>   		break;
>   
>   	case SKD_CHECK_STATUS_REQUEUE_REQUEST:
> -		if ((unsigned long) ++req->special < SKD_MAX_RETRIES) {
> +		if ((unsigned long) skreq->retries < SKD_MAX_RETRIES) {
>   			skd_log_skreq(skdev, skreq, "retry");
>   			blk_mq_requeue_request(req, true);
>   			break;

Hi Christoph,

Where has the code been moved to that increments the new skreq->retries 
counter?

Thanks,

Bart.
