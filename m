Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 10:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353188AbiFVK6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353315AbiFVK6K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 06:58:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334622BE2
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:58:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ge10so1842264ejb.7
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55loFqe+UMj9KqqehB+wsllYkDP6e0enqwmjpgBJx5w=;
        b=L9KtPW3R2oIpleBL/XQXBYv04XEnisqgrSVLC+dp2Ktdzffl1q7PSAwM+PiMQMqotQ
         8l29El/qKJ3Tgp4O6OUNqfcQ2BHh/OLS4/lCAYJ82t+Fp3vqqd10YRKE78sKqyeL5Wnf
         qimD7bBRDBlT9dwO1msoKO4fMUv8WFEDIHqlBYWn5dDAKBDlbp5G54Xa11f7/wknJ6A0
         wPch5BrFc7Mnloo9RU0um6rLidfEuPjhle9rDBIJ3XCEVstFQjXOb+GAMKZViZ2I5BW7
         iM2FVidVnOOAsAZA7Pd0I4QGHK3biIdBwINEKauR/8c2+evuM/AEFTGIF/e3lPohAezO
         8QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55loFqe+UMj9KqqehB+wsllYkDP6e0enqwmjpgBJx5w=;
        b=In/iLUPUtcE5NDDT7zSbIqpISqSv7ndupAsBaKr4r7bYVjTz1AMwxZNCMO6agu/6yG
         RjJSi4UFwvnkRYFyoPu++uijLrlqfdSTHOSpyIDplcZGLRYotnEjsoQvExWVNs0Q9Cdd
         KG1bzLTjbbvJPC1zVNqCnz680EBHEFecyVjw5EPWJRSwP5y/zxT4x+lZ4dQM9gSnUIyg
         yNpFitn1I11THbwOevzlxLok+mtrxxXK8R9pgQVNYDGuBPlTDy/1cfnOvaPAS2PlU4tU
         Cyl2jt9U+A29Aky7WyxdKZHP7/QIX8jUaLY0bw0KFhwOFsPCAZW0Kh5Sg5IMrVUb90KR
         oxkQ==
X-Gm-Message-State: AJIora9HeP1Q/3dpf4Z8qDyyZgazTGLcRDECvAYQdxxonkf6q/sk3W6p
        P57TlMEu6uWYm/p1fxTeL/9yShQSRs8OKXaPoBGuVA==
X-Google-Smtp-Source: AGRyM1v6jZ3bgEHsyTGY896cG4kIxxcLHJkBgKFDy1g/7g3jMJg1Jn4JTKTEW021NCw+lBMPselrM9ro/1GBMf1SAlk=
X-Received: by 2002:a17:906:449:b0:711:c975:cfb8 with SMTP id
 e9-20020a170906044900b00711c975cfb8mr2705638eja.58.1655895482767; Wed, 22 Jun
 2022 03:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220620034923.35633-1-guoqing.jiang@linux.dev> <20220620034923.35633-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-4-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 22 Jun 2022 12:57:52 +0200
Message-ID: <CAMGffE=-5n3aUFX5a02zgp8fy_9dFHgaDVLQ=iMn5_m+GF-Rbg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] rnbd-clt: kill read_only from struct rnbd_clt_dev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 5:50 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> The member is not needed since we can call get_disk_ro to achieve the
> same goal.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
lgtm
Acked-by: Jack Wang <jinpu.wang@ionos.com>


> ---
>  drivers/block/rnbd/rnbd-clt.c | 8 ++------
>  drivers/block/rnbd/rnbd-clt.h | 1 -
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 6c4970878d23..0bade2680eb9 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -949,7 +949,7 @@ static int rnbd_client_open(struct block_device *block_device, fmode_t mode)
>  {
>         struct rnbd_clt_dev *dev = block_device->bd_disk->private_data;
>
> -       if (dev->read_only && (mode & FMODE_WRITE))
> +       if (get_disk_ro(dev->gd) && (mode & FMODE_WRITE))
>                 return -EPERM;
>
>         if (dev->dev_state == DEV_STATE_UNMAPPED ||
> @@ -1402,12 +1402,8 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
>
>         set_capacity(dev->gd, dev->nsectors);
>
> -       if (dev->access_mode == RNBD_ACCESS_RO) {
> -               dev->read_only = true;
> +       if (dev->access_mode == RNBD_ACCESS_RO)
>                 set_disk_ro(dev->gd, true);
> -       } else {
> -               dev->read_only = false;
> -       }
>
>         /*
>          * Network device does not need rotational
> diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
> index 2e2e8c4a85c1..26fb91d800e3 100644
> --- a/drivers/block/rnbd/rnbd-clt.h
> +++ b/drivers/block/rnbd/rnbd-clt.h
> @@ -117,7 +117,6 @@ struct rnbd_clt_dev {
>         char                    *pathname;
>         enum rnbd_access_mode   access_mode;
>         u32                     nr_poll_queues;
> -       bool                    read_only;
>         bool                    wc;
>         bool                    fua;
>         u32                     max_hw_sectors;
> --
> 2.34.1
>
