Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53140C43465
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0DE21D43
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 08:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="JXeByUkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIRISj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Sep 2020 04:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgIRISj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 04:18:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA84C061756
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2020 01:18:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so6990017ejb.1
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2020 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0cOuj0tyTgGzllb+rK+TK1g8Ercqsw8ImNlq73xmLCc=;
        b=JXeByUkwnBkyD2bWF4IYm7XAKW3prSqWTC7zlC5UjdKQq71KARjqXm7kqA7PE1so1a
         aCw668UG867Nk86rHr2JDraUCR45YFjfIf1Wxl6YFwi1ld9pML8CO6BtTVsEu0srzPcS
         7C+iR4EVIW5wMPAgbeEPskGxN61FKfbr743jJMhD8sFBsNiMqCC4cH1dYZ+mo/wdl90w
         UiO+2kCCkhH76z40BVpf9yRdIdMnjP4wJun9Yiox5OGGQ/dKafI9bXDZ3t/pRorWmj07
         9otx9HTgVq0KHLDbeUFTHM+uUlWKJ8dxGAxRamDiE6TFJXKSS8TVu9kkSx0eigqXkK9G
         2jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cOuj0tyTgGzllb+rK+TK1g8Ercqsw8ImNlq73xmLCc=;
        b=jNRaSZfWM2+J68Ig6rZIfEoB5YRbPSV1m1gP4zlBaZzBkDWv245HxJg2w5mVvVpZm8
         F74V/exWb8scqDIqT4M2rtuSd3M1NifYCPNaMr6eMorrRbXxbOVjA5i82wRnDmwjCqfH
         YiJW0xcqqo5fhe1RiYALuWwydLwRrH0zKZp60X+J7/JSTvYsCMPePII8UQ3ikTG2vCyY
         pVibw5ludBwEuy0X/ZeF0d7CohL/xXdZ7cUU+ySk7UE1MLEOjEmjFpyZHPk+fGynH98S
         L7hiUOiZW4+54gMSWM8avdruJi2DQlzjxttux12tFVMXKaeDwL9aqUULqzn/3jfZJdBy
         hL4A==
X-Gm-Message-State: AOAM533i/JFU5MKF3Umeu7+VB1O9bRibDIm2+YCdgxIVKFM/Tvh+UnNX
        SDSSLINtvCsNYYS985WOYjdD21nZIXCyc0XZ0tePESAE4T9a0Q==
X-Google-Smtp-Source: ABdhPJw6VWUK5Pg/GCbLk8kKltR4keE7ppDBjX/WCZZE3i9DqdLelttt012uN0GzqbM2e/Giw1EQ7XrOOU2yTjmSkyc=
X-Received: by 2002:a17:906:dbf5:: with SMTP id yd21mr33923911ejb.521.1600417117347;
 Fri, 18 Sep 2020 01:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200918072356.10331-1-gi-oh.kim@clous.ionos.com>
In-Reply-To: <20200918072356.10331-1-gi-oh.kim@clous.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 18 Sep 2020 10:18:26 +0200
Message-ID: <CAMGffEn79RE=JbTPR0AzW+3EZO0MwemwTLwkc-LTnK8f06dKWA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: send_msg_close if any error occurs after send_msg_open
To:     Gioh Kim <gi-oh.kim@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 18, 2020 at 9:24 AM Gioh Kim <gi-oh.kim@cloud.ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> After send_msg_open is done, send_msg_close should be done
> if any error occurs and it is necessary to recover
> what has been done.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Looks good to me!
Thanks!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index cc6a4e2587ae..4a24603d5224 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1520,7 +1520,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>                               "map_device: Failed to configure device, err: %d\n",
>                               ret);
>                 mutex_unlock(&dev->lock);
> -               goto del_dev;
> +               goto send_close;
>         }
>
>         rnbd_clt_info(dev,
> @@ -1539,6 +1539,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>
>         return dev;
>
> +send_close:
> +       send_msg_close(dev, dev->device_id, WAIT);
>  del_dev:
>         delete_dev(dev);
>  put_dev:
> --
> 2.20.1
>
