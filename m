Return-Path: <jack@suse.cz>
Date: Mon, 4 Sep 2017 14:47:06 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, axboe@kernel.dk,
	Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, mgorman@suse.de,
	Volker.Lendecke@sernet.de, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: support IOCB_NOWAIT in generic_file_buffered_read
Message-ID: <20170904124706.GB5664@quack2.suse.cz>
References: <20170829141321.4482-1-hch@lst.de>
 <20170829141321.4482-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829141321.4482-3-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue 29-08-17 16:13:19, Christoph Hellwig wrote:
> From: Milosz Tanski <milosz@adfin.com>
> 
> Allow generic_file_buffered_read to bail out early instead of waiting for
> the page lock or reading a page if IOCB_NOWAIT is specified.
> 
> Signed-off-by: Milosz Tanski <milosz@adfin.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> Acked-by: Sage Weil <sage@redhat.com>

This looks good to me now. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  mm/filemap.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4bcfa74ad802..eed394fd331c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1937,6 +1937,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  
>  		page = find_get_page(mapping, index);
>  		if (!page) {
> +			if (iocb->ki_flags & IOCB_NOWAIT)
> +				goto would_block;
>  			page_cache_sync_readahead(mapping,
>  					ra, filp,
>  					index, last_index - index);
> @@ -1950,6 +1952,11 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  					index, last_index - index);
>  		}
>  		if (!PageUptodate(page)) {
> +			if (iocb->ki_flags & IOCB_NOWAIT) {
> +				put_page(page);
> +				goto would_block;
> +			}
> +
>  			/*
>  			 * See comment in do_read_cache_page on why
>  			 * wait_on_page_locked is used to avoid unnecessarily
> @@ -2131,6 +2138,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		goto readpage;
>  	}
>  
> +would_block:
> +	error = -EAGAIN;
>  out:
>  	ra->prev_pos = prev_index;
>  	ra->prev_pos <<= PAGE_SHIFT;
> -- 
> 2.11.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
