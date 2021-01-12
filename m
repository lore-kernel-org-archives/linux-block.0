Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A07C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 15:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D73C23131
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbhALPev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhALPev (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 10:34:51 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA041C061786;
        Tue, 12 Jan 2021 07:34:33 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m6so1591917pfm.6;
        Tue, 12 Jan 2021 07:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RVuECvNPbIKct0vhZG5VyO5CR6uluO/0d3yC7WXia4s=;
        b=HI6KrNCZhlvK/P2qwujoTxU0dyNl5pO+ERhl880VC3ZVmWHdnc12/FRplsiLALoLpQ
         DhGkfCuPNcyLdO0o+BV8mBdHOR67to4FsoCHW6mGidBLSNyQzRnsFuYcUjddoWc8qp/X
         mSm2U5ogYTCfHrAAVhJa95mYde/LzrjP3GVho/e/KE7qR4b6G3VEQTCpYJg320TBX4ZR
         kIL04T8+LYWtMVWqjZXR39BkJH9/W8V0LT7uitSCHmMMCupW1KyRIe1zdfZ+m4Aoz7ja
         FjIrb0pPeAR9vv546OQDXz3ZZKBl5Vo6MAE+wCn7LQdfyyTryBzJ5zHaj6pWD06JJDkj
         9NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RVuECvNPbIKct0vhZG5VyO5CR6uluO/0d3yC7WXia4s=;
        b=eOXSDRx+jA4ejXpqWmGtPEPFpzCGGHwI0/1LwIR7IRiXCqB/DlYLj1ah7XxSSSY/7W
         2DRbzYRIYwonmjQV3cA5xSQyxaKYAgTS+Z+xGnEj4elEi2A6uqdv4pVUYsbzNarcrlsP
         kFtAs7syo7eMo4bH5xnyq5nGtcD2azqfG6o7syN/GrBHZF9cDBcDrqttRe9R5VhjyA+K
         Um+KvvZsYI9lKAn8ilxdXVEsdP6eOVNei34kVSu+ZBJkARWrySyQkQzvc7JqLw4r0zSx
         iwL8wSodxI/gZik3HJOrHipsXaHp71Ap5qozVED358vIQ1/Rl438wWNjkdqb5Mcp38W5
         Gz2w==
X-Gm-Message-State: AOAM530IQ2GQD2GHFE+NqRHVuljEaId1OdXp940pQKBF9YrOwAHekJm6
        HnOnlTW5nLqi9M5QEg4N9bgsQ2jbXW2DbLMvByg=
X-Google-Smtp-Source: ABdhPJyfFCMrM1pHAKnzaAFF1beFe+dz5Z6vWGzaTwLXdBSrj4ozRSeA8/h3TjrVLExyI3jqCackj2GYCzNhAtd+6yo=
X-Received: by 2002:a65:48cb:: with SMTP id o11mr5198353pgs.121.1610465673155;
 Tue, 12 Jan 2021 07:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20210112152951.154024-1-fengli@smartx.com>
In-Reply-To: <20210112152951.154024-1-fengli@smartx.com>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Tue, 12 Jan 2021 23:34:06 +0800
Message-ID: <CAEK8JBD68oTcuV+Cf-S1Vv-n6nyr5UM_zWA5iJFHP=UvQ14AZg@mail.gmail.com>
Subject: Re: [PATCH] blk: avoid divide-by-zero with zero granularity
To:     Li Feng <fengli@smartx.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm sorry, ignore this one.

Li Feng <fengli@smartx.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:30=E5=86=99=E9=81=93=EF=BC=9A
>
> If the physical_block_size and io_min is less than a sector, the
> 'granularity >> SECTOR_SHIFT' will be zero.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  include/linux/blkdev.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f94ee3089e01..4d029e95adb4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1485,6 +1485,10 @@ static inline int queue_alignment_offset(const str=
uct request_queue *q)
>  static inline int queue_limit_alignment_offset(struct queue_limits *lim,=
 sector_t sector)
>  {
>         unsigned int granularity =3D max(lim->physical_block_size, lim->i=
o_min);
> +       granularity =3D granularity >> SECTOR_SHIFT;
> +       if (!granularity)
> +               return 0;
> +
>         unsigned int alignment =3D sector_div(sector, granularity >> SECT=
OR_SHIFT)
>                 << SECTOR_SHIFT;
>
> --
> 2.29.2
>
