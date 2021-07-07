Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2DAC07E9C
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72A861CC2
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 20:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhGGUmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 16:42:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhGGUmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 16:42:53 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5FxN-1l13Og0AFR-0118yd; Wed, 07 Jul 2021 22:40:11 +0200
Received: by mail-wm1-f50.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso2527548wmj.4;
        Wed, 07 Jul 2021 13:40:10 -0700 (PDT)
X-Gm-Message-State: AOAM530U7WKuuH7jtqH1QT94meDJldyPPnBEuko0ZP796ICuFNSCPCZV
        MWO+9nXvtZgkPnsweyMOb+KrY16wkPYtnZj0X20=
X-Google-Smtp-Source: ABdhPJxVhxtjWfZENqb3qvXdchtUZVs1vrewX7U1cQSc9Fj2KhtkQ4WGJ9YiQMCY07djksJd1iz9gKY3FqcUV7dSneo=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr1030507wmb.142.1625690410658;
 Wed, 07 Jul 2021 13:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
 <20210706205927.4407-1-abd.masalkhi@gmail.com> <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
 <YOWt2swxONAvhesH@ls3530>
In-Reply-To: <YOWt2swxONAvhesH@ls3530>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Jul 2021 22:39:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1EFuqgZGdpWzib3RxFf6TXCy_CUTZx2ekd0wTbdNdoxg@mail.gmail.com>
Message-ID: <CAK8P3a1EFuqgZGdpWzib3RxFf6TXCy_CUTZx2ekd0wTbdNdoxg@mail.gmail.com>
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
X-Provags-ID: V03:K1:YjQw2VVw6gmdv/M8o6CCNhN/4FZCpRizx+SBpO+cI4W9e51x779
 j1Uz3KIdiVzD2/tMF+POr8Le36PzJijuOp+YlZx5X0Pci5LqDDubQu2hsX+Hmq4b0eNs1RU
 KpnWNzsF+isGDaV8ux7vNb3IgIU3OFWmEYI5UaBk99xLf0JyPUA+4onytNqm6C99R+E+Z97
 8mLWPqcfXJLdQL2/O2H9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pYDxCV0MjDg=:aPOinCfYTKz16Qxj89APz1
 2k/Ag0pfhxWd8/klk/zD3jTzJtvutll7rohtWwmVLvl9vc2ecLKORjo4MWKph/ntF/DGeiTKl
 /1+wGPjRNA7t+EBN/J5W8PWXunMkTIvtCna8KglfBYVb9yKQUeQWFCLoagK5sSD8FgsEO5H9h
 NMu3Zkhe4Mesyr/NksCikiSK9Ro1Xp99CQtaPcgEeFGbGl07hBoduuvF6Yofodi9wCiKuTqHg
 J1qHNWd0Q+HzudrXWBZfWr+8rUTVWHQwVtw69ddlEOMdC60ZZFrnLOtiIswYTIvkkYSpZp9l3
 468lMFVooEn8DrQpIYDkuLDRQsUhcADhhmTduXfMkYGv2AuH2WQ8TNqtj4HtcvwVmTy0zQE2+
 GqrUqkQpej+Zq09Q/CuHQrW/YsuuAjkAgrckYYkb/icjya8X1MPBdBkeUXtqyVe55mqXdji2k
 IYocjwFJzC88xN+a8SJW8JJ8tdlZzQhlQGroPsR8x5D5uiAIUgbBtbu6yGA192Zoa0Q0CEyHc
 +dieaIhOo15a4GFZRSWi2Y/fJI8QNRofdZyofhUY+wLrz10XdZf64UudX96r/b1qVbDJXwGci
 njZouAYfWDjTcBwXJxGq6BTr9lcI/vUZs8vrHeVc098Zxfw4RBOUTnvNnY6P2qEGyXD6b3KSL
 8AdPlAoqIke9ChnobmAQMGErHq9qwKm+POYMiUe4OumgV+s4l+MgC9EJW8YzcF/NKJYuRSWUR
 qLsCpUCOHVwUm5O7q84P2rQ1MqTiDzWmMODxiODqduZUL0kqWtbdtlo2NWkigZOnWEhZ23Qzr
 S6VkHaNCHvCV3EKSFX6OQ1PY1r+ULJdUPhuw18KK8f/OKTuJOFveMWLLANOR1xIded/3f0/LB
 b/a+tK85FYEH+xYQ4X2vicBo5wjRIXOR7wIaAH7ZSqOy8Br3kxt/Ri9Dyv81qd2tTH/e95gr7
 xnGKB4yoxb2piw+i3VRbKBO27k4M/xNSALkbMHxS64aDKum+AIjnb
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 7, 2021 at 3:36 PM Helge Deller <deller@gmx.de> wrote:
> * Arnd Bergmann <arnd@arndb.de>:
> > My first thought was this was a result of -finline-functions getting
> > enabled by default in gcc-10, but enabling it on gcc-9 did not
> > help here. It's likely that the gcc behavior was fixed in the process
> > of enabling the more aggressive inliner by default though.
> >
> > I also tried building genhd.o for every architecture that has
> > gcc-9.4 support and did not find the problem anywhere except
> > on parisc.
> >
> > Using CONFIG_CC_OPTIMIZE_FOR_SIZE did solve the
> > problem for me (frame size down to 164 bytes), but I could not
> > pinpoint a specific -f option that fixes it for -O2. Maybe we can
> > simply change the defconfig here? 32-bit parisc systems are
> > probably memory limited enough that building a -Os kernel
> > is a good idea anyway. 64-bit parisc already builds with -Os
> > but does not see the warning with -O2 either.
>
> I agree that the simplest solution is to increase the default value for
> parisc here.
> On parisc we have a 32k stack (either 1x32k or 2x16k when using IRQ
> stacks). I increased the default value to 1280 in 2017, but as can be
> seen here this isn't sufficient. Either way, we have an active runtime
> check for stack overflows which has never triggered yet, so let's just
> remove the compiler warning by increasing the value to 2048. Patch is
> below.
>
> [PATCH] parisc: Increase gcc stack frame check to 2048 for 32- and 64-bit
>
> parisc uses much bigger frames than other architectures, so increase the
> stack frame check value to 2048 to avoid compiler warnings.

I think setting it to 2048 is rather excessive, and it would make you miss
other real bugs. What I suggested was to change the defconfig to use
CONFIG_CC_OPTIMIZE_FOR_SIZE instead.

The reasoning for the 1280 byte limit on parisc is that it needs a few extra
bytes for its larger stack frames, and 1024 for the other 32-bit architectures
is only there because anything smaller warns for a handful of functions
that are fine-tuned to need slightly less than that, when the call chain
is predictable and using less would impact performance.

I actually think we should reduce the warning limit for 64-bit architectures
to 1280 bytes as well, but that triggers a couple of warnings that still
need to be resolved first. In almost all cases, a kernel function needing
more than 512 bytes is an indication of either a bug in the kernel, or
(rarely) in the compiler.

        Arnd
