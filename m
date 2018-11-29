Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E741C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CD52145D
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CD52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbeK3EGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:06:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeK3EGx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:06:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90387A78;
        Thu, 29 Nov 2018 09:00:51 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3E803F59C;
        Thu, 29 Nov 2018 09:00:50 -0800 (PST)
Date:   Thu, 29 Nov 2018 17:00:48 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     ard.biesheuvel@linaro.org, linux-block@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
Message-ID: <20181129170048.GQ3505@e103592.cambridge.arm.com>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127100858.6995-2-liuyun01@kylinos.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 06:08:58PM +0800, Jackie Liu wrote:
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
> That is patch version 3. Thanks for Ard Biesheuvel's
> suggestions.
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
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
> +	kernel_neon_begin();
> +	xor_block_inner_neon.do_2(bytes, p1, p2);
> +	kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3)
> +{
> +	kernel_neon_begin();
> +	xor_block_inner_neon.do_3(bytes, p1, p2, p3);
> +	kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3, unsigned long *p4)
> +{
> +	kernel_neon_begin();
> +	xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
> +	kernel_neon_end();
> +}
> +
> +static void
> +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +{
> +	kernel_neon_begin();
> +	xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
> +	kernel_neon_end();
> +}
> +
> +static struct xor_block_template xor_block_arm64 = {
> +	.name   = "arm64_neon",
> +	.do_2   = xor_neon_2,
> +	.do_3   = xor_neon_3,
> +	.do_4   = xor_neon_4,
> +	.do_5	= xor_neon_5
> +};
> +#undef XOR_TRY_TEMPLATES
> +#define XOR_TRY_TEMPLATES           \
> +	do {        \
> +		xor_speed(&xor_block_8regs);    \
> +		xor_speed(&xor_block_32regs);    \
> +		if (cpu_has_neon()) { \
> +			xor_speed(&xor_block_arm64);\
> +		} \
> +	} while (0)

Should there be a may_use_simd() check somewhere?

If we invoke this in a softirq I don't see what prevents us from
corrupting the task's NEON state.

(The check might be in some surrounding glue code that I missed...)

[...]

Cheers
---Dave
