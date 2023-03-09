Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D27C64EC4
	for <linux-block@archiver.kernel.org>; Thu,  9 Mar 2023 03:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCID2L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 22:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCID2J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 22:28:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0911EFEA
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 19:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NpyOst0aug1wpFJ+wMLEd7XR9byordlOSIR7ZuITUlE=; b=1SkSCUsE73G9VSkRDnH+RI+ZvO
        ERzAF6ohriPDvA0d5itwjTNVo76F5ATAIIbHHHd36Tn1IQH5R+ne4mbDr9TrS/q7EdUgYF5ktfCuc
        hXg8J/qwxWgY2DtwbtxD7ToB9OWbAx/8NZNo8DnSaeDLK/9ncB2oLUKzrjnLaRxGVhjhFXXILFTA7
        ZopchGOVBMQ/tQEswshi24o2tfq9t3BpkUr27qWPpn7sDzdGzCMD+66GsyKoQDumRGf35gtcS6LGI
        Qwix6sg4mRUAajhorJaRZL+bxaSSFicvQDscja1SrRHUoItKW8gJ0Q9e9m5CcCZQTtl68ros/g1qV
        t1Siabfg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pa6wk-007e9D-Ji; Thu, 09 Mar 2023 03:28:02 +0000
Date:   Wed, 8 Mar 2023 19:28:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/5] brd: convert to folios
Message-ID: <ZAlSQviNuTBqQN42@bombadil.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-2-hare@suse.de>
 <ZAYk5wOUaXAIouQ5@casper.infradead.org>
 <76613838-fa4c-7f3e-3417-7a803fafc6c2@suse.de>
 <ZAboHUp/YUkEs/D1@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAboHUp/YUkEs/D1@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 07, 2023 at 07:30:37AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 07, 2023 at 07:55:32AM +0100, Hannes Reinecke wrote:
> > On 3/6/23 18:37, Matthew Wilcox wrote:
> > > On Mon, Mar 06, 2023 at 01:01:23PM +0100, Hannes Reinecke wrote:
> > > > -	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> > > > -	if (!page)
> > > > +	folio = folio_alloc(gfp | __GFP_ZERO, 0);
> > > > +	if (!folio)
> > > 
> > > Did you drop HIGHMEM support on purpose?
> > 
> > No; I thought that folios would be doing that implicitely.
> > Will be re-adding.
> 
> We can't ... not all filesystems want to allocate every folio from
> HIGHMEM.  eg for superblocks, it often makes more sense to allocate the
> folio from lowmem than allocate it from highmem and keep it kmapped.
> The only GFP flag that folios force-set is __GFP_COMP because folios by
> definition are compound pages.

Just some historical information here. Some commit logs would seem
to make it seem that __GFP_HIGHMEM was added to support DAX, but it's
not the case. When DAX suport was removed from brd the __GFP_HIGHMEM
removed was removed by mistake, and later fixed through commit
f6b50160a06d4 ("brd: re-enable __GFP_HIGHMEM in brd_insert_page()").
But that doesn't tell us what the default were before.

To avoid future removals maybe we should document why we care?

See these commits:

9db5579be4bb5 ("rewrite rd")               initial commit with highmem
cb9cd2ef0bbb4 ("rd: support XIP")          forces highmem if XIP, but already set
a7a97fc9ff6c2 ("brd: rename XIP to DAX")   renames the config to DAX
26defe34e48e1 ("fix brd allocation flags") tries to fix the confusion but makes it worse

And so commit f6b50160a06d4 ("brd: re-enable __GFP_HIGHMEM in brd_insert_page()")
seems to be correct in re-adding it, adn commit cb9cd2ef0bbb4 ("rd: support XIP")
made things confusing assuming we wanted only highmem when DAX was
enabled.

So we only want highmem just because it's been there since it was first added.
That's all.

  Luis
