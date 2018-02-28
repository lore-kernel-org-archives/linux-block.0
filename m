Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 28 Feb 2018 00:51:36 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: add 'requeue' fault attribute
Message-ID: <20180228085136.GA27941@vader.DHCP.thefacebook.com>
References: <e3116aee-ae06-a415-c56f-30c3780f6a67@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e3116aee-ae06-a415-c56f-30c3780f6a67@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 27, 2018 at 03:34:53PM -0700, Jens Axboe wrote:
> Similarly to the support we have for testing/faking timeouts for
> null_blk, this adds support for triggering a requeue condition.
> Considering the issues around restart we've been seeing, this should be
> a useful addition to the testing arsenal to ensure that we are handling
> requeue conditions correctly.
> 
> This works for queue mode 1 (legacy request_fn based path) and 2 (blk-mq
> path), as there's no good way to do requeue with a bio based driver.
> This is similar to the timeout path.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
>  null_blk.c |   55 +++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
> index 287a09611c0f..363536572e19 100644
> --- a/drivers/block/null_blk.c
> +++ b/drivers/block/null_blk.c

[snip]

> @@ -1422,10 +1440,12 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	blk_mq_start_request(bd->rq);
>  
> -	if (!should_timeout_request(bd->rq))
> -		return null_handle_cmd(cmd);
> +	if (should_requeue_request(bd->rq))
> +		return BLK_STS_RESOURCE;

Hm, this goes through the less interesting requeue path, add to the
dispatch list and __blk_mq_requeue_request(). blk_mq_requeue_request()
is the one that I wanted to test since that's the one that needs to call
the scheduler hook.
