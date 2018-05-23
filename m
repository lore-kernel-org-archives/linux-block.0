Return-Path: <hare@suse.de>
Subject: Re: [PATCH 04/14] nbd: complete requests from ->timeout
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b0303d04-322a-e64f-7465-225e9fdc833a@suse.de>
Date: Wed, 23 May 2018 15:28:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> By completing the request entirely in the driver we can remove the
> BLK_EH_HANDLED return value and thus the split responsibility between the
> driver and the block layer that has been causing trouble.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/nbd.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 09d9959287fe..30a851b8a99c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -300,7 +300,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>   
>   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>   		cmd->status = BLK_STS_TIMEOUT;
> -		return BLK_EH_HANDLED;
> +		goto done;
>   	}
>   	config = nbd->config;
>   
> @@ -338,8 +338,9 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>   	cmd->status = BLK_STS_IOERR;
>   	sock_shutdown(nbd);
>   	nbd_config_put(nbd);
> -
> -	return BLK_EH_HANDLED;
> +done:
> +	blk_mq_complete_request(req);
> +	return BLK_EH_DONE;
>   }
>   
>   /*
> 
Again, some testcase would be nice ...

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
