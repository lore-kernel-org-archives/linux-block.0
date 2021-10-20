Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45155C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DAE610A3
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJTGn4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhJTGn4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:43:56 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C47C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xmEwncYBafvXExcKU+8G9RM78tZAvewx/pTJuW7H96g=; b=JgU0hGOqOAi2loOkkJZh3K6Xig
        Bm/VmhTWFXGLGWUwtCldHiavdeIOrvvuleylrhswArtDPEbJ9u8I1l5S3g6aNKmMtN6nqzD948Q3B
        LGOJAmdX5uIYyUuCFq3HqKJINKWZQEVG5qrrEbleJgjwETcI4YXX8Ji3K5kJJyOuB7bHn4r+Oe0fu
        J5d9+tPNsvrLqFEuL3JeKlexbz9rgej0yIp4B1UinnJZvmgjLkMPdgaJthbJJXGchm2QNcQKuZ2dT
        x1ipv6mqinGAhcbIXCwNGfNKQYdGbvpRGsWWMOAjkr3PjUTeL9lti3bbkV7/UPsiM/I7h1CISzS5m
        Wi1VJx1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md5ID-003UIj-Qw; Wed, 20 Oct 2021 06:41:41 +0000
Date:   Tue, 19 Oct 2021 23:41:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 14/16] block: skip advance when async and not needed
Message-ID: <YW+6JZcwPW+zGqqp@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <48fd2fe9d0367620ceda34b79857892841f18668.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48fd2fe9d0367620ceda34b79857892841f18668.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:23PM +0100, Pavel Begunkov wrote:
> Nobody cares about iov iterators state if we return -EIOCBQUEUED, so as
> the we now have __blkdev_direct_IO_async(), which gets pages only once,
> we can skip expensive iov_iter_advance(). It's around 1-2% of all CPU
> spent.

This is a pretty horrible code structure.  If you do want to optimize
this case just call __bio_iov_bvec_set directly from your fast path for
the iov_iter_is_bvec case.  And please add a big fat comment explaining
it and document in the commit why this matters using actual numbers on
a real workload.
