Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13ABC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 11:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA31208E0
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 11:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgCaLEm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:04:42 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34203 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbgCaLEm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 07:04:42 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02VB1a4e024578;
        Tue, 31 Mar 2020 13:01:36 +0200
Date:   Tue, 31 Mar 2020 13:01:36 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Christoph Hellwig <hch@infradead.org>
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
Message-ID: <20200331110136.GB24562@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
 <20200331101019.GA6299@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331101019.GA6299@infradead.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Tue, Mar 31, 2020 at 03:10:19AM -0700, Christoph Hellwig wrote:
> Hi Willy,
> 
> given that you are actively maintaining the floppy driver now,

No no no I'm not! Denis is :-) Really, I mean I just proposed some help
to clean up this mess after being tricked into not believing a bug report
just because the code was too confusing.

> any
> chance I could trick you into proper highmem handling?  I've been trying
> to phase out block layer bounce buffering, and any help from a competent
> maintainer to move their drivers to properly support highmem by kmapping
> for PIO/MMIO I/O would be very helpful.

I'm not sure what this implies regarding this code, to be honest. It's
very tricky and implements sort of a state machine using function pointers
within its interrupt handler so you never know exactly what accesses what,
and quite a part of it remains obscure to me :-/  I can accept to help, I
can even run tests since I still have running hardware, but I'd at least
need some guidance. And probably Denis would know better than me there.
Also I doubt we'd get sufficient testing on less common archs. While I
do have sparc64/parisc/alpha available, I haven't booted a recent kernel
on any of them for a while (2.4 used to be the last ones), and I'm not
sure it's reasonable to go into such changes without proper testing.

What do you think ?

Willy
