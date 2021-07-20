Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC5C07E95
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 06:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1307C61004
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 06:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhGTGNe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhGTGNI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:13:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC8C061574;
        Mon, 19 Jul 2021 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0CmZtM83YivlMkH6ioTNkWqXqgtpPQ044+TPH2r8ezk=; b=JMG0p/ekwaaxcmSVbqjY4knyaw
        cOHBxLrpRI+c4q70n3SsVtVm/p1t17LLU4xYNGnwOq3wA0yVBPczGbaNIZb/EyjygK1KyjGazjTHy
        +8hZ3YqRbZRU2eJ0V3l2C9KYgH2tujnoOHTt6eGx7UEth2LbHjDk84ggwQwFN971i98ax01DPMxqB
        OFgmCBgpnicdd6qVt+bMdCWy0188WDCaUqxB4Kx8LIsMwCt00sVUdc+A++RN99ukIYGCVSoOdpWPl
        Z1fVDf6et68FTdZKVpzaguoUSOxNVP1C/4HMcvHYfdmaqJdsq7FBHDWvu/bxuFvqjpaoX6Iq2UNJZ
        LOV3bN6A==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jcS-007qJ7-Ie; Tue, 20 Jul 2021 06:52:50 +0000
Date:   Tue, 20 Jul 2021 08:52:43 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 05/17] iomap: Convert iomap_page_release to take a
 folio
Message-ID: <YPZyuyAQx9yqO9qV@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:49PM +0100, Matthew Wilcox (Oracle) wrote:
> -static void
> -iomap_page_release(struct page *page)
> +static void iomap_page_release(struct folio *folio)
>  {
> -	struct iomap_page *iop = detach_page_private(page);
> -	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
> +	struct iomap_page *iop = folio_detach_private(folio);
> +	unsigned int nr_blocks = i_blocks_per_folio(folio->mapping->host,
> +							folio);

Nit: but I find this variant much easier to read:

	unsigned int nr_blocks =
		i_blocks_per_folio(folio->mapping->host, folio);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
