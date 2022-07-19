Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E8FCCA47F
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 10:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGSKP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 06:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiGSKP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 06:15:27 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D937F1758C;
        Tue, 19 Jul 2022 03:15:26 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id b21so7508953qte.12;
        Tue, 19 Jul 2022 03:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AFpDIUO0Z1GH4GNi5scr5xWYu4oA/Oar7iQh9zNS4c=;
        b=YLIWEKx8XvEFh+rf2ROjz/qjKihy6ehVOTMWt7x4v8vfKgan58Iudqj3thh47xW7Pt
         1cCL9PBLmoDrAhmV6Xd1JGUS8e+aIlWoVpc3FWNfxO7AfgEqvAZ14F9X/GkKLAXeloKo
         Mj4Dztox/l8dVPkogoDpoYJEky6mz9AYJCkAh7K38tOcVip4UKS5hxXtANvtYTXeD8dH
         JmrnCBX06jNTQS380X2KTpYXeIpZfDn61ROFgfP6iBrrkF0gIEiO/CEJk1WsW7zJ0fKg
         zBVcmOY9zvwPkJ6bWXgBB8mXritXrIyhGnxSD4ErGctVXzBDjqmlffzsb2K7+xaXabr6
         hkmg==
X-Gm-Message-State: AJIora+upRvTEjkkMcDO9rL4cQCYQa4prxdeUB0ub/s8EoTBTJMZV5PC
        RyxSdVaYAfqd4wHv7DnOgvjVEllBai7Dfw==
X-Google-Smtp-Source: AGRyM1uFM1qsVqYVSorZu6QHkc1OtnZ4AYUJb+dgxxk/uy4Jq79hJnC8ZzKG9Uq8yrXryWQd92EJ8A==
X-Received: by 2002:ac8:7f05:0:b0:31e:f639:bcc6 with SMTP id f5-20020ac87f05000000b0031ef639bcc6mr4366787qtk.137.1658225725793;
        Tue, 19 Jul 2022 03:15:25 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id ec5-20020a05620a484500b006b59eacba61sm13391164qkb.75.2022.07.19.03.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 03:15:25 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31d85f82f0bso135344197b3.7;
        Tue, 19 Jul 2022 03:15:25 -0700 (PDT)
X-Received: by 2002:a81:84c1:0:b0:31e:4e05:e4f4 with SMTP id
 u184-20020a8184c1000000b0031e4e05e4f4mr5616013ywf.384.1658225725281; Tue, 19
 Jul 2022 03:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220713140711.97356-1-ming.lei@redhat.com> <6e5d590b-448d-ea75-f29d-877a2cd6413b@kernel.dk>
 <Ys9g9RhZX5uwa9Ib@T590>
In-Reply-To: <Ys9g9RhZX5uwa9Ib@T590>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 12:15:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVenE9dwaOs7Qz-cxvry44ExcxBGMK-G=2KQ5SWUrR_tw@mail.gmail.com>
Message-ID: <CAMuHMdVenE9dwaOs7Qz-cxvry44ExcxBGMK-G=2KQ5SWUrR_tw@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] ublk: add io_uring based userspace block driver
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        io-uring@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

Thanks for your patch!

On Thu, Jul 14, 2022 at 2:24 AM Ming Lei <ming.lei@redhat.com> wrote:
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -409,10 +409,13 @@ config BLK_DEV_RBD
>           If unsure, say N.
>
>  config BLK_DEV_UBLK
> -       tristate "Userspace block driver"
> +       tristate "Userspace block driver (Experimental)"
>         select IO_URING
>         help
> -          io uring based userspace block driver.
> +         io_uring based userspace block driver. Together with ublk server, ublk
> +         has been working well, but interface with userspace or command data
> +         definition isn't finalized yet, and might change according to future
> +         requirement, so mark is as experimental now.

it

>
>  source "drivers/block/rnbd/Kconfig"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
