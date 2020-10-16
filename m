Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590CAC433E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73D120874
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 16:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJgXHABo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410794AbgJPQ75 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410436AbgJPQ74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 12:59:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FEEC061755;
        Fri, 16 Oct 2020 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rX72xEW/FraddlP/xroD+/n2ZPPyq/NOSwKo4SiG7CE=; b=XJgXHABoqPlTir4V2Amptz90w7
        rzIQ/XXOClAtPSo2MB63E9qFTQhVNp17k1ROOPIspMrJcvthAZMn27dGbJqC+2OGD+Z98LQK95Vut
        8Wh6JE2hf1wkhO1nezhTd4S0VHk0G0LpA0ObYVkPa0+XPthQXPxa5f/IP1ITdMLuY3h2SoyH8PC8n
        ImeRqky6neHxZ8/yKUf9hAapTUlrwsxPo6Z/0vP7sSOyp5opXRLNuMyGWEzcHC3B/w4p386ybp2D/
        YN/ttezYFt9OwUomY8B2p8a57khdThkpJwd7a5IHJ1c8m3WstrzrbquywdzIEN09rINoeLuJ2iZoV
        o8qGYxSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTT59-0008M8-Do; Fri, 16 Oct 2020 16:59:55 +0000
Date:   Fri, 16 Oct 2020 17:59:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: Make mpage_readpage synchronous
Message-ID: <20201016165955.GG20115@casper.infradead.org>
References: <20201016161426.21715-1-willy@infradead.org>
 <20201016161426.21715-3-willy@infradead.org>
 <20201016165608.GB1426921@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016165608.GB1426921@dhcp-10-100-145-180.wdl.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 16, 2020 at 09:56:08AM -0700, Keith Busch wrote:
> On Fri, Oct 16, 2020 at 05:14:26PM +0100, Matthew Wilcox (Oracle) wrote:
> > +	err = submit_bio_killable(args.bio, mpage_end_io);
> > +	if (unlikely(err))
> > +		goto err;
> > +
> > +	SetPageUptodate(page);
> 
> On success, isn't the page already set up to date through the
> mpage_end_io() callback?

On success, mpage_end_io() isn't called.  And we don't want it to be
because we don't want the page to be unlocked.  I should probably have
included a reference to
https://lore.kernel.org/linux-fsdevel/20201016160443.18685-1-willy@infradead.org/
