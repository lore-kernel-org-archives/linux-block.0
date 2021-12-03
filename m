Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF9DC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 16:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhLCQUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhLCQUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 11:20:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCAC061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 08:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z5lBZX9MrCtSgBxcdrFbiXIPCPltTB5SEppdL+CtI5s=; b=WT3vXA/jKvgz7yn6wK1ZtFRz8s
        iVMqFKwQZv6Ww0lbYQkqNFGSpSIUFmK+6IxLMpZe9bHtV/Ligi3BsudrFzfX9LwiILs2iigvf6nGJ
        e1wV9ri53sgZfuGb9CsWUAtIO/+trNQuX1ERIdT5v9SlaBPrbQzPSI7eOQPJyi7zsKsW2viYnS+VH
        4PI+XKlfBQbSSl8FDT87pTy2EPgHcMtglGYsD5zAoa1gZ7S2ifXRmV9VvdLlcD3w/kDdYMNR7AufJ
        q79O/Q/Tsx+BE2UvmlVG0Wbx/QmJuTscZOzuoXpFMWUTUIlhru3WMTbA3WQgb5p+AOoW60lN2aiDF
        w456jtNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtBEz-009KtR-T8; Fri, 03 Dec 2021 16:16:54 +0000
Date:   Fri, 3 Dec 2021 16:16:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
Message-ID: <YapC9cl6qsOAjzNj@casper.infradead.org>
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203153829.298893-2-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 03, 2021 at 08:38:28AM -0700, Jens Axboe wrote:
> +++ b/include/linux/fs.h

fs.h is the wrong place for these functions; they're pagecache
functionality, so they should be in pagemap.h.

> +/* Returns true if writeback might be needed or already in progress. */
> +static inline bool mapping_needs_writeback(struct address_space *mapping)
> +{
> +	return mapping->nrpages;
> +}

I don't like this function -- mapping_needs_writeback says to me that it
tests a flag in mapping->flags.  Plus, it does exactly the same thing as
!mapping_empty(), so perhaps ...

> +static inline bool filemap_range_needs_writeback(struct address_space *mapping,
> +						 loff_t start_byte,
> +						 loff_t end_byte)
> +{
> +	if (!mapping_needs_writeback(mapping))
> +		return false;

just make this
	if (mapping_empty(mapping))
		return false;

Other than that, no objections to making this static inline.
