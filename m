Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEA1C4363A
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64263208FE
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD76WB1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbgJ1WkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388997AbgJ1WkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:40:05 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF323C0613CF;
        Wed, 28 Oct 2020 15:40:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w191so1293036oif.2;
        Wed, 28 Oct 2020 15:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VqXxfIJlTWg5JCY6WaiibiaF3Av1Vws4rOMWH/oaM0=;
        b=bD76WB1brthOpLFfv36vGMmcP4BS6e19mPzrCOrXZ+Hd8gSxot+/WePxzOxICMi53p
         BKbiqI/FpdzxYIUVSQvBeV6dAQRezv9anxIcKtuLYKQe6L31Yy4+rK5sKk83WM8usOMH
         n5Ir0BcnCOdVshVI1GMRdnSsuTKpS7S0WG1EOmXjXhYY74fi/7EkfwuKffAAB+BC4WND
         jayvmnKpEa2h7AUcGU+7m1cn3JXJFi9CbCUkQo5id26mirH/iNdLG6Rcr0tnVXTmHya4
         qXLjqg0ZdJbcO5O1l3DhfG0Mvy/HnsQkexwq+4pN1LaNxwF78V3+RVnsHgOH+66A+t/h
         tKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VqXxfIJlTWg5JCY6WaiibiaF3Av1Vws4rOMWH/oaM0=;
        b=dZ8/d4jMT+1WauwXdKu2y24j/lghjFuPBnMMZYkXJlrxBJOZ6+t6srCPNHJAGZQ2Tv
         oGFavrTmpNDKAXh1Lr4JNwPQjSRO8OfB/aDEuuEdXbu5CsJ+B3C0d1r/JSAyPLjzo5eZ
         Bnf54WpCjueajfXhJGQPGkcIQYmlM+cDBa///VRoKfGztZp4KK5YonQaOpdz+idW0JFc
         90fH897ABq24YQGS/OtkKggLWIk3ZgSXvnhH3pQ2LdaLEfnu8KalYIIk60OXZn6uuc80
         H2i2H7HDUMbtvuA+V10kGvc5H1t0BrJeSA8i3EXtCsd8EUmBeyDJjpFer8d6TZfL6DEj
         G1Eg==
X-Gm-Message-State: AOAM530tQEq8l3kT72oZWAWxzGwlnnTrTdR64d6f1MMK4LKwyzpCEJC0
        ZRqtbKsjK8lO7UoEkz50qv6Y0kSWgAf5ixOGVbMcrVVhkw==
X-Google-Smtp-Source: ABdhPJx4S9NeGKBomtg+fa/VVwHqLjhQvXJ1U1E/K8q3oOWW5pYScZO11e/S6e2LVh8RvgnD3+DgJHW3RudeLMiSCSM=
X-Received: by 2002:a17:90a:3f0f:: with SMTP id l15mr6747809pjc.190.1603884343625;
 Wed, 28 Oct 2020 04:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201026085141.1179-1-rsalvaterra@gmail.com> <20201027012204.GD2412725@google.com>
 <CALjTZvbf4qK6SHEe7OhkTC_o7kaY4oOKQ+kk-D2OUq_ULsYAqQ@mail.gmail.com> <20201028101934.GB48825@google.com>
In-Reply-To: <20201028101934.GB48825@google.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 28 Oct 2020 11:25:32 +0000
Message-ID: <CALjTZvaTiAS1vMyrTNvrfy7KOjemy+tW5-hbTy5SHYfsbRE=_Q@mail.gmail.com>
Subject: Re: [PATCH v3] zram: break the strict dependency from lzo
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Sergey,

On Wed, 28 Oct 2020 at 10:19, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> Can the following work then?

Almost! See below. :)

> Completely untested.
>
> ===8<===
>
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index fe7a4b7d30cf..f93eed40e155 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -2,7 +2,7 @@
>  config ZRAM
>         tristate "Compressed RAM block device support"
>         depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
> -       select CRYPTO_LZO
> +       depends on (CRYPTO_LZO || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_ZSTD)

This reverses the dependency order, as now we have to select a
supported compression algorithm in order for zram to be visible in the
block device drivers list. This is why I wrote the ZRAM_AUTOSEL_ALGO
kconfig symbol, which automatically selects lzo as a fallback. If the
user chooses to select another supported algorithm, he will then be
allowed to deselect lzo. We thus follow the principle of least
surprise, IMHO.

>         help
>           Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
>           Pages written to these disks are compressed and stored in memory
> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index 33e3b76c4fa9..98c7c46c9c3a 100644
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
> @@ -202,6 +204,21 @@ void zcomp_destroy(struct zcomp *comp)
>         kfree(comp);
>  }
>
> +const char *default_compressor(void)
> +{
> +       /*
> +        * Pick the first available one (there should be at least one).
> +        *
> +        * In theory, we can drop all the ifdefs from backends[] and
> +        * just iterate backends array doing crypto_has_comp(comp, 0, 0)
> +        * for each entry and return the first one which is recognized by
> +        * crypto. But crypto_has_comp() modprobes compression drivers,
> +        * so we may endup with extra loaded drivers, when the 'default'
> +        * compressor is not what zram is configured to use.
> +        */
> +       return backends[0];
> +}

This is much more elegant, indeed, and I completely agree with just
returning the first one. I'll incorporate your feedback and send a v4
soon.

Thanks a lot,
Rui
