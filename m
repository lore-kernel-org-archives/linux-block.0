Return-Path: <prvs=736960120=Bart.VanAssche@wdc.com>
Subject: Re: [PATCHv2 2/2] scsi: set timed out out mq requests to complete
To: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 Jianchao Wang <jianchao.w.wang@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20180723143751.10843-1-keith.busch@intel.com>
 <20180723143751.10843-2-keith.busch@intel.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <86e23e58-6f80-7957-30f7-8b0ce8cb50ce@wdc.com>
Date: Tue, 24 Jul 2018 15:46:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180723143751.10843-2-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 07/23/18 07:37, Keith Busch wrote:
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 8932ae81a15a..2715cdaa669c 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -296,6 +296,20 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
>   		rtn = host->hostt->eh_timed_out(scmd);
>   
>   	if (rtn == BLK_EH_DONE) {
> +		/*
> +		 * For blk-mq, we must set the request state to complete now
> +		 * before sending the request to the scsi error handler. This
> +		 * will prevent a use-after-free in the event the LLD manages
> +		 * to complete the request before the error handler finishes
> +		 * processing this timed out request.
> +		 *
> +		 * If the request was already completed, then the LLD beat the
> +		 * time out handler from transferring the request to the scsi
> +		 * error handler. In that case we can return immediately as no
> +		 * further action is required.
> +		 */
> +		if (req->q->mq_ops && !blk_mq_mark_complete(req))
> +			return rtn;
>   		if (scsi_abort_command(scmd) != SUCCESS) {
>   			set_host_byte(scmd, DID_TIME_OUT);
>   			scsi_eh_scmd_add(scmd);

This change looks incomplete to me. I think the following scenario is 
not handled properly by the above patch:
- host->hostt->eh_timed_out() gets called.
- The request "req" completes from another context while
   host->hostt->eh_timed_out() is in progress.
- host->hostt->eh_timed_out() calls scsi_finish_command().

I think that scenario will lead to a double completion.

Bart.
