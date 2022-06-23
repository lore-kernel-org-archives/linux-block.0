Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95BCC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiFWHVp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWHVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:21:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFBC4614D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:21:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z7so27175651edm.13
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeA4WlitdwoXoktociM5uJmUK9Kz7JdC6QnTurz9y10=;
        b=TcEKrVBRFKYIA3VIOOO+mp53GzRkckqmV90ywsT4sUQ4FpZki5kXdsUwqALow+pHBP
         awEsYciTPoyFkzxL+45QS8hOmy9JL995Jw0qGnOe+kE6VsbX0plaVuri1oBl5xKGgMig
         Jc16c2mwFA7agYohYEfm4i+FKBqzgY3mVGVM/UbyHvVXv+D2XWL/OYo9jnu33Wevp8wX
         HDAtTuYfR3DMDzB7zaRb3O+O7hZwVHosUi0XCrGjBnGV14DyTe89MK3O7omgxJeGJsis
         uG0xyZ4ng0sC1kblb2zTRrp8SG2BBr2LtKYbo/RxAwxN8E2tnIhONe4YpfcTbUCMqwH3
         MPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeA4WlitdwoXoktociM5uJmUK9Kz7JdC6QnTurz9y10=;
        b=7rzZhKzH3p3yzW8uXeQnfl9p9vvz3mf/pyOYXF/1UWA4SG5qrf6o+XMxBUgxiMOKYM
         nnToKmgm+ffE5MKQ7zDo6PwRnf5Y/uQp/j4zmF9cgxZo2SXCGa/NLs6UmRSYnt0XupZH
         +U2XsAwg+u9PcRUiVrxNloWHiXSV0e1frzYeyLUrZi6Jz7BBhH2dLCODvc4LtA7CKjPk
         UHRoiCmMS875G1Hgm+4Gu1e0+WBReEbUqlXdrtuJyX0XnZiQG9Ubn+Wu62cD/SCrx+oQ
         tUA811gpx/tshQk45UPSZ729TjfvPJZtt3uCyeEkSEpQBSdHWOiLh9SW2pH4ad/4zDzs
         QoAQ==
X-Gm-Message-State: AJIora8XeDGMDRQRpTAx5r4x1Bisf84x8sZsnZ2akZssLYTKN84hUU/Y
        GfeIWqCJPLmJKWB4xIXQIxRCv7wSbhfEyvWt12EwOw==
X-Google-Smtp-Source: AGRyM1uez/z77ahZC1di2hYtFRqgYIDJmatgt1vK9A8LC2Lhdqi9bJZncN8uHPpOVknE1DmhumpR5JrI5mAfX59uELA=
X-Received: by 2002:a05:6402:1249:b0:435:5e0c:20ac with SMTP id
 l9-20020a056402124900b004355e0c20acmr8796785edw.100.1655968900969; Thu, 23
 Jun 2022 00:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220623062116.15976-1-guoqing.jiang@linux.dev> <20220623062116.15976-8-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-8-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 23 Jun 2022 09:21:30 +0200
Message-ID: <CAMGffE=gbqM2VYhbypmf3vKspZKFvGst_sdGBLELOJX4ykT7pw@mail.gmail.com>
Subject: Re: [PATCH V1 7/8] rnbd-clt: pass sector_t type for resize capacity
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 8:22 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Let's change the parameter type to 'sector_t' then we don't need to cast
> it from rnbd_clt_resize_dev_store, and update rnbd_clt_resize_disk too.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
>  drivers/block/rnbd/rnbd-clt.c       | 6 +++---
>  drivers/block/rnbd/rnbd-clt.h       | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
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
> index a9bfab53bbf7..c77da3d0317e 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -69,7 +69,7 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
>  }
>
>  static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
> -                                   size_t new_nsectors)
> +                                   sector_t new_nsectors)
>  {
>         if (get_capacity(dev->gd) == new_nsectors)
>                 return 0;
> @@ -77,7 +77,7 @@ static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>         /*
>          * If the size changed, we need to revalidate it
>          */
> -       rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\n",
> +       rnbd_clt_info(dev, "Device size changed from %llu to %llu sectors\n",
>                       get_capacity(dev->gd), new_nsectors);
>         set_capacity_and_notify(dev->gd, new_nsectors);
>         return 0;
> @@ -117,7 +117,7 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
>         return err;
>  }
>
> -int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize)
> +int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, sector_t newsize)
>  {
>         int ret = 0;
>
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
