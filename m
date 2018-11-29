Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62366C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A0A20989
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 16:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A0A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeK3EBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:01:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbeK3EBH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:01:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B56EA78;
        Thu, 29 Nov 2018 08:55:06 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F2E03F59C;
        Thu, 29 Nov 2018 08:55:05 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:55:03 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     ard.biesheuvel@linaro.org, linux-block@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] arm64/neon: add workaround for ambiguous C99
 stdint.h types
Message-ID: <20181129165501.GP3505@e103592.cambridge.arm.com>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127100858.6995-1-liuyun01@kylinos.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 06:08:57PM +0800, Jackie Liu wrote:
> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> for ambiguous C99 stdint.h types"), this patch redefines the macros that
> are used in stdint.h so its definitions of uint64_t and int64_t are
> compatible with those of the kernel.
> 
> This patch comes from: https://patchwork.kernel.org/patch/3540001/
> Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> We mark this file as a private file and don't have to override asm/types.h
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  arch/arm64/include/asm/neon-intrinsics.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 arch/arm64/include/asm/neon-intrinsics.h
> 
> diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> new file mode 100644
> index 0000000..96a3fda
> --- /dev/null
> +++ b/arch/arm64/include/asm/neon-intrinsics.h
> @@ -0,0 +1,28 @@
> +#ifndef _NEON_INTRINSICS_H
> +#define _NEON_INTRINSICS_H
> +
> +#include <asm-generic/int-ll64.h>
> +
> +/*
> + * For Aarch64, there is some ambiguity in the definition of the types below
> + * between the kernel and GCC itself. This is usually not a big deal, but it
> + * causes trouble when including GCC's version of 'stdint.h' (this is the file
> + * that gets included when you #include <stdint.h> on a -ffreestanding build).
> + * As this file also gets included implicitly when including 'arm_neon.h' (the
> + * NEON intrinsics support header), we need the following to work around the
> + * issue if we want to use NEON intrinsics in the kernel.
> + */
> +
> +#ifdef __INT64_TYPE__
> +#undef __INT64_TYPE__
> +#define __INT64_TYPE__		__signed__ long long

Minor query: Out of interest, why __signed__ here, and not signed?

Most similar headers do the same, but I haven't figured out why.

Cheers
---Dave
