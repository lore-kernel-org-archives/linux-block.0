Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C968DC35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 14:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACB324656
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 14:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgBYOCR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:02:17 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31526 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgBYOCQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 09:02:16 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01PE27FN031971;
        Tue, 25 Feb 2020 15:02:07 +0100
Date:   Tue, 25 Feb 2020 15:02:07 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
Message-ID: <20200225140207.GA31782@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
 <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c181b184-1785-b221-76fa-4313bbada09d@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 10:14:40AM +0300, Denis Efremov wrote:
> 
> 
> On 2/25/20 6:45 AM, Willy Tarreau wrote:
> > On Tue, Feb 25, 2020 at 02:13:42AM +0300, Denis Efremov wrote:
> >> On 2/25/20 12:53 AM, Linus Torvalds wrote:
> >>> So I'd like to see that second step that does the
> >>>
> >>>     -static int fdc;                 /* current fdc */
> >>>     +static int current_fdc;
> >>>
> >>> change.
> >>>
> >>> We already call the global 'drive' variable 'current_drive', so it
> >>> really is 'fdc' that is misnamed and ambiguous because it then has two
> >>> different cases: the global 'fdc' and then the various shadowing local
> >>> 'fdc' variables (or function arguments).
> >>>
> >>> Mind adding that too? Slightly less automatic, I agree, because then
> >>> you really do have to disambiguate between the "is this the shadowed
> >>> use of a local 'fdc'" case or the "this is the global 'fdc' use" case.
> > 
> > I definitely agree. I first wanted to be sure the patches were acceptable
> > as a principle, but disambiguating the variables is easy to do now.
> 
> Ok, I don't want to break in the middle of your changes in this case.

So I started this and discovered the nice joke you were telling me
about regarding FD_IOPORT which references fdc. Then the address
registers FD_STATUS, FD_DATA, FD_DOR, FD_DIR, FD_DCR which are
based on FD_IOPORT also depend on it.

These ones are used by fd_outb() which is arch-dependent, so if we
want to pass a third argument we have to change them all and make sure
not to break them too much.

In addition the FD_* macros defined above are used by x86, and FD_DOR is
also used by arm while all other archs hard-code all the values. ARM also
uses floppy_selects[fdc] and new_dor... I'm starting to feel the trap here!
I also feel a bit concerned that these are exported in uapi with a hard-coded
0x3f0 base address. I'm just not sure how portable all of this is in
the end :-/

Now I'm wondering, how far should we go and how much is it acceptable to
change ? I'd rather not have "#define fdc current_fdc" just so that it
builds, but on the other hand this problem clearly outlights the roots
of the issue, which lies in "fdc" being silently accessed by macros with
nobody noticing!

Willy
