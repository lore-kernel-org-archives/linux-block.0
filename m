Return-Path: <axboe@kernel.dk>
Date: Fri, 5 Jan 2018 08:42:31 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [GIT PULL 24/25] lightnvm: pblk: add iostat support
Message-ID: <20180105154230.GA13829@kernel.dk>
References: <20180105131621.20808-1-m@bjorling.me>
 <20180105131621.20808-25-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180105131621.20808-25-m@bjorling.me>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 05 2018, Matias Bj�rling wrote:
> From: Javier Gonz�lez <javier@cnexlabs.com>
> 
> Since pblk registers its own block device, the iostat accounting is
> not automatically done for us. Therefore, add the necessary
> accounting logic to satisfy the iostat interface.

Ignorant question - why is it a raw block device, not using blk-mq?

> @@ -193,9 +197,9 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>  	__pblk_end_io_read(pblk, rqd, true);
>  }
>  
> -static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
> -				      unsigned int bio_init_idx,
> -				      unsigned long *read_bitmap)
> +static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
> +				 unsigned int bio_init_idx,
> +				 unsigned long *read_bitmap)
>  {
>  	struct bio *new_bio, *bio = rqd->bio;
>  	struct pblk_sec_meta *meta_list = rqd->meta_list;
> @@ -306,6 +310,8 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
>  	return NVM_IO_OK;
>  
>  err:
> +	pr_err("pblk: failed to perform partial read\n");
> +
>  	/* Free allocated pages in new bio */
>  	pblk_bio_free_pages(pblk, bio, 0, new_bio->bi_vcnt);
>  	__pblk_end_io_read(pblk, rqd, false);

This seems to include unrelated changes, like the rename above and the
addition of the error logging?

-- 
Jens Axboe
