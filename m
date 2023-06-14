Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CB6EB64D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 14:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245543AbjFNOQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245542AbjFNOQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 10:16:46 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA302683
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 07:16:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39ca0c2970aso3964587b6e.3
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686752199; x=1689344199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f57lCLd7OdJQ5Blvl8wGJZyK116HtB6qFU6rPcmeblM=;
        b=LSQwn5MG67BP/+AQZt17SggoC4gLE3roHuhaYzIcFAuElnPEdILAfPsBHCJZVvqwh3
         XvRbYvSPgP+OkIUVaDnUpKqNbzGqO7UEnZ/Kr5+tV5tqa2pTaS05sj/LlavK0voHdg5L
         8Os8TgtX0c/OJgEg8I+w52z/UYhCY8r2Hp+whkOCH8c6XaK2i0IbpHBi81/XP6F+X4sG
         JUpz4BtXIoS/6LIAgNdOHbcppVUNc6RsHlF5i9Uso1MdJmjvGUHgFlU6pu0zYdCWXSNi
         RZEj9fvIVkWRC1tPlpNMCmmvB3/LwDnfcZGu8MDSIb+arT+zuNVIfTNeRTCkm1/j3d3e
         TZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752199; x=1689344199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f57lCLd7OdJQ5Blvl8wGJZyK116HtB6qFU6rPcmeblM=;
        b=V73p9RDQGNFzyxLMniVHzFOgDGcIgj70bGL3zRapL6tDdEnr130iD+vS44rJ2CXzkX
         RyuQjEOVTNq2wJMVsI5sLvovVNv3yXFYa9AkAkQRlw8+qbJKxq/Q8QUhN5HHrGSz7tKL
         uKo3KgCfcEg+zsTTc6wW56ksr8RcTtrihTD00nA3a5jZ9jb0/lEP79LEYh7qJK+wqJZU
         G723HU/N3VtFG3dcWymOUk+qE3oC4ulEDMUUbY+MUFIPdmHkKok7Ik+Q+mOge9KS42qp
         n5yz/FnMgSJJ6plSQK4lBGopsiEjf1qRDS4o/Oxo1ZFcnoh8UML2q5ImXIP0gi9JGz6A
         wUlA==
X-Gm-Message-State: AC+VfDx23Tgr2e7VotTSfZGsv5EyeE9DN/GeCOtoIdvf84N421mtc4Cj
        dVyS0amr5uIR/xSbZxVd49Xr+107Q/skBt2NgJ4N9Q==
X-Google-Smtp-Source: ACHHUZ7wb3qZ+Qnq9csb+a5N85VcMfo3f7fVKEeFXq1y2jgoyp8xHBYXcB4Sf3yFT1UhZua9LFNTzQXcWOCxAZOfITE=
X-Received: by 2002:a05:6808:2984:b0:397:fbe7:a0fb with SMTP id
 ex4-20020a056808298400b00397fbe7a0fbmr10144901oib.18.1686752199333; Wed, 14
 Jun 2023 07:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230614141338.3480029-1-senozhatsky@chromium.org>
In-Reply-To: <20230614141338.3480029-1-senozhatsky@chromium.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 14 Jun 2023 10:16:03 -0400
Message-ID: <CADyq12xoEKpYOd7nFy+ET89ss-zTdKbbj6870UMDQeLe09=Zow@mail.gmail.com>
Subject: Re: [PATCH] zram: further limit recompression threshold
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Sergey

On Wed, Jun 14, 2023 at 10:13=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Recompression threshold should be below huge-size-class
> watermark.

Acked-by: Brian Geffon <bgeffon@google.com>

>
> Suggested-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 1867f378b319..5676e6dd5b16 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1753,7 +1753,7 @@ static ssize_t recompress_store(struct device *dev,
>                 }
>         }
>
> -       if (threshold >=3D PAGE_SIZE)
> +       if (threshold >=3D huge_class_size)
>                 return -EINVAL;
>
>         down_read(&zram->init_lock);
> --
> 2.41.0.162.gfafddb0af9-goog
>
