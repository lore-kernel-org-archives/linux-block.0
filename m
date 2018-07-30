Return-Path: <ming.lei@redhat.com>
Date: Mon, 30 Jul 2018 20:37:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v5 3/3] block: bio_iov_iter_get_pages: pin more pages for
 multi-segment IOs
Message-ID: <20180730123715.GC6972@ming.t460p>
References: <20180725211509.13592-1-mwilck@suse.com>
 <20180725211509.13592-4-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725211509.13592-4-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 25, 2018 at 11:15:09PM +0200, Martin Wilck wrote:
> bio_iov_iter_get_pages() currently only adds pages for the
> next non-zero segment from the iov_iter to the bio. That's
> suboptimal for callers, which typically try to pin as many
> pages as fit into the bio. This patch converts the current
> bio_iov_iter_get_pages() into a static helper, and introduces
> a new helper that allocates as many pages as
> 
>  1) fit into the bio,
>  2) are present in the iov_iter,
>  3) and can be pinned by MM.
> 
> Error is returned only if zero pages could be pinned. Because of
> 3), a zero return value doesn't necessarily mean all pages have been
> pinned. Callers that have to pin every page in the iov_iter must still
> call this function in a loop (this is currently the case).
> 
> This change matters most for __blkdev_direct_IO_simple(), which calls
> bio_iov_iter_get_pages() only once. If it obtains less pages than requested,
> it returns a "short write" or "short read", and __generic_file_write_iter()
> falls back to buffered writes, which may lead to data corruption.
> 
> Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for
>  simplified bdev direct-io")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  block/bio.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 489a430..925033d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -903,14 +903,16 @@ int bio_add_page(struct bio *bio, struct page *page,
>  EXPORT_SYMBOL(bio_add_page);
>  
>  /**
> - * bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
> + * __bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
>   * @bio: bio to add pages to
>   * @iter: iov iterator describing the region to be mapped
>   *
> - * Pins as many pages from *iter and appends them to @bio's bvec array. The
> + * Pins pages from *iter and appends them to @bio's bvec array. The
>   * pages will have to be released using put_page() when done.
> + * For multi-segment *iter, this function only adds pages from the
> + * the next non-empty segment of the iov iterator.
>   */
> -int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> +static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
>  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt, idx;
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> @@ -947,6 +949,33 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	iov_iter_advance(iter, size);
>  	return 0;
>  }
> +
> +/**
> + * bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
> + * @bio: bio to add pages to
> + * @iter: iov iterator describing the region to be mapped
> + *
> + * Pins pages from *iter and appends them to @bio's bvec array. The
> + * pages will have to be released using put_page() when done.
> + * The function tries, but does not guarantee, to pin as many pages as
> + * fit into the bio, or are requested in *iter, whatever is smaller.
> + * If MM encounters an error pinning the requested pages, it stops.
> + * Error is returned only if 0 pages could be pinned.
> + */
> +int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> +{
> +	unsigned short orig_vcnt = bio->bi_vcnt;
> +
> +	do {
> +		int ret = __bio_iov_iter_get_pages(bio, iter);
> +
> +		if (unlikely(ret))
> +			return bio->bi_vcnt > orig_vcnt ? 0 : ret;
> +
> +	} while (iov_iter_count(iter) && !bio_full(bio));

When 'ret' isn't zero, and some partial progress has been made, seems less pages
might be obtained than requested too. Is that something we need to worry about?

Thanks,
Ming
