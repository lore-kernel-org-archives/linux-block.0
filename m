Return-Path: <ming.lei@redhat.com>
Date: Tue, 30 Oct 2018 17:37:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Balbir Singh <sblbir@amzn.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add cmd_flags to print_req_error
Message-ID: <20181030093708.GC13582@ming.t460p>
References: <20181030024015.1092-1-sblbir@amzn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181030024015.1092-1-sblbir@amzn.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 30, 2018 at 02:40:15AM +0000, Balbir Singh wrote:
> I ran into a bug where after hibernation due to incompatible
> backends, the block driver returned BLK_STS_NOTSUPP, with the
> current message it's hard to find out what the command flags
> were. Adding req->cmd_flags help make the problem easier to
> diagnose.
> 
> Signed-off-by: Balbir Singh <sblbir@amzn.com>
> Reviewed-by: Eduardo Valentin <eduval@amazon.com>
> ---
> 
> Testing: Compile tested at my end
> 
> Changelog
>   - convert %llx to %x and remove casting to unsigned long long
> 
>  block/blk-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index cdfabc5646da..0fd6104bb0d2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -256,10 +256,11 @@ static void print_req_error(struct request *req, blk_status_t status)
>  	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
>  		return;
>  
> -	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu\n",
> -			   __func__, blk_errors[idx].name, req->rq_disk ?
> -			   req->rq_disk->disk_name : "?",
> -			   (unsigned long long)blk_rq_pos(req));
> +	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x\n",
> +				__func__, blk_errors[idx].name,
> +				req->rq_disk ?  req->rq_disk->disk_name : "?",
> +				(unsigned long long)blk_rq_pos(req),
> +				req->cmd_flags);
>  }
>  
>  static void req_bio_endio(struct request *rq, struct bio *bio,
> -- 
> 2.16.2
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
