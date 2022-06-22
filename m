Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EFC43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 10:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351639AbiFVK5U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348179AbiFVK5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 06:57:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F73B57B
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:57:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t5so856578eje.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=atUFvcgOFvrEbeC31B5JBEnIffc9RQ2J+sYG42p+JAk=;
        b=HdlnSPfBpaxz2dwK7lfSe6PniBCEpKeIq4q4vyY2EnE4FBgjOAKxCxziTZk9dS/d/b
         pNKMOe6zYlVZsMOmgMtuLXyTfeSD+6OFOlaLDFqlfCNam8TKemv1B2Y+uGL98L/MoTwR
         CUFFuNsAv3n0pmkj6SE40DEr2imRPKOj6i45kNMSq/hR4C7qWHcGMy3EUlovw3RJiUzU
         zixc7t7FFVgKaJGckL4mkVEYO4TkD8x3lEIRq85zMfdDsxLluVQcI6EQTW8+zeo0GZ10
         Lrc2EhHeB7EUrLV70Ay4k2gN8yTV1qU/2NkHl9XfdPgkR133AOSyvnBRvhw+OMjjG2px
         YPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atUFvcgOFvrEbeC31B5JBEnIffc9RQ2J+sYG42p+JAk=;
        b=JJQJG6nFnphg/q+oNz/ImQaBl9bnKLjeyKHfyU5nHGwDvlz6602Llf8kIyaWI09cGX
         itVdwCR2z8v7QUQxvAMHMnb9J63GOXurO8KNPP8L/P0ycGQXrtHtIl2g8KgLl4nyMJuM
         rqAzz0ZEALBC9hqHe7UP9VpTU/QF8FCJtT9kR61mosq9YZuYp83c/hLrzREOgoagXkys
         Jl18EDE+tHsg1RDJzRa58D4rwuPsm/h8eh8aADkJbAa8VTncB0SUY1Z9huvAg5Jhnz6/
         6sNGJFmjTqj08JGPk0oh1S2GCeOy8kSxb6GIXRzCwoGDMU5FYWE01LNqpYca8U6g5iMu
         V/Xg==
X-Gm-Message-State: AJIora9t7xZX+GjAYiMmLSRY35s3yapNYlbNeyblsUafS61wMCIe5toM
        iIgjVXFAJUmLoXsZqROHiwU2OqCasXNmNDmIkq8mVw==
X-Google-Smtp-Source: AGRyM1u2ufBD0Hm8vqF9HPHkZtZCdWE8OJDa23axI3/je277pFNcCVetgT963p0Q9KEFkt01ApYjceEp5MhJzeKf4BE=
X-Received: by 2002:a17:906:77c8:b0:722:e753:fbbe with SMTP id
 m8-20020a17090677c800b00722e753fbbemr2626489ejn.692.1655895437456; Wed, 22
 Jun 2022 03:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220620034923.35633-1-guoqing.jiang@linux.dev> <20220620034923.35633-7-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-7-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 22 Jun 2022 12:57:06 +0200
Message-ID: <CAMGffE=N2hAvBQB_kt1ZcnqNBg7SHxZ=3jquR0fogatoad6WKA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] rnbd-clt: refactor rnbd_clt_change_capacity
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 5:50 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> 1. process_msg_open_rsp checks if capacity changed or not before call
> rnbd_clt_change_capacity while the checking also make sense for
> rnbd_clt_resize_dev_store, let's move the checking into the function.
>
> 2. change the parameter type to 'sector_t' then we don't need to cast
> it from rnbd_clt_resize_dev_store, and update rnbd_clt_resize_disk too.
>
> 3. no need to checking the return value, make it return void.
>
better to split this into 3 patches.
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c |  2 +-
>  drivers/block/rnbd/rnbd-clt.c       | 24 ++++++++++++------------
>  drivers/block/rnbd/rnbd-clt.h       |  2 +-
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
> index 2be5d87a3ca6..e7c7d9a68168 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -376,7 +376,7 @@ static ssize_t rnbd_clt_resize_dev_store(struct kobject *kobj,
>         if (ret)
>                 return ret;
>
> -       ret = rnbd_clt_resize_disk(dev, (size_t)sectors);
> +       ret = rnbd_clt_resize_disk(dev, sectors);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 2c63cd5ac09d..6c6c4ba3d41d 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -68,13 +68,18 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
>         return refcount_inc_not_zero(&dev->refcount);
>  }
>
> -static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
> -                                   size_t new_nsectors)
> +static void rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
> +                                    sector_t new_nsectors)
>  {
> -       rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\n",
> +       if (get_capacity(dev->gd) != new_nsectors)
> +               return;
This change is broken, it leads to resize no longer work, should be "=="
> +
> +       /*
> +        * If the size changed, we need to revalidate it
> +        */
> +       rnbd_clt_info(dev, "Device size changed from %llu to %llu sectors\n",
>                       get_capacity(dev->gd), new_nsectors);
>         set_capacity_and_notify(dev->gd, new_nsectors);
> -       return 0;
>  }
>
>  static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
> @@ -93,12 +98,7 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
>         if (dev->dev_state == DEV_STATE_MAPPED_DISCONNECTED) {
>                 u64 nsectors = le64_to_cpu(rsp->nsectors);
>
> -               /*
> -                * If the device was remapped and the size changed in the
> -                * meantime we need to revalidate it
> -                */
> -               if (get_capacity(dev->gd) != nsectors)
> -                       rnbd_clt_change_capacity(dev, nsectors);
> +               rnbd_clt_change_capacity(dev, nsectors);
>                 gd_kobj = &disk_to_dev(dev->gd)->kobj;
>                 kobject_uevent(gd_kobj, KOBJ_ONLINE);
>                 rnbd_clt_info(dev, "Device online, device remapped successfully\n");
> @@ -116,7 +116,7 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
>         return err;
>  }
>
> -int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize)
> +int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, sector_t newsize)
>  {
>         int ret = 0;
>
> @@ -126,7 +126,7 @@ int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize)
>                 ret = -ENOENT;
>                 goto out;
>         }
> -       ret = rnbd_clt_change_capacity(dev, newsize);
> +       rnbd_clt_change_capacity(dev, newsize);
>
>  out:
>         mutex_unlock(&dev->lock);
> diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
> index df237d2ea0d9..a48e040abe63 100644
> --- a/drivers/block/rnbd/rnbd-clt.h
> +++ b/drivers/block/rnbd/rnbd-clt.h
> @@ -138,7 +138,7 @@ int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
>                            const struct attribute *sysfs_self);
>
>  int rnbd_clt_remap_device(struct rnbd_clt_dev *dev);
> -int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize);
> +int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, sector_t newsize);
>
>  /* rnbd-clt-sysfs.c */
>
> --
> 2.34.1
>
