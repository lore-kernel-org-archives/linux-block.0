Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B367C433B4
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 06:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EF4611B0
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 06:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhDIGXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 02:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhDIGXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 02:23:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15294C061761
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 23:23:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e14so6824753ejz.11
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0WMp8MwKJ/u3qX7Dv8XtiWzb8xXHglsszw5dF/53Js=;
        b=RSzU/8fTXW2zL+EO/inJbfSmLIUvORZ+0ncpCjsA5xwox5jMW+/13995cQ1BG3+drn
         IZLu1plLrnt4tTK9456EABz/OGQNBErWwlNrkad+Xu2ynqUdG049uL1nGgvDOpkN5YQF
         Z5VxJ8a24qmf8sTw08PZCOYyjRLbLc3aSYuEVLbcrzIzisS19Y+MvrZRe4EsB/OXp7Zc
         Nduhl29srfd0adZ5Np0cthNChuCC60bAfT50gGRfWDz28GU052SKiHM22kDt34JNpaSP
         j+zO42c44T9gPxiY1sPbQ8GzIO4UTE4AKDK4iq42bImf4aZVY+wH3fXj/mbLqLnaRAzL
         UY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0WMp8MwKJ/u3qX7Dv8XtiWzb8xXHglsszw5dF/53Js=;
        b=ETZrwtGZ7XHbV6+thAmEag3vokgOTCHjqK63XI9spkjvnis7mtFiUgInyBxVQYXySP
         LImK/evq4I786+lAngZWROzvPhxTIyD1NQ1lT8ydc7602vvfXOSU49dJq2SKJqzLI9dw
         urNFOQzwdJeUjKYhINx9ONCKDPM+bbPJBVwwtC8Usww8nErGOwzdUFrjbMBzKzcldpEb
         EIWzc4EInTpi8R0iMDGwozVoVy8gVCE2XzJ43Nx0E0BbxDhLgHahuYUnxS3QH78oB8gr
         vFmJk5UuZ64scx4G0wXKVv2J2j3YwsXwN3C/cDjHIXlwuUbdv0mzfShqf85g2pSebxdU
         RQ3A==
X-Gm-Message-State: AOAM530gLQsRODUNIN1oTnlGpMa3JNgO3J4D5tRSfEWpd6x4IPi2KPPE
        ZnFRA6qKCDzNAtYmgfaZxBYIlTMxnYvA0szowhHnOsQv4iPHrw==
X-Google-Smtp-Source: ABdhPJyNW8FA7KCEbD2ruFaUWyLqipptmdm8sQ3TknahXLmC9cmxEHhJE+UDIIR9xnnqW2/0yG2B0wUwPtpsfi7AkfM=
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr14338784ejc.133.1617949418711;
 Thu, 08 Apr 2021 23:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtNAEwCk1WkA_25FVUrR0QJ2vt2Dh_w+m-QOSjb8f5TBQ@mail.gmail.com>
 <BYAPR04MB4965A95A5131664085CDD8B786739@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965A95A5131664085CDD8B786739@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Apr 2021 11:53:27 +0530
Message-ID: <CA+G9fYt30EZOv2mUOf+xGh3R3A0SMJhvVtHFwZuKyBgB75UTTw@mail.gmail.com>
Subject: Re: [next] drivers/cdrom/gdrom.c:586:61: error: 'rq' undeclared
 (first use in this function)
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya,

On Fri, 9 Apr 2021 at 11:01, Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 4/8/21 22:21, Naresh Kamboju wrote:
> > Linux next tag 20210408 architecture sh builds failed due to these errors.
> >
> > # to reproduce this build locally:
> >
> > make --silent --keep-going --jobs=8
> > O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sh
> > CROSS_COMPILE=sh4-linux-gnu- 'CC=sccache sh4-linux-gnu-gcc'
> > 'HOSTCC=sccache gcc'
> >
> >
> > In file included from /builds/linux/include/linux/scatterlist.h:9,
> >                  from /builds/linux/include/linux/dma-mapping.h:10,
> >                  from /builds/linux/drivers/cdrom/gdrom.c:16:
> > /builds/linux/drivers/cdrom/gdrom.c: In function 'gdrom_readdisk_dma':
> > /builds/linux/drivers/cdrom/gdrom.c:586:61: error: 'rq' undeclared
> > (first use in this function)
> >   586 |  __raw_writel(page_to_phys(bio_page(req->bio)) + bio_offset(rq->bio),
> >       |                                                             ^~
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > Regressions found on sh:
> >   - build/gcc-9-dreamcast_defconfig
> >   - build/gcc-10-dreamcast_defconfig
> >   - build/gcc-8-dreamcast_defconfig
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >
>
> This can be fixed by following :-
>
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index e7717d090868..742b4a0932e3 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -583,7 +583,7 @@ static blk_status_t gdrom_readdisk_dma(struct
> request *req)
>         read_command->cmd[1] = 0x20;
>         block = blk_rq_pos(req)/GD_TO_BLK + GD_SESSION_OFFSET;
>         block_cnt = blk_rq_sectors(req)/GD_TO_BLK;
> -       __raw_writel(page_to_phys(bio_page(req->bio)) + bio_offset(rq->bio),
> +       __raw_writel(page_to_phys(bio_page(req->bio)) +
> bio_offset(req->bio),
>                         GDROM_DMA_STARTADDR_REG);
>         __raw_writel(block_cnt * GDROM_HARD_SECTOR, GDROM_DMA_LENGTH_REG);
>         __raw_writel(1, GDROM_DMA_DIRECTION_REG);

Thanks for your patch.
After applying this typo fix, the build pass now.

- Naresh
