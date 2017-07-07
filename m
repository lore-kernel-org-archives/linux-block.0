Return-Path: <mgorman@suse.de>
Date: Fri, 7 Jul 2017 11:23:13 +0100
From: Mel Gorman <mgorman@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, axboe@kernel.dk,
	Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, Volker.Lendecke@sernet.de,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: support IOCB_NOWAIT in generic_file_buffered_read
Message-ID: <20170707102313.fnjq4iv4gq3xldl5@suse.de>
References: <20170706153019.11645-1-hch@lst.de>
 <20170706153019.11645-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20170706153019.11645-3-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 06, 2017 at 08:30:17AM -0700, Christoph Hellwig wrote:
> From: Milosz Tanski <milosz@adfin.com>
> 
> Allow generic_file_buffered_read to bail out early instead of waiting for
> the page lock or reading a page if IOCB_NOWAIT is specified.
> 
> Signed-off-by: Milosz Tanski <milosz@adfin.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> Acked-by: Sage Weil <sage@redhat.com>

Acked-by: Mel Gorman <mgorman@suse.de>
> ---
>  mm/filemap.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9865350d6b89..bb70b64ffb48 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1843,6 +1843,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  
>  		page = find_get_page(mapping, index);
>  		if (!page) {
> +			if (iocb->ki_flags & IOCB_NOWAIT)
> +				goto would_block;
>  			page_cache_sync_readahead(mapping,
>  					ra, filp,
>  					index, last_index - index);
> @@ -1948,6 +1950,11 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		continue;
>  
>  page_not_up_to_date:
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			put_page(page);
> +			goto would_block;
> +		}
> +

This potentially could do with a comment to say that from here we will
either block on the page lock or on the read operation but it's fairly
obvious from context. What is potentially less obvious is that a page
lock contention ends up here. That could be due to a read operation taking
place in parallel but also page migrations, page scanning etc. They are all
blocking operations but the duration could be anthing from nanoseconds to
milliseconds. That *might* be surprising to some who notice they got EAGAIN
on data that should be cache resident due to the page being activated on
the LRU, being migrated etc.

That sort of gotcha might belong in the man page but it is an implementation
detail so maybe the man page should note that EAGAIN can occur for cache
resident data in some circumstances.

I can't actually see anything wrong with the patch so...

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
