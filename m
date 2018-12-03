Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B2C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5CF214D9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 20:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFEnIRfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5CF214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbeLCUGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:06:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56119 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCUGI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 15:06:08 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so11397862itg.5
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MuAW2wYrnSpr7RW3J4Vo9qLQIWIcepPDrYMFFF3sQE=;
        b=fFEnIRfi5YkkUkRBdjsNHxmhjdmo/ziDwlwkW8gdHQ5BnL/jEfgjopJA69y9tFYUks
         0QboPyY9AKTOZchijzuIUaAvsvuqxWJRceNNVHUjq9onh5WDpD1G3YXYXGI45yGMZoWq
         83sDUN5++w5osGDuu8Vs8+VwvhjFcWGfUZoXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MuAW2wYrnSpr7RW3J4Vo9qLQIWIcepPDrYMFFF3sQE=;
        b=a1KM1MHt2OvD0aLMW3xXQ36PlOpLwBdnDPvvXp9ZgHdPlcJt8fbjbXMMf+cH0RUas/
         6fZXy3Eo162wluLcJ8J4hiY3b/ZtEfTKl9PgOmDIv52EawgR653jcOJCwOgfmPc2oW/b
         sW9xPG5FnUQnSfGvtRTNGl90U5GK0EKd1cMARuaPVH4ClQSHb2VAxTIZtUjvZ0vmOFQT
         lx8pWkgoUI3USiwv9msJrXyo77Q9H1ffGKFv1D6SipEnk5qIkKJkgbrS0xNLKQ4Cmlbd
         jRJHSVnXby3QI7rqjH88zd9NCN2vZ4kiQA5bjdX1Z+IjifFJSIQH/Mz+Np3MWT+MW3vo
         HVxw==
X-Gm-Message-State: AA+aEWbsltKcgkGD0xPLoUT872PnRDTVbswFhd5qc7iUNDWrQNZchXr9
        zFLz7r+fm3B2mjWDwR4Nb2UsK6S/qs1xa1bFgt40kw==
X-Google-Smtp-Source: AFSGD/U3eP5kEDjeM63Sy5qrNlPN3brESbbrjxREIvocXgzQIodgkzbBN6rh2qGFx1TaJu3pwRIqO64bVGhP2DMI2+Q=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr9465968itk.71.1543867564341;
 Mon, 03 Dec 2018 12:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20181128010901.1052-1-liuyun01@kylinos.cn> <20181203192310.GG29028@arm.com>
In-Reply-To: <20181203192310.GG29028@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 3 Dec 2018 21:05:52 +0100
Message-ID: <CAKv+Gu_CwVt_-HDvaV+VBaFzA+u3RqBKhd9c7tOkGQxC8pZMjQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64/neon: add workaround for ambiguous C99
 stdint.h types
To:     Will Deacon <will.deacon@arm.com>
Cc:     liuyun01 <liuyun01@kylinos.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 3 Dec 2018 at 20:22, Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Nov 28, 2018 at 09:09:00AM +0800, Jackie Liu wrote:
> > In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> > for ambiguous C99 stdint.h types"), this patch redefines the macros that
> > are used in stdint.h so its definitions of uint64_t and int64_t are
> > compatible with those of the kernel.
> >
> > This patch comes from: https://patchwork.kernel.org/patch/3540001/
> > Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > We mark this file as a private file and don't have to override asm/types.h
> >
> > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > ---
> >  arch/arm64/include/asm/neon-intrinsics.h | 34 ++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/neon-intrinsics.h
> >
> > diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> > new file mode 100644
> > index 0000000..e378766
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/neon-intrinsics.h
> > @@ -0,0 +1,34 @@
> > +#ifndef _NEON_INTRINSICS_H
> > +#define _NEON_INTRINSICS_H
>
> We tend to name these with an __ASM_ prefix, so it should be:
>
> #ifndef __ASM_NEON_INTRINSICS_H
>
> That said, I notice that the commit you refer to for arch/arm/ actually
> places this stuff under uapi/. Is that needed?
>

No, it doesn't. It creates asm/types.h which has been moved into uap/
at a later date (which I guess means we're stuck with it). In
hindsight, it would have been better for ARM to create a neon
instrinsics header file such as this one, since the override is only
needed when you include <arm_neon.h>.

> > +#include <asm-generic/int-ll64.h>
> > +
> > +/*
> > + * For Aarch64, there is some ambiguity in the definition of the types below
> > + * between the kernel and GCC itself. This is usually not a big deal, but it
> > + * causes trouble when including GCC's version of 'stdint.h' (this is the file
> > + * that gets included when you #include <stdint.h> on a -ffreestanding build).
> > + * As this file also gets included implicitly when including 'arm_neon.h' (the
> > + * NEON intrinsics support header), we need the following to work around the
> > + * issue if we want to use NEON intrinsics in the kernel.
> > + */
>
> Could you elaborate on what the ambiguities / conflicts in the types are
> please? I think you can also remove the sentence about directly including
> stdint on a freestanding build, since it doesn't seem relevant to the
> kernel afaict (we only pull it in via arm_neon.h).
>

In the kernel, u64/s64 are [un]signed long long, not [un]signed long.
So by redefining these macros to the former, we can force gcc-stdint.h
to define uint64_t / in64_t in a compatible manner.

> > +
> > +#ifdef __INT64_TYPE__
> > +#undef __INT64_TYPE__
> > +#define __INT64_TYPE__               __signed__ long long
>
> Do we need this __signed__ part?
>

No that seems redundant to me.
