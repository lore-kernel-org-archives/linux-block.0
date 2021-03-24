Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED2C433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 10:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8876361A07
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 10:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhCXKel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbhCXKe0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 06:34:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9CEC0613DE
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 03:34:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y6so27047229eds.1
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbhw/ZDmJTjBytyPJI4UoxBWXtQ1ngIRpvlPehMK2p8=;
        b=K5eF6tArEz7YZ2z0SVz1j+SY3aWkpkm/lMhGoxxmkXIldsJwPb5kfAzOSN0zkPVgwE
         xq+o94WZliHVWgIsTUQY8P6nSgPdrIumCDyXVJd8Ledi0nEjytIuL05OvkIS+wi6C+dx
         uyu5K/7mJsQrZNNyiR2L3gCLKKfHRrykP00+GgjWrhqYm0LyY4iYvUJZ50y/pyReWft7
         MqyjC1I8FU2kdmepFT5TA6QTL1nd1MLkaHElSY9uexyV1WRz2w6YgSJbq3oyWtNRF/OO
         f859NY9Xx9u6gRS/WJd0PGyrbdCxM0q3Sn5uu/nHScF63Esgw/e8CtvIEmX391Z7Cgv6
         ltQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbhw/ZDmJTjBytyPJI4UoxBWXtQ1ngIRpvlPehMK2p8=;
        b=FxC/9qieAi0OKthqrIi7YDu6jEZQzU3hp19GwcT615klbhjnjKWTZIRFn/CbMO9OYD
         MewHypai0SE3DoER4QJcE8iCunXdtqSn2xJK6uEoa9nFp4hSkYeq3cD412t79Vf9HESI
         tDCCAYG0FXnaHJty6SwKvpQglNmwQNNGNBibvt7dsqSiKd4QW6+A1oDEJVBTOJ2dyMYp
         Mp1IH3ir1wdkcW4wGgPJ3qQqoBBTaK1LzgCXmNKp28CwDcNppawupBCSXaGV7SXfDUVG
         dTq/DTRs2uV1DygJrt8gwCUN4IS8zTiC2LrfpoeWE3i/7a5STG58WwEZ34s44G3UkRFS
         ohTg==
X-Gm-Message-State: AOAM533qkg9kSXXDOiP6GpCzpIeG1SitfmYsvE+/EcwKVjlarF3DOQLa
        ypjt+a6nOHChHfa9du3fcUgQiZgMcN8W0AyslO7b7g==
X-Google-Smtp-Source: ABdhPJzd+cqvYyBPZHJeB8/Vy81pM52Ij0bfN/tp45Qzn+7LGL6qmwPViYVX7+JE7pz+I6/Hr+AfwXfKBsXlE5DyyxY=
X-Received: by 2002:a50:f38f:: with SMTP id g15mr2652251edm.262.1616582059297;
 Wed, 24 Mar 2021 03:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210323125535.1866249-1-arnd@kernel.org>
In-Reply-To: <20210323125535.1866249-1-arnd@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 Mar 2021 11:34:08 +0100
Message-ID: <CAMGffE=XZ_5ibx2jMxC_kLLKSLmV882XGk6yHAc2B4y2VRvTrw@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-clt: fix overlapping snprintf arguments
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 1:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The -Wrestrict warning (disabled by default) points out undefined
> behavior calling snprintf():
>
> drivers/block/rnbd/rnbd-clt-sysfs.c: In function 'rnbd_clt_get_path_name':
> drivers/block/rnbd/rnbd-clt-sysfs.c:486:8: error: 'snprintf' argument 4 overlaps destination object 'buf' [-Werror=restrict]
>   486 |  ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
>       |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/rnbd/rnbd-clt-sysfs.c:472:67: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>   472 | static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
>       |                                                             ~~~~~~^~~
>
> This can be simplified by using a single snprintf() to print the
> whole buffer, avoiding the undefined behavior.
>
> Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices with the same name from different servers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
> index d4aa6bfc9555..38251b749664 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -479,11 +479,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
>         while ((s = strchr(pathname, '/')))
>                 s[0] = '!';
>
> -       ret = snprintf(buf, len, "%s", pathname);
> -       if (ret >= len)
> -               return -ENAMETOOLONG;
> -
> -       ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
> +       ret = snprintf(buf, len, "%s@%s", pathname, dev->sess->sessname);
>         if (ret >= len)
>                 return -ENAMETOOLONG;
>
> --
> 2.29.2
>
Thanks Arnd, We have a same patch will send out soon as part of a
bigger patchset.
