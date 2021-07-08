Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C27C07E9C
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 11:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E116146D
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 11:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhGHLqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 07:46:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhGHLqF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 07:46:05 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MOzKk-1lpJKg2EPc-00PMdE; Thu, 08 Jul 2021 13:43:22 +0200
Received: by mail-wm1-f54.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso3817518wmj.4;
        Thu, 08 Jul 2021 04:43:22 -0700 (PDT)
X-Gm-Message-State: AOAM532ocqVsq+x/Y2MqihGYv91R01sEYBklJWeoXfwALxENjNdaHD3C
        C2pP4YxBvkloaImyZY8Wyejbg9aTox4a8MShIbA=
X-Google-Smtp-Source: ABdhPJyUUHGbToM1X7Daz/HpQyPyl+dL3rYQNqq3pJ8zJxAYgQN5iezllBPJuSfmhDVzyloX96rQ0zJji3gQMLbjqAw=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr4697466wmh.120.1625744253544;
 Thu, 08 Jul 2021 04:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
 <20210706205927.4407-1-abd.masalkhi@gmail.com> <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
 <YOWt2swxONAvhesH@ls3530> <CAK8P3a1EFuqgZGdpWzib3RxFf6TXCy_CUTZx2ekd0wTbdNdoxg@mail.gmail.com>
 <bece0f60-b19e-5601-3bd9-c899c3d4cd93@gmx.de>
In-Reply-To: <bece0f60-b19e-5601-3bd9-c899c3d4cd93@gmx.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Jul 2021 13:37:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0x4gba+syLqjBDG0634FNDNRTvDm4dQ9p_fmgSXBUiig@mail.gmail.com>
Message-ID: <CAK8P3a0x4gba+syLqjBDG0634FNDNRTvDm4dQ9p_fmgSXBUiig@mail.gmail.com>
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a
 warning while compiling with a cross compiler for parisc
To:     Helge Deller <deller@gmx.de>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bernardo Innocenti <bernie@develer.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:n35Htb9MrjAP/WLrgMNtcMItQh2Zk244KS4GSxPhEn1TdM3c4pm
 HqktELI5uhvK998xOq64Ic+OHSb6pdH/jeUEg45YkiQ4GqrJtNWiGNjMD958n1mGFI9DoCc
 1mqFFkzzsdmDZlVjNDpv1XJuaUk1BX00AIDSIy/yS7A47kr+5vdcOpHXWa1uICCpoVcPE9N
 0V/xgbu0+z+IWQq7MxDng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9gOPVnN2wk=:qNUObeuKz8MzuIxH8hlHNz
 PhwAQLvXs+QZuRoGYJS6a/dJdZ7RYWJkYRLGt4Hfi9H7oj2SbCOlNXFgGpU3U5hNljQJ+ubsB
 TlVSeZ2tWifIP2KUWJRJe0kCOkCWv/VWEiJsqg4zMBIqESaHl3EdPbggXoDhxTZ7Pl1bYh16J
 oJZGYb4RsmsA0Ctu59l1hfoYgm0aHGFupsSiRqrjvoQldq0ZLUXrlU1yiEe3b4BWrl2ZDNibJ
 MsLAHNYcylf0CIZTlvB7jtPktwca7KBf5mSVmoIXMZfFcgGZFVVCWkpmZbZHZmaf08if9FMdE
 wljOG1sVwusJDtu13wZ9cpp+WQNR3UyHd8TFuHye03CTV5Sk7AhrxIOlSmZ2rnJJR4v2y+R5N
 4M/ctEb4mqucOWZLaT20mXJBoELURusic7L6IcXSqV2ULt73JlckDoSoBIC8vScnAmF/OgNx3
 wH5Swq/uUxNBnX6VcPuoyqJIGsCY5mABHqe2+bAQZjLKIaLbBLQ9GpK/N84sp+7eDW26EjZPw
 kadc2PqfoWSKPcKIOWY42t/dk4wl0rGMuQoWmyBB4qLZxFVhIDTg5kdydoDr4HJHSSYcd5ugT
 OfKx3feBxwegTQLdibcCEklri2Ti/HTZl3t5/Qfy1ev65nnKptFUUPTskTuF2wpWCnlGHSipx
 yDAVdtKGkIcNkjyhWQXvBEKld38PmZMfjqdCWbG/W+KjpbnPJ2GZtBjRwOzo9yy2tmb4Z/xLO
 f3wEDK0P7WuDw/6NA3QCEYhlLVwNqHw0SPph1LJNtsjdu0gIcmX5RLpy6mIEC6IoCiFo84mtX
 B9Sul5EkCHPxpZLfb77+0QyJVDKRk2Wh7mSe2TYzJcBlzZ/FkhkJENiy9Bx2YxMs/V8GdMifO
 EdIcdyYN69Mpm5Zpv+amGk2c1vHoyF7cxqFDaJ+FMcI5MPpul5Dun98ZXSxfjCIzsIAV0Qv42
 MekupFSg4M9LeF6JWI96KAA8IcMof5DYR+hYLD0oioukRhivtMTqk
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 8, 2021 at 11:30 AM Helge Deller <deller@gmx.de> wrote:
> On 7/7/21 10:39 PM, Arnd Bergmann wrote:
> >> [PATCH] parisc: Increase gcc stack frame check to 2048 for 32- and 64-bit
> >>
> >> parisc uses much bigger frames than other architectures, so increase the
> >> stack frame check value to 2048 to avoid compiler warnings.
> >
> > I think setting it to 2048 is rather excessive,
>
> Since parisc needs roughly twice the frame (and stack) size as x86,
> 2048 seemed logical since that's the double of what's used on x86.
> Of course we can reduce it, e.g. to 1536.

But it doesn't use twice as much for large functions at all. The stack
frame for a small function is much larger, so you need a larger kernel
stack to allow for deely nested call chains, but the frame for single
function with large variables is only a bit larger as most of it is used up
by those variables.

> > and it would make you miss other real bugs. What I suggested was to
> > change the defconfig to use CONFIG_CC_OPTIMIZE_FOR_SIZE instead.
>
> But then you still will see those warnings in case you choose to not
> optize for size.

Right, and I would consider that a good thing: this warning is for a real
(though fairly harmless) bug that has already been fixed with newer
toolchains, so anyone that runs into the bug should probably see the
warning for it. Doubling the limit would effectively prevent similar bugs
from being noticed, and they could be in performance-critical code
or cause an actual stack overrun.

I can think of two other, more directed workarounds:

- change block/Makefile to add -Os to the cflags for this one file in
  known-broken configurations (parisc with old gcc and -O2),
  to be removed in a few years when gcc-10 becomes the minimum
  supported version

- add a warning that points to the gcc bug (if someone has a link)
  when building an affected configuration, and let users decide to
  either change their setup (using -Os or a newer compiler) or to
  ignore the warning.

> or bad coding, e.g. huge local variables

That's what I meant with 'kernel bug'.

       Arnd
