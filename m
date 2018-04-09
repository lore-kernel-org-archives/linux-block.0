Return-Path: <willy@infradead.org>
Date: Mon, 9 Apr 2018 09:03:54 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, Bart.VanAssche@wdc.com, linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6/7] block: consistently use GFP_NOIO instead of
 __GFP_NORECLAIM
Message-ID: <20180409160354.GD11756@bombadil.infradead.org>
References: <20180409153916.23901-1-hch@lst.de>
 <20180409153916.23901-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409153916.23901-7-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 09, 2018 at 05:39:15PM +0200, Christoph Hellwig wrote:
> Same numerical value (for now at least), but a much better documentation
> of intent.

> @@ -499,7 +499,7 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
>  		break;
>  	}
>  
> -	if (bytes && blk_rq_map_kern(q, rq, buffer, bytes, __GFP_RECLAIM)) {
> +	if (bytes && blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO)) {

We don't seem to have grabbed any locks between the line which allocates
memory using GFP_USER (line 446) and here, so I don't see why we should
prohibit I/O?
