Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2DBC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 10:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3298B206DB
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 10:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="codfAmuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgCaKKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:10:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaKKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 06:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hJxfOSzdmYrs6hSSrcsd02nNF7mdH/uu3mzeMEqvEn8=; b=codfAmuINBu2/Figchpip9pX1c
        Fbanc2gqJEXQjBlwCDhlhpzRc3Az15dGiuRcAbbx+5Tu6z9xcQXfEKPziljf5Nkk8AGO3iuSuELk1
        W5KaTs8eTRDuCm+ajEKWCDk3gZn1qSSFoMXMQn8h+JgiW3lgA7M22UVfx7rXDhMvdmm4mc0prIEk/
        19EJ8Y0+X5yiu8KQKA0PAM7ghVOAp+14kSNZcHUwm+arlCbE+NsrzFyIHZUFeH/oszRV0sQMfTLDK
        wCIFJmXk6QhT3BhVpkwjro4DZERUEtwLH+GPWJl5f3bOMB17gQzATq0B4i4dJAmPwYIqB5bIi6zTD
        c+n3iNbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJDqd-0002uU-T8; Tue, 31 Mar 2020 10:10:19 +0000
Date:   Tue, 31 Mar 2020 03:10:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <20200331101019.GA6299@infradead.org>
References: <20200331094054.24441-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Willy,

given that you are actively maintaining the floppy driver now, any
chance I could trick you into proper highmem handling?  I've been trying
to phase out block layer bounce buffering, and any help from a competent
maintainer to move their drivers to properly support highmem by kmapping
for PIO/MMIO I/O would be very helpful.
