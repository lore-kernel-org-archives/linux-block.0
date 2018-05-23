Return-Path: <hare@suse.de>
Subject: Re: [PATCH 11/14] block: document the blk_eh_timer_return values
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-12-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3a39674d-4248-0803-d88a-f0acba1e73b1@suse.de>
Date: Wed, 23 May 2018 15:36:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/blkdev.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3d9d4da4dedd..3815d9dcfbe0 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -337,8 +337,8 @@ typedef int (init_rq_fn)(struct request_queue *, struct request *, gfp_t);
>   typedef void (exit_rq_fn)(struct request_queue *, struct request *);
>   
>   enum blk_eh_timer_return {
> -	BLK_EH_DONE,
> -	BLK_EH_RESET_TIMER,
> +	BLK_EH_DONE,		/* drivers has completed the command */
> +	BLK_EH_RESET_TIMER,	/* reset timer and try again */
>   };
>   
>   typedef enum blk_eh_timer_return (rq_timed_out_fn)(struct request *);
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
