Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BE2C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiFWHWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWHWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:22:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7D4614D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:22:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cw10so15397511ejb.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wN1AweyrXk9yDL62BbHXe3TeLQ3gDlhMBDEsB2KNa4Y=;
        b=XyjZEa4aH5Wv7/frBZbn9UIr02L32x9JAzRc5yRF/0Ckfxw7SdMS4tW4H9QYffDROZ
         383IzN6kdpPytibAFU6xrxMJB6Q/vTHhIEUEeucqSGcrv7WMtb7Jy85wRRj2tJymwMln
         NVI8gyUcwAESKCLug6hq3nr3a87uLFOfpj84AuJwrgSFKoWQp/g21c0YbOa+dg6H6UKy
         xKcTWSkUQg3avKVVxCg3ArgD6C8YebtbJa+iFCtjlhPElvriK+tdTfZbNm+HkmMYcQzx
         AQmrpGXQeB4vKkNmv4BB7VXzotlQI1YWstY0YtEqLcUbg333clz0W390ODgNVP0OqpXc
         WkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wN1AweyrXk9yDL62BbHXe3TeLQ3gDlhMBDEsB2KNa4Y=;
        b=IfCUs+Zt7ceehbzBfLxxVjdssW6Faa0e1/jLFEI0PYP6X7X5udI7lXt41EOlLYy2CY
         a4eD/O1fW3AFQg9DY5bLeIFHd9XkWmGWKBzm2IMRN3Dl00Q4XHpFpmS9GfrDzX2zDCEt
         SofUt/dyITAZ959Ee+OKJ+4oL6WXjIlHZsl0cEQvu8iiew3F+apjox9ZPfoCGZj1kSIC
         YlvBK4DLfJlnLz4vZCrg6VGHi9sKLHcjf3CuXKe4U9vzz52zx6PlRz+zIf8GCFbQLMq/
         WWuMlGb9x6z4GwTCEhQWwA82v0eCuzXvydiA7tFEsj8NXv/NhNqMukA2J/Z3tAurIWZp
         TFiA==
X-Gm-Message-State: AJIora/wSBzMsqTiSF5u9ikqHI0y791k0TcKYbE3+P4kMCRc//9Kx8Xb
        ZNSHUUwIi9RY/tdI7c1NktqK/B/vA3Y17egYuzQyNQ==
X-Google-Smtp-Source: AGRyM1u9315l6sX617kbT0R1QlJGocjZrk78/y6fRl/NhAeqa5T+nkyxxCndweEYoCaK6XSeMxzOEVg1yJI9Z6lNZac=
X-Received: by 2002:a17:906:7742:b0:708:ad9f:8e88 with SMTP id
 o2-20020a170906774200b00708ad9f8e88mr6589649ejn.735.1655968940180; Thu, 23
 Jun 2022 00:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220623062116.15976-1-guoqing.jiang@linux.dev> <20220623062116.15976-9-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-9-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 23 Jun 2022 09:22:09 +0200
Message-ID: <CAMGffEnjfgZ9TCFxfjyNpfO4JF6JpruEs-Fit+BJgi7fUb1HZQ@mail.gmail.com>
Subject: Re: [PATCH V1 8/8] rnbd-clt: make rnbd_clt_change_capacity return void
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 8:22 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> No need to checking the return value, make it return void.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index c77da3d0317e..7a418c4d47e4 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -68,11 +68,11 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
>         return refcount_inc_not_zero(&dev->refcount);
>  }
>
> -static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
> +static void rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>                                     sector_t new_nsectors)
>  {
>         if (get_capacity(dev->gd) == new_nsectors)
> -               return 0;
> +               return;
>
>         /*
>          * If the size changed, we need to revalidate it
> @@ -80,7 +80,6 @@ static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>         rnbd_clt_info(dev, "Device size changed from %llu to %llu sectors\n",
>                       get_capacity(dev->gd), new_nsectors);
>         set_capacity_and_notify(dev->gd, new_nsectors);
> -       return 0;
>  }
>
>  static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
> @@ -127,7 +126,7 @@ int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, sector_t newsize)
>                 ret = -ENOENT;
>                 goto out;
>         }
> -       ret = rnbd_clt_change_capacity(dev, newsize);
> +       rnbd_clt_change_capacity(dev, newsize);
>
>  out:
>         mutex_unlock(&dev->lock);
> --
> 2.34.1
>
