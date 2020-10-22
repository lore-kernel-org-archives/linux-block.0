Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFC0C388F7
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16E121D43
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 21:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9CbMxFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899186AbgJVVTa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897428AbgJVVT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 17:19:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531B2C0613CE;
        Thu, 22 Oct 2020 14:19:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s22so1774160pga.9;
        Thu, 22 Oct 2020 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3W/IOmdOMUGlXlTzumA+5bE0zrAqv8UmjtWcnintli8=;
        b=U9CbMxFwmbX0fhv+7Qcq0QxQoZfeBEaxscO+5CXSLFUuRYCe6TgHRMTagtmXBBXPEv
         QGBGDqQdo7K+2zfpDLEuRecZqTDzDWVda4/VxjhpxD/s2tKgExJsxq5MqK+ZZBg2VVJP
         jxP1y1tJZ3Z0i+014MaPrDOEFO2GJM49mkuR343t7tsjPGEIp0cIQH8bQ2lXZn3GKoye
         A8RAEdRbkWGeR1hngtnV20p0aVk/aqmTfMjVQftZXMP48cmjEVld9qJyTTuq2Kj31bld
         3Khpy3tVdqI1DRTK27XXx7uMiOLouMfglmdnsIjfsyaJpqsa9MrdAK6W4Lx8mrU6F7pq
         Blzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3W/IOmdOMUGlXlTzumA+5bE0zrAqv8UmjtWcnintli8=;
        b=N2RJBhx4lFtokAekv6MoMIKyeIbQoupP2un1NxSxQb45xatEi6GnU6xuBlQ+UOy8V4
         BfnrSKJPZccFgc/Gz1v2sZPsAjjY5E74kdokjHMA9vuPY1Fs8+UwQh7l0UbsPUsp5PUw
         +n81zHITSHL00ylzUlZEQ5sKKcuIUZ0nfykLFXTRTOgSmi8/ICc37KPYyY3uaa49w42K
         Ox/7VlbRQzoXBA/fMCiZzIijCCJIDbYKyG5ioKoQe8AFaTGPDKduF6232SsGDMZVd9Qn
         GMURQMwNsWb09+Du/BTef/X0k78CzO4C6UxxKnddfJ0yNXNtVdI20KTetyC25kZoHDqc
         CzoA==
X-Gm-Message-State: AOAM532ppnc8EZhGP0JYi2WYiuPz2Sma1nm45zD31phPLboFDHa0rUT3
        OXZhjT3iQFG7yMal+KyofPqqmJD1J8DORHgEzA==
X-Google-Smtp-Source: ABdhPJwI2PlyNT/SIF/Rw95v2BBZOro346Q8rSD3bOyrMFNR7Fpob2djOzpAfN18RMuvRJJ4xWjtSgyJgz1CVe+MaDI=
X-Received: by 2002:a17:90a:ce8c:: with SMTP id g12mr3853435pju.185.1603401568802;
 Thu, 22 Oct 2020 14:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201022161134.2115-1-rsalvaterra@gmail.com>
In-Reply-To: <20201022161134.2115-1-rsalvaterra@gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 22 Oct 2020 22:19:17 +0100
Message-ID: <CALjTZva495Lp39D=AKoRcdK2MbqwVRenaaMA+4KUPtLCXEeKJQ@mail.gmail.com>
Subject: Re: [PATCH] zram: break the strict dependency from lzo
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Oops, this is broken, I'll send a v2 soon.

On Thu, 22 Oct 2020 at 17:11, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> There's nothing special about zram and lzo. It works just fine without it, so
> as long as at least one of the other supported compression algorithms is
> selected.
>
> Additionally, drop the explicit dependency from CRYPTO, as it's implied by the
> selection of the algorithms themselves.
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
>  drivers/block/zram/Kconfig | 8 ++++++--
>  drivers/block/zram/zcomp.c | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index fe7a4b7d30cf..2641b86f8677 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -1,8 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config ZRAM
>         tristate "Compressed RAM block device support"
> -       depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
> -       select CRYPTO_LZO
> +       depends on BLOCK && SYSFS && ZSMALLOC
>         help
>           Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
>           Pages written to these disks are compressed and stored in memory
> @@ -37,3 +36,8 @@ config ZRAM_MEMORY_TRACKING
>           /sys/kernel/debug/zram/zramX/block_state.
>
>           See Documentation/admin-guide/blockdev/zram.rst for more information.
> +
> +config ZRAM_AUTOSEL_ALGO
> +       def_bool y
> +       depends on ZRAM && !(CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_ZSTD)
> +       select CRYPTO_LZO
> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index 33e3b76c4fa9..052aa3f65514 100644
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -15,8 +15,10 @@
>  #include "zcomp.h"
>
>  static const char * const backends[] = {
> +#if IS_ENABLED(CONFIG_CRYPTO_LZO)
>         "lzo",
>         "lzo-rle",
> +#endif
>  #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
>         "lz4",
>  #endif
> --
> 2.28.0
>
