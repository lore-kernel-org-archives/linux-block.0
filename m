Return-Path: <hare@suse.de>
Subject: Re: [PATCH 27/28] blk-merge: kill dead queue lock held check
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-28-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2fe807e8-e3f7-a42c-b52d-098dde7eacdb@suse.de>
Date: Mon, 29 Oct 2018 08:12:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-28-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> This is dead code, any queue reaching this part has mq_ops
> attached.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-merge.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3561dcce2260..0128284bded4 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -704,9 +704,6 @@ static void blk_account_io_merge(struct request *req)
>   static struct request *attempt_merge(struct request_queue *q,
>   				     struct request *req, struct request *next)
>   {
> -	if (!q->mq_ops)
> -		lockdep_assert_held(q->queue_lock);
> -
>   	if (!rq_mergeable(req) || !rq_mergeable(next))
>   		return NULL;
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
