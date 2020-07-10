Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C8C433DF
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 07:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9621C207F9
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 07:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0p4lCNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgGJH30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJH3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 03:29:25 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01419C08C5DC
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 00:29:24 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id l12so1525144uak.7
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTkYNwGzgj0pnyOd6/mQEfIDNv2BJD5cxzVN7vZlhGA=;
        b=y0p4lCNYaKfzGKjhuYKHtmPHT4iXqEDmIgWN26ISyxSxBt81oHuLSHNxKPhgM3L/nj
         cgLPf7XjGdPg1QTdRrEN1F1mm2xssHUcybsGXU4wkzDoKlHK8Ad8IQ1iKHPyEJSiAR5w
         GSxgKc54e4fGLzDhC0xe/dZTQApa03txbWo0ZpFRlW4LCc73VeVAaB2QY/87tdBJSjzO
         uvgQ9qau4PFqv/MGUE+C/Eh7jd/56qMSpqMBtwhQXgUEImjRD1RswdC5dV2LZdHVlpVJ
         F4sZRiuB915rWbtTKX/KoId0n77xzcEYdmc75oWqbZ8SoIo9cBsEDPZ9DVnmV9PV7+eU
         btAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTkYNwGzgj0pnyOd6/mQEfIDNv2BJD5cxzVN7vZlhGA=;
        b=Wgc3SMoBhElRZfw9U3n/0jzEEZdOHSg8Zz8FiCwGHs68XGaiiR+CE2RcJzHRW5bPcK
         4ux8npFBcB4PCRa/lYN6FyGyNNxWbTgTSrmqiuZVIfoW6KmLtEmbjEf+ag4fRFAgaz98
         CTwDHmLthhsN8gn8pWf4fVRLLjxRt/tq/b9URRKYHi+uUpEviTPYkB7q/gABn/zKcxf7
         LvXOhtGQeHuufC51lWIYLTRShRdh3v55yCDkMkSIGsZak0CjFydeZ/dpedKZWPLBm0m6
         r1PgKS1TtV/2qKFijkkzkWXfz+m3fyr7v/Av35ror/mF0zXK3uYXx4EShXwLq3EAxYLm
         0e3g==
X-Gm-Message-State: AOAM531nuLxHcDltS8cKBjOsewNCSSEPo0FIl9H5w1CjjoYuofXgu7Oq
        5H6FiToHb0+EYzxOie/KxKcgacPOqWGJrKwacTkOWme/nrI=
X-Google-Smtp-Source: ABdhPJxHNlCLh9CShjrDdywo7NsnP0aoWUv878oapDo31qCG/k1VUc7yJ0S59pkOnASjsky1KC/KK1QIO9xbZzpbFaw=
X-Received: by 2002:ab0:6f0a:: with SMTP id r10mr57659956uah.100.1594366164126;
 Fri, 10 Jul 2020 00:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200708122546.214579-1-hch@lst.de> <20200708122546.214579-7-hch@lst.de>
In-Reply-To: <20200708122546.214579-7-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Jul 2020 09:28:47 +0200
Message-ID: <CAPDyKFqgHXAmc1k3BTpfUOW_iDWtyqWEcy3vRfZ3Lv3WaJwnBQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: remove the call to check_disk_change
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 8 Jul 2020 at 14:41, Christoph Hellwig <hch@lst.de> wrote:
>
> The mmc driver doesn't support event notifications, which means
> that check_disk_change is a no-op.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4791c82f8f7c78..fa313b63413547 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -312,10 +312,7 @@ static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>
>         mutex_lock(&block_mutex);
>         if (md) {
> -               if (md->usage == 2)
> -                       check_disk_change(bdev);
>                 ret = 0;
> -
>                 if ((mode & FMODE_WRITE) && md->read_only) {
>                         mmc_blk_put(md);
>                         ret = -EROFS;
> --
> 2.26.2
>
