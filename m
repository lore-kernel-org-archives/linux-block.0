Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B320FC35E04
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 18:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A011206E6
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 18:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgBYSI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:08:29 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31545 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBYSI2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 13:08:28 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01PI8KvV001137;
        Tue, 25 Feb 2020 19:08:20 +0100
Date:   Tue, 25 Feb 2020 19:08:20 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
Message-ID: <20200225180820.GA1133@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
 <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com>
 <20200225140207.GA31782@1wt.eu>
 <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
 <20200225180219.GA395@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225180219.GA395@1wt.eu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 07:02:19PM +0100, Willy Tarreau wrote:
> On Tue, Feb 25, 2020 at 06:22:47PM +0300, Denis Efremov wrote:
> > I think that for the first attempt changing will be enough:
> > -static int fdc;                        /* current fdc */
> > +static int current_fdc;                        /* current fdc */
> > and
> > -#define FD_IOPORT fdc_state[fdc].address
> > +#define FD_IOPORT fdc_state[current_fdc].address
> > and for fd_setdor in ./arch/arm/include/asm/floppy.h
> 
> So after a bit more digging, that should not be correct because:
>   - disk_change() uses a local "fdc" variable with expectations that
>     it will be used by fd_inb(FD_DIR)
>     
>   - set_dor() uses a local fdc argument that's used by
>     fd_outb(newdor, FD_DOR)
> 
> Here we have "fdc" hidden in:
>   - FD_DOR/FD_DIR (referencing FD_IOPORT) on x86
>   - fd_outb(), relying on fd_setdor() on ARM

And in the ARM case, fdc is used to index a two-entries array with exactly
identical values, with N_FDC set to 1 so even there it's pointless... Maybe
I'll get rid of this first.

Willy
