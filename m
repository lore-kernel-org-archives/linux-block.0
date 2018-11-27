Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E230C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 08:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37E1208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 08:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sms81Zhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37E1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeK0TPM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:15:12 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37756 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeK0TPM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 14:15:12 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so32457169iti.2
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 00:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuHAnM5BI+HgyLDLv7ZDeoLzwoAZOnoZGAnhSsYZtTw=;
        b=Sms81ZhjjRXWTIy+kS99TZHdEzETtb5jOa5DXwBJtyG9QIEcp1jDv1nlCTmcPebCod
         T/hFo2rJV3B/DnWt+UPv1VFAMeqUo2i2O/J3jbIAUNURP6JgcC9ROC9rpFQ/+Gotastr
         112iuCJkXTHJylNA339T6e+uWLAJgEvBzuHxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuHAnM5BI+HgyLDLv7ZDeoLzwoAZOnoZGAnhSsYZtTw=;
        b=qfetzjf5oujMFlBIKllQtZDPdPQly80u9mpPFYmYVWroATYpgtfbt2CXkyPpn1ZhUX
         OkGj2EOtOY8/lpNsecU50jESg59gXRN0Ltc+Wf4p1kKzZKFuSopoq+FEuh3di32+ASdC
         9Zh6mGGKOsB1ZKXiSkRzKgRiwJw2NfkJFzBVQxVX7N3yusBLCQZC/kA/EEHxZtNaPI7I
         YJ18xuEk0yKnlZT8PUKMfAgGuQHRAlIQC167HOEpklbWE3+L6FCICoAY0ZmDXIh+LWXl
         2mbPyfIqsWqAEDdn6gnst74ZdIVUD+96zu+vIeJ3yi74k+l6q58L6nOcBuNVq2rMdj0O
         VTvQ==
X-Gm-Message-State: AA+aEWY/CKOmnkUYRhPpXAJEb7Qcjj0WnXnCnSG+/4J24JSkMSDefAP/
        9B7xx+TkqE2XZWFduKK75OGXJZUliIzREdbj4gRFWmeX
X-Google-Smtp-Source: AFSGD/XhEimExY5J1SIOwuCRiIrEy5TYsmUUbny44xQ5zNM1inUNUmX4n0GMzHhxz4HfBUrciIUlrG/7eCwqe301804=
X-Received: by 2002:a02:734b:: with SMTP id a11mr25506730jae.62.1543306686960;
 Tue, 27 Nov 2018 00:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20181127052701.4144-1-liuyun01@kylinos.cn>
In-Reply-To: <20181127052701.4144-1-liuyun01@kylinos.cn>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 27 Nov 2018 09:17:55 +0100
Message-ID: <CAKv+Gu9TEZ9j3xB9dM_tP9tenzoH+p6Y7-1KCKGEL7AkiVdRdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: add workaround for ambiguous C99 stdint.h types
To:     liuyun01 <liuyun01@kylinos.cn>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 27 Nov 2018 at 06:28, Jackie Liu <liuyun01@kylinos.cn> wrote:
>
> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> for ambiguous C99 stdint.h types"), this patch redefines the macros that
> are used in stdint.h so its definitions of uint64_t and int64_t are
> compatible with those of the kernel.
>
> This patch comes from: https://patchwork.kernel.org/patch/3540001/
> Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>

OK, I remember now :-)

So this is the reason you had two separate source files in the
previous revision.

Could we maybe deal with this differently? Could we add a header

arch/arm64/include/asm/neon-intrinsics.h

that includes <arm_neon.h> after setting the preprocessor overrides
below? And reference that header from your code?

That way, we don't have to override asm/types.h for everyone.



> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  arch/arm64/include/uapi/asm/types.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 arch/arm64/include/uapi/asm/types.h
>
> diff --git a/arch/arm64/include/uapi/asm/types.h b/arch/arm64/include/uapi/asm/types.h
> new file mode 100644
> index 0000000..0016780
> --- /dev/null
> +++ b/arch/arm64/include/uapi/asm/types.h
> @@ -0,0 +1,26 @@
> +#ifndef _UAPI_ASM_TYPES_H
> +#define _UAPI_ASM_TYPES_H
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
> +#endif /* _UAPI_ASM_TYPES_H */
> --
> 2.7.4
>
>
>
>
