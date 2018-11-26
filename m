Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F730C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 11:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E857320672
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 11:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+J1QqZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E857320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeKZWY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:24:57 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44558 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeKZWY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 17:24:57 -0500
Received: by mail-io1-f67.google.com with SMTP id r200so13596970iod.11
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 03:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOoap+4eGkOVPse3IyPS1NoMn0ZE0SUqZ5BP8psbkdU=;
        b=j+J1QqZcsj68pAos93DHuTD/MmJlvCzQDwi6DirRGqk6A4dPoAeDfpVBtzdc2/A5Jl
         +cOyQ8AOzysuoFJgZG7tBj/+YnSjsKOmCLyg8jcbAszEoLQXWuHDhSiSMuMAaVdRcjcS
         ojODJHdC5ddrTXAHFkqZ/0co/MV81pcewjYXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOoap+4eGkOVPse3IyPS1NoMn0ZE0SUqZ5BP8psbkdU=;
        b=IXArPoRvHzZg/0J81n2gZ3AoGUb4nzKoEAmEZk24TAHM0MkMCJiBnPEslmxB8+yOxQ
         WaazO0cJn8QnoS27i20h8t4/UsIApxLouGcVBV/rNmKUQIusw1/q4IUK1BpmG335r3Ta
         CHgASUMgBQW66Rg/KODsxX3ad/wgSTUFbtZlqR64fRMD086VinXpk/PPJvUXM8d/ayJa
         1vjrPosDnItls8ySSWnN2l6RPvQ368q8SaVMW7IxkNgfuP8xa+8V08QL1tEVhHCo8fnD
         FBhd5RFQxeP3yBwNITHYb1EBwt7xdXl6gE5xmrrbPVjzxSYWTW2kocrj81EMYxDBAaWi
         UdrQ==
X-Gm-Message-State: AA+aEWbLZVAsMt3FNZwlwHN8a+zVLQsCeNJMPtpb7PrjnNUOeu+ug9Wa
        Hio78pCb6qIsMzvtOoGd7G5cX/2K2C/mArvQ1VXAIxXtn8E=
X-Google-Smtp-Source: AFSGD/URlUkjNEDMsvovc84J5pVBiynB0/C7hRI5BlI0Zl01p8GOlIL01oBUsAx6TqJxAnu1WenKhtpnRYY/3oEtmi0=
X-Received: by 2002:a6b:7a46:: with SMTP id k6mr21532629iop.60.1543231865266;
 Mon, 26 Nov 2018 03:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20181126085530.2699-1-liuyun01@kylinos.cn>
In-Reply-To: <20181126085530.2699-1-liuyun01@kylinos.cn>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 26 Nov 2018 12:30:53 +0100
Message-ID: <CAKv+Gu8EAqehWPysCBD10buLXwfr5v_rRivYrzsLLG=CE_hVyQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: crypto: add NEON accelerated XOR implementation
To:     liuyun01 <liuyun01@kylinos.cn>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jackie,

On Mon, 26 Nov 2018 at 09:56, Jackie Liu <liuyun01@kylinos.cn> wrote:
>
> This is a NEON acceleration method that can improve
> performance by approximately 20%. I got the following
> data from the centos 7.5 on Huawei's HISI1616 chip:
>
> [ 93.837726] xor: measuring software checksum speed
> [ 93.874039]   8regs  : 7123.200 MB/sec
> [ 93.914038]   32regs : 7180.300 MB/sec
> [ 93.954043]   arm64_neon: 9856.000 MB/sec
> [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
>
> I believe this code can bring some optimization for
> all arm64 platform.
>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  arch/arm64/include/asm/xor.h   |  73 ++++++++++++++++++++
>  arch/arm64/lib/Makefile        |   7 ++
>  arch/arm64/lib/xor-neon-core.c | 152 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/lib/xor-neon-glue.c |  36 ++++++++++

You should remove xor.h from arch/arm64/include/asm/Kbuild as well so
we no longer get the asm-generic version.

>  4 files changed, 268 insertions(+)
>  create mode 100644 arch/arm64/include/asm/xor.h
>  create mode 100644 arch/arm64/lib/xor-neon-core.c
>  create mode 100644 arch/arm64/lib/xor-neon-glue.c
>
> diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> new file mode 100644
> index 0000000..31e8aaf
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
> +            unsigned long *p3)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_3(bytes, p1, p2, p3);
> +       kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +            unsigned long *p3, unsigned long *p4)
> +{
> +       kernel_neon_begin();
> +       xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
> +       kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +            unsigned long *p3, unsigned long *p4, unsigned long *p5)
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
> +#endif // CONFIG_KERNEL_MODE_NEON
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 69ff988..272cc42 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -5,6 +5,13 @@ lib-y          := clear_user.o delay.o copy_from_user.o                \
>                    memcmp.o strcmp.o strncmp.o strlen.o strnlen.o       \
>                    strchr.o strrchr.o tishift.o
>
> +ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
> +obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
> +xor-neon-y                     += xor-neon-glue.o xor-neon-core.o

No need for two separate source files (see below)

> +CFLAGS_REMOVE_xor-neon-core.o  += -mgeneral-regs-only
> +CFLAGS_xor-neon-core.o         += -ffreestanding

This looks ok. I will note (for other reviewers) that the
-ffreestanding is required because the <arm_neon.h> system header
includes <stdint.h>, which either pulls in the system's <stdint.h> or
gcc-stdint.h which ships with the compiler (and we want the latter)

> +endif
> +
>  # Tell the compiler to treat all general purpose registers (with the
>  # exception of the IP registers, which are already handled by the caller
>  # in case of a PLT) as callee-saved, which allows for efficient runtime
> diff --git a/arch/arm64/lib/xor-neon-core.c b/arch/arm64/lib/xor-neon-core.c
> new file mode 100644
> index 0000000..b2880a2
> --- /dev/null
> +++ b/arch/arm64/lib/xor-neon-core.c
> @@ -0,0 +1,152 @@
> +/*
> + * arch/arm64/lib/xor-neon-core.c
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
> +#include <arm_neon.h>
> +
> +void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2)
> +{
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
> +               v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
> +               v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
> +               v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
> +
> +               /* store */
> +               vst1q_u64(p1 +  0, v0);
> +               vst1q_u64(p1 +  2, v1);
> +               vst1q_u64(p1 +  4, v2);
> +               vst1q_u64(p1 +  6, v3);
> +
> +               p1 += 8;
> +               p2 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3)
> +{
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
> +               v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
> +               v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
> +               v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
> +
> +               /* store */
> +               vst1q_u64(p1 +  0, v0);
> +               vst1q_u64(p1 +  2, v1);
> +               vst1q_u64(p1 +  4, v2);
> +               vst1q_u64(p1 +  6, v3);
> +
> +               p1 += 8;
> +               p2 += 8;
> +               p3 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3, unsigned long *p4)
> +{
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
> +               v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
> +               v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
> +               v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
> +
> +               /* p1 ^= p4 */
> +               v0 = veorq_u64(v0, vld1q_u64(p4 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p4 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p4 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p4 +  6));
> +
> +               /* store */
> +               vst1q_u64(p1 +  0, v0);
> +               vst1q_u64(p1 +  2, v1);
> +               vst1q_u64(p1 +  4, v2);
> +               vst1q_u64(p1 +  6, v3);
> +
> +               p1 += 8;
> +               p2 += 8;
> +               p3 += 8;
> +               p4 += 8;
> +       } while (--lines > 0);
> +}
> +
> +void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
> +       unsigned long *p2, unsigned long *p3,
> +       unsigned long *p4, unsigned long *p5)
> +{
> +       register uint64x2_t v0, v1, v2, v3;
> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
> +
> +       do {
> +               /* p1 ^= p2 */
> +               v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
> +               v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
> +               v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
> +               v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
> +
> +               /* p1 ^= p3 */
> +               v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
> +
> +               /* p1 ^= p4 */
> +               v0 = veorq_u64(v0, vld1q_u64(p4 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p4 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p4 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p4 +  6));
> +
> +               /* p1 ^= p5 */
> +               v0 = veorq_u64(v0, vld1q_u64(p5 +  0));
> +               v1 = veorq_u64(v1, vld1q_u64(p5 +  2));
> +               v2 = veorq_u64(v2, vld1q_u64(p5 +  4));
> +               v3 = veorq_u64(v3, vld1q_u64(p5 +  6));
> +
> +               /* store */
> +               vst1q_u64(p1 +  0, v0);
> +               vst1q_u64(p1 +  2, v1);
> +               vst1q_u64(p1 +  4, v2);
> +               vst1q_u64(p1 +  6, v3);
> +
> +               p1 += 8;
> +               p2 += 8;
> +               p3 += 8;
> +               p4 += 8;
> +               p5 += 8;
> +       } while (--lines > 0);
> +}
> diff --git a/arch/arm64/lib/xor-neon-glue.c b/arch/arm64/lib/xor-neon-glue.c
> new file mode 100644
> index 0000000..fdaac8b
> --- /dev/null
> +++ b/arch/arm64/lib/xor-neon-glue.c
> @@ -0,0 +1,36 @@
> +/*
> + * arch/arm64/lib/xor-neon-glue.c
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
> +
> +void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
> +                            unsigned long *p2);
> +void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
> +                            unsigned long *p2, unsigned long *p3);
> +void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
> +                            unsigned long *p2, unsigned long *p3,
> +                            unsigned long *p4);
> +void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
> +                            unsigned long *p2, unsigned long *p3,
> +                            unsigned long *p4, unsigned long *p5);
> +
> +struct xor_block_template const xor_block_inner_neon = {
> +       .name   = "__inner_neon__",
> +       .do_2   = xor_arm64_neon_2,
> +       .do_3   = xor_arm64_neon_3,
> +       .do_4   = xor_arm64_neon_4,
> +       .do_5   = xor_arm64_neon_5,
> +};
> +EXPORT_SYMBOL_GPL(xor_block_inner_neon);

Can you move this struct into the NEON source file? (and drop this
file altogether) Or are there header soup concerns?

> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
> --
> 2.7.4
>
>
>
