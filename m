Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E44DC433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 07:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DECA20657
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 07:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="soiaT+Il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgERHZV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 03:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERHZU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 03:25:20 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85040C05BD0C
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 00:25:19 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id s5so3105159uad.4
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aM+aPj0zOelCyynTrSmLMMQxc/+9X5BzxNpmeNMaiC4=;
        b=soiaT+IlxtbU5bq6IqH0Hfp0oTnXcMaNQXTj3b/oA7odKHdqeOpIAT4AP18YPTa+tJ
         QU+brKC5T+uT06O5yb35yJ0a3o3PlIIZz8uHd+abKZTErLQtIVRSkBI0TrxMcKvrRsL5
         J4TabbAwz7055GNTUqrcH54OifcE0MnnFcqdGxogoh7Usu5JYo8dWW1GBaXD2W0WSIdG
         Z68VroVjJTmK5QKbN6MiZO9D7wbg52jJ5t6Op/fPqvV/yZnUBo2A9L8ivWHhYSpxHF/D
         07OiDBSE6PXT+sCN09hHYEF1OUnsTwra2pOdio3nsRu1520JgxorFIMMdbJK8v2wHRS8
         rGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aM+aPj0zOelCyynTrSmLMMQxc/+9X5BzxNpmeNMaiC4=;
        b=OZDUj5e1sX3Yo8nhBQfBAGq4UYY9NIn7XwmUqlNG/+DkDt6gmUdc47d47zz6BFSwBp
         hSKhr5gAwfdLCD7DIT6D1kTxtcLLD1J6WAitEef08kLELNbM/8qIcQuYOc/3UM/8usfd
         q6IxjXoB4F/0Ps+gGrvC5e90nyiZTfoUL8apFOAuqLVGRcRGI1GzKzFOIl9w4XHJt8LH
         FZGPbDjJow7xLYf7YERKx2Ceio0VEjYMOHYF6Ec1damyIc5jo2M4mBX/VB9I7nGQ8vd4
         9c32yrXjnEWPAtuAtKPsWEyNo/vIY/2hR1gx1CMbGSb+mOUjjC2tzsEX37ch1v7ghNYi
         tpqg==
X-Gm-Message-State: AOAM530AH+rreYB3nr0CRcOksunawDT/7+Yme1neTNS+gh/E/CD4DOA8
        O7Znh0m0e+/3uolYWm3w48d9fgOz7yR5mw3hNYPHQA==
X-Google-Smtp-Source: ABdhPJweGliNvIcLeCDU05CO+CaxX92MJZt0aMcqXXyqQIkHu9/Nlxtk64UFlOyWaAs4a7SkMmnbVVYmQTm7wnBffrY=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr10183460uaa.15.1589786718366;
 Mon, 18 May 2020 00:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200517021225.22890-1-digetx@gmail.com> <20200517021225.22890-3-digetx@gmail.com>
 <7bddacf1-5fe0-5119-48ac-6a0cc65c5af0@gmail.com>
In-Reply-To: <7bddacf1-5fe0-5119-48ac-6a0cc65c5af0@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 09:24:42 +0200
Message-ID: <CAPDyKFrGbKSx=afZCNBN_r_6iNm_TX0tZVRLK05ZUTDBGvAuyA@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] mmc: block: Add mmc_bdev_to_card() helper
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?Q?Nils_=C3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve McIntyre <steve@einval.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 May 2020 at 01:55, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 17.05.2020 05:12, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MU=
LT
> > parameter, and thus, the partition parser needs to retrieve that EXT_CS=
D
> > value from the block device.  There are also some other parts of struct
> > mmc_card that are needed for the partition parser in order to calculate
> > the eMMC offset and verify different things.  This patch introduces new
> > helper which takes block device for the input argument and returns the
> > corresponding MMC card.
> >
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/mmc/core/block.c   | 15 +++++++++++++++
> >  include/linux/mmc/blkdev.h | 13 +++++++++++++
> >  2 files changed, 28 insertions(+)
> >  create mode 100644 include/linux/mmc/blkdev.h
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index c5367e2c8487..99298e888381 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/debugfs.h>
> >
> >  #include <linux/mmc/ioctl.h>
> > +#include <linux/mmc/blkdev.h>
> >  #include <linux/mmc/card.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/mmc.h>
> > @@ -305,6 +306,20 @@ static ssize_t force_ro_store(struct device *dev, =
struct device_attribute *attr,
> >       return ret;
> >  }
> >
> > +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
> > +{
> > +     struct mmc_blk_data *md;
> > +
> > +     if (bdev->bd_disk->major !=3D MMC_BLOCK_MAJOR)
> > +             return NULL;
> > +
> > +     md =3D mmc_blk_get(bdev->bd_disk);
> > +     if (!md)
> > +             return NULL;
> > +
> > +     return md->queue.card;
> > +}
> > +
> >  static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
> >  {
> >       struct mmc_blk_data *md =3D mmc_blk_get(bdev->bd_disk);
> > diff --git a/include/linux/mmc/blkdev.h b/include/linux/mmc/blkdev.h
> > new file mode 100644
> > index 000000000000..67608c58de70
> > --- /dev/null
> > +++ b/include/linux/mmc/blkdev.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + *  linux/include/linux/mmc/blkdev.h
> > + */
> > +#ifndef LINUX_MMC_BLOCK_DEVICE_H
> > +#define LINUX_MMC_BLOCK_DEVICE_H
> > +
> > +struct block_device;
> > +struct mmc_card;
> > +
> > +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
> > +
> > +#endif /* LINUX_MMC_BLOCK_DEVICE_H */
> >
>
> Hello Ulf / Jens and everyone,

Hi Dmitry,

>
> Guys, what do you think about this change?

As I stated in an earlier reply, I am deferring the review from mmc
point of view, until I see some confirmation from Jens that he is okay
with adding a new partition format.

Otherwise I may just waste my time on reviews. I hope you understand.

Kind regards
Uffe

>
> Currently it's not allowed to compile MMC_BLOCK as a loadable kernel
> module if TEGRA_PARTITION is enabled because it depends on MMC_BLOCK
> presence. I'm curious if this situation could be improved by moving
> mmc_bdev_to_card() to linux/mmc/blkdev.h and then:
>
> 1. Moving all private mmc/core/block.c structs to the public
> linux/mmc/blkdev.h.
>
> 2. Or adding a "private opaque" pointer to a struct block_device and
> setting it to md->queue.card, for example.
>
> 3. I see that struct block_device already has some bd_private field, but
> I'm not sure whether it could be used for what I'm trying to achieve.
> Actually I don't see where bd_private is used in kernel at all.
>
> I'd like get yours feedback, thanks in advance.
