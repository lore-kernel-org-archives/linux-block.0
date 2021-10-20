Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D33C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 17:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E24F60F9F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 17:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJTRbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhJTRb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 13:31:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37632C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5EkxZf2eMV9JL5MvIdT/IOmsCeNDQTUDESVj/mqBxWY=; b=JxVEBuQq3GSo/Sv7p+9WRW/gDR
        wt/7aMvx/kzcQEF7wvjDOVt9mGPElRmL1injMvNKxOnwyP9NgiBqflGZ+vQrwNdF222xOtYng8Wx4
        xyL0bQ6pR5wphe4sovzGereXJ5OuXLCyfQKL2J4CJnHsbj6Fi1rSEfFb6RcqNiRWIQjj0BMU0bSSg
        jeSMrZ4N+7FOnCh/R5av4nsiXhl0PkyqSEVTnLBqVxbzJ1RwOg1IjIiy6BnT0gZoCemeZDgbrAvME
        oPklq1VwdvCSZSzWgzC/p/guw+QZuD+jZiY/uyHVRjvWzHnXDbPUbxqbFfh4IOq/kjbeVvJO3Uu5y
        Woc9QJpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdFOp-005K35-2p; Wed, 20 Oct 2021 17:29:11 +0000
Date:   Wed, 20 Oct 2021 10:29:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 05/16] block: inline a part of bio_release_pages()
Message-ID: <YXBR5z/ouMI490xQ@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <c01c0d2c4d626eb1b63b196d98375a7e89d50db3.1634676157.git.asml.silence@gmail.com>
 <YW+zdYMG2FUlzXWA@infradead.org>
 <dd5451ed-f0ad-98b0-18c1-5cd2aa87aaef@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5451ed-f0ad-98b0-18c1-5cd2aa87aaef@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 08:15:25AM -0600, Jens Axboe wrote:
> I just want to be very clear that neither mine nor Pavel's work is
> trying to get into benchmarketing. There are very tangible performance
> benefits, and they are backed up by code analysis and testing. That
> said, the point is of course not to make this any harder to follow or
> maintain, but we are doing suboptimal things in various places and those
> should get cleaned up, particularly when they impact performance. Are
> some a big eager? Perhaps, but let's not that that cloud the perception
> of the effort as a whole.

A lot of it seems generally useful.  But optimizing for BIO_NO_PAGE_REF
is really special.  Besides a few in-kernel special cases this is all
about the io_uring pre-registered buffers, which are very much a
special case and not a normal workload at all.  In this case it is just
an extra conditional moved into a few callers so I think we're ok, but
I'm really worried about optimizing this benchmark fast path over the
code everyone actually uses.
