Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8CFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 18:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiF3Sl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiF3Sl2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 14:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36BC3C70E
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AAE762264
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF366C341CA
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656614484;
        bh=+505afaOGdC14Kno67sUW3PyS911tZg4fBKw6VzianQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RcTmZfi1dIWCi4MnxJj+svW/H1b7naT6hmIDy15kWoUxh2uzN5hKX1ny3P9px/8q8
         vFn5Alju0wsrJQBmwUeykOaNi2eSPVkjauI8gdy7TKcu8Vqb6SvHAYuSww71mDSYhS
         hb6lyBHyLyJa69uz9gq3aYVrAdGoBfUkl/5I+4kktgMM7tCNzHFpqX7ru3tiLMnSm7
         VuvOwUkFrzwNe3TQ4ExpjQMO+AqKzjGonbQWrj9FptEPi0svObrYtbkeSCgaFMiGZH
         Rr5KvzfbhhPowi2btWV09cRSaWdCWn7BS8NqNqDLxJPDeKOy0Di1I+hXgfEKnEkkMg
         38/CxdA0ca+EA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-317a66d62dfso1962697b3.7
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:41:24 -0700 (PDT)
X-Gm-Message-State: AJIora+WsN0KhqhGJhb/N3Y0VEwAWuG5aU1JNQMmkmIEIH6E852lHnb1
        w/Nlr4NChlTVeXZTx2zN/W/snsWuzMkRNIO1hIE=
X-Google-Smtp-Source: AGRyM1s/iC944uFbiy9WeTiKCdDluThNxKK8Z7Hp+RMCyA5xozEjfbD/Ar/KPj11SAmM+fPvY8z1L+8tx/LiJ4AedXM=
X-Received: by 2002:a81:4fd3:0:b0:31b:7a89:5e16 with SMTP id
 d202-20020a814fd3000000b0031b7a895e16mr12116466ywb.472.1656614483743; Thu, 30
 Jun 2022 11:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220629233145.2779494-1-bvanassche@acm.org> <20220629233145.2779494-35-bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-35-bvanassche@acm.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 30 Jun 2022 11:41:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5GoFpGbk_MF0PFN0E3E+NwBn_sMNL3bdQ=q3VNBUKpow@mail.gmail.com>
Message-ID: <CAPhsuW5GoFpGbk_MF0PFN0E3E+NwBn_sMNL3bdQ=q3VNBUKpow@mail.gmail.com>
Subject: Re: [PATCH v2 34/63] md/raid1: Use the new blk_opf_t type
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 4:32 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Improve static type checking by using the new blk_opf_t type for
> variables that represent request flags.
>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/raid1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index e7cd1d30d68a..8180b57be040 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1220,8 +1220,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
>         struct raid1_info *mirror;
>         struct bio *read_bio;
>         struct bitmap *bitmap = mddev->bitmap;
> -       const int op = bio_op(bio);
> -       const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
> +       const enum req_op op = bio_op(bio);
> +       const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
>         int max_sectors;
>         int rdisk;
>         bool r1bio_existed = !!r1_bio;
