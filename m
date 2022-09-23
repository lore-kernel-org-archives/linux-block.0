Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6B5C6FA8B
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiIWPxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiIWPxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 11:53:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A029A1280F1
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E0IPn3X+H+fm//bm526e0CysKo9xMGL8XfOTcWqhJVE=; b=E85AIrdJtVs2hn42R3MtdEWtmq
        dQOR4tnVYO5HCPP55VLgcjEXJnco4gnlwqCg60M7hlEVMoDcFUamOQ+H/rqrCfBLGsBYFimqIPf0Q
        l6PKQjogqpPl7sL0xTwN82tibF2YKN95v8zN3PW8H+lOYe1VqkG7F071eBS3DVVdRcOFW5G8Dj+b/
        e5wn6klRrYgXairGMtjZn92RZYKU9YlB72OSwFIVvrcMK+bt2FeWBciYJqeKZplYpqsdvEqckpRn3
        +apoFXnKsZk0RoT8+/p03LNMC8ucXr8KoLfUJIfxsWLgkYaeqkb+UP/ppzSVeKMqvD7Df7nzJ1LiF
        SZnQSEEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obkz3-004tlz-5e; Fri, 23 Sep 2022 15:52:57 +0000
Date:   Fri, 23 Sep 2022 08:52:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v2 2/4] brd: extend the rcu regions to cover read and
 write
Message-ID: <Yy3WWap0A3WD8nkq@infradead.org>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209201353540.26058@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209201353540.26058@file01.intranet.prod.int.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20, 2022 at 01:56:25PM -0400, Mikulas Patocka wrote:
> This patch extends the rcu regions, so that lookup followed by a read or
> write of a page is done inside rcu read lock. This si be needed for the
> following patch that enables discard.
> 
> Note that we also replace "BUG_ON(!page);" with "if (page) ..." in
> copy_to_brd - the page may be NULL if write races with discard. In this
> situation, the result is undefined, so we can actually skip the write
> operation at all.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  drivers/block/brd.c |   59 +++++++++++++++++++++++-----------------------------
>  1 file changed, 27 insertions(+), 32 deletions(-)
> 
> Index: linux-2.6/drivers/block/brd.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/brd.c
> +++ linux-2.6/drivers/block/brd.c
> @@ -50,31 +50,12 @@ struct brd_device {
>  
>  /*
>   * Look up and return a brd's page for a given sector.
> + * This must be called with the rcu lock held.
>   */
>  static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>  {
> +	pgoff_t idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
> +	return radix_tree_lookup(&brd->brd_pages, idx);
>  }

This is still missing the rcu_read_lock_held() assertation if you
want to keep it as separate function.

> +	rcu_read_lock();
> +	page = brd_lookup_page(brd, sector);
> +	if (page) {
> +		dst = kmap_atomic(page);
> +		memcpy(dst + offset, src, copy);
> +		kunmap_atomic(dst);
> +	}
> +	rcu_read_unlock();

How is the null check going to work here?  Simply not copying
data is no exactly the expected result.

This is why I think we need the higher level rework I suggested
last time where we have a helper that always gives you page
(or maybe an error) by moving the insert so that it also does
the actual final lookup.
