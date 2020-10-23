Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B24C388F9
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F2F24182
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 09:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Hxsjmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461183AbgJWJJz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Oct 2020 05:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461182AbgJWJJz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 05:09:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A88C0613CE;
        Fri, 23 Oct 2020 02:09:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh6so524226plb.5;
        Fri, 23 Oct 2020 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuWQAlQv3OUlkNPH4uDNpUc9APhaKy9hZDLX83ypl+8=;
        b=K2Hxsjmcc+sTwvAIvsRO07AaKT13u1kEboHWoywS48QZnrOxhy4GbK7zWr5hHT+d7F
         MHNaE+BGG+CURadnC6lF59xCZz12/cdqKSrADFaU9WKRvTPWJ7LwZQx1As6RdmdIkt47
         svRDVApQ5LTt9wCqultuByNZwhpY/i9RS6aG5HOw3ieAwSoXQAWGiqCOcH/+0Rf0/SmA
         EdI4VqEWC02WjXVRgPO+vlCxUljeSgtRK06Br4f7YQ1JySElDFJetX3shol07iYOz0NS
         Nhyfoov6e2AuEgxL1uqvVPWPOQafX+KE7zd14RJQPvP6Y8+MFWkbosbHNAIbMbECo5sB
         1tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuWQAlQv3OUlkNPH4uDNpUc9APhaKy9hZDLX83ypl+8=;
        b=DNVQC6QpT5QKXGFdmOK7McseUg7IX3p5eObac67JMvuEG/A01r3tGnNWD8UwlhMOMi
         r/N4gAGPxxLchTuhRExsMI+q81VBx90JY758jcfg4jnVtdQtHfmyJQ38uoacOuMIx+vr
         zDdwI0KTTEaJFPEt6nr4PYaUHS6OmvQ1vgcSCiBHS/A2uoRPWOsYdpjGl7bo26cTlDPr
         MqthVcOaHa+tYua+ZRlfA0AHnkS/eBbbkanSJqBz34S3/LmFSQE8fYK9VumC2/7LW/2P
         9luZSXiYPkvvDed5Y9/UT25Es7JtlNfxShKqwzoAr1hLu2IU77UpBvSlUnTrWcy+954r
         5vHw==
X-Gm-Message-State: AOAM533ScG9hsq4Y1xRqkEsyuNAYbresfQfEdHttSo2c4/WwceZUj9Vl
        gryXh10I+2vgSgLqD+7gLSPf4wPKMHDB7STxmg==
X-Google-Smtp-Source: ABdhPJzv5tSwrbDBtQ6aZLfkw4IYFW0K/Iha8OS76J7ws/85axaytL2RHKp6qTEj7O2FwBFsJNRXSQeSzreAwayXhcg=
X-Received: by 2002:a17:902:b08b:b029:d5:f570:d514 with SMTP id
 p11-20020a170902b08bb02900d5f570d514mr1593892plr.68.1603444194797; Fri, 23
 Oct 2020 02:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201022213017.8066-1-rsalvaterra@gmail.com>
In-Reply-To: <20201022213017.8066-1-rsalvaterra@gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 23 Oct 2020 10:09:43 +0100
Message-ID: <CALjTZvagCQu3Wz39wK3ij=NPHyT6gs7-4tub7DjLjNbt2HhFTQ@mail.gmail.com>
Subject: Re: [PATCH v2] zram: break the strict dependency from lzo
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sigh. Please disregard this too, I also need to fix the default
selection. I'll send a new version against 5.10-rc1, next week.

On Thu, 22 Oct 2020 at 22:30, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> There's nothing special about zram and lzo. It works just fine without it, so
> as long as at least one of the other supported compression algorithms is
> selected.
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
> v2: fix the dependency on CRYPTO.
>
>  drivers/block/zram/Kconfig | 6 +++++-
>  drivers/block/zram/zcomp.c | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index fe7a4b7d30cf..14b2b098d662 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -2,7 +2,6 @@
>  config ZRAM
>         tristate "Compressed RAM block device support"
>         depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
> -       select CRYPTO_LZO
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
