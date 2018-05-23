Return-Path: <hare@suse.de>
Subject: Re: [PATCH 08/14] mmc: complete requests from ->timeout
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-9-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <468e163e-0e7f-5d32-fa27-f71b648c4069@suse.de>
Date: Wed, 23 May 2018 15:31:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> By completing the request entirely in the driver we can remove the
> BLK_EH_HANDLED return value and thus the split responsibility between the
> driver and the block layer that has been causing trouble.
> 
> [While this keeps existing behavior it seems to mismatch the comment,
>   maintainers please chime in!]
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/mmc/core/queue.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 56e9a803db21..648eb6743ed5 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -111,8 +111,9 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
>   				__mmc_cqe_recovery_notifier(mq);
>   			return BLK_EH_RESET_TIMER;
>   		}
> -		/* No timeout */
> -		return BLK_EH_HANDLED;
> +		/* No timeout (XXX: huh? comment doesn't make much sense) */
> +		blk_mq_complete_request(req);
> +		return BLK_EH_DONE;
>   	default:
>   		/* Timeout is handled by mmc core */
>   		return BLK_EH_RESET_TIMER;
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
