Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9122BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A54207D3
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 09:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="IEF7FAI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgESJh2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgESJh2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 05:37:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A4EC061A0C
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 02:37:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l17so15103018wrr.4
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5m5JovpW4KqrVfnLRe5gitpajPe9wGwEXNUrXvNPEs=;
        b=IEF7FAI6x1I3Lf7An67lAfZUK20DO9GSTzsH62JauPTM8I6kmBTDUXYz54dRkY8UHh
         f97QULm66kPRjIwzh5pyDNSWClz1/1sZHBrwQJie5L+camhGSiZ4w3IZDOmPCdgmmCV5
         hZQyuRQ7ZhiOfftaTPLfwrieP/EOSDpM4MrMcCU/V0SuK2rMyFNQ+QC30Z7yZqGfH336
         uHNljLNThGwUeXSokRyyK2LV8bG3NfJ1njhQ4WQQVhF9k7QmobkhLcMo6wcDSOCovLq0
         Jn22LbPem5fxoegbZxNxlk0D5c2WnnMcCPxk8H/xgDv+WrbFBwjuIGNZYTmZDu16nT+a
         QdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5m5JovpW4KqrVfnLRe5gitpajPe9wGwEXNUrXvNPEs=;
        b=tcRmK2YQvagS+P7dkLXrcN+TtS1mbN3Xg5Pk96Zz5ntTmR8Gqkd/5YjdSBKpgbr5jv
         Yy2Rn06X1qkW4YHGKCEq8Gv7Nbpz8yZJSNDMROwSVBv2wL+R6wBCnlVLm6QT6h4zKEF5
         gcCp7Q2ts44MM2o+ooE0bFnxgGWMYPAJEXB1o8Cn82N+I2C4xN4XorvCufMSZ/N5B9z/
         Zk0eUNhZZmr58oOktQkyb4fuTW9T+kuV/vwEocTJYnhmcN1y103Pf6PrVqf0yX0Yvwdi
         cVIu821VymX4N77Nb9DyRJaYROFnpj4GnZlDZ5/PzqYgpVWTw181FuS33Qe8F6aPiBlY
         UhCw==
X-Gm-Message-State: AOAM531Q8Z7p1dU0XvSE1hwxefIWpHNwPqek1/1Jjs1AV2jpAqiQ0Zw4
        PvLA3E+rDwgRhVQ9iT8kXb4v3jHpBz2ydplr9sUo
X-Google-Smtp-Source: ABdhPJyH2+DPmDhPeyW8f0tviX0MVkoaEzS87+oz2jYAkQdvB9/HgdGl9oCjG+bniDmpmB4wQoHITcxjzMtQhJjLrIo=
X-Received: by 2002:adf:cc81:: with SMTP id p1mr23625980wrj.192.1589881047033;
 Tue, 19 May 2020 02:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200519091924.134494-1-weiyongjun1@huawei.com>
In-Reply-To: <20200519091924.134494-1-weiyongjun1@huawei.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 19 May 2020 11:37:16 +0200
Message-ID: <CAHg0Huwq6yRX7x8-A8uZ_NqCib03wZ1fGwaAN2q=6e-tR=sozA@mail.gmail.com>
Subject: Re: [PATCH -next] block/rnbd: server: fix error return code in rnbd_srv_create_dev_sysfs()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 11:16 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fix to return negative error code -ENOMEM from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: 8cee532f469b ("block/rnbd: server: sysfs interface functions")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/block/rnbd/rnbd-srv-sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
> index 106775c074d1..5ba1a31ad626 100644
> --- a/drivers/block/rnbd/rnbd-srv-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -52,8 +52,10 @@ int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
>
>         dev->dev_sessions_kobj = kobject_create_and_add("sessions",
>                                                         &dev->dev_kobj);
> -       if (!dev->dev_sessions_kobj)
> +       if (!dev->dev_sessions_kobj) {
> +               ret = -ENOMEM;
>                 goto put_dev_kobj;
> +       }
>
>         bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
>         ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
>

Right, thanks you.
Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
