Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D139C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiFWHU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWHU4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:20:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729245AFB
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:20:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ay16so19759124ejb.6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycA/WnTh3/ADN2YY5V61t9U1nxvBTz6zvuIq7PfwWX4=;
        b=Dv9QzrvWijckOHORuQwyjtLLJdyScOUqXZvbm/hksyMSU03P2oQiskw8GPLGrBUvuX
         wHuzhlknygLE5JW+lKQB6dQ/Ak2gs4zlzYvi3I77IKy73GRAP32cQt1DtNsSEg0mU7W/
         nB7Q+kEleE3AAlaE/vtf56zhdlmsIhnYFJNj6bLdTSQEkgKLhL6gY6joplFKrv1nBt0y
         8UOZERVscDKPznYJV67AOvuAEIpEmaLqDyOSxa90YNWRwGzWYDMp7mTGPRhQNsqFZNXP
         dSjQm1ED31OUQEW3JIGUDF/v36L3BcTnRgxzMOaAEM4kqiWW9Ax0j0JI3yxTvaPWECls
         rM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycA/WnTh3/ADN2YY5V61t9U1nxvBTz6zvuIq7PfwWX4=;
        b=WdzOiQKYyQblBqLj/yZ3J2ZzmqTJGSHN+fw3zJKclEDKimjQZkxtR2Qv6j8gbbl8dW
         sKlccvczodKoNXVJMm5DsAabo0EsDtJdlLlSlzTo74303dEbIo5KNTAuiCmghiwnVawg
         1FeY7xgJz58eY31W+rpmX0x4ED19gaxglxuW3bq9sodxCNujxDXYU1os5uOMoCOzCrA7
         x0bY1XFrUJKWtdRngFxWDjjme9JBTpaKalgG7IswTMz46CRoPPfCZFT1EpPW5pkuV6IN
         Cg1y8jSp7vcQIrjQFl0Cu9Ki2brRicuAtIxq54CI5rzXxBKLG84UZu7MSac4zBBNqPNM
         ZCVA==
X-Gm-Message-State: AJIora/mqzUmd5ZvdJvRVO1T9XNe+7d5jNZhTYxzo4WkBLHpZ8uRdR+w
        lUoLF4V9HvWsnfcsUYDfwv/mRoAd9x6NWfDfAuZ9tA==
X-Google-Smtp-Source: AGRyM1u/th4RrEL22BcBwqyQjUBazuHhg02xA9aSziNz58L295fC9Y3GuUaDZmUgwQ5N49LSer0ydzPCYu0X5K9VP5Q=
X-Received: by 2002:a17:907:7da5:b0:711:c9cd:61e0 with SMTP id
 oz37-20020a1709077da500b00711c9cd61e0mr6938713ejc.443.1655968853940; Thu, 23
 Jun 2022 00:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220623062116.15976-1-guoqing.jiang@linux.dev> <20220623062116.15976-7-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-7-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 23 Jun 2022 09:20:43 +0200
Message-ID: <CAMGffEnFbdPWaBzW6htXkH1F6yudPBioAJK_58nNFT-Ln1-SHw@mail.gmail.com>
Subject: Re: [PATCH V1 6/8] rnbd-clt: check capacity inside rnbd_clt_change_capacity
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 8:22 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Currently, process_msg_open_rsp checks if capacity changed or not before
> call rnbd_clt_change_capacity while the checking also make sense for
> rnbd_clt_resize_dev_store, let's move the checking into the function.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index da2ba9477b1e..a9bfab53bbf7 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -71,6 +71,12 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
>  static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>                                     size_t new_nsectors)
>  {
> +       if (get_capacity(dev->gd) == new_nsectors)
> +               return 0;
> +
> +       /*
> +        * If the size changed, we need to revalidate it
> +        */
>         rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\n",
>                       get_capacity(dev->gd), new_nsectors);
>         set_capacity_and_notify(dev->gd, new_nsectors);
> @@ -93,12 +99,7 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
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
> --
> 2.34.1
>
