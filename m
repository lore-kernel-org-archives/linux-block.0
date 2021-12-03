Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E04CC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 18:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhLCSSY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 13:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhLCSSY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 13:18:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78541C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GD64sxxkaZgcvMwCyBi5m/HQbOLiEzO+oT6UsEbNhcg=; b=iYFrG4xrkFfWYQVQ2wrTXBybqJ
        tVudS1M040SYOSPaPtZ9RFKd68nhiwLiZnsnCvRjz8qOUNxFFjZq0uBNSlhc5/qkNgnmjz59RouZl
        9aeX05B1imc9dajB0XtEeEb1mxdtWyFcMVOdd4OM1w0of6EfMeHipeEw7fzjrtlW9PFer5GZ8mn4j
        rBreXCasMV2uAwcPEIpkcFG52/JMQ7/KYRdp+c8eaQy/DCi1ZiPJwQEjO46hsG0MSudp8La/at9AW
        bAZoqUsQQO/I+cCTEq23eGhd01q9bW2GRUk6wd6ElFtzdYHgFa6o8IUEjz9bDivU7c1hUXH5WHUO5
        pwM4vM+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtD5G-009j2F-I1; Fri, 03 Dec 2021 18:14:58 +0000
Date:   Fri, 3 Dec 2021 18:14:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
Message-ID: <Yapeosr1ByRBEdgT@casper.infradead.org>
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
 <YapC9cl6qsOAjzNj@casper.infradead.org>
 <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
 <5e92c117-0cdb-9ea6-3f1c-912e683c4e51@kernel.dk>
 <89810ae4-7c9b-ec8f-5450-ef8dc51ad8a4@kernel.dk>
 <97e253f7-d945-0c6b-3d8b-dcf597f04f69@kernel.dk>
 <YapYAt7+r7K0aQ3+@casper.infradead.org>
 <e386e230-4eef-f4da-f327-9b0f1d33fe47@kernel.dk>
 <9cabdcc3-e760-bab5-edfe-ae225e5d4db9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cabdcc3-e760-bab5-edfe-ae225e5d4db9@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 03, 2021 at 11:01:14AM -0700, Jens Axboe wrote:
> On 12/3/21 10:57 AM, Jens Axboe wrote:
> >> I'm happy with this, if you just move it to pagemap.h
> > 
> > OK, I'll try it out.
> 
> Wasn't too bad at all, actually just highlighted that I missed removing
> the previous declaration of filemap_range_needs_writeback() in fs.h
> I'll do a full compile and test, but this seems sane.
> 
> commit 63c6b3846b77041d239d5b5b5a907b5c82a21c4c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Oct 28 08:47:05 2021 -0600
> 
>     mm: move filemap_range_needs_writeback() into header
>     
>     No functional changes in this patch, just in preparation for efficiently
>     calling this light function from the block O_DIRECT handling.
>     
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bbf812ce89a8..6b8dc1a78df6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2847,8 +2847,6 @@ static inline int filemap_fdatawait(struct address_space *mapping)
>  
>  extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
>  				  loff_t lend);
> -extern bool filemap_range_needs_writeback(struct address_space *,
> -					  loff_t lstart, loff_t lend);
>  extern int filemap_write_and_wait_range(struct address_space *mapping,
>  				        loff_t lstart, loff_t lend);
>  extern int __filemap_fdatawrite_range(struct address_space *mapping,
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 605246452305..274a0710f2c5 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -963,6 +963,35 @@ static inline int add_to_page_cache(struct page *page,
>  int __filemap_add_folio(struct address_space *mapping, struct folio *folio,
>  		pgoff_t index, gfp_t gfp, void **shadowp);
>  
> +bool filemap_range_has_writeback(struct address_space *mapping,
> +				 loff_t start_byte, loff_t end_byte);
> +
> +/**
> + * filemap_range_needs_writeback - check if range potentially needs writeback
> + * @mapping:           address space within which to check
> + * @start_byte:        offset in bytes where the range starts
> + * @end_byte:          offset in bytes where the range ends (inclusive)
> + *
> + * Find at least one page in the range supplied, usually used to check if
> + * direct writing in this range will trigger a writeback. Used by O_DIRECT
> + * read/write with IOCB_NOWAIT, to see if the caller needs to do
> + * filemap_write_and_wait_range() before proceeding.
> + *
> + * Return: %true if the caller should do filemap_write_and_wait_range() before
> + * doing O_DIRECT to a page in this range, %false otherwise.
> + */
> +static inline bool filemap_range_needs_writeback(struct address_space *mapping,
> +						 loff_t start_byte,
> +						 loff_t end_byte)
> +{
> +	if (!mapping->nrpages)
> +		return false;
> +	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
> +	    !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> +		return false;
> +	return filemap_range_has_writeback(mapping, start_byte, end_byte);
> +}
> +
>  /**
>   * struct readahead_control - Describes a readahead request.
>   *
> diff --git a/mm/filemap.c b/mm/filemap.c
> index daa0e23a6ee6..655c9eec06b3 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -646,8 +646,8 @@ static bool mapping_needs_writeback(struct address_space *mapping)
>  	return mapping->nrpages;
>  }
>  
> -static bool filemap_range_has_writeback(struct address_space *mapping,
> -					loff_t start_byte, loff_t end_byte)
> +bool filemap_range_has_writeback(struct address_space *mapping,
> +				 loff_t start_byte, loff_t end_byte)
>  {
>  	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
>  	pgoff_t max = end_byte >> PAGE_SHIFT;
> @@ -667,34 +667,8 @@ static bool filemap_range_has_writeback(struct address_space *mapping,
>  	}
>  	rcu_read_unlock();
>  	return page != NULL;
> -
> -}
> -
> -/**
> - * filemap_range_needs_writeback - check if range potentially needs writeback
> - * @mapping:           address space within which to check
> - * @start_byte:        offset in bytes where the range starts
> - * @end_byte:          offset in bytes where the range ends (inclusive)
> - *
> - * Find at least one page in the range supplied, usually used to check if
> - * direct writing in this range will trigger a writeback. Used by O_DIRECT
> - * read/write with IOCB_NOWAIT, to see if the caller needs to do
> - * filemap_write_and_wait_range() before proceeding.
> - *
> - * Return: %true if the caller should do filemap_write_and_wait_range() before
> - * doing O_DIRECT to a page in this range, %false otherwise.
> - */
> -bool filemap_range_needs_writeback(struct address_space *mapping,
> -				   loff_t start_byte, loff_t end_byte)
> -{
> -	if (!mapping_needs_writeback(mapping))
> -		return false;
> -	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
> -	    !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> -		return false;
> -	return filemap_range_has_writeback(mapping, start_byte, end_byte);
>  }
> -EXPORT_SYMBOL_GPL(filemap_range_needs_writeback);
> +EXPORT_SYMBOL_GPL(filemap_range_has_writeback);
>  
>  /**
>   * filemap_write_and_wait_range - write out & wait on a file range
> 
> -- 
> Jens Axboe
> 
