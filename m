Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EA5C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 11:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8C12086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 11:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0xvKXXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8C12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeK0Wju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:39:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35775 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeK0Wju (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 17:39:50 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so7788186itp.0
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idndrP+BDP9L412eLH0viFfoX5mFV7BfqSVJaJ1Mhfg=;
        b=J0xvKXXmx5T5lDneuesz4+x16jRAPJj+TdGQddGLMcp5Ytz3QHu1yb6ncgJ+pyil0u
         HbFvIMs3iGs+K5+DN9t/710XVxA4xi824wQTjsRKuGpdhomXeZnQclKBVzl/uZEQGdug
         eGjz0NOBdzlw8IQt2KXlN3aXK/clatofeHNvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idndrP+BDP9L412eLH0viFfoX5mFV7BfqSVJaJ1Mhfg=;
        b=uPiFcv+tsH4VSUa8JshMlCgyO4ieYOWMnTXxSihwvOvFMvrKOMXgwy698r1UYyvbJh
         wVu3u7bO3CusKcjvlpE/Cd8gTm7WVJdYQu/N9klSKvUyzxABAL7Bgfs/H2wsZG+QDDGs
         iQ0eht/PY3bxLAqDe7LnXW1eDbakJu3kmxPvn2P01GEEffj0BXEorGfOqDI3GyqdoDet
         INMWqzwRmkHam3y0wQHEnIpSNWBTLGpBO3okQckKv9TbQAj4c8k4ScNTWbEMyki5Fkj9
         xbjA+Y0k0HIcNj/MVuUBF8r/rARuyUDnQVaMsMnAbzREGx1KpYcHldmZR+6US6RCQSYk
         0ZOg==
X-Gm-Message-State: AGRZ1gI/1L2uF9i5x1yMtCTo4asEthmSthbBWrAE5YzKTVjMt29Jdt/7
        Za8MniBih6u+fRm+H80nxi/Pk15BU38FcMM2UXTGIw==
X-Google-Smtp-Source: AFSGD/Xc6hwLsWmFqkSA38gHKrQ3h81C/r6DlzydhNF3+G0Z37xWvgNNwkqUQN6nbn6dP+ARYB8QDlzlCt8mOqC7sTM=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr29543737ith.158.1543318932025;
 Tue, 27 Nov 2018 03:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
In-Reply-To: <20181127100858.6995-1-liuyun01@kylinos.cn>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 27 Nov 2018 12:42:00 +0100
Message-ID: <CAKv+Gu_iqRWyFJ+otvnrunBDQXOztGu-C3-qd6bfLR-aXxxBeg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64/neon: add workaround for ambiguous C99
 stdint.h types
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
> +#define __INT64_TYPE__         __signed__ long long
> +#endif
> +
> +#ifdef __UINT64_TYPE__
> +#undef __UINT64_TYPE__
> +#define __UINT64_TYPE__                unsigned long long
> +#endif
> +
> +#include <arm_neon.h>
> +

We should make this

/*
 * genksyms chokes on the ARM NEON instrinsics system header, but we
don't export anything
 * it defines anyway, so just disregard when genksyms execute.
 */
#ifndef __GENKSYMS__
#include <arm_neon.h>
#endif

to work around the issue you reported with symbol versioning.

> +#endif /* ! _NEON_INTRINSICS_H */
> --
> 2.7.4
>
>
>
>
