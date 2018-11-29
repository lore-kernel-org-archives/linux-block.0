Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9A7C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 18:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499892082F
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 18:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5qlKNHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499892082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeK3FPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:15:38 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35563 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeK3FPh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 00:15:37 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so5144599itp.0
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 10:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VvKlloFZLEkPTpB6IANQFaVBZdX67Sa3i8aIF1wOTQ=;
        b=h5qlKNHfshis0rHPjp3z+qGXRaWeD4X71aItWnONcBZWAD9pkGjPnjT9pw74pFBNhZ
         O/yidcvwqFz76AsvHVV/R6Gx5+LBZPmDiAKSEp0sN+5H0Hnvo3+fzPe0ZgOBVGKPOKVF
         OoN+77EdFPwSu8uWYtccEsvyVqWksmoiEBUKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VvKlloFZLEkPTpB6IANQFaVBZdX67Sa3i8aIF1wOTQ=;
        b=nhDT+EA8SxqZGJVzKwIAsOesvm3oJ/4bDOphrqF01E8SwHn0cweyp/n7cW5znB8KZk
         ktiEpsGWCwTs1dGvmlvjXkp4Ez+IkOtbmlyoWpc6AN1wsIRLXEmeD+mJAlN9e0vMz8RZ
         G6qEY2QRAyLgXpWzv8Qldp9qUxpf174Gdgr6pjpUqhJmKYWJ3HuA4zr6S5TD1dRa0wXd
         fyc9zwO+EQFu/rXPU7sNSGS6LcbhSSB5MHuFA1Jzv/yRw7kXaFOqjNAUsnglaxxdsjLX
         O6xUi+f1t5aJ1Ch2NpaGgRHpcbpJxniR0mdP1qp4pRTy/53u0TzlGnaLBHzDqlliUaW4
         WkFw==
X-Gm-Message-State: AA+aEWafpz9Pu/OnsH40Q+1O2l4RxjjEnLqOZQ5krMESkeyJp+0dW5dn
        gL3E4r5b7UlLvckhD9SaVS1okob928Qob2z2+m5JYA==
X-Google-Smtp-Source: AFSGD/Ve07yvxbqRZgwtriQ/JDAHw0ByIxNEi8hwrXkZNoBnm4HEVPvCvQFK+GIawLrHtQ6fKuefSN2mDp80s+vy9Og=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr2687617ith.158.1543514963110;
 Thu, 29 Nov 2018 10:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20181127100858.6995-1-liuyun01@kylinos.cn> <20181127100858.6995-2-liuyun01@kylinos.cn>
 <20181129170048.GQ3505@e103592.cambridge.arm.com>
In-Reply-To: <20181129170048.GQ3505@e103592.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 29 Nov 2018 19:09:10 +0100
Message-ID: <CAKv+Gu-rm6uygi7+_=ssJ7UK-RgYgGNVyiTQ4O9zkN3JoYEB7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR implementation
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     liuyun01 <liuyun01@kylinos.cn>, linux-block@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 29 Nov 2018 at 18:00, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Tue, Nov 27, 2018 at 06:08:58PM +0800, Jackie Liu wrote:
> > This is a NEON acceleration method that can improve
> > performance by approximately 20%. I got the following
> > data from the centos 7.5 on Huawei's HISI1616 chip:
> >
> > [ 93.837726] xor: measuring software checksum speed
> > [ 93.874039]   8regs  : 7123.200 MB/sec
> > [ 93.914038]   32regs : 7180.300 MB/sec
> > [ 93.954043]   arm64_neon: 9856.000 MB/sec
> > [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
> >
> > I believe this code can bring some optimization for
> > all arm64 platform.
> >
> > That is patch version 3. Thanks for Ard Biesheuvel's
> > suggestions.
> >
> > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > ---
> >  arch/arm64/include/asm/Kbuild |   1 -
> >  arch/arm64/include/asm/xor.h  |  73 +++++++++++++++++
> >  arch/arm64/lib/Makefile       |   6 ++
> >  arch/arm64/lib/xor-neon.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 263 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/xor.h
> >  create mode 100644 arch/arm64/lib/xor-neon.c
> >
> > diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> > index 6cd5d77..1877f29 100644
> > --- a/arch/arm64/include/asm/Kbuild
> > +++ b/arch/arm64/include/asm/Kbuild
> > @@ -27,4 +27,3 @@ generic-y += trace_clock.h
> >  generic-y += unaligned.h
> >  generic-y += user.h
> >  generic-y += vga.h
> > -generic-y += xor.h
> > diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> > new file mode 100644
> > index 0000000..856386a
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/xor.h
> > @@ -0,0 +1,73 @@
> > +/*
> > + * arch/arm64/include/asm/xor.h
> > + *
> > + * Authors: Jackie Liu <liuyun01@kylinos.cn>
> > + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/hardirq.h>
> > +#include <asm-generic/xor.h>
> > +#include <asm/hwcap.h>
> > +#include <asm/neon.h>
> > +
> > +#ifdef CONFIG_KERNEL_MODE_NEON
> > +
> > +extern struct xor_block_template const xor_block_inner_neon;
> > +
> > +static void
> > +xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> > +{
> > +     kernel_neon_begin();
> > +     xor_block_inner_neon.do_2(bytes, p1, p2);
> > +     kernel_neon_end();
> > +}
> > +
> > +static void
> > +xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> > +             unsigned long *p3)
> > +{
> > +     kernel_neon_begin();
> > +     xor_block_inner_neon.do_3(bytes, p1, p2, p3);
> > +     kernel_neon_end();
> > +}
> > +
> > +static void
> > +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> > +             unsigned long *p3, unsigned long *p4)
> > +{
> > +     kernel_neon_begin();
> > +     xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
> > +     kernel_neon_end();
> > +}
> > +
> > +static void
> > +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> > +             unsigned long *p3, unsigned long *p4, unsigned long *p5)
> > +{
> > +     kernel_neon_begin();
> > +     xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
> > +     kernel_neon_end();
> > +}
> > +
> > +static struct xor_block_template xor_block_arm64 = {
> > +     .name   = "arm64_neon",
> > +     .do_2   = xor_neon_2,
> > +     .do_3   = xor_neon_3,
> > +     .do_4   = xor_neon_4,
> > +     .do_5   = xor_neon_5
> > +};
> > +#undef XOR_TRY_TEMPLATES
> > +#define XOR_TRY_TEMPLATES           \
> > +     do {        \
> > +             xor_speed(&xor_block_8regs);    \
> > +             xor_speed(&xor_block_32regs);    \
> > +             if (cpu_has_neon()) { \
> > +                     xor_speed(&xor_block_arm64);\
> > +             } \
> > +     } while (0)
>
> Should there be a may_use_simd() check somewhere?
>
> If we invoke this in a softirq I don't see what prevents us from
> corrupting the task's NEON state.
>
> (The check might be in some surrounding glue code that I missed...)
>

There is no check. This code should simply not be called from
non-process context, same as the RAID56 code.

This is not terribly robust, obviously, but appears to be common
practice in this realm of the kernel.
