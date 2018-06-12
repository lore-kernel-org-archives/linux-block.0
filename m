Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Tue, 12 Jun 2018 02:16:30 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
	linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: add a bio_reuse helper
Message-ID: <20180612061629.GA19281@kmo-pixel>
References: <20180611194806.13222-1-hch@lst.de>
 <20180611194806.13222-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180611194806.13222-2-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 11, 2018 at 09:48:01PM +0200, Christoph Hellwig wrote:
> This abstracts out a way to reuse a bio without destroying the
> data pointers.

What is the point of this? What "data pointers" does it not destroy?

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c         | 20 ++++++++++++++++++++
>  include/linux/bio.h |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 70c4e1b6dd45..fa1b7ab50784 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -308,6 +308,26 @@ void bio_reset(struct bio *bio)
>  }
>  EXPORT_SYMBOL(bio_reset);
>  
> +/**
> + * bio_reuse - prepare a bio for reuse
> + * @bio:	bio to reuse
> + *
> + * Prepares an already setup and possible used bio for reusing it another
> + * time.  Compared to bio_reset() this preserves the bio size and the
> + * layout and contents of the bio vectors.
> + */
> +void bio_reuse(struct bio *bio)
> +{
> +	unsigned int size = bio->bi_iter.bi_size;
> +	unsigned short vcnt = bio->bi_vcnt;
> +
> +	bio_reset(bio);
> +
> +	bio->bi_iter.bi_size = size;
> +	bio->bi_vcnt = vcnt;
> +}
> +EXPORT_SYMBOL_GPL(bio_reuse);
> +
>  static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>  	struct bio *parent = bio->bi_private;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index f08f5fe7bd08..15c871ab50db 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -475,6 +475,7 @@ extern void bio_init(struct bio *bio, struct bio_vec *table,
>  		     unsigned short max_vecs);
>  extern void bio_uninit(struct bio *);
>  extern void bio_reset(struct bio *);
> +void bio_reuse(struct bio *);
>  void bio_chain(struct bio *, struct bio *);
>  
>  extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
