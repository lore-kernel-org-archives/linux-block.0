Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCA5CE79D3
	for <linux-block@archiver.kernel.org>; Wed, 20 Sep 2023 14:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjITOTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Sep 2023 10:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjITOTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2023 10:19:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B10AF;
        Wed, 20 Sep 2023 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LCL+za9L/oG2/oA78zLeMg4B2m4wFuzkxDAfhaMatew=; b=oviwYh8MABsy1PRUiBtKJPBW7V
        AT3zmPZ9R5MV64hEW7VITZ9VoHzAvWzxHW9izNdgIdtfBru3wNbChS/M2LdfI5SwGGNqVhCHAgAvJ
        PVm4Cu1U9pDPpDPmQGFXgxn6bydjmRPHg41wt+W+qxD6+82oJfy35vjhnRqToqRfAIA4KHprgW4wq
        jOtFWq61xQ/lAH24QzuPjskmuI1lfZJkovAx9WI6ZqI/U+1o90djRnLEmMCmGy16M8CSN9QVOhQ3R
        cypPV3zlf66QTkf4StGQGRDrwX8mTcvHSQRP0EElooG0q2sLiZZa1AYhl+KsUlUhUjSnYbyLC1uxL
        3jgo3PYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiy2U-006EhU-IP; Wed, 20 Sep 2023 14:18:51 +0000
Date:   Wed, 20 Sep 2023 15:18:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/18] mm/readahead: rework loop in
 page_cache_ra_unbounded()
Message-ID: <ZQr/ShPjJobN+zhk@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-2-hare@suse.de>
 <CGME20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b@eucas1p1.samsung.com>
 <20230920115643.ohzza3x3cpgbo54s@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920115643.ohzza3x3cpgbo54s@localhost>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 20, 2023 at 01:56:43PM +0200, Pankaj Raghav wrote:
> On Mon, Sep 18, 2023 at 01:04:53PM +0200, Hannes Reinecke wrote:
> >  		if (folio && !xa_is_value(folio)) {
> > @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  			 * not worth getting one just for that.
> >  			 */
> >  			read_pages(ractl);
> > -			ractl->_index++;
> > -			i = ractl->_index + ractl->_nr_pages - index - 1;
> > +			ractl->_index += folio_nr_pages(folio);
> > +			i = ractl->_index + ractl->_nr_pages - index;
> I am not entirely sure if this is correct.
> 
> The above if condition only verifies if a folio is in the page cache but
> doesn't tell if it is uptodate. But we are advancing the ractl->index
> past this folio irrespective of that.
> 
> Am I missing something?

How readahead works?

Readahead is for the optimistic case where nothing has gone wrong;
we just don't have anything in the page cache yet.

If there's a !uptodate folio in the page cache, there are two
possibilities.  The most likely is that we have two threads accessing this
file at the same time.  If so, we should stop and allow the other thread
to do the readahead it has decided to do.  The less likely scenario is
that we had an error doing a previous readahead.  If that happened, we
should not try reading it again in readahead; we should let the thread
retry the read when it actually tries to access the folio.
