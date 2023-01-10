Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA26C54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 05:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjAJFIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjAJFIV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 00:08:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F01CFD4;
        Mon,  9 Jan 2023 21:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s3eeXxhx4tpS7pmZqfCJKqLGMlzmrOgdka1kjKMznI4=; b=XGJEFCmW/g7ojPqXxDzSIo/bZf
        2a1smaf/JQQz3olueaj9Y/Wc9QEAHCtgcy/b088rjTbOT7NQvB4EWdhUDrvh4EYj9IicLMmUDh6vF
        3eMwCkdKa3Sa+CQyan10aMktrXtIQ7GNYZ+mSs2eNJcC1xWRHZk5YgJJYlST66qQAoRpxqTROL8T4
        T232bsST3sdD/CpGNKEQBwDYVhkPgZSp0qRqj4Srl4tvHyDk0aiaaaw47+4+cCxG1s5iLl59Km8fF
        EHw2/n22dBHQXzTjC6VfjYdPM3tnT5jcbbCsn50bm0zeldFCJaFDuJAFwM1mv61F6FP5s0EHEoIWN
        ZRBIX7bQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF6s5-002w7R-Jj; Tue, 10 Jan 2023 05:08:25 +0000
Date:   Tue, 10 Jan 2023 05:08:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, jgg@nvidia.com, axboe@kernel.dk,
        logang@deltatee.com, hch@lst.de, alex.williamson@redhat.com,
        leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Message-ID: <Y7zyyTxdoJulq7OD@casper.infradead.org>
References: <20230109144701.83021-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109144701.83021-1-yishaih@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 09, 2023 at 04:47:01PM +0200, Yishai Hadas wrote:
>  	if (sgt_append->prv) {
> +		unsigned long paddr =
> +			(page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +

1. page_to_pfn() * PAGE_SIZE is spelled page_to_phys()

2. physical addresses have type phys_addr_t.  Oh, wait, paddr isn't a
physical address, it's a pfn because you divide by PAGE_SIZE at the end.
But you will get truncation on 32-bit, because page_to_pfn() has type
unsigned long.  Anyway, this shouldn't be called paddr.  Maybe last_pfn
or something?

> +			 sgt_append->prv->offset + sgt_append->prv->length) /
> +			PAGE_SIZE;
