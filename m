Return-Path: <ming.lei@redhat.com>
Date: Tue, 5 Jun 2018 11:23:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: simplify bio_check_pages_dirty
Message-ID: <20180605032329.GD28826@ming.t460p>
References: <20180604135853.30972-1-hch@lst.de>
 <20180604135853.30972-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180604135853.30972-2-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 04, 2018 at 03:58:51PM +0200, Christoph Hellwig wrote:
> bio_check_pages_dirty currently inviolates the invariant that bv_page of
> a bio_vec inside bi_vcnt shouldn't be zero, and that is going to become
> really annoying with multpath biovecs.  Fortunately there isn't any
> all that good reason for it - once we decide to defer freeing the bio
> to a workqueue holding onto a few additional pages isn't really an
> issue anymore.  So just check if there is a clean page that needs
> dirtying in the first path, and do a second pass to free them if there
> was none, while the cache is still hot.
> 
> Also use the chance to micro-optimize bio_dirty_fn a bit by not saving
> irq state - we know we are called from a workqueue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c | 56 +++++++++++++++++++++-----------------------------------
>  1 file changed, 21 insertions(+), 35 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 53e0f0a1ed94..50941c1c9118 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1590,19 +1590,15 @@ static void bio_release_pages(struct bio *bio)
>  	struct bio_vec *bvec;
>  	int i;
>  
> -	bio_for_each_segment_all(bvec, bio, i) {
> -		struct page *page = bvec->bv_page;
> -
> -		if (page)
> -			put_page(page);
> -	}
> +	bio_for_each_segment_all(bvec, bio, i)
> +		put_page(bvec->bv_page);
>  }
>  
>  /*
>   * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
>   * If they are, then fine.  If, however, some pages are clean then they must
>   * have been written out during the direct-IO read.  So we take another ref on
> - * the BIO and the offending pages and re-dirty the pages in process context.
> + * the BIO and re-dirty the pages in process context.
>   *
>   * It is expected that bio_check_pages_dirty() will wholly own the BIO from
>   * here on.  It will run one put_page() against each page and will run one
> @@ -1620,52 +1616,42 @@ static struct bio *bio_dirty_list;
>   */
>  static void bio_dirty_fn(struct work_struct *work)
>  {
> -	unsigned long flags;
> -	struct bio *bio;
> +	struct bio *bio, *next;
>  
> -	spin_lock_irqsave(&bio_dirty_lock, flags);
> -	bio = bio_dirty_list;
> +	spin_lock_irq(&bio_dirty_lock);
> +	next = bio_dirty_list;
>  	bio_dirty_list = NULL;
> -	spin_unlock_irqrestore(&bio_dirty_lock, flags);
> +	spin_unlock_irq(&bio_dirty_lock);
>  
> -	while (bio) {
> -		struct bio *next = bio->bi_private;
> +	while ((bio = next) != NULL) {
> +		next = bio->bi_private;
>  
>  		bio_set_pages_dirty(bio);
>  		bio_release_pages(bio);
>  		bio_put(bio);
> -		bio = next;
>  	}
>  }
>  
>  void bio_check_pages_dirty(struct bio *bio)
>  {
>  	struct bio_vec *bvec;
> -	int nr_clean_pages = 0;
> +	unsigned long flags;
>  	int i;
>  
>  	bio_for_each_segment_all(bvec, bio, i) {
> -		struct page *page = bvec->bv_page;
> -
> -		if (PageDirty(page) || PageCompound(page)) {
> -			put_page(page);
> -			bvec->bv_page = NULL;
> -		} else {
> -			nr_clean_pages++;
> -		}
> +		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
> +			goto defer;
>  	}
>  
> -	if (nr_clean_pages) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&bio_dirty_lock, flags);
> -		bio->bi_private = bio_dirty_list;
> -		bio_dirty_list = bio;
> -		spin_unlock_irqrestore(&bio_dirty_lock, flags);
> -		schedule_work(&bio_dirty_work);
> -	} else {
> -		bio_put(bio);
> -	}
> +	bio_release_pages(bio);
> +	bio_put(bio);
> +	return;
> +defer:
> +	spin_lock_irqsave(&bio_dirty_lock, flags);
> +	bio->bi_private = bio_dirty_list;
> +	bio_dirty_list = bio;
> +	spin_unlock_irqrestore(&bio_dirty_lock, flags);
> +	schedule_work(&bio_dirty_work);
>  }
>  
>  void generic_start_io_acct(struct request_queue *q, int rw,

It is good simplification, and the only effect may be some pages
which will be freed a bit late in partial clean case.

I have run fio randread on null_blk in a 512M ram fedora 27 cloud image
based VM, not see IOPS drop, so:

Tested-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
