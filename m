Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB6C35E07
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A382084E
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuGnhr4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgBYOxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:53:44 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46365 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbgBYOxn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 09:53:43 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so8135390vso.13
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 06:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWz4wDeiQ+dMtZmMMfMTReHPvDQ7FFlWV1iEIBtaea4=;
        b=SuGnhr4P2blA3x8jlYXg1G0+xqxyloO0I0ugkiAJtHLnx4kXvSifw31EVLq2SK/Imy
         2hdmZhH8m1eQGZW9mUMi4W4fNCztO2ho0S0dXBRKKuz1bPMbFwzhCknrSFHgSOQTc42a
         T5drEFsRvR+NK8V85+HGQ7XeEvAZCym6MS+YPy04fHNBycaAbC3Mzvv6OB0fzvM0da5G
         rIp9QLeu1itsiEtR6gwAZl7hjMp7rK9J17wzW8x+X+Q7Luefyys7cJ1To6wCCPLri6pU
         rHeEaeQNrzcYAyx+IVw9GojNBe/mkc1PMKz0Hjff0SLKcio+KAmnAefTm5bJwBRVYT91
         HW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWz4wDeiQ+dMtZmMMfMTReHPvDQ7FFlWV1iEIBtaea4=;
        b=s+EKhw8qF5vtvH1UE9wm1TwpaU7o4sV2XxGV1OMgbL5cAXyc/LQjkHW1P39GTQwV5Z
         0K8mXMdXm2/XHU46yETbtz7eMCfpSLGOYzxqCw8ztWlGKptWKZjXPCfZX4kpi4C8eKaQ
         67247RkM52I4nyd15nNs1MQvVXssjlfaIkrwKWt+JEv0nMtu2wzx+CTX5BZt/ew+jv8/
         B2y0LrkQrh7BltjdnX9NmDfd0KhhTV50M4hn9406Qj7BSvs3AaMD0jWB04QWSe/45V2D
         J0gFk152AOWCSa/7z2Xvmi3tNNO0EHq2vi2+m+tJfnUKCaaRANG1bnAGQFnQ/x74IJlT
         J4wg==
X-Gm-Message-State: APjAAAXsKe9nHdGUBg7Ejhp6Hhi+Vt34syYHgku2QfUOEprYxo6qxge5
        bOngZ2wtPETPWk/3gosdasIhuzXjXFs36C+aXdxkng==
X-Google-Smtp-Source: APXvYqzlsHIb9YP3hCpfGA3Rdvg18zkDRP+rQoidSvkbh7QnCla2LkAkAEyvsQqyTzNbdgy/e8+g60oi0oH2Qq7EHJk=
X-Received: by 2002:a05:6102:757:: with SMTP id v23mr30298970vsg.35.1582642420792;
 Tue, 25 Feb 2020 06:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20200224231841.26550-1-digetx@gmail.com> <20200224231841.26550-3-digetx@gmail.com>
In-Reply-To: <20200224231841.26550-3-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Feb 2020 15:53:04 +0100
Message-ID: <CAPDyKFoSwjkOX85jjA-Q-ScdC0aUozroOu3_-FO4yBE8pgtCow@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mmc: block: Add mmc_bdev_to_card() helper
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
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 25 Feb 2020 at 00:22, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
> parameter, and thus, the partition parser needs to retrieve that EXT_CSD
> value from the block device. This patch introduces new helper which takes
> block device for the input argument and returns corresponding MMC card.

Rather than returning the card, why not return the value you are
looking for instead? That sound more straightforward, but also allows
mmc core code to stay closer to the mmc core.

Kind regards
Uffe

>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/core/block.c | 14 ++++++++++++++
>  include/linux/mmc/card.h |  3 +++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 663d87924e5e..5d853450c764 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -301,6 +301,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
>         return ret;
>  }
>
> +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
> +{
> +       struct mmc_blk_data *md;
> +
> +       if (bdev->bd_disk->major != MMC_BLOCK_MAJOR)
> +               return NULL;
> +
> +       md = mmc_blk_get(bdev->bd_disk);
> +       if (!md)
> +               return NULL;
> +
> +       return md->queue.card;
> +}
> +
>  static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>  {
>         struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 90b1d83ce675..daccb0cc25f8 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -7,6 +7,7 @@
>  #ifndef LINUX_MMC_CARD_H
>  #define LINUX_MMC_CARD_H
>
> +#include <linux/blkdev.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>
> @@ -324,4 +325,6 @@ bool mmc_card_is_blockaddr(struct mmc_card *card);
>  #define mmc_card_sd(c)         ((c)->type == MMC_TYPE_SD)
>  #define mmc_card_sdio(c)       ((c)->type == MMC_TYPE_SDIO)
>
> +struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
> +
>  #endif /* LINUX_MMC_CARD_H */
> --
> 2.24.0
>
