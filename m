Return-Path: <akpm@linux-foundation.org>
Date: Thu, 15 Jun 2017 11:25:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, linux-api@vger.kernel.org,
 viro@zeniv.linux.org.uk, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/10] fs: Introduce filemap_range_has_page()
Message-Id: <20170615112533.36d21ee582c968f6d5dec42f@linux-foundation.org>
In-Reply-To: <20170615160002.17233-3-rgoldwyn@suse.de>
References: <20170615160002.17233-1-rgoldwyn@suse.de>
	<20170615160002.17233-3-rgoldwyn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 15 Jun 2017 10:59:54 -0500 Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:

> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> filemap_range_has_page() return true if the file's mapping has
> a page within the range mentioned. This function will be used
> to check if a write() call will cause a writeback of previous
> writes.
> 
> ...
>
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2517,6 +2517,8 @@ extern int filemap_fdatawait(struct address_space *);
>  extern void filemap_fdatawait_keep_errors(struct address_space *);
>  extern int filemap_fdatawait_range(struct address_space *, loff_t lstart,
>  				   loff_t lend);
> +extern int filemap_range_has_page(struct address_space *, loff_t lstart,
> +				  loff_t lend);
>  extern int filemap_write_and_wait(struct address_space *mapping);
>  extern int filemap_write_and_wait_range(struct address_space *mapping,
>  				        loff_t lstart, loff_t lend);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6f1be573a5e6..87aba7698584 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -376,6 +376,39 @@ int filemap_flush(struct address_space *mapping)
>  }
>  EXPORT_SYMBOL(filemap_flush);
>  
> +/**
> + * filemap_range_has_page - check if a page exists in range.
> + * @mapping:           address space structure to wait for

"to wait for" seems wrong.

> + * @start_byte:        offset in bytes where the range starts
> + * @end_byte:          offset in bytes where the range ends (inclusive)
> + *
> + * Find at least one page in the range supplied, usually used to check if
> + * direct writing in this range will trigger a writeback.
> + */
> +int filemap_range_has_page(struct address_space *mapping,
> +			   loff_t start_byte, loff_t end_byte)

Would a bool return type be better?

> +{
> +	pgoff_t index = start_byte >> PAGE_SHIFT;
> +	pgoff_t end = end_byte >> PAGE_SHIFT;
> +	struct pagevec pvec;
> +	int ret;
> +
> +	if (end_byte < start_byte)
> +		return 0;
> +
> +	if (mapping->nrpages == 0)
> +		return 0;
> +
> +	pagevec_init(&pvec, 0);
> +	ret = pagevec_lookup(&pvec, mapping, index, 1);
> +	if (!ret)
> +		return 0;
> +	ret = (pvec.pages[0]->index <= end);
> +	pagevec_release(&pvec);
> +	return ret;
> +}
> +EXPORT_SYMBOL(filemap_range_has_page);
> +
