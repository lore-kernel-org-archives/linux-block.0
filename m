Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A57C678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 07:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCGHap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 02:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGHao (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 02:30:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C08B196A3
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 23:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Oz8lbCC+qgTP0B9VLKv7zLfNF0q/HdrdFq9ZLmiR5I=; b=sWCrVKaRarq2O68r/M/EjwmlMp
        smSsnaaR5toggaReWtM1N7vZdXQFO4BkV9gD54dhzBB2ALsXHNGcBU8xAcUttWZMocJ8oNAfGvjsu
        eyyMGNF8RTgBN7Wvb+zlrrgWcIhxY8Q60HglZSbD0Dwu/pdCAp9Hu6ZrWa3gYNW7rQVU3DhXra9N7
        iDPOKi06d6mOijNu0A0zZHm5IBWKrHUPWNaGrmWdtr+AlCZdcH9dcWC37AIyHOb1exBXiO9KciRdB
        gCWJU7EfrlXtSwge6rBh/xOyY+UIcCraYxVMuysLkgXKd66AQY32ywbSGJI8rj0VgvRcr8Q77hcDL
        amnKV5+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZRmP-0067GJ-Vf; Tue, 07 Mar 2023 07:30:38 +0000
Date:   Tue, 7 Mar 2023 07:30:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/5] brd: convert to folios
Message-ID: <ZAboHUp/YUkEs/D1@casper.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-2-hare@suse.de>
 <ZAYk5wOUaXAIouQ5@casper.infradead.org>
 <76613838-fa4c-7f3e-3417-7a803fafc6c2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76613838-fa4c-7f3e-3417-7a803fafc6c2@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 07, 2023 at 07:55:32AM +0100, Hannes Reinecke wrote:
> On 3/6/23 18:37, Matthew Wilcox wrote:
> > On Mon, Mar 06, 2023 at 01:01:23PM +0100, Hannes Reinecke wrote:
> > > -	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> > > -	if (!page)
> > > +	folio = folio_alloc(gfp | __GFP_ZERO, 0);
> > > +	if (!folio)
> > 
> > Did you drop HIGHMEM support on purpose?
> 
> No; I thought that folios would be doing that implicitely.
> Will be re-adding.

We can't ... not all filesystems want to allocate every folio from
HIGHMEM.  eg for superblocks, it often makes more sense to allocate the
folio from lowmem than allocate it from highmem and keep it kmapped.
The only GFP flag that folios force-set is __GFP_COMP because folios by
definition are compound pages.
