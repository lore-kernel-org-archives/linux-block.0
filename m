Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A230AC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 13:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiGFNJY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiGFNJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:09:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A37C205C3;
        Wed,  6 Jul 2022 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oZewV7nvSkHVBfShe1MZGHcV0gb/7NEtkHKBliIeP7s=; b=qOjLPInd+VTQAgvTwzFUbTvHK4
        lrIqhVDJZUUPAdV5ipvvFqjNhc+mBBf5oO32lYMGfqCZ6S4XIpJAZ3v5xMCPPgVrAQ7LwR1tMcQlG
        yiVxA+KmEpBEsuBqLQauEjSzNtZTLGK9oKdFHEFrMCJT2i9fzqHLfzGKBBecb4xXnx5uZdnp8kf9p
        2oA8jDQ6SCaXGjJll8vDdYLXM+EflLXWuIbBERgknGvq5Tn8eZU2a0sly3OF0GzegPNRRrfCOua1c
        LPFM+aey0BZs+V3u01XKL56lw1YbpR2EaDP4nZ92OthsEMBWnhpBPPnmOvXSowCMcZf3+o+P7vhS6
        R2VQRIGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o94mO-00AAZy-6T; Wed, 06 Jul 2022 13:09:20 +0000
Date:   Wed, 6 Jul 2022 06:09:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/20] block, blksnap: big buffer in the form of an array
 of pages
Message-ID: <YsWJgCjcS1UnBlvq@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-9-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-9-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 13, 2022 at 06:53:01PM +0300, Sergei Shtepa wrote:
> Description of the struct big_buffer, which is used to store
> sufficiently large amounts of data, such as a CBT map, and functions for
> working with it. There are systems on which quite often the kmalloc()
> memory allocation function of several hundred kilobytes ends with an
> error code, and it is impossible to use virtual memory when handling an
> I/O unit, since a page fault situation is possible. A simple array of
> pages solves this problem.

FYI, vmalloc can now be used in a GFP_NOIO context by using
memalloc_noio_save / memalloc_noio_restore, which could be used to
simplify this a lot.
