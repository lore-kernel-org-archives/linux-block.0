Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06895C4BA0B
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D275B20714
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 08:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgBZISO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:18:14 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31587 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgBZISO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 03:18:14 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01Q8I8dH001973;
        Wed, 26 Feb 2020 09:18:08 +0100
Date:   Wed, 26 Feb 2020 09:18:08 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
Message-ID: <20200226081808.GA1589@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
 <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com>
 <20200225140207.GA31782@1wt.eu>
 <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
 <CAHk-=wggnfCR2JcC-U9LxfeBo2UMagd-neEs8PwDHsGVfLfS=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggnfCR2JcC-U9LxfeBo2UMagd-neEs8PwDHsGVfLfS=Q@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 10:08:51AM -0800, Linus Torvalds wrote:
> We should at least try moving those bits to the floppy.c file and
> remove it from the header file.
> 
> For example, doing a Debian code search on "FDPATCHES" doesn't find
> any user space hits. Searching for "FD_STATUS" gets a lot of hits, but
> thos all seem to be because it's a symbol used by user space programs,
> ("file descriptor status"), not because those hits actually used the
> fdreg.h header file.
> 
> So we can remove at least the FD_IOPORT mess from the header file, I bet.

OK so I think this time I managed to get it done after two failed attempts.

I've sent in response to this thread 6 new patches to the series just for
validation (11 to 16), I'll spam relevant people when resending the whole
if we agree on the principle already.

First, still no single byte change in the output code:
  willy@wtap:master$ diff -u floppy-{before,after}.s
  --- floppy-before.s     2020-02-26 08:59:04.185152450 +0100
  +++ floppy-after.s      2020-02-26 08:58:58.253156733 +0100
  @@ -1,5 +1,5 @@
   
  -floppy-before.o:     file format elf64-x86-64
  +floppy-after.o:     file format elf64-x86-64
   
   
   Disassembly of section .text:

Second, I could kill FD_IOPORT entirely. The FD_* macros are now
just the registers offsets. I've added two local functions fdc_inb()
and fdc_outb() which take an fdc and the register, and remap this
to fd_inb() and fd_outb() so that we don't need to fiddle anymore
with "fdc". I had one attempt at propagating that cleanup (base+reg
instead of port) to various archs, it was OK but didn't bring any
visible value in my opinion.

Third, I renamed "fdc" to "current_fdc" and carefully replaced all
"fdc" instances which didn't build with "current_fdc". This revealed
that at many places we iterate over current_fdc just because it was
the required name for the register macro (which used to derive from
FD_IOPORT). So at this point I'm still seeing a lot of possible
cleanups which will produce different binary output but will be quite
more reviewable. The common pattern in floppy.c is :

    for (current_fdc = 0; current_fdc < N_FDC; current_fdc++) {
        do_something(current_fdc);
    }
    current_fdc = 0;

  or:

    for (i = 0; i < N_FDC; i++) {
        current_fdc = i;
        do_something(current_fdc);
    }
    current_fdc = 0;

These ones can safely be cleaned up.

I also thought that once done we could have a "current_fdc" being a
struct floppy_fdc_state* instead of an int and directly point to the
correct fdc_state. This way we'll regain a lot of readability in the
code.

Please just tell me what you think and if I should repost a whole
series and/or continue the cleanup.

Thanks,
Willy
