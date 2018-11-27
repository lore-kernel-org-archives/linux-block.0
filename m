Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725CCC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 11:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F80C2086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 11:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gi2Ylcci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F80C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeK0WrW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:47:22 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51702 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbeK0WrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 17:47:22 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so33720118itl.1
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 03:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEaDNSa4i2TPvY1yxAFcnNRAKn6mO+3tcS5vtnxeTR4=;
        b=gi2Ylcci6fDjXgTaxSdJY3VaMmKgGk5kWVPd8OL7Zqkqol4derpiuwp6BWT/8r50x1
         Z/4P/SKVWMDzSM7S5InDeTyvDt5X9zroWmvBZ0zXS1zinLJbJEcSGeu9NIjjF9K95BwR
         SZEusL3hA8apP0NEI7+JxIkLCF6xx/JyPzbFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEaDNSa4i2TPvY1yxAFcnNRAKn6mO+3tcS5vtnxeTR4=;
        b=NOtGkg9EhiS6X6kJqSXLG4XlEjLVCO3l2bz7bG7A6f06jlGwhBpVrOP0xO5qFgE/Id
         PTptImNvfXGtm2hAOBVGpqHrC1m2ioB/za4CngHBWRNbyTrH+frHTLgLkiLy+K8EjRXD
         UntwHUFpcOVTdk9oFdnmKQeZOA26DKaJsAGAR+92wmKEIICjHzmN3+d9NXi0gDntkrpT
         7ANokzDIHZroEbfb2rYexCwAxTFIBaJd7bJDL5PsaZBtlZCKsncC9LEVEh6uZ3ELap03
         xGzMXN/0iql9JGqXIqIHv5ni+EyZ6czyXnxsvz9TpE2f6txAj9rTN0Z/SsY2hRk39P0w
         rQBA==
X-Gm-Message-State: AGRZ1gLltCypgHooSTty5yD4QmS5UNyf4fyyVkAEtoMq1u3HR58Osg4e
        Q3ysH0fKT3TKrzoJOI/RXo4kEfQGgnp/KYkbq9nw2iwuCzw=
X-Google-Smtp-Source: AJdET5cAm+ysn8aLYmWD8zrMxBg8kJc+RkPi3LiAuaFKLw4iDbnIZPGUvyVsa4HQjKWHWmd9Z86GMnrshq3FRNZvLds=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr27957137itk.71.1543319383000;
 Tue, 27 Nov 2018 03:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20181127100858.6995-1-liuyun01@kylinos.cn> <20181127100858.6995-2-liuyun01@kylinos.cn>
In-Reply-To: <20181127100858.6995-2-liuyun01@kylinos.cn>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 27 Nov 2018 12:49:31 +0100
Message-ID: <CAKv+Gu8u2exYQ-Q=H1_WrpmQHEddNaC7VC=OYsz-C2kbCobyGA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR implementation
To:     liuyun01 <liuyun01@kylinos.cn>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 27 Nov 2018 at 11:10, Jackie Liu <liuyun01@kylinos.cn> wrote:
>
> This is a NEON acceleration method that can improve
> performance by approximately 20%. I got the following
> data from the centos 7.5 on Huawei's HISI1616 chip:
>
> [ 93.837726] xor: measuring software checksum speed
> [ 93.874039]   8regs  : 7123.200 MB/sec
> [ 93.914038]   32regs : 7180.300 MB/sec
> [ 93.954043]   arm64_neon: 9856.000 MB/sec

That looks more like 37% to me

Note that Cortex-A57 gives me

[    0.111543] xor: measuring software checksum speed
[    0.154874]    8regs     :  3782.000 MB/sec
[    0.195069]    32regs    :  6095.000 MB/sec
[    0.235145]    arm64_neon:  5924.000 MB/sec
[    0.236942] xor: using function: 32regs (6095.000 MB/sec)

so we fall back to the scalar code, which is fine.

> [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
>
> I believe this code can bring some optimization for
> all arm64 platform.
>
> That is patch version 3. Thanks for Ard Biesheuvel's
> suggestions.
>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/Kbuild |   1 -
>  arch/arm64/include/asm/xor.h  |  73 +++++++++++++++++
>  arch/arm64/lib/Makefile       |   6 ++
>  arch/arm64/lib/xor-neon.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 263 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/xor.h
>  create mode 100644 arch/arm64/lib/xor-neon.c
>
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 6cd5d77..1877f29 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -27,4 +27,3 @@ generic-y += trace_clock.h
>  generic-y += unaligned.h
>  generic-y += user.h
>  generic-y += vga.h
> -generic-y += xor.h
> diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> new file mode 100644
> index 0000000..856386a
> --- /dev/null
> +++ b/arch/arm64/include/asm/xor.h
> @@ -0,0 +1,73 @@
> +/*
> + * arch/arm64/include/asm/xor.h
> + *
> + * Authors: Jackie Liu <liuyun01@kylinos.cn>
> + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/hardirq.h>
> +#include <asm-generic/xor.h>
> +#include <asm/hwcap.h>
> +#include <asm/neon.h>
> +
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +
> +extern struct xor_block_template const xor_block_inner_neon;
> +
> +static void
> +xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_2(bytes, p1, p2);
> +       kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +               unsigned long *p3)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_3(bytes, p1, p2, p3);
> +       kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +               unsigned long *p3, unsigned long *p4)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
> +       kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +               unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
> +       kernel_neon_end();
> +}
> +
> +static struct xor_block_template xor_block_arm64 = {
> +       .name   = "arm64_neon",
> +       .do_2   = xor_neon_2,
> +       .do_3   = xor_neon_3,
> +       .do_4   = xor_neon_4,
> +       .do_5   = xor_neon_5
> +};
> +#undef XOR_TRY_TEMPLATES
> +#define XOR_TRY_TEMPLATES           \
> +       do {        \
> +               xor_speed(&xor_block_8regs);    \
> +               xor_speed(&xor_block_32regs);    \
> +               if (cpu_has_neon()) { \
> +                       xor_speed(&xor_block_arm64);\
> +               } \
> +       } while (0)
> +
> +#endif /* ! CONFIG_KERNEL_MODE_NEON */
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 69ff988..5540a16 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -5,6 +5,12 @@ lib-y          := clear_user.o delay.o copy_from_user.o                \
>                    memcmp.o strcmp.o strncmp.o strlen.o strnlen.o       \
>                    strchr.o strrchr.o tishift.o
>
> +ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
> +obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
> +CFLAGS_REMOVE_xor-neon.o       += -mgeneral-regs-only
> +CFLAGS_xor-neon.o              += -ffreestanding
> +endif
> +
>  # Tell the compiler to treat all general purpose registers (with the
>  # exception of the IP registers, which are already handled by the caller
>  # in case of a PLT) as callee-saved, which allows for efficient runtime
> diff --git a/arch/arm64/lib/xor-neon.c b/arch/arm64/lib/xor-neon.c
> new file mode 100644
> index 0000000..131c60c2
> --- /dev/null
> +++ b/arch/arm64/lib/xor-neon.c
> @@ -0,0 +1,184 @@
> +/*
> + * arch/arm64/lib/xor-neon.c
> + *
> + * Authors: Jackie Liu <liuyun01@kylinos.cn>
> + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/raid/xor.h>
> +#include <linux/module.h>
> +#include <asm/neon-intrinsics.h>
> +
> +void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2)
> +{
> +       uint64_t *dp1 = (uint64_t *)p1;
> +       uint64_t *dp2 = (uint64_t *)p2;
> +
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
> +               v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
> +               v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
> +               v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
> +
> +               /* store */
> +               vst1q_u64(dp1 +  0, v0);
> +               vst1q_u64(dp1 +  2, v1);
> +               vst1q_u64(dp1 +  4, v2);
> +               vst1q_u64(dp1 +  6, v3);
> +
> +               dp1 += 8;
> +               dp2 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3)
> +{
> +       uint64_t *dp1 = (uint64_t *)p1;
> +       uint64_t *dp2 = (uint64_t *)p2;
> +       uint64_t *dp3 = (uint64_t *)p3;
> +
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
> +               v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
> +               v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
> +               v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
> +
> +               /* store */
> +               vst1q_u64(dp1 +  0, v0);
> +               vst1q_u64(dp1 +  2, v1);
> +               vst1q_u64(dp1 +  4, v2);
> +               vst1q_u64(dp1 +  6, v3);
> +
> +               dp1 += 8;
> +               dp2 += 8;
> +               dp3 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3, unsigned long *p4)
> +{
> +       uint64_t *dp1 = (uint64_t *)p1;
> +       uint64_t *dp2 = (uint64_t *)p2;
> +       uint64_t *dp3 = (uint64_t *)p3;
> +       uint64_t *dp4 = (uint64_t *)p4;
> +
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
> +               v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
> +               v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
> +               v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
> +
> +               /* p1 ^= p4 */
> +               v0 = veorq_u64(v0, vld1q_u64(dp4 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(dp4 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(dp4 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(dp4 +  6));
> +
> +               /* store */
> +               vst1q_u64(dp1 +  0, v0);
> +               vst1q_u64(dp1 +  2, v1);
> +               vst1q_u64(dp1 +  4, v2);
> +               vst1q_u64(dp1 +  6, v3);
> +
> +               dp1 += 8;
> +               dp2 += 8;
> +               dp3 += 8;
> +               dp4 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3,
> +       unsigned long *p4, unsigned long *p5)
> +{
> +       uint64_t *dp1 = (uint64_t *)p1;
> +       uint64_t *dp2 = (uint64_t *)p2;
> +       uint64_t *dp3 = (uint64_t *)p3;
> +       uint64_t *dp4 = (uint64_t *)p4;
> +       uint64_t *dp5 = (uint64_t *)p5;
> +
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
> +               v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
> +               v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
> +               v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
> +
> +               /* p1 ^= p4 */
> +               v0 = veorq_u64(v0, vld1q_u64(dp4 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(dp4 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(dp4 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(dp4 +  6));
> +
> +               /* p1 ^= p5 */
> +               v0 = veorq_u64(v0, vld1q_u64(dp5 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(dp5 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(dp5 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(dp5 +  6));
> +
> +               /* store */
> +               vst1q_u64(dp1 +  0, v0);
> +               vst1q_u64(dp1 +  2, v1);
> +               vst1q_u64(dp1 +  4, v2);
> +               vst1q_u64(dp1 +  6, v3);
> +
> +               dp1 += 8;
> +               dp2 += 8;
> +               dp3 += 8;
> +               dp4 += 8;
> +               dp5 += 8;
> +       } while (--lines > 0);
> +}
> +
> +struct xor_block_template const xor_block_inner_neon = {
> +       .name   = "__inner_neon__",
> +       .do_2   = xor_arm64_neon_2,
> +       .do_3   = xor_arm64_neon_3,
> +       .do_4   = xor_arm64_neon_4,
> +       .do_5   = xor_arm64_neon_5,
> +};
> +EXPORT_SYMBOL(xor_block_inner_neon);
> +
> +MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
> +MODULE_DESCRIPTION("ARMv8 XOR Extensions");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
>
>
