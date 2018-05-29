Return-Path: <shawn.lin@rock-chips.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 shawn.lin@rock-chips.com, Bart Van Assche <bart.vanassche@wdc.com>,
 Ming Lei <ming.lei@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Tejun Heo <tj@kernel.org>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 10/14] mmc: complete requests from ->timeout
To: Christoph Hellwig <hch@lst.de>
References: <20180529135239.27005-1-hch@lst.de>
 <20180529135239.27005-11-hch@lst.de>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <4625bce6-0f93-ef84-0d55-b084f37c97ce@rock-chips.com>
Date: Tue, 29 May 2018 22:55:00 +0800
MIME-Version: 1.0
In-Reply-To: <20180529135239.27005-11-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-block@vger.kernel.org>

[+ Ulf, Adrian, linux-mmc, as linux-mmc and folks are missing in the
recipient list.]

On 2018/5/29 21:52, Christoph Hellwig wrote:
> By completing the request entirely in the driver we can remove the
> BLK_EH_HANDLED return value and thus the split responsibility between the
> driver and the block layer that has been causing trouble.
> 
> [While this keeps existing behavior it seems to mismatch the comment,
>   maintainers please chime in!]

The comment means the timeout doesn't happen for the current in-flight 
request which command queue is doing, and the request is finished 
previously(correct me if I'm wrong). So mmc defers the complete stuff to
blk_timeout_work to help. Maybe the comment should gone as well.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
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


-- 
Best Regards
Shawn Lin
