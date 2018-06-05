Return-Path: <ming.lei@redhat.com>
Date: Tue, 5 Jun 2018 11:28:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: bio_set_pages_dirty can't see NULL bv_page in
 a valid bio_vec
Message-ID: <20180605032845.GE28826@ming.t460p>
References: <20180604135853.30972-1-hch@lst.de>
 <20180604135853.30972-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180604135853.30972-3-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 04, 2018 at 03:58:52PM +0200, Christoph Hellwig wrote:
> So don't bother handling it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 50941c1c9118..d95fab72acb5 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1578,10 +1578,8 @@ void bio_set_pages_dirty(struct bio *bio)
>  	int i;
>  
>  	bio_for_each_segment_all(bvec, bio, i) {
> -		struct page *page = bvec->bv_page;
> -
> -		if (page && !PageCompound(page))
> -			set_page_dirty_lock(page);
> +		if (!PageCompound(bvec->bv_page))
> +			set_page_dirty_lock(bvec->bv_page);
>  	}
>  }

Looks reasonable:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
