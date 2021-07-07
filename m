Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED06C07E9C
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 13:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7634661C81
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 13:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhGGNjh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 09:39:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:60437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhGGNjh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Jul 2021 09:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625664993;
        bh=bADii7QME+i4827E0EpMZaThgfcrFZi9xhWBV6OTRkU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Y9m1iTWuKl37yZt4pMvkzyuUA5zh1qD16/0OerEt/rXPgwWIy9R7DAB9fYdaHQkdl
         50kXT5X4qH7BlYWsOZxVgjB4HT8qwHxZ+ZbEefMut4T11S38sGy9PFN2pimkyau27y
         B/3cglHBs1eypdpTTGyrLrcxB5jm7xlheGp3Sw+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.134.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQIv-1lMXiA1VcF-00oZF8; Wed, 07
 Jul 2021 15:36:33 +0200
Date:   Wed, 7 Jul 2021 15:36:26 +0200
From:   Helge Deller <deller@gmx.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, bernie@develer.com,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a
 warning while compiling with a cross compiler for parisc
Message-ID: <YOWt2swxONAvhesH@ls3530>
References: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
 <20210706205927.4407-1-abd.masalkhi@gmail.com>
 <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
X-Provags-ID: V03:K1:nnhbPhVe0w4FsB/qB/wiShDLGfu12+BnEY7KLWwti1Fl5PBVH/E
 S77xnutvouWiaEN3nI8M0/NOzFl8vqGA2pjn0vjxo4+Bf+Y6uGss++TTPNSIHXIRGNjb11w
 LOntItw/iwGhXtCxvPLf3/zv/RGsWp7LNrjj/tKGWTw/ceIz30BN3DUuAoyaggzQy3vh5AT
 ENKEoZ5BLki9HHD3m7Rkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pt6NqcR/CpE=:d1NXX/4rxAOw2q5N1rLcSe
 w9H1UR2atQHqUEoi2GHiRm6G6qSTcro+4Qr0AY7IQAyeJyeHhKcvrWbD6F6tSoaB7zUqJZWUv
 7RyZF5v39JXAS+0z1G06KdCYryPswtK3X6KFKI/jz2LrNkot3g+vR71L1OZ+jnogAkTT5Zt9o
 x7cp2kx6oyi9zTikm4n+ZgzsvsS/+qSj9hYzhChyNkcAiwa7kOJDH36U/V9eWiSzmRu5SexAl
 KL0aIKTklaa8mV+iwDTWOXx+QMpjNihe2QzNAqEmt+8DuomBhA5ys8TW29EeQOJBaGLgNvZef
 i6jF6HRQxSU83n+1kVquLmTypezR7ekNjLY4Gr9EZBUbj8oK/ep6e7MEVjpFYqsXhumfTvFwF
 N/92ZwHAsajPuF9/VdF82VqjktcgDSNVQmdEYWK75iXnmLVv3TkOvb3nkSX+15DWYmDdtpuSp
 jKnTXKy600lH5JB+2Wbg3hK0rnwGLEWIhdeGH6tYfuHtx7JMr8vHR1Fx6pF/PakEDg3q7BICc
 Bo/UB8FM58NPKhMt1rI6gCW80XulxrZPwP8k8uMth0WpJIQAChuReiWNVI+mmPOQAj5sDZE0F
 5kX1aL1zOx6Ls3XFdQ7WzuS7oHFR1nG/eWlb5WrzccpuF6CkMXwL0va7S3IePaVQGK3EyzZRg
 8Pry8VDPa7NfjmM6qs+c58htQYkS3IJCiVm0qnmcDZkfX2MBZK9PZyHLGCjEhI0/dgWpGWZaT
 8rKI++D6MufT0a42DU6HqufI5wlllnsDWDDBzerdluFsu7SYgwsg6RSIChizdA7VP22udTiRL
 JSaZ1fe8+4iBYu0/JTT5+WaVsRmUswwx/z7SJZIuixI20UoQq1xarjmJAhO9++iJy1Cmlrflm
 JMW+tB369DpnRVo+Kj3hfuivIUoDq6SCrwun3YDgpb7sKTFaydFE5qEpC24YvB+EsCqoC2knz
 98lPLOwPmPFnx1lZCgTjFt8qIS99y6+bDts0Pdne4Q6w40Q5n2oe82F1cqElXTZZAtR+tr0e4
 +aM+qiDD6BHDYNhK8MWCVf0OFEE63TEiBkE5RwiQx0EbqmBB4Bs1SIuj4KfGeXtVhsAXa7IOV
 Mx4NMHhR+KJJSIZObU0LgX/TzEqsPNOaHJh
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de>:
> On Tue, Jul 6, 2021 at 10:59 PM Abd-Alrhman Masalkhi
> <abd.masalkhi@gmail.com> wrote:
> >
> > I have compiled the kernel with a cross compiler hppa-linux-gnu-
> > (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 and the conficuration was the
> > default, Build for generic-32bit "generic-32bit_defconfig"
>
> Ok, thanks. I have reproduced this now with gcc-9.4.0 from
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/.
>
> I have also tried it with the other gcc versions and shown that it
> happens with every older compiler as well, but it does not happen
> with gcc-10 or gcc-11, which bring the frame size down to 164 or
> 172 bytes respectively. gcc-10 also fixes similar warnings for
> net/ipv4/tcp_input.c, net/sunrpc/stats.c and lib/xxhash.c that
> fly under the radar with the default warning level.
>
> My first thought was this was a result of -finline-functions getting
> enabled by default in gcc-10, but enabling it on gcc-9 did not
> help here. It's likely that the gcc behavior was fixed in the process
> of enabling the more aggressive inliner by default though.
>
> I also tried building genhd.o for every architecture that has
> gcc-9.4 support and did not find the problem anywhere except
> on parisc.
>
> Using CONFIG_CC_OPTIMIZE_FOR_SIZE did solve the
> problem for me (frame size down to 164 bytes), but I could not
> pinpoint a specific -f option that fixes it for -O2. Maybe we can
> simply change the defconfig here? 32-bit parisc systems are
> probably memory limited enough that building a -Os kernel
> is a good idea anyway. 64-bit parisc already builds with -Os
> but does not see the warning with -O2 either.

I agree that the simplest solution is to increase the default value for
parisc here.
On parisc we have a 32k stack (either 1x32k or 2x16k when using IRQ
stacks). I increased the default value to 1280 in 2017, but as can be
seen here this isn't sufficient. Either way, we have an active runtime
check for stack overflows which has never triggered yet, so let's just
remove the compiler warning by increasing the value to 2048. Patch is
below.

Helge

=2D--

[PATCH] parisc: Increase gcc stack frame check to 2048 for 32- and 64-bit

parisc uses much bigger frames than other architectures, so increase the
stack frame check value to 2048 to avoid compiler warnings.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..1d99c3194e18 100644
=2D-- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -335,9 +335,8 @@ config FRAME_WARN
 	int "Warn for stack frames larger than"
 	range 0 8192
 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
-	default 1280 if (!64BIT && PARISC)
-	default 1024 if (!64BIT && !PARISC)
-	default 2048 if 64BIT
+	default 1024 if !(64BIT || PARISC)
+	default 2048 if (64BIT || PARISC)
 	help
 	  Tell gcc to warn at build time for stack frames larger than this.
 	  Setting this too low will cause a lot of warnings.

