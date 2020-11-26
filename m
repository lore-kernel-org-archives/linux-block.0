Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBAC64E75
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 14:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863692224A
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 14:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="D1LbUTmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389847AbgKZOEo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 09:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389606AbgKZOEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 09:04:42 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1C4C0617A7
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 06:04:41 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id u19so1078386edx.2
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2msFitdz7jneyi5nHmujXpbaLFZfcSY4FLaJaH2640k=;
        b=D1LbUTmPTvKUgRmGIV/rJfCW0JlkVcwSY4SyBOipgdzYjUKMiOTSf8irLD4IA8Ym9n
         qfZlNZm8eUzJuFd//Swf+63RvVTsiDA9WnIfFXium5KpySlYdiwpvovai1mydjKR6ZM8
         ly6NiQzxpYPweX4AoYLMbCyqikWGG5/VALPox3MxPiDzuIsyEqEJd8NCWcamyRPzFp/i
         ICV0TU/mX7bFeImElF0Ax7JdPQpoDGEclt0eIIyuAkMZa6+zLvoHwxIwTf02Lfr4V2ys
         QTovNLhRVJjAv4Lo6AFZr99zsmGzQxvGSc9kHbWyV2OzrFCr+94Wn4eDEFncRbRJxH1O
         PLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2msFitdz7jneyi5nHmujXpbaLFZfcSY4FLaJaH2640k=;
        b=IbR3JKEBrV+mV9ksUUFCHKvWKiMpRpuWJuGd1y+fkrhPxLvo9jvq1PO7kiSkPgQjxI
         fA+pJWsl7zB+PjYnKKq9Y415/cdJnhj2556lAyDhnxxlttOQ/pGd8S3IhxEiTxdKjMpO
         t3B0fYVKRM+McfK2Tb/A9kpUOkpXrcRfL2I/w+nnvVjC44FYoLC6AkX4XlczDop+trpN
         nA//4TwZLEY9T/aS0ZgcRm9N5YwnkZSVFrwsWTSEEoE0kNAMywWtN4S8ErD4NHC+1t7F
         SX8pNgu7rpQuOcAhLR0/+0Q2rI46cSh8n0oKPPw7HpXdNjgllGlOgm1ZIyL50x3XAbeV
         IkXw==
X-Gm-Message-State: AOAM532meSxWd3H5VT1aVpBdh7oQhLovOp/AJ50kg79rgH/qFKDfhmiP
        fqzC6ljtP0E+XRSDw0bwpEunqwfasOCPB05LRmYQ8A==
X-Google-Smtp-Source: ABdhPJxHwAF6TBjrA3BlhhsXGld+74AMCQCcrgzWOJcVzqJ3JM1iGXjxUIPi+TT0f2Oi5VMsdhtV0xl6k++BTrDYNYc=
X-Received: by 2002:a50:c30d:: with SMTP id a13mr2658012edb.89.1606399479885;
 Thu, 26 Nov 2020 06:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20201125124647.30327-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20201125124647.30327-1-bobo.shaobowang@huawei.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 26 Nov 2020 15:04:29 +0100
Message-ID: <CAMGffEn--=SspdwND785Y7CcxFZhnf_6f86F50wPgSJUbtuEzA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: server: Fix error return code in rnbd_srv_create_dev_sysfs()
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        cj.chengjian@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 25, 2020 at 1:47 PM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Fix to return -ENOMEM error code from the error handling case where
> kobject_create_and_add() failed instead of 0 in rnbd_srv_create_dev_sysfs(),
> as done elsewhere in this function.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Thanks Shaobo, we have a fix for more cases:
https://lore.kernel.org/linux-block/20201126104723.150674-8-jinpu.wang@cloud.ionos.com/T/#u
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
> --
> 2.17.1
>
