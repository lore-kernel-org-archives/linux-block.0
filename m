Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 25 Oct 2017 11:34:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] mq-deadline: add 'deadline' as a name alias
Message-ID: <20171025183439.GC9160@vader>
References: <1508954687-3204-1-git-send-email-axboe@kernel.dk>
 <1508954687-3204-4-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508954687-3204-4-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 25, 2017 at 12:04:47PM -0600, Jens Axboe wrote:
> The scheduler framework now supports looking up the appropriate
> scheduler with the {name,mq} tupple. We can register mq-deadline
> with the alias of 'deadline', so that switching to 'deadline'
> will do the right thing based on the type of driver attached to
> it.

Reviewed-by: Omar Sandoval <osandov@fb.com>

A blktest for this would be nice.

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/mq-deadline.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index a1cad4331edd..0179e484ec98 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -657,6 +657,7 @@ static struct elevator_type mq_deadline = {
>  #endif
>  	.elevator_attrs = deadline_attrs,
>  	.elevator_name = "mq-deadline",
> +	.elevator_alias = "deadline",
>  	.elevator_owner = THIS_MODULE,
>  };
>  MODULE_ALIAS("mq-deadline-iosched");
> -- 
> 2.7.4
> 
