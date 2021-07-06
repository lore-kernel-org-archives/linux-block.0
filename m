Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169DFC07E9B
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 19:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4A761A25
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 19:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhGFT1R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:27:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhGFT1Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 15:27:16 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQ5nK-1lnfo124Ho-00M3LV; Tue, 06 Jul 2021 19:35:21 +0200
Received: by mail-wr1-f49.google.com with SMTP id i94so27029273wri.4;
        Tue, 06 Jul 2021 10:35:21 -0700 (PDT)
X-Gm-Message-State: AOAM533ss/yHIZt/vz+SRPk9Dk5YCs2sewg3+3MKFgUhleIl8PDtZP0F
        TlhrT4jCoIgFLijE/9icVGK04CTM/GlOrPr9jQ0=
X-Google-Smtp-Source: ABdhPJxihhB6pAlSqg5TCWb1uOqDtAR681g/7nJAg+M4cbpSiCJILLocGjrsG1M7XBi00jNJbolYnKwzxwMuWr6BZPM=
X-Received: by 2002:a5d:6485:: with SMTP id o5mr23976504wri.286.1625592921101;
 Tue, 06 Jul 2021 10:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <YORh3XGNiRKzjDbS@infradead.org> <20210706153054.145461-1-abd.masalkhi@gmail.com>
 <YOSMct1YHs++E1vt@infradead.org>
In-Reply-To: <YOSMct1YHs++E1vt@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 19:35:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
Message-ID: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a
 warning while compiling with a cross compiler for parisc
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bernardo Innocenti <bernie@develer.com>,
        "torvalds@linux-foundation.org Abd-Alrhman Masalkhi" 
        <abd.masalkhi@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Parisc List <linux-parisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:t6riS402GfG5/lDaaFu72j+ZZl/prBu5e4jk9mBJ9ICY2T2/Wjj
 r27vWivFr8SLRbiImKrfNj7d95huCn+cUewC9t7gZp5D6uPBko++ZtxV+lumoHybiU1ham5
 FtTXsOhg6GIlB7yn8KW1P4eF3hEUU9v3UtWhHGhCGDKKr5J1lZKu2RBOR8b5w42vJr3D4dz
 kkJg8FC6DKIVdtkAgOpYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8CUTNqg4JMs=:U6Dyr3Gs6w4LhWoWb4cjNT
 1Fxe825DEDSEHL69tbVt08365ceqwdibPFqNhetQWeModsKuSLrcFuejru69DGrEMqFcsn+5V
 8GdZp+hwkKfPNOy/DGWoI+e5HuDlBaFMv0X6sOXioY+NjNOsZU1EbSoQzFumzpo7qch0w+z9s
 Gz150o82xIBoZ8rucsbw6my7sgdbzBjw2s5l9Ip39BwkVm6Bk9FV4+u42tUFO6jwJCehQqICB
 XiUq4g5+OdTv16hWlYxyVDbNSf2BTbxdkmRDxV60458sk5OTW+Fxkth0X1muBknfIkG0oVold
 HMOtCQHGd/etTAeOiCJPsxBeqXhsN3YyfMzR7wg/bWatVpzWuVEUDXYv6AvrHC5Jfvq3Ry2X7
 DtnZcXc4SWYWAApTuITKIrjXc+HvQUEvEEdVC4WThbQuYFxkcqq0vG4dZAo2y3QlW6nRjxLdy
 30EwIkztQholYsO205H5gScPlsYeWLDXs3yxJ/7YgacgYymt2yj+8xx+HXAzgBojIKQE62Uxj
 Fs8G/m5kmTyODi9KX6zXmvayapKGyFSegxCQ/vda50LAxUML0V/ebZGi2K3zKZoTL3F/6wgca
 bdwvOORsMEl8eP8VsEheo9TzSxXzQj4py9y5wUVI/isvy+pQb1zVqRkiwVz2bX0x1P+Q6KFUD
 aee+KW5QzgUZ5pZCBuc4wVNyaS8vUm1hHxjtyKAmzsMvz8p8RB4fiaSfO55riUvEDgsaCMmP5
 nGYZgUcd7xMsy+7h3yfkYEr5HHglyykYn6N/qwbvewoMhVc1xkjjsFqDfz4iosb48AXNnjEuH
 obcyQKanfVj0yvLOOGRyfylTJDRkRNTpcjH6SPq3bFueHwZ2cnr68Abmm4CayuWFlXjE3dY5U
 +JOF0tcirT0q2Hdh5fWwGcmcPDnftgNzJBpCbgV1jTsXmoAF+R2bXBv1f2/5iY1DoL2xWde8o
 HjKF5NV5pcSF/LteBicR9BXSg3jqnaA9x+xe/z1+UuliYXdhsJyWf
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 6, 2021 at 7:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jul 06, 2021 at 05:30:54PM +0200, Abd-Alrhman Masalkhi wrote:
> > Thank you for your comment, the div_u64 function is called 5 times
> > inside diskstats_show function, so I have made a test case; I have
> > replaced one call with a constant number then I have compiled the
> > kernel, the result was instead of emitting "the frame size of 1656
> > bytes is larger than 1280 bytes" warning, it has emitted "the frame
> > size of 1328 bytes is larger than 1280 bytes" warning, so I came to the
> > conclusion that each call to div_u64 will add 328 bytes to the stack
> > frame of diskstats_show function, since it is an inlined function. so I
> > thought it might be the solution that to preventing div_u64 to be
> > inlined in diskstats_show function.
>
> Adding a bunch of relevant parties to the CC list - any idea how we
> can make the generic do_div / div_u64 not use up such gigantic amounts
> of stack?

I've seen variations of this problem many times, though usually not
involving do_div().

My guess is that this is happening here because of a combination of
things, most of the time it doesn't get nearly as bad:

- parisc has larger stack frames than others
- ilog2() as used in __div64_const32() is somewhat unreliable, it may
  end up determining that its input is a __builtin_constant_p(), but then
  still produce code for the non-constant case when the caller is
  only partially inlined
- Some compiler options make the problem worse by increasing the
  pressure on the register allocator.
- Some compiler targets don't deal well with register pressure and
  use more stack slots than they really should.

If you have the .config file that triggers this and the exact compiler
version, I can have a closer look to narrow down which of these
are part of the problem for that particular file.

One thing we did on ARM OABI (which does not deal well with
64-bit math) was to turn off the inline version of __arch_xprod_64
and instead use an extern function for do_div().

       Arnd
