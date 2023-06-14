Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A74EB64D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 12:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244713AbjFNMqA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244710AbjFNMp7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 08:45:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB619BC;
        Wed, 14 Jun 2023 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yIlDgmGpWDX6+aYjnp7Qi0Lh0iY6Vm9oqGpNd9f4x94=; b=bPwAh3lUBaW4f0udSC4u3trHwP
        qDfyxtpr4cLGU7L6JKQAfALLMN7MfccalkDZkLO6OAmWDN1WQFSG7KQFjYj5YTWQ+v7I1Z2f27A5h
        9M8THr5vxPDfnMNuHgYPIzPKO2ECPeav/eH0cUFVVIvlMiWqkskK1LLEvMG/4EtWtuQBWGKbFMuda
        ulbpTHbBv0nb/JRxllCpHfG84FB/mgE18ow3cp4vOdjg3MqoRYw8STxpc5te+tYsW9PI4yhltuwVq
        3M7ivyVRJqvfCNI/3CcS1/qi3lPgRFQfOtERR9P2/c95vl/vKzjfJ3vcrL9WS5+uNcIs/f1CzmEwu
        DpFc5GkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9Psk-006J3a-6Q; Wed, 14 Jun 2023 12:45:50 +0000
Date:   Wed, 14 Jun 2023 13:45:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/7] brd: use XArray instead of radix-tree to index
 backing pages
Message-ID: <ZIm2fqesAKAHHh5j@casper.infradead.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614114637.89759-2-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 14, 2023 at 01:46:31PM +0200, Hannes Reinecke wrote:
>  static void brd_free_pages(struct brd_device *brd)
>  {
> -	unsigned long pos = 0;
> -	struct page *pages[FREE_BATCH];
> -	int nr_pages;
> -
> -	do {
> -		int i;
> -
> -		nr_pages = radix_tree_gang_lookup(&brd->brd_pages,
> -				(void **)pages, pos, FREE_BATCH);
> -
> -		for (i = 0; i < nr_pages; i++) {
> -			void *ret;
> -
> -			BUG_ON(pages[i]->index < pos);
> -			pos = pages[i]->index;
> -			ret = radix_tree_delete(&brd->brd_pages, pos);
> -			BUG_ON(!ret || ret != pages[i]);
> -			__free_page(pages[i]);
> -		}
> -
> -		pos++;
> +	struct page *page;
> +	pgoff_t idx;
>  
> -		/*
> -		 * It takes 3.4 seconds to remove 80GiB ramdisk.
> -		 * So, we need cond_resched to avoid stalling the CPU.
> -		 */
> -		cond_resched();
> +	xa_for_each(&brd->brd_pages, idx, page) {
> +		__free_page(page);
> +		cond_resched_rcu();

This should be a regular cond_resched().  The body of the loop is run
without the RCU read lock held.  Surprised none of the bots have noticed
an unlock-underflow.  Perhaps they don't test brd ;-)

With that fixed,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
