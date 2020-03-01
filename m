Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E8C3F2D1
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 06:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7525E21775
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgCAGqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 01:46:09 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31982 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCAGqJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 01:46:09 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0216k17C024045;
        Sun, 1 Mar 2020 07:46:01 +0100
Date:   Sun, 1 Mar 2020 07:46:01 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
Message-ID: <20200301064601.GA24037@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200229141354.GA23095@1wt.eu>
 <CAHk-=whFAAV_TOLFNnj=wu4mD2L9OvgB6n2sKDdmd8buMKFv8A@mail.gmail.com>
 <202003010019.14391.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003010019.14391.linux@zary.sk>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 01, 2020 at 12:19:14AM +0100, Ondrej Zary wrote:
> On Saturday 29 February 2020 16:58:11 Linus Torvalds wrote:
> > On Sat, Feb 29, 2020 at 8:14 AM Willy Tarreau <w@1wt.eu> wrote:
> > >
> > > So if you or Denis think there's some value in me continuing to explore
> > > one of these areas, I can continue, otherwise I can simply resend the
> > > last part of my series with the few missing Cc and be done with it.
> > 
> > It's fine - this driver isn't worth spending a ton of effort on.
> > 
> > The only users are virtualization, and even they are going away
> > because floppies are so small, and other things have become more
> > standard anyway (ie USB disk) or easier to emulate (NVMe or whatever).
> > 
> > So I suspect the only reason floppy is used even in that area is just
> > legacy "we haven't bothered updating to anything better and we have
> > old scripts and images that work".
> > 
> >               Linus
> > 
> 
> There are real users with real floppy drives out there.

OK thanks for the feedback. Then I'll continue the minimum cleanups to
try to focus on maintainability and on the principle of least surprise,
and I'll have a quick look at the possible simplifications brought by
the limitation to one FDC, in case that really helps.

Willy
