Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A9DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhKWTDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhKWTDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:03:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7E8C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lM1/R5zU8qzsNVka3IVNyM5NoOuKVsTuZ7jhJHHgrcU=; b=PIwK0MZolva2id1ECZFWvDkddF
        zizsYOpNj6BHTbKVpZvL5LkwCcTaJj2Ic2EZ6Dg4y3UDN+CDILLk9fEd157NPg/ZqatID9uwL58Fw
        v+nvsONcsWJtnWBSJyPbGFy+0wmCsaGtEpnwWM3WbcDNtNUEiPs0Ym7ejFAaJdOA6+asdFi1MRTdt
        Pcg+JK6fhm2iSzbOSdiOIvD5oswwMV6shIoFm9aL4yg7NCei1KgvamR8HCrAd1d5deGBEx9SgmG1l
        69x4xsqCOcCHaaTzEODjXspr56FkWHFSEOcaJPoOTD0lyeRfDl1Qg9ycyOuPpCgJM1dmeRi2e3o6V
        Zig0s5aA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpb1F-003GdB-5Q; Tue, 23 Nov 2021 18:59:53 +0000
Date:   Tue, 23 Nov 2021 10:59:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
Message-ID: <YZ06Kd6qpRPt3KG4@infradead.org>
References: <20211123171058.346084-1-axboe@kernel.dk>
 <20211123171058.346084-4-axboe@kernel.dk>
 <YZ03/OVZcJ+KlfFm@infradead.org>
 <b24a297d-3d57-7f8d-1932-da614454b28d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24a297d-3d57-7f8d-1932-da614454b28d@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 23, 2021 at 11:58:42AM -0700, Jens Axboe wrote:
> On 11/23/21 11:50 AM, Christoph Hellwig wrote:
> >> +	spin_lock_irq(&q->stats->lock);
> >> +	if (q->poll_stat) {
> >> +		spin_unlock_irq(&q->stats->lock);
> >> +		kfree(poll_stat);
> >> +		return true;
> >> +	}
> >> +	q->poll_stat = poll_stat;
> >> +	spin_unlock_irq(&q->stats->lock);
> > 
> > If we'd use a cmpxchg to install the pointer we could keep the
> > blk_queue_stats definition private.
> 
> How about we just move this alloc+enable logic into blk-stat.c instead?

That's a good idea either way.  But I think cmpxchg is much better
for installing a pointer than an unrelated lock.
