Return-Path: <ming.lei@redhat.com>
Date: Tue, 29 Aug 2017 18:45:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] mq-deadline: Enable auto-loading when built as module
Message-ID: <20170829104530.GD32439@ming.t460p>
References: <20170813170219.GG18698@decadent.org.uk>
 <20170813170315.GH18698@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170813170315.GH18698@decadent.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Aug 13, 2017 at 06:03:15PM +0100, Ben Hutchings wrote:
> The block core requests modules with the "-iosched" name suffix, but
> mq-deadline does not have that suffix.  Add an alias.
> 
> Fixes: 945ffb60c11d ("mq-deadline: add blk-mq adaptation of the deadline ...")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  block/mq-deadline.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 1b964a387afe..78e7698fa4ed 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -660,6 +660,7 @@ static struct elevator_type mq_deadline = {
>  	.elevator_name = "mq-deadline",
>  	.elevator_owner = THIS_MODULE,
>  };
> +MODULE_ALIAS("mq-deadline-iosched");
>  
>  static int __init deadline_init(void)
>  {

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
