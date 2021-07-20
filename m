Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0944AC07E9B
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14C761165
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhGTGdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbhGTGdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:33:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE299C061574;
        Tue, 20 Jul 2021 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D4/2594UznIb06/W+TYQvHolWuTP4voEII+lw6CHkAg=; b=lwNBiu5OYrA1R86PAIHNNVqUZ3
        HTSfB+mZGK54+4EKC61Mbbgq2bbiGk4clI97u4xVyHIUkiuLFcgKVLtxrX92QrTk2631AW1oCJYTz
        FXQZxSHuHadSUCqjjdQ5S1BN4sf3NnyvxKaj5vo2QdrZk6hiaWjoxQ7zeDRMloePMa8y3qKcKqBiH
        hSGG7eo/VFULDmOlKbVbfNO0f86OEG8xhb3IGwzeYZP8i/sG2B7NGhT5z6C69QoikYzj/IClrDA/B
        LEwIRhGwh4nTMyQ4oBSH80vj6jRmk2d4UJ+jFN2hoZRUKjhyMmpQCQHHu7J/lxfyjtpqbcVnnAicu
        YO2Ifyow==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jw7-007rJw-FI; Tue, 20 Jul 2021 07:13:09 +0000
Date:   Tue, 20 Jul 2021 09:13:02 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 12/17] iomap: Convert iomap_page_mkwrite to use a
 folio
Message-ID: <YPZ3fn2pAxc16tSR@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:56PM +0100, Matthew Wilcox (Oracle) wrote:
> -	struct page *page = data;
> +	struct folio *folio = data;
>  	int ret;
>  
>  	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
> +		ret = __block_write_begin_int(&folio->page, pos, length, NULL,
> +						iomap);
>  		if (ret)
>  			return ret;
> -		block_commit_write(page, 0, length);
> +		block_commit_write(&folio->page, 0, length);
>  	} else {
> -		WARN_ON_ONCE(!PageUptodate(page));
> -		set_page_dirty(page);
> +		WARN_ON_ONCE(!folio_test_uptodate(folio));
> +		folio_mark_dirty(folio);

Not that having this else clause code for the !IOMAP_F_BUFFER_HEAD case
here is a bit silly, and becomes more so with folios - it should probably
move into the caller.  I'll see what I can do there in this merge window
to prepare.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
