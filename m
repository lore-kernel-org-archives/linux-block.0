Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2FDECAAA1
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 19:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ1TV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1TV6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 15:21:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12121CD42
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dPfx6ShIAN4bSOnBuP/wZ73HCi1ftnk1VnWf2MapqDk=; b=T3XhA2yULrCJuvp6Fh9fsNSOSR
        xrUSQvXKUF5V3Qm8Stw9sIuhbXHH0SnZnpILEC54pyru5mdYgOCGggO1QSI/NC9SBYiiPFkUAwd0y
        8k1X8bWjZJiV4palXbWaQuxjl5xRyWvSIXIbjvUxYjEepDmRX+h0n2I8iwbnIYJZjFXBAJCSmJ6M2
        LO+y9QArmqIyoJPgrUXpocdB+8Eksi+cS+mepGlW6aY/MzF2epH+y+OnMy16/g62DkCS0RjRh0dxi
        w4nFqLZ4nxGT6VmdB56og2asWRw/4LP2+OmdG2rxdMXIuyNGHlqbrXki7fnx9r/XP2bD00mv5LkI7
        CSiUF4Dg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooUvS-00F1hC-2v;
        Fri, 28 Oct 2022 19:21:55 +0000
Date:   Fri, 28 Oct 2022 20:21:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn and
 max_pfn wrong way
Message-ID: <Y1wr0g39GzHcAk9v@ZenIV>
References: <Y1wZTtENDq3fvs6n@ZenIV>
 <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 28, 2022 at 12:51:00PM -0600, Jens Axboe wrote:
> On 10/28/22 12:02 PM, Al Viro wrote:
> > 	We have this:
> > 
> > static inline bool blk_queue_may_bounce(struct request_queue *q)
> > {
> >         return IS_ENABLED(CONFIG_BOUNCE) &&
> >                 q->limits.bounce == BLK_BOUNCE_HIGH &&
> >                 max_low_pfn >= max_pfn;
> > }
> > 
> > static inline struct bio *blk_queue_bounce(struct bio *bio,
> >                 struct request_queue *q)
> > {
> >         if (unlikely(blk_queue_may_bounce(q) && bio_has_data(bio)))
> >                 return __blk_queue_bounce(bio, q);
> >         return bio;
> > }
> > 
> > Now, the last term in expression in blk_queue_may_bounce() is
> > true only on the boxen where max_pfn is no greater than max_low_pfn.
> > 
> > Unless I'm very confused, that's the boxen where we don't *have*
> > any highmem pages.
> > 
> > What's more, consider this:
> > 
> > static __init int init_emergency_pool(void)
> > {
> >         int ret;
> > 
> > #ifndef CONFIG_MEMORY_HOTPLUG
> >         if (max_pfn <= max_low_pfn)
> >                 return 0;
> > #endif
> > 
> >         ret = mempool_init_page_pool(&page_pool, POOL_SIZE, 0);
> >         BUG_ON(ret);
> >         pr_info("pool size: %d pages\n", POOL_SIZE);
> > 
> >         init_bounce_bioset();
> >         return 0;
> > }
> > 
> > On the same boxen (assuming we've not hotplug) page_pool won't be set up
> > at all, so we wouldn't be able to bounce any highmem page if we ever
> > ran into one.
> > 
> > AFAICS, this condition is backwards - it should be
> > 
> > static inline bool blk_queue_may_bounce(struct request_queue *q)
> > {
> >         return IS_ENABLED(CONFIG_BOUNCE) &&
> >                 q->limits.bounce == BLK_BOUNCE_HIGH &&
> >                 max_low_pfn < max_pfn;
> > }
> > 
> > What am I missing here?
> 
> I don't think you're missing anything, the case we need it for is when
> max_pfn > max_low_pfn. I wonder when this got botched? Because some
> of those statements date back probably about 20 years when we started
> allowing highmem pages to do IO.

9bb33f24abbd "block: refactor the bounce buffering code" about a year ago.

But fixing the test alone is not going to be enough - just a quick look
through __blk_queue_bounce() catches an obvious bug on write (we copy
the part of highmem page we covered by bio into the beginning of the
bounce page - and leave ->bv_offset as-is) as well as a possible bug in
->bi_status handling (if we really can run into bio_split() there).

I wonder if we ought to simply add "depends on BROKEN" for CONFIG_BOUNCE... ;-/
