Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA4EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiAQIIe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiAQIId (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:08:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92779C061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 00:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FU6ILmBnxVV2kR23YjnR83PcS15HqV9jnzyI3bW4spc=; b=F3+z8Gt8gV3HebQeXxYV0IfLlK
        cj08+pTappPNJhLmBwsyCl/WDjvj8TUYkkpVPYTjaHWiLnU09hu6sLyJeAW+zrMC2rOrq84lGsbp7
        kv68uPtnVQiB3C7t4Wz0nJc0fS2S7uABIi6be/dDg6J1FhVOHpTYm6SUS5lX7zzofRIR+rEt/zRJZ
        1D0iP7eq2wEm9jAx0MXh/Y+3yODNNrgCQTrjiJ6Xy1TdDTR2MPGa+pXJCqJB3mmlaSPbasYqEJK1K
        DMRA3DferfUxRjdKqF3oBd6Afz/r2hNxQDPmeUl0UaEJLyFWZXkk9rVybUBFFANye3j5aotNTBE9t
        qfduI55A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9N44-00E1mQ-8b; Mon, 17 Jan 2022 08:08:32 +0000
Date:   Mon, 17 Jan 2022 00:08:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Ming Lei <ming.lei@redhat.com>
Subject: Re: [dm-devel] [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING
 for dm-rq
Message-ID: <YeUkABLBcStfJxNp@infradead.org>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <YcH/E4JNag0QYYAa@infradead.org>
 <YcP4FMG9an5ReIiV@T590>
 <YcuB4K8P2d9WFb83@redhat.com>
 <Yd1BFpYTBlQSPReW@infradead.org>
 <Yd2tDWuP+aT3Hxbj@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd2tDWuP+aT3Hxbj@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 11:15:09AM -0500, Mike Snitzer wrote:
> Round and round we go.. Pretty tired of this.

Same here.

> You are perfectly fine with incrementally compromising request-based
> DM's ability to evolve as block core does.

I would not word it that way, but I think we mean the same thing.  Yes,
I do not want to add more hooks for a complete oddball that has no
actual use case.  dm-rq does a good enough job for SCSI and has all
the infrastucture for it.  We should not more cruft to exteded it to
use cases for which there is no consesus and which are much better
covered by alredy existing code in the kernel.
