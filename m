Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A23C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 14:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiBBOD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiBBODZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 09:03:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BADC061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WQ2L5/ObHkXFJ17v3gfX3wo3y3s1Mn9urNO+NaAYYgU=; b=BOj7m3fkiBcwXXbRlvjHKjiLV7
        Fm1wMRar2jk1XY9BCQR2VxBY7luUA2DeguyTP/WLglcqIjtWYTVyXaIzMUqSpT9xZkp/dAGqf4ANb
        gPhZBRe9nmrrSg1xdRqz4VbGJMUS0NcqXh/FX880zL5HU+l7Kn/y61t7E4jzJmwIxdrTyqyEC4Vje
        HqgbABtLs5jOuPI4QJva11o91d7kV1YPIeSlTE3VD5+QWBWviRp5Ee0EdNq+HHeaG7xbFuJSTV8vI
        wobK+cLGrUEgYwtlbwruVoOz4A0ienf7XwGlCZly/EJZYGBwxjQhd/1Wm40vlqc4VaHd2yCHx1yRL
        JrUTAcqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFGE8-00FW8R-QQ; Wed, 02 Feb 2022 14:03:16 +0000
Date:   Wed, 2 Feb 2022 06:03:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <YfqPJLTIx18DCGii@infradead.org>
References: <20220131230255.789059-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131230255.789059-1-mfo@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> Well, blkdev_direct_IO() gets references for all pages, and on READ
> operations it only sets them dirty _later_.
> 
> So, if MADV_FREE'd pages (i.e., not dirty) are used as buffers for
> direct IO read from block devices, and page reclaim happens during
> __blkdev_direct_IO[_simple]() exactly AFTER bio_iov_iter_get_pages()
> returns, but BEFORE the pages are set dirty, the situation happens.
> 
> The direct IO read eventually completes. Now, when userspace reads
> the buffers, the PTE is no longer there and the page fault handler
> do_anonymous_page() services that with the zero-page, NOT the data!

So why not just set the pages dirty early like the other direct I/O
implementations?  Or if this is fine with the patch should we remove
the early dirtying elsewhere?

> Reproducer:
> ==========
> 
> @ test.c (simplified, but works)

Can you add this to blktests or some other regularly run regression
test suite?

> +				smp_rmb();
> +
> +				/*
> +				 * The only page refs must be from the isolation
> +				 * plus one or more rmap's (dropped by discard:).

Overly long line.

> +				 */
> +				if ((ref_count == 1 + map_count) &&

No need for the inner braces.

