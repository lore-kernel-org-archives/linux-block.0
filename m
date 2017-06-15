Return-Path: <rgoldwyn@suse.de>
Subject: Re: [PATCH 0/10 v12] No wait AIO
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, linux-api@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <20170615160002.17233-1-rgoldwyn@suse.de>
 <20170615112528.7cbdfd6cdf26a5c13450acdf@linux-foundation.org>
 <1003b3e8-a775-e8ac-d1ca-11055d941a98@suse.de>
 <20170615150100.52c0387406e6ce5167dc098e@linux-foundation.org>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <77f14155-f706-4bc4-0e52-39e8487413d5@suse.de>
Date: Thu, 15 Jun 2017 18:49:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170615150100.52c0387406e6ce5167dc098e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 06/15/2017 05:01 PM, Andrew Morton wrote:
> On Thu, 15 Jun 2017 16:51:41 -0500 Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> 
>>> I have only minor quibbles - I'll grab the patch series for some -next
>>> testing (at least).
>>>
>>
>> I agree to the quibbles you have on patch 02/10. Should I send the
>> entire fixed series, just the 02/10 patch, or would you prefer to fix it?
> 
> This?

Perfect. Thanks!

> 
> --- a/include/linux/fs.h~fs-introduce-filemap_range_has_page-fix
> +++ a/include/linux/fs.h
> @@ -2517,8 +2517,8 @@ extern int filemap_fdatawait(struct addr
>  extern void filemap_fdatawait_keep_errors(struct address_space *);
>  extern int filemap_fdatawait_range(struct address_space *, loff_t lstart,
>  				   loff_t lend);
> -extern int filemap_range_has_page(struct address_space *, loff_t lstart,
> -				  loff_t lend);
> +extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
> +				   loff_t lend);
>  extern int filemap_write_and_wait(struct address_space *mapping);
>  extern int filemap_write_and_wait_range(struct address_space *mapping,
>  				        loff_t lstart, loff_t lend);
> diff -puN mm/filemap.c~fs-introduce-filemap_range_has_page-fix mm/filemap.c
> --- a/mm/filemap.c~fs-introduce-filemap_range_has_page-fix
> +++ a/mm/filemap.c
> @@ -378,31 +378,30 @@ EXPORT_SYMBOL(filemap_flush);
>  
>  /**
>   * filemap_range_has_page - check if a page exists in range.
> - * @mapping:           address space structure to wait for
> + * @mapping:           address space within which to check
>   * @start_byte:        offset in bytes where the range starts
>   * @end_byte:          offset in bytes where the range ends (inclusive)
>   *
>   * Find at least one page in the range supplied, usually used to check if
>   * direct writing in this range will trigger a writeback.
>   */
> -int filemap_range_has_page(struct address_space *mapping,
> -			   loff_t start_byte, loff_t end_byte)
> +bool filemap_range_has_page(struct address_space *mapping,
> +			    loff_t start_byte, loff_t end_byte)
>  {
>  	pgoff_t index = start_byte >> PAGE_SHIFT;
>  	pgoff_t end = end_byte >> PAGE_SHIFT;
>  	struct pagevec pvec;
> -	int ret;
> +	bool ret;
>  
>  	if (end_byte < start_byte)
> -		return 0;
> +		return false;
>  
>  	if (mapping->nrpages == 0)
> -		return 0;
> +		return false;
>  
>  	pagevec_init(&pvec, 0);
> -	ret = pagevec_lookup(&pvec, mapping, index, 1);
> -	if (!ret)
> -		return 0;
> +	if (!pagevec_lookup(&pvec, mapping, index, 1))
> +		return false;
>  	ret = (pvec.pages[0]->index <= end);
>  	pagevec_release(&pvec);
>  	return ret;
> _
> 

-- 
Goldwyn
