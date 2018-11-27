Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D90C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 12:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFE32086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 12:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFE32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeK0Xuv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:50:51 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:51891 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbeK0Xuv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 18:50:51 -0500
X-QQ-mid: bizesmtp9t1543323173ti2rpcb8v
Received: from [127.0.0.1] (unknown [210.22.22.130])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 27 Nov 2018 20:52:52 +0800 (CST)
X-QQ-SSF: 00400000002000F0FL51000C0000000
X-QQ-FEAT: mAJfWfDYrJNzSLtPfFfInFPbfxEgOcgy7OsZInmnmdu11F2jxYD2b5ToGOLeF
        9dhpxUnQ0rgo0dO3oiltNlNvqQSY4jO6XAYUpU/dHyiREUCCqsSmy6on1oHeqQNKzjprEAV
        Y/s+kpqlyCv6tOTPoSatHvb38NOmTjDrGPIIB7liGPxVPEJHdz2nWCFtWPs/gk+F9wBJ1Jn
        xzHqCYuapgtvWfUE7/yCztEDnocTAVyMLVZR+KiuPNUYsL+k2HKSX+FszUR6NycDMwDIoMM
        fIoONycd+30MCWAqTKjuvBDpsWFVsDAZ4SpF0UlDlQlHEb
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
From:   JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <CAKv+Gu_Jh356UqQcfVOQvuBUpw3z2ihTv-gpLbeUaFium-wVPA@mail.gmail.com>
Date:   Tue, 27 Nov 2018 20:52:52 +0800
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DE716789-CF11-4F3E-BCCD-2055E49F807E@kylinos.cn>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
 <CAKv+Gu8u2exYQ-Q=H1_WrpmQHEddNaC7VC=OYsz-C2kbCobyGA@mail.gmail.com>
 <CAKv+Gu_Jh356UqQcfVOQvuBUpw3z2ihTv-gpLbeUaFium-wVPA@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: Apple Mail (2.3445.101.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yes, I got it. Thanks for review these patch.

BR.
Jackie

> 在 2018年11月27日，20:46，Ard Biesheuvel <ard.biesheuvel@linaro.org> 写道：
> 
> (add maintainers back to cc)
> 
> On Tue, 27 Nov 2018 at 12:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> 
>> On Tue, 27 Nov 2018 at 11:10, Jackie Liu <liuyun01@kylinos.cn> wrote:
>>> 
>>> This is a NEON acceleration method that can improve
>>> performance by approximately 20%. I got the following
>>> data from the centos 7.5 on Huawei's HISI1616 chip:
>>> 
>>> [ 93.837726] xor: measuring software checksum speed
>>> [ 93.874039]   8regs  : 7123.200 MB/sec
>>> [ 93.914038]   32regs : 7180.300 MB/sec
>>> [ 93.954043]   arm64_neon: 9856.000 MB/sec
>> 
>> That looks more like 37% to me
>> 
>> Note that Cortex-A57 gives me
>> 
>> [    0.111543] xor: measuring software checksum speed
>> [    0.154874]    8regs     :  3782.000 MB/sec
>> [    0.195069]    32regs    :  6095.000 MB/sec
>> [    0.235145]    arm64_neon:  5924.000 MB/sec
>> [    0.236942] xor: using function: 32regs (6095.000 MB/sec)
>> 
>> so we fall back to the scalar code, which is fine.
>> 
>>> [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
>>> 
>>> I believe this code can bring some optimization for
>>> all arm64 platform.
>>> 
>>> That is patch version 3. Thanks for Ard Biesheuvel's
>>> suggestions.
>>> 
>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> 
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> 
> 
> This goes with v4 of the NEON intrinsics patch.
> 
> Jackie: no need to resend these, but next time, please repost the
> series entirely, not just a single patch, and keep the maintainers on
> cc.
> 
>>> ---
>>> arch/arm64/include/asm/Kbuild |   1 -
>>> arch/arm64/include/asm/xor.h  |  73 +++++++++++++++++
>>> arch/arm64/lib/Makefile       |   6 ++
>>> arch/arm64/lib/xor-neon.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
>>> 4 files changed, 263 insertions(+), 1 deletion(-)
>>> create mode 100644 arch/arm64/include/asm/xor.h
>>> create mode 100644 arch/arm64/lib/xor-neon.c
>>> 
>>> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
>>> index 6cd5d77..1877f29 100644
>>> --- a/arch/arm64/include/asm/Kbuild
>>> +++ b/arch/arm64/include/asm/Kbuild
>>> @@ -27,4 +27,3 @@ generic-y += trace_clock.h
>>> generic-y += unaligned.h
>>> generic-y += user.h
>>> generic-y += vga.h
>>> -generic-y += xor.h
>>> diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
>>> new file mode 100644
>>> index 0000000..856386a
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/xor.h
>>> @@ -0,0 +1,73 @@
>>> +/*
>>> + * arch/arm64/include/asm/xor.h
>>> + *
>>> + * Authors: Jackie Liu <liuyun01@kylinos.cn>
>>> + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/hardirq.h>
>>> +#include <asm-generic/xor.h>
>>> +#include <asm/hwcap.h>
>>> +#include <asm/neon.h>
>>> +
>>> +#ifdef CONFIG_KERNEL_MODE_NEON
>>> +
>>> +extern struct xor_block_template const xor_block_inner_neon;
>>> +
>>> +static void
>>> +xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>>> +{
>>> +       kernel_neon_begin();
>>> +       xor_block_inner_neon.do_2(bytes, p1, p2);
>>> +       kernel_neon_end();
>>> +}
>>> +
>>> +static void
>>> +xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>>> +               unsigned long *p3)
>>> +{
>>> +       kernel_neon_begin();
>>> +       xor_block_inner_neon.do_3(bytes, p1, p2, p3);
>>> +       kernel_neon_end();
>>> +}
>>> +
>>> +static void
>>> +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>>> +               unsigned long *p3, unsigned long *p4)
>>> +{
>>> +       kernel_neon_begin();
>>> +       xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
>>> +       kernel_neon_end();
>>> +}
>>> +
>>> +static void
>>> +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>>> +               unsigned long *p3, unsigned long *p4, unsigned long *p5)
>>> +{
>>> +       kernel_neon_begin();
>>> +       xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
>>> +       kernel_neon_end();
>>> +}
>>> +
>>> +static struct xor_block_template xor_block_arm64 = {
>>> +       .name   = "arm64_neon",
>>> +       .do_2   = xor_neon_2,
>>> +       .do_3   = xor_neon_3,
>>> +       .do_4   = xor_neon_4,
>>> +       .do_5   = xor_neon_5
>>> +};
>>> +#undef XOR_TRY_TEMPLATES
>>> +#define XOR_TRY_TEMPLATES           \
>>> +       do {        \
>>> +               xor_speed(&xor_block_8regs);    \
>>> +               xor_speed(&xor_block_32regs);    \
>>> +               if (cpu_has_neon()) { \
>>> +                       xor_speed(&xor_block_arm64);\
>>> +               } \
>>> +       } while (0)
>>> +
>>> +#endif /* ! CONFIG_KERNEL_MODE_NEON */
>>> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
>>> index 69ff988..5540a16 100644
>>> --- a/arch/arm64/lib/Makefile
>>> +++ b/arch/arm64/lib/Makefile
>>> @@ -5,6 +5,12 @@ lib-y          := clear_user.o delay.o copy_from_user.o                \
>>>                   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o       \
>>>                   strchr.o strrchr.o tishift.o
>>> 
>>> +ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
>>> +obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
>>> +CFLAGS_REMOVE_xor-neon.o       += -mgeneral-regs-only
>>> +CFLAGS_xor-neon.o              += -ffreestanding
>>> +endif
>>> +
>>> # Tell the compiler to treat all general purpose registers (with the
>>> # exception of the IP registers, which are already handled by the caller
>>> # in case of a PLT) as callee-saved, which allows for efficient runtime
>>> diff --git a/arch/arm64/lib/xor-neon.c b/arch/arm64/lib/xor-neon.c
>>> new file mode 100644
>>> index 0000000..131c60c2
>>> --- /dev/null
>>> +++ b/arch/arm64/lib/xor-neon.c
>>> @@ -0,0 +1,184 @@
>>> +/*
>>> + * arch/arm64/lib/xor-neon.c
>>> + *
>>> + * Authors: Jackie Liu <liuyun01@kylinos.cn>
>>> + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/raid/xor.h>
>>> +#include <linux/module.h>
>>> +#include <asm/neon-intrinsics.h>
>>> +
>>> +void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
>>> +       unsigned long *p2)
>>> +{
>>> +       uint64_t *dp1 = (uint64_t *)p1;
>>> +       uint64_t *dp2 = (uint64_t *)p2;
>>> +
>>> +       register uint64x2_t v0, v1, v2, v3;
>>> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
>>> +
>>> +       do {
>>> +               /* p1 ^= p2 */
>>> +               v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
>>> +               v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
>>> +               v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
>>> +               v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
>>> +
>>> +               /* store */
>>> +               vst1q_u64(dp1 +  0, v0);
>>> +               vst1q_u64(dp1 +  2, v1);
>>> +               vst1q_u64(dp1 +  4, v2);
>>> +               vst1q_u64(dp1 +  6, v3);
>>> +
>>> +               dp1 += 8;
>>> +               dp2 += 8;
>>> +       } while (--lines > 0);
>>> +}
>>> +
>>> +void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
>>> +       unsigned long *p2, unsigned long *p3)
>>> +{
>>> +       uint64_t *dp1 = (uint64_t *)p1;
>>> +       uint64_t *dp2 = (uint64_t *)p2;
>>> +       uint64_t *dp3 = (uint64_t *)p3;
>>> +
>>> +       register uint64x2_t v0, v1, v2, v3;
>>> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
>>> +
>>> +       do {
>>> +               /* p1 ^= p2 */
>>> +               v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
>>> +               v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
>>> +               v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
>>> +               v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
>>> +
>>> +               /* p1 ^= p3 */
>>> +               v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
>>> +               v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
>>> +               v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
>>> +               v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
>>> +
>>> +               /* store */
>>> +               vst1q_u64(dp1 +  0, v0);
>>> +               vst1q_u64(dp1 +  2, v1);
>>> +               vst1q_u64(dp1 +  4, v2);
>>> +               vst1q_u64(dp1 +  6, v3);
>>> +
>>> +               dp1 += 8;
>>> +               dp2 += 8;
>>> +               dp3 += 8;
>>> +       } while (--lines > 0);
>>> +}
>>> +
>>> +void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
>>> +       unsigned long *p2, unsigned long *p3, unsigned long *p4)
>>> +{
>>> +       uint64_t *dp1 = (uint64_t *)p1;
>>> +       uint64_t *dp2 = (uint64_t *)p2;
>>> +       uint64_t *dp3 = (uint64_t *)p3;
>>> +       uint64_t *dp4 = (uint64_t *)p4;
>>> +
>>> +       register uint64x2_t v0, v1, v2, v3;
>>> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
>>> +
>>> +       do {
>>> +               /* p1 ^= p2 */
>>> +               v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
>>> +               v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
>>> +               v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
>>> +               v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
>>> +
>>> +               /* p1 ^= p3 */
>>> +               v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
>>> +               v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
>>> +               v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
>>> +               v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
>>> +
>>> +               /* p1 ^= p4 */
>>> +               v0 = veorq_u64(v0, vld1q_u64(dp4 +  0));
>>> +               v1 = veorq_u64(v1, vld1q_u64(dp4 +  2));
>>> +               v2 = veorq_u64(v2, vld1q_u64(dp4 +  4));
>>> +               v3 = veorq_u64(v3, vld1q_u64(dp4 +  6));
>>> +
>>> +               /* store */
>>> +               vst1q_u64(dp1 +  0, v0);
>>> +               vst1q_u64(dp1 +  2, v1);
>>> +               vst1q_u64(dp1 +  4, v2);
>>> +               vst1q_u64(dp1 +  6, v3);
>>> +
>>> +               dp1 += 8;
>>> +               dp2 += 8;
>>> +               dp3 += 8;
>>> +               dp4 += 8;
>>> +       } while (--lines > 0);
>>> +}
>>> +
>>> +void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
>>> +       unsigned long *p2, unsigned long *p3,
>>> +       unsigned long *p4, unsigned long *p5)
>>> +{
>>> +       uint64_t *dp1 = (uint64_t *)p1;
>>> +       uint64_t *dp2 = (uint64_t *)p2;
>>> +       uint64_t *dp3 = (uint64_t *)p3;
>>> +       uint64_t *dp4 = (uint64_t *)p4;
>>> +       uint64_t *dp5 = (uint64_t *)p5;
>>> +
>>> +       register uint64x2_t v0, v1, v2, v3;
>>> +       long lines = bytes / (sizeof(uint64x2_t) * 4);
>>> +
>>> +       do {
>>> +               /* p1 ^= p2 */
>>> +               v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
>>> +               v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
>>> +               v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
>>> +               v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
>>> +
>>> +               /* p1 ^= p3 */
>>> +               v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
>>> +               v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
>>> +               v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
>>> +               v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
>>> +
>>> +               /* p1 ^= p4 */
>>> +               v0 = veorq_u64(v0, vld1q_u64(dp4 +  0));
>>> +               v1 = veorq_u64(v1, vld1q_u64(dp4 +  2));
>>> +               v2 = veorq_u64(v2, vld1q_u64(dp4 +  4));
>>> +               v3 = veorq_u64(v3, vld1q_u64(dp4 +  6));
>>> +
>>> +               /* p1 ^= p5 */
>>> +               v0 = veorq_u64(v0, vld1q_u64(dp5 +  0));
>>> +               v1 = veorq_u64(v1, vld1q_u64(dp5 +  2));
>>> +               v2 = veorq_u64(v2, vld1q_u64(dp5 +  4));
>>> +               v3 = veorq_u64(v3, vld1q_u64(dp5 +  6));
>>> +
>>> +               /* store */
>>> +               vst1q_u64(dp1 +  0, v0);
>>> +               vst1q_u64(dp1 +  2, v1);
>>> +               vst1q_u64(dp1 +  4, v2);
>>> +               vst1q_u64(dp1 +  6, v3);
>>> +
>>> +               dp1 += 8;
>>> +               dp2 += 8;
>>> +               dp3 += 8;
>>> +               dp4 += 8;
>>> +               dp5 += 8;
>>> +       } while (--lines > 0);
>>> +}
>>> +
>>> +struct xor_block_template const xor_block_inner_neon = {
>>> +       .name   = "__inner_neon__",
>>> +       .do_2   = xor_arm64_neon_2,
>>> +       .do_3   = xor_arm64_neon_3,
>>> +       .do_4   = xor_arm64_neon_4,
>>> +       .do_5   = xor_arm64_neon_5,
>>> +};
>>> +EXPORT_SYMBOL(xor_block_inner_neon);
>>> +
>>> +MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
>>> +MODULE_DESCRIPTION("ARMv8 XOR Extensions");
>>> +MODULE_LICENSE("GPL");
>>> --
>>> 2.7.4



