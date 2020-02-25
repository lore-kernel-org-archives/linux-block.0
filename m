Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7476C35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 18:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9B720CC7
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 18:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgBYSPw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:15:52 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31550 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgBYSPw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 13:15:52 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01PIFfwi001143;
        Tue, 25 Feb 2020 19:15:41 +0100
Date:   Tue, 25 Feb 2020 19:15:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
Message-ID: <20200225181541.GA1138@1wt.eu>
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
> On Tue, Feb 25, 2020 at 7:22 AM Denis Efremov <efremov@linux.com> wrote:
> >
> > I think that for the first attempt changing will be enough:
> > -static int fdc;                        /* current fdc */
> > +static int current_fdc;                        /* current fdc */
> > and
> > -#define FD_IOPORT fdc_state[fdc].address
> > +#define FD_IOPORT fdc_state[current_fdc].address
> 
> Please don't do this blindly - ie without verifying that there are no
> cases of that "local fdc variable shadowing" issue.

That's exactly what I'm doing. In fact I first renamed the variable
and am manually checking all places which do not compile anymore.
Hence the surprizes.

> Of course, such a verification might be as easy as "generates exact
> same code" rather than looking at every use.

That's exactly what I'm doing.

> And btw, don't worry too much about this being in an UAPI file. I'm
> pretty sure that's because of specialty programs that use the magical
> ioctls to do special formatting. They want the special commands
> (FD_FORMAT etc), but I don't think they really use the port addresses.
> 
> So I think it's in a UAPI file entirely by mistake.

OK this will help me, thanks for the hint :-)

> We should at least try moving those bits to the floppy.c file and
> remove it from the header file.

Makes sense.

> For example, doing a Debian code search on "FDPATCHES" doesn't find
> any user space hits. Searching for "FD_STATUS" gets a lot of hits, but
> thos all seem to be because it's a symbol used by user space programs,
> ("file descriptor status"), not because those hits actually used the
> fdreg.h header file.
> 
> So we can remove at least the FD_IOPORT mess from the header file, I bet.
> 
> Worst case - if somebody finds some case that uses them, we can put it back.

I like that. And at least we'll know how they use it (likely without the
dependency on fdc).

Thanks,
Willy
