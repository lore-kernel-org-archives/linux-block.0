Return-Path: <hare@suse.de>
Subject: Re: [PATCH 07/28] blk-mq: remove legacy check in queue
 blk_freeze_queue()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-8-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b1c0a73f-5d59-e865-aeb0-289c99683a69@suse.de>
Date: Sat, 27 Oct 2018 12:52:43 +0200
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-8-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c82dc44d4d8..a58d2d953876 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -177,8 +177,6 @@ void blk_freeze_queue(struct request_queue *q)
>   	 * exported to drivers as the only user for unfreeze is blk_mq.
>   	 */
>   	blk_freeze_queue_start(q);
> -	if (!q->mq_ops)
> -		blk_drain_queue(q);
>   	blk_mq_freeze_queue_wait(q);
>   }
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
