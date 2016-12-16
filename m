Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove unused member (busy) from struct
 blk_queue_tag
To: Ritesh Harjani <riteshh@codeaurora.org>
References: <1481863316-6736-1-git-send-email-riteshh@codeaurora.org>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fb106079-6dd9-5040-edc4-a7567a8d32ad@kernel.dk>
Date: Fri, 16 Dec 2016 08:19:56 -0700
MIME-Version: 1.0
In-Reply-To: <1481863316-6736-1-git-send-email-riteshh@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/15/2016 09:41 PM, Ritesh Harjani wrote:
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  include/linux/blkdev.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 286b2a2..8369564 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -288,7 +288,6 @@ enum blk_queue_state {
>  struct blk_queue_tag {
>  	struct request **tag_index;	/* map of busy tags */
>  	unsigned long *tag_map;		/* bit map of free/busy tags */
> -	int busy;			/* current depth */
>  	int max_depth;			/* what we will send to device */
>  	int real_max_depth;		/* what the array can hold */
>  	atomic_t refcnt;		/* map can be shared */

Applied, thanks.

-- 
Jens Axboe
