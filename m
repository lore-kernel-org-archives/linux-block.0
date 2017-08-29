Return-Path: <ming.lei@redhat.com>
Date: Tue, 29 Aug 2017 18:45:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
Message-ID: <20170829104508.GC32439@ming.t460p>
References: <20170813170219.GG18698@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170813170219.GG18698@decadent.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Aug 13, 2017 at 06:02:19PM +0100, Ben Hutchings wrote:
> The block core requests modules with the "-iosched" name suffix, but
> bfq no longer has that suffix.  Add an alias.
> 
> Fixes: ea25da48086d ("block, bfq: split bfq-iosched.c into multiple ...")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  block/bfq-iosched.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 436b6ca6b175..3a01563bd564 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4998,6 +4998,7 @@ static struct elevator_type iosched_bfq_mq = {
>  	.elevator_name =	"bfq",
>  	.elevator_owner =	THIS_MODULE,
>  };
> +MODULE_ALIAS("bfq-iosched");
>  
>  static int __init bfq_init(void)
>  {
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming
