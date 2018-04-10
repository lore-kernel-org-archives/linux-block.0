Return-Path: <hare@suse.de>
Date: Tue, 10 Apr 2018 08:29:13 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, Bart.VanAssche@wdc.com, willy@infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 7/7] block: use GFP_KERNEL for allocations from
 blk_get_request
Message-ID: <20180410082913.475c8ca3@pentland.suse.de>
In-Reply-To: <20180409153916.23901-8-hch@lst.de>
References: <20180409153916.23901-1-hch@lst.de>
	<20180409153916.23901-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Mon,  9 Apr 2018 17:39:16 +0200
Christoph Hellwig <hch@lst.de> wrote:

> blk_get_request is used for pass-through style I/O and thus doesn't
> need GFP_NOIO.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 432923751551..253a869558f9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1578,7 +1578,7 @@ static struct request
> *blk_old_get_request(struct request_queue *q, unsigned int op,
> blk_mq_req_flags_t flags) {
>  	struct request *rq;
> -	gfp_t gfp_mask = flags & BLK_MQ_REQ_NOWAIT ? GFP_ATOMIC :
> GFP_NOIO;
> +	gfp_t gfp_mask = flags & BLK_MQ_REQ_NOWAIT ? GFP_ATOMIC :
> GFP_KERNEL; int ret = 0;
>  
>  	WARN_ON_ONCE(q->mq_ops);

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
