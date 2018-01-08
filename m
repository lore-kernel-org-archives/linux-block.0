Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43000 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754945AbeAHSFL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jan 2018 13:05:11 -0500
Received: by mail-pf0-f193.google.com with SMTP id d23so6498606pfe.9
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2018 10:05:11 -0800 (PST)
Subject: Re: [PATCH 08/10] block: move bio_alloc_pages() to bcache
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org,
        linux-bcache <linux-bcache@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
References: <20171208131409.11889-1-ming.lei@redhat.com>
 <20171208131409.11889-9-ming.lei@redhat.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <c388724b-45eb-445c-8a93-cf25c313fa65@lyle.org>
Date: Mon, 8 Jan 2018 10:05:09 -0800
MIME-Version: 1.0
In-Reply-To: <20171208131409.11889-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/08/2017 05:14 AM, Ming Lei wrote:
> bcache is the only user of bio_alloc_pages(), and all users should use
> bio_add_page() instead, so move this function into bcache, and avoid
> it misused in future.

Can things like this -please- be sent to the bcache list and bcache
maintainers?  I'm preparing my patch set for Jens and I'm surprised by
merge conflicts from stuff in my queue.  (Just showed up in next to show
the conflict in the past couple of days).

Mike

> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c              | 28 ----------------------------
>  drivers/md/bcache/util.c | 27 +++++++++++++++++++++++++++
>  drivers/md/bcache/util.h |  1 +
>  include/linux/bio.h      |  1 -
>  4 files changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 228229f3bb76..76bb3dafffea 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -969,34 +969,6 @@ void bio_advance(struct bio *bio, unsigned bytes)
>  EXPORT_SYMBOL(bio_advance);
>  
>  /**
> - * bio_alloc_pages - allocates a single page for each bvec in a bio
> - * @bio: bio to allocate pages for
> - * @gfp_mask: flags for allocation
> - *
> - * Allocates pages up to @bio->bi_vcnt.
> - *
> - * Returns 0 on success, -ENOMEM on failure. On failure, any allocated pages are
> - * freed.
> - */
> -int bio_alloc_pages(struct bio *bio, gfp_t gfp_mask)
> -{
> -	int i;
> -	struct bio_vec *bv;
> -
> -	bio_for_each_segment_all(bv, bio, i) {
> -		bv->bv_page = alloc_page(gfp_mask);
> -		if (!bv->bv_page) {
> -			while (--bv >= bio->bi_io_vec)
> -				__free_page(bv->bv_page);
> -			return -ENOMEM;
> -		}
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(bio_alloc_pages);
> -
> -/**
>   * bio_copy_data - copy contents of data buffers from one chain of bios to
>   * another
>   * @src: source bio list
> diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
> index 61813d230015..ac557e8c7ef5 100644
> --- a/drivers/md/bcache/util.c
> +++ b/drivers/md/bcache/util.c
> @@ -283,6 +283,33 @@ start:		bv->bv_len	= min_t(size_t, PAGE_SIZE - bv->bv_offset,
>  	}
>  }
>  
> +/**
> + * bio_alloc_pages - allocates a single page for each bvec in a bio
> + * @bio: bio to allocate pages for
> + * @gfp_mask: flags for allocation
> + *
> + * Allocates pages up to @bio->bi_vcnt.
> + *
> + * Returns 0 on success, -ENOMEM on failure. On failure, any allocated pages are
> + * freed.
> + */
> +int bio_alloc_pages(struct bio *bio, gfp_t gfp_mask)
> +{
> +	int i;
> +	struct bio_vec *bv;
> +
> +	bio_for_each_segment_all(bv, bio, i) {
> +		bv->bv_page = alloc_page(gfp_mask);
> +		if (!bv->bv_page) {
> +			while (--bv >= bio->bi_io_vec)
> +				__free_page(bv->bv_page);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Portions Copyright (c) 1996-2001, PostgreSQL Global Development Group (Any
>   * use permitted, subject to terms of PostgreSQL license; see.)
> diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
> index ed5e8a412eb8..c92de937bcab 100644
> --- a/drivers/md/bcache/util.h
> +++ b/drivers/md/bcache/util.h
> @@ -558,6 +558,7 @@ static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
>  }
>  
>  void bch_bio_map(struct bio *bio, void *base);
> +int bio_alloc_pages(struct bio *bio, gfp_t gfp_mask);
>  
>  static inline sector_t bdev_sectors(struct block_device *bdev)
>  {
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 3f314e17364a..46cdbe0335a5 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -501,7 +501,6 @@ static inline void bio_flush_dcache_pages(struct bio *bi)
>  #endif
>  
>  extern void bio_copy_data(struct bio *dst, struct bio *src);
> -extern int bio_alloc_pages(struct bio *bio, gfp_t gfp);
>  extern void bio_free_pages(struct bio *bio);
>  
>  extern struct bio *bio_copy_user_iov(struct request_queue *,
> 
