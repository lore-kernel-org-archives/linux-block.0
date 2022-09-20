Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CBBC54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 07:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiITHiO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiITHiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:38:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6260516
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PaBKzzji2Oday9RFISZPc7AVNz4dkMggLSLRR4gxGEY=; b=WAb5pGe+XkDdPdA31k8j9LUa3I
        crxFjNOx9FABY34GecywZe9UeYLpc5MLNO9GtoTQe9ccpF40mBQksEG0uwTQ8PJjr0ZHTkwXDJba7
        ofA0FMx0ytF3qMvyvAMbyDpObe00Z3OkBz1wm/1lKmZWmoY2iK8jf26kZZkYaFTggTCn5738oPDh2
        Mxs6jvioI6SvNVG2FvfEcKQ/23tSPozbPL6YykfyIFwwfp6CA668OS7e4yfNOlDmASZo0ej6ECnMY
        Glpk+w6HwTcqIXzP08cMawvlI6pqhklkDWvygNQTq0ANQkio5xI2wRxsIrI6RekcCsA+bqsRWVBbp
        qIN0NkFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXpY-001Q1v-Mo; Tue, 20 Sep 2022 07:38:08 +0000
Date:   Tue, 20 Sep 2022 00:38:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 2/4] brd: extend the rcu regions to cover read and write
Message-ID: <Yylt4A7B6dsn7+bu@infradead.org>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209160459250.543@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209160459250.543@file01.intranet.prod.int.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>   * Look up and return a brd's page for a given sector.
> + * This must be called with the rcu lock held.

Please ad a rcu_read_lock_held() check then.

> -	rcu_read_lock();
>  	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
>  	page = radix_tree_lookup(&brd->brd_pages, idx);
> -	rcu_read_unlock();
> -
> -	BUG_ON(page && page->index != idx);
>  
>  	return page;

No need for the page variable now.  In fact there is no real need
for this helper now, as all the callers really should operate on
the sector on the index anyway.

>  }
> @@ -88,7 +74,9 @@ static bool brd_insert_page(struct brd_d
>  	struct page *page;
>  	gfp_t gfp_flags;
>  
> +	rcu_read_lock();
>  	page = brd_lookup_page(brd, sector);
> +	rcu_read_unlock();
>  	if (page)
>  		return true;

So this looks odd, as we drop the rcu lock without doing anything,
but it actually turns out to be correct as brd_do_bvec does yet
another lookup of it.  So we get an initial look, and optional
insert and then another lookup.  Not very efficient and it might be
worth to fix brd_do_bvec up to avoid these extra lookups given
that you touch it anyway (as would be an radix tree to xarray
conversion).

