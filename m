Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E838CCA47C
	for <linux-block@archiver.kernel.org>; Sun, 12 Jun 2022 15:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiFLP1K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Jun 2022 11:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiFLP1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jun 2022 11:27:10 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87435EDD8
        for <linux-block@vger.kernel.org>; Sun, 12 Jun 2022 08:27:08 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-30ce6492a60so30006177b3.8
        for <linux-block@vger.kernel.org>; Sun, 12 Jun 2022 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKtz7aN4iqLwpjMxddmPWT/Yv9HKk9kmTNthHMCTmzI=;
        b=T9YefAqcwoWBIxZvqn+6v2XWWOet+BsnQU0+RFWVg6KgivzT/L5lObsCTPCQTt/t5Q
         O40qE1hi12jMrF4WTFqKtW2LzpBjaorQNa34aV4k3hv8HKQ8PdKPMEaSSxFMV47/mzpy
         5NB8fyovqGp5apHZFDa58gx5ZaH+tLAMzs45xITz4fb4vlzo0gMUB+DN67+3WhqdQW2m
         K11090o1HY9Z5N/7OrH4HIp/tOUVaTeFZraEa0DnsQrfgrbOu3JKvaQW4n5bCyWXag2u
         d53mOuvNeMu27ZoK5W99SVTmAQTCjGIg6OdP3eCz5qEG76PT5nxBz7fhGrEZ0izsu26g
         oVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKtz7aN4iqLwpjMxddmPWT/Yv9HKk9kmTNthHMCTmzI=;
        b=5hw3qT0eexVzjUoZI2cv7KngCXpMMCwW4ZPPJRlq6uAg7/kvxmBolJh/h/mboz5RsH
         //1ygZFLzXJlZL79TT1PyTmGRPpJ6zttEJqeVF6Xcj5q1JDGmoZ/mPnGozzAJXV0SKJZ
         eCcnuJyZgPC0olmj+1XgtNg/vhQTppa52UbM7dI0tfEqYnul3Lz9eO1cXbkGpSt0v6eF
         vDVnk9Vcl41F9V/2sFxw2fduQ0SZMTM+8n21ETgy3+fPjuLoRw53PWLDBPbt/eR5Aw6a
         CuVAGspCdytSqTyDJ1mw+L7ugldWDAIF6dUZbG1TYcAZRwmMj5tVxJ0HeZ3QQ8R3y1m8
         PuRQ==
X-Gm-Message-State: AOAM5317klqjhxDEhdsrrcKBaVlW5xSFTEGYgulTK3ZGGGLZa0RrRo39
        W9vTsvKzQoA6oIv2LJOpTAqtNHR9Ps1ciBYDrnMZdA==
X-Google-Smtp-Source: ABdhPJzw73ekffcunyjrSkMcYzhG2oTN3hgX5618XHyVJPGma2VxAdtu2GUrDNvI7Ls/FS87wXEYytUyk6/LQyIQ8vY=
X-Received: by 2002:a81:1a43:0:b0:30c:78b1:f23d with SMTP id
 a64-20020a811a43000000b0030c78b1f23dmr60215098ywa.166.1655047628056; Sun, 12
 Jun 2022 08:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com> <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com> <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com> <YqANP1K/6oRNCUKZ@google.com> <YqBRZcsfrRMZXMCC@google.com>
In-Reply-To: <YqBRZcsfrRMZXMCC@google.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Jun 2022 20:56:56 +0530
Message-ID: <CA+G9fYvjpCOcTVdpnHTOWaf3KcDeTM3Njn_NnXvU37ppoHH5uw@mail.gmail.com>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sergey,

On Wed, 8 Jun 2022 at 13:06, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/06/08 11:45), Sergey Senozhatsky wrote:
> >
> > Something like this?
>
> May be even something like below. Move static initializer to cpu up
> hook.

Thanks for providing a fix patch.
As per your suggestion debug lock enabled.

CONFIG_DEBUG_LOCK_ALLOC=y

I have tested this patch and the reported issue got resolved [1].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> ---
>  mm/zsmalloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 9152fbde33b5..6d3789d834e2 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -453,9 +453,7 @@ MODULE_ALIAS("zpool-zsmalloc");
>  #endif /* CONFIG_ZPOOL */
>
>  /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
> -static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
> -       .lock   = INIT_LOCAL_LOCK(lock),
> -};
> +static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
>
>  static __maybe_unused int is_first_page(struct page *page)
>  {
> @@ -1113,6 +1111,7 @@ static inline int __zs_cpu_up(struct mapping_area *area)
>         area->vm_buf = kmalloc(ZS_MAX_ALLOC_SIZE, GFP_KERNEL);
>         if (!area->vm_buf)
>                 return -ENOMEM;
> +       local_lock_init(&area->lock);
>         return 0;
>  }
>
>
> 2.36.1.255.ge46751e96f-goog

Build artifacts link [2]

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/5160519#L828
[2] https://builds.tuxbuild.com/2ATpwm83jTe2wlUX33YeTpshh2u/
