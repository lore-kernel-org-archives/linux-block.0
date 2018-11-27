Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8322AC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 12:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423D62086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 12:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wysw/WfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423D62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeK0Xmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:42:53 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51051 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeK0Xmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 18:42:53 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so16359794iti.0
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 04:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+riOEYRFNVvZ5OoRZXe4KvvnQ2Pgq/owpZySS8aSbI=;
        b=Wysw/WfBGpnDiuJ/unLsJn9ncpvSEDLDoi27VXrO2KzJnLbA++6daW7ln1PuSz2+bL
         4vpDEjUL5Nzc4+gOebdEa6+hQTv7y5zCwcu8Zkocom1VXp2ONM2hgViWIYfLTtbbADDk
         SmY8CRWG0Dl/5RMa/SlggLl1kkXg8KNniMk20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+riOEYRFNVvZ5OoRZXe4KvvnQ2Pgq/owpZySS8aSbI=;
        b=VRsW7GO18wgjrzOPsYDtsW1pd8fkGSUvk5iRv6L4pyWo3fj4onC7hPxBt7gvsvxMQy
         UOIXeju7U72t7u91cqXyPIehN7WhYckCudc/D5WEBKNOf5lhCyozwk7+i2nzWzLkJUOt
         qNX3FGLvA5Bx3k79pUS+gc7vgduhAIz86wdW47VMu/HDgelIxztnIkzd3ydQKU6X6dPS
         nyROLW7Sc5VIeOcGHjw87TkvTsvDROAW8oNX+FTeFsCM4f7kLPE9HxtG/ZwmLvtbYGAb
         7JqJPSZ31ibr+ZZdKjpU3RSMpJJLAs4e+h3c8eOV8RJH8/CD+a9yuAuR9yBSIMG9vKwi
         7HBw==
X-Gm-Message-State: AGRZ1gLH3/7BOm5MlNwGlnDUp1GErqgXsHq6mRClkHrpDPwrHSae52Ak
        9rPmk3Hlt7F+KwIPpN+JCLS+hf5zSMfDR0otgiHRGkfb
X-Google-Smtp-Source: AJdET5eunhjv7HjP9LDbbMk7QEQxziwaDMR1VK9dmdXc70V+oSZIHxTPpVKTsyW1bseK/iC0+wUrw7cdSKJBsrspFhQ=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr28134503itk.71.1543322702995;
 Tue, 27 Nov 2018 04:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20181127123813.7523-1-liuyun01@kylinos.cn>
In-Reply-To: <20181127123813.7523-1-liuyun01@kylinos.cn>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 27 Nov 2018 13:44:51 +0100
Message-ID: <CAKv+Gu8KB91XmacyS5rBK+_5pKdS_i+z2Wi+J0fGXweL9Q_hqg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] arm64/neon: add workaround for ambiguous C99
 stdint.h types
To:     liuyun01 <liuyun01@kylinos.cn>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(add maintainers back to cc)

On Tue, 27 Nov 2018 at 13:38, Jackie Liu <liuyun01@kylinos.cn> wrote:
>
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

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

(Nit below)

> ---
>  arch/arm64/include/asm/neon-intrinsics.h | 35 ++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 arch/arm64/include/asm/neon-intrinsics.h
>
> diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> new file mode 100644
> index 0000000..145d8ea
> --- /dev/null
> +++ b/arch/arm64/include/asm/neon-intrinsics.h
> @@ -0,0 +1,35 @@
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
> +#define __INT64_TYPE__         __signed__ long long
> +#endif
> +
> +#ifdef __UINT64_TYPE__
> +#undef __UINT64_TYPE__
> +#define __UINT64_TYPE__                unsigned long long
> +#endif
> +
> +/*
> + * genksyms chokes on the ARM NEON instrinsics system header, but we
> + * don't export anything
> + * it defines anyway, so just disregard when genksyms execute.

Can we fix up the spurious newline and the grammar here when applying? [my bad]

> + */
> +#ifndef __GENKSYMS__
> +#include <arm_neon.h>
> +#endif
> +
> +#endif /* ! _NEON_INTRINSICS_H */
> --
> 2.7.4
>
>
>
