Return-Path: <BATV+0ce91e3c8ec9178008cb+5000+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 2 May 2017 01:06:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] blk: replace bioset_create_nobvec() with a flags
 arg to bioset_create()
Message-ID: <20170502080617.GA5578@infradead.org>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654407.5146.12779672368228096310.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149369654407.5146.12779672368228096310.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index d1b04b0e99cf..0975da6bebd9 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -373,8 +373,10 @@ static inline struct bio *bio_next_split(struct bio *bio, int sectors,
>  	return bio_split(bio, sectors, gfp, bs);
>  }
>  
> -extern struct bio_set *bioset_create(unsigned int, unsigned int);
> -extern struct bio_set *bioset_create_nobvec(unsigned int, unsigned int);
> +extern struct bio_set *bioset_create(unsigned int, unsigned int, int flags);
> +enum {
> +	BIOSET_NEED_BVECS = BIT(0),
> +};

I really hate the BIT macro as it obsfucates what's going on.

Why not just

	BIOSET_NEED_BVECS	= (1 << 0),

which is a lot more intuitive.

Otherwise looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
