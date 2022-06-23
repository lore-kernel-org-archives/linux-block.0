Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E650C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiFWHU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiFWHUV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:20:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E94615D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:20:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e2so16268196edv.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9n8dWAkPONYR4qOZyO/F0+9bLbexCmrnFGFIthi2GzY=;
        b=amgWEbOm74LoYyS5RhPLzQG30LZVrXilN4+pxHZoIeJuS+HmIAhBI0tH5ErpYYD2Bk
         levUEyD0FMzlngpxvIifcqBhd2mfrjeMkfKEbWTDxvTF8FURHx72wrNGbc5OP/b6tpXW
         /7yVIEK4xnFMTCZeVxSEiPr28yO31+GqJKtkFNt/4M9GrRg4X4Lz3iqevxgi8QSdx1Es
         txicYsduagkLyCvm2tFOK4EQHbJXe+6TpQpA8wERl1O9JuEFDiR4Xmgz3CRfXzhc5a1z
         hfqFfzcc2uP6dYzxCz3WaTgm1z7aea8lXpMLRK3tyEZa0sbuPerkh/ssDKr9RzpWXtdN
         4Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9n8dWAkPONYR4qOZyO/F0+9bLbexCmrnFGFIthi2GzY=;
        b=bbbpM4wM7On7gHj8HpoOwjBnWlloyXH0l5yiTIxMOwD3fs4eLRIqpGPLvCwRghVw1m
         Ju1LxXtcjV4FtP7F7QvN3A+SHuAG1Zbl4QrKkrTrJyN7Hvya1n5YflLKzW5YPrhGP/Vq
         Ox6FomN331aapK8A9uVUOMzZkCznYGM5V9raWELv12bp7MRC5lR25DOXXMagBZwOzYh3
         0OxL5gqVf+aeP1vlZrwE1EUwrTskPPsi6D8BbWn41EnhxQXiG75QcieDiAxCFcbdIS62
         xBdbRQPAyPAdS4Nv4NDoELg4fBZ78jfNOYd9bqnn6OcE+xkYlx8aVP20mZPFQYBqkU9P
         wAKA==
X-Gm-Message-State: AJIora/dDS2BznSc4+sioCM/lIJSwyyTJ/sAGWD+sYgH0sxWAuC1Pszy
        oM7E/fOk/lP7Hz/eXsiIXmZFUGKWw7CM0/IcDTFtRQ==
X-Google-Smtp-Source: AGRyM1vtZEXFvolGG1jT0IjK+SZlJ7yAThBH1NuOEK546ughggx7LwzKVlPzQI3nfKi9qWEZUzmNOncP7OXzaWh4rYo=
X-Received: by 2002:a05:6402:42d5:b0:433:1727:b31c with SMTP id
 i21-20020a05640242d500b004331727b31cmr8849484edc.9.1655968819022; Thu, 23 Jun
 2022 00:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220623062116.15976-1-guoqing.jiang@linux.dev> <20220623062116.15976-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-2-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 23 Jun 2022 09:20:08 +0200
Message-ID: <CAMGffE=xzE86vuju4mpJtETMF1B-aC=K2Kn6VtN94ZCFKbU_Mw@mail.gmail.com>
Subject: Re: [PATCH V1 1/8] rnbd-clt: open code send_msg_open in rnbd_clt_map_device
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 8:21 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Let's open code it in rnbd_clt_map_device, then we can use information
> from rsp to setup gendisk and request_queue in next commits. After that,
> we can remove some members (wc, fua and max_hw_sectors etc) from struct
> rnbd_clt_dev.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 43 +++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 409c76b81aed..9e9aeba86d33 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1562,7 +1562,14 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>  {
>         struct rnbd_clt_session *sess;
>         struct rnbd_clt_dev *dev;
> -       int ret;
> +       int ret, errno;
> +       struct rnbd_msg_open_rsp *rsp;
> +       struct rnbd_msg_open msg;
> +       struct rnbd_iu *iu;
> +       struct kvec vec = {
> +               .iov_base = &msg,
> +               .iov_len  = sizeof(msg)
> +       };
>
>         if (exists_devpath(pathname, sessname))
>                 return ERR_PTR(-EEXIST);
> @@ -1582,7 +1589,39 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>                 ret = -EEXIST;
>                 goto put_dev;
>         }
> -       ret = send_msg_open(dev, RTRS_PERMIT_WAIT);
> +
> +       rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
> +       if (!rsp) {
> +               ret = -ENOMEM;
> +               goto del_dev;
> +       }
> +
> +       iu = rnbd_get_iu(sess, RTRS_ADMIN_CON, RTRS_PERMIT_WAIT);
> +       if (!iu) {
> +               ret = -ENOMEM;
> +               kfree(rsp);
> +               goto del_dev;
> +       }
> +       iu->buf = rsp;
> +       iu->dev = dev;
> +       sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
> +
> +       msg.hdr.type    = cpu_to_le16(RNBD_MSG_OPEN);
> +       msg.access_mode = dev->access_mode;
> +       strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
> +
> +       WARN_ON(!rnbd_clt_get_dev(dev));
> +       ret = send_usr_msg(sess->rtrs, READ, iu,
> +                          &vec, sizeof(*rsp), iu->sgt.sgl, 1,
> +                          msg_open_conf, &errno, RTRS_PERMIT_WAIT);
> +       if (ret) {
> +               rnbd_clt_put_dev(dev);
> +               rnbd_put_iu(sess, iu);
> +               kfree(rsp);
> +       } else {
> +               ret = errno;
> +       }
> +       rnbd_put_iu(sess, iu);
>         if (ret) {
>                 rnbd_clt_err(dev,
>                               "map_device: failed, can't open remote device, err: %d\n",
> --
> 2.34.1
>
