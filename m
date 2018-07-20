Return-Path: <ming.lei@redhat.com>
Date: Fri, 20 Jul 2018 10:22:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@ZenIV.linux.org.uk>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/3] blkdev: __blkdev_direct_IO_simple: fix leak in
 error case
Message-ID: <20180720022225.GA17311@ming.t460p>
References: <20180719210158.25923-1-mwilck@suse.com>
 <20180719210158.25923-3-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719210158.25923-3-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 11:01:57PM +0200, Martin Wilck wrote:
> Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for simplified bdev direct-io")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  fs/block_dev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 0dd87aa..aba2541 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -221,7 +221,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	ret = bio_iov_iter_get_pages(&bio, iter);
>  	if (unlikely(ret))
> -		return ret;
> +		goto out;
>  	ret = bio.bi_iter.bi_size;
>  
>  	if (iov_iter_rw(iter) == READ) {
> @@ -250,12 +250,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  		put_page(bvec->bv_page);
>  	}
>  
> -	if (vecs != inline_vecs)
> -		kfree(vecs);
> -
>  	if (unlikely(bio.bi_status))
>  		ret = blk_status_to_errno(bio.bi_status);
>  
> +out:
> +	if (vecs != inline_vecs)
> +		kfree(vecs);
> +
>  	bio_uninit(&bio);
>  
>  	return ret;
> -- 
> 2.17.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
