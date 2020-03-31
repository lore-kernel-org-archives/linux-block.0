Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6981C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8694B208E0
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AlcQymeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgCaPr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:47:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 11:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QuUejbsfcejHB1RDQsQ9fzakZjmz1KKNU/bqFeeAGiQ=; b=AlcQymeCjtoov6XtxOxx/t+rZ9
        YnrGLhpzMg8TbbDRsngQAF1xZwvByUCY9IoG3YdWk+kcBc8u3A09s2qJxercHLVNdSsHQtW8v0o7z
        Mf+wL0T6+yVOwlAxGhHMAkosrWtnQH/gET4hQbLOdjA9ZiPhlytaiw0KzFtpndWb5cNABRYa4sdBG
        Hc03ooCDVyoZ16cSnmsZ+R5RMUZXRhqoEcKrIRc+Yn0cnBwhiccJTRnBWJW8omyHg1UCByYh3vD1O
        MHMEIK3hK76BwbZkWjHflcHZO3KnDCKx2J8N9nJ5hHOlCWaGfJIgt/pDo/pY76LbsYQ7NJSiWlLol
        UaLDvYkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJIoG-0004Hh-UP; Tue, 31 Mar 2020 15:28:12 +0000
Date:   Tue, 31 Mar 2020 08:28:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Ian Molton <spyro@f2s.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, x86@kernel.org
Subject: Re: [PATCH 00/23] Floppy driver cleanups
Message-ID: <20200331152812.GA16100@infradead.org>
References: <20200331094054.24441-1-w@1wt.eu>
 <20200331101019.GA6299@infradead.org>
 <20200331110136.GB24562@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331110136.GB24562@1wt.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 31, 2020 at 01:01:36PM +0200, Willy Tarreau wrote:
> I'm not sure what this implies regarding this code, to be honest. It's
> very tricky and implements sort of a state machine using function pointers
> within its interrupt handler so you never know exactly what accesses what,
> and quite a part of it remains obscure to me :-/  I can accept to help, I
> can even run tests since I still have running hardware, but I'd at least
> need some guidance. And probably Denis would know better than me there.
> Also I doubt we'd get sufficient testing on less common archs. While I
> do have sparc64/parisc/alpha available, I haven't booted a recent kernel
> on any of them for a while (2.4 used to be the last ones), and I'm not
> sure it's reasonable to go into such changes without proper testing.

The basic change is that instead of using bio_data() or page_address
all pages coming from the block layer need to be properly kmap()ed.
I'll try to cook something up an will send it to Denis and you for
review and testing.  The code things about sparc64/parisc/alpha is
that they all don't have highmem, so these changes should be effective
no-ops for them.
