Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FAC07E95
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 06:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8F1610F7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 06:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbhGTGC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbhGTGCU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:02:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7169BC061762;
        Mon, 19 Jul 2021 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yHEkvegX26cVfn3GkiLWFqcYGsXKWPu+0RziWCi4PNQ=; b=itzkrhKqUQAJb/TGYv0epIArX2
        XQYlyumTDeAyQx1Zx12TkGxqGdpgeePnT2Wn9IrMsqzvJrOnH8sDURWSunM/k3bGVwFK83ZEEfOdZ
        SiC6NEHDTjY+8xr0kQLKVukXeO4DYkP/M3VeCOhM9ipqe7b78EKiJ4US3/R31ofc9pNoYdkBZPWj6
        vHBtymaHAB3UVOVFmYbLZUwL6rhMsUFMgEWOD0DeuJSHjRq6wtlQWt7EKwKtWhfFngiB+aSeIyHOF
        et033hLWYXwMTVGuFr1CSny08jgnsVE4rfz8V5IlU6w4jqZ7LTSFf/dlPRivTDwIGPwJ1CWQOZTsb
        BI4iNYjg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jS4-007pmm-CB; Tue, 20 Jul 2021 06:42:10 +0000
Date:   Tue, 20 Jul 2021 07:42:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 01/17] block: Add bio_add_folio()
Message-ID: <YPZwODMq1ilIeS4t@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:45PM +0100, Matthew Wilcox (Oracle) wrote:
> +/**
> + * bio_add_folio - Attempt to add part of a folio to a bio.
> + * @bio: Bio to add to.
> + * @folio: Folio to add.
> + * @len: How many bytes from the folio to add.
> + * @off: First byte in this folio to add.
> + *
> + * Always uses the head page of the folio in the bio.  If a submitter only
> + * uses bio_add_folio(), it can count on never seeing tail pages in the
> + * completion routine.  BIOs do not support folios that are 4GiB or larger.
> + *
> + * Return: The number of bytes from this folio added to the bio.
> + */
> +size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> +		size_t off)
> +{
> +	if (len > UINT_MAX || off > UINT_MAX)
> +		return 0;
> +	return bio_add_page(bio, &folio->page, len, off);
> +}

I'd use the opportunity to switch to a true/false return instead of
the length.  This has been on my todo list for bio_add_page for a while,
so it might make sense to start out the new API the right way.
