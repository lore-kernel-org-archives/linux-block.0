Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5C4C3F2C6
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B1824680
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 14:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgB2OOE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 09:14:04 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31908 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgB2OOE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 09:14:04 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01TEDsh9023477;
        Sat, 29 Feb 2020 15:13:54 +0100
Date:   Sat, 29 Feb 2020 15:13:54 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
Message-ID: <20200229141354.GA23095@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <0f5effb1-b228-dd00-05bc-de5801ce4626@linux.com>
 <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On Wed, Feb 26, 2020 at 09:49:05AM -0800, Linus Torvalds wrote:
> On Wed, Feb 26, 2020 at 6:57 AM Denis Efremov <efremov@linux.com> wrote:
> >
> > If Linus has no objections (regarding his review) I would prefer to
> > accept 1-10 patches rather to resend them again. They seems complete
> > to me as the first step.
> 
> I have no objections, and the patches 11-16 seem to have addressed all
> my "I wish.." concerns too (except for the "we should rewrite or
> sunset the driver entirely"). Looks fine to me.

So I continued to work on this cleanup and regardless of the side I
attacked this hill, it progressively stalled once I got closer to
the interrupt and delayed work stuff. I understood the root cause of
the problem, it's actually double:

  - single interrupt for multiple FDCs : this means we need to have
    some global context to know what we're working with. It is not
    completely true because we could very well have a list of pending
    operations per FDC to scan on interrupt and update them when the
    interrupt strikes and the FDC reports a completion. I noticed that
    raw_cmd, raw_buffer, inr, current_req, _floppy, plus a number of
    function pointers used to handle delayed work should in fact be
    per-FDC if we didn't want to change them at run time ;

  - single DMA channel for multiple FDCs : regardless of what could
    be done for the interrupt above, we're still stuck with a single
    DMA setup at once, which requires to issue reset_fdc() here and
    there, making it clear we can't work with multiple FDCs in parallel.

Given the number of places where such global variables are set, I'm
not totally confident in the fact that nowhere we keep a setting
that was assigned for the FDC in the previous request. For example
a spurious (or late) interrupt could slightly affect the fdc_state[]
and maybe even emit FD_SENSEI to the current controller. Also this
comment in floppy_interrupt() made me realize the driver pre-dates
SMP support:

 /* It is OK to emit floppy commands because we are in an interrupt
  * handler here, and thus we have to fear no interference of other
  * activity.
  */

It seems that changing the current FDC is still only protected by
the fdc_busy bit, but that the interrupt handler doesn't check
if anything is expected before touching bits related to current_fdc.

All this made me wonder if we really want to continue to maintain the
support for multiple FDCs. I checked all archs, and only x86, alpha
and powerpc support more than one FDC, 2 to be precise (hence up to
8 drives). I have the impression that if we keep a single FDC we'll
have a cleaner code that doesn't need to change global settings under
us when doing resets or scans. So I don't know if that's something
interesting to pursue.

I also noticed that a lot of global variables are inter-dependent and
should probably be moved to fdc_state[] so that what's per-FDC is now
more explicit, except that this struct is exposed to userland via
the FDGETFDCSTAT ioctl (but that could be changed so that the fdc_state
is just a struct inside a per-fdc larger struct).

At least now I get a better picture of the little ROI felt trying to
clean this, and I don't think that even a complete rewrite as you
suggested would address all the issues at all.

So if you or Denis think there's some value in me continuing to explore
one of these areas, I can continue, otherwise I can simply resend the
last part of my series with the few missing Cc and be done with it.

Willy
