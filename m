Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84042C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 17:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353594AbhLCRuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 12:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbhLCRuI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 12:50:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C36C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rjAyR6sH984y4pmdXmcmyB1FXphSIYWtIhcV+8T7f4k=; b=F+fP0E7ozhEsLFbBdOUiSX4ZCf
        YBbN2qkrcieIe2Hx6g15d20pHOHF8j6rikRyJqH5VtAB2gvGRLEwDPNsaGjP3Py7C1KdZ2qrq5M0Q
        uFDyvpjs2UYX4f4BuAVyKf/hpKAz7vcS0pKDniDrExhta3pUom8Nf/o2bjnYj+EGQIFAeNuF1moFh
        eYvuryMgV7Stn6JeG4kok4LWs80QNXiwZv496/6lS8m8t6DF6s64ruLPCr7LHg4wNUxCYZqf+mtao
        jxvd2nui46ajhkYvCZ5ApAdm7E/B4ZEtgC5/xgYyqRBUXIveieuIUaA5YM53kG0C1SuBE0fEZNbt5
        aNiGtJng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtCdu-009dOr-3R; Fri, 03 Dec 2021 17:46:42 +0000
Date:   Fri, 3 Dec 2021 17:46:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
Message-ID: <YapYAt7+r7K0aQ3+@casper.infradead.org>
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
 <YapC9cl6qsOAjzNj@casper.infradead.org>
 <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
 <5e92c117-0cdb-9ea6-3f1c-912e683c4e51@kernel.dk>
 <89810ae4-7c9b-ec8f-5450-ef8dc51ad8a4@kernel.dk>
 <97e253f7-d945-0c6b-3d8b-dcf597f04f69@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e253f7-d945-0c6b-3d8b-dcf597f04f69@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 03, 2021 at 09:38:25AM -0700, Jens Axboe wrote:
> On 12/3/21 9:35 AM, Jens Axboe wrote:
> > On 12/3/21 9:31 AM, Jens Axboe wrote:
> >> On 12/3/21 9:24 AM, Jens Axboe wrote:
> >>> On 12/3/21 9:16 AM, Matthew Wilcox wrote:
> >>>> On Fri, Dec 03, 2021 at 08:38:28AM -0700, Jens Axboe wrote:
> >>>>> +++ b/include/linux/fs.h
> >>>>
> >>>> fs.h is the wrong place for these functions; they're pagecache
> >>>> functionality, so they should be in pagemap.h.

I think you missed this ^^^

> >> That does introduce a dependency from fs.h -> pagemap.h which isn't trivially
> >> resolvable...
> >>
> >> What if we just rename the above funciton to mapping_has_pages() or something
> >> instead?
> > 
> > Or just drop the helper, to be honest. There are more tests for
> > mapping->nrpages right now than there are callers of this silly little
> > helper.
> 
> Like this:

I'm happy with this, if you just move it to pagemap.h

> 
> commit 80d0d63df336376f53375c98703bcae0ec50d26b
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Oct 28 08:47:05 2021 -0600
> 
>     mm: move filemap_range_needs_writeback() into header
>     
>     No functional changes in this patch, just in preparation for efficiently
>     calling this light function from the block O_DIRECT handling.
>     
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bbf812ce89a8..11a37adc2520 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2845,6 +2845,35 @@ static inline int filemap_fdatawait(struct address_space *mapping)
>  	return filemap_fdatawait_range(mapping, 0, LLONG_MAX);
>  }
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
>  extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
>  				  loff_t lend);
>  extern bool filemap_range_needs_writeback(struct address_space *,
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
> 
> -- 
> Jens Axboe
> 
