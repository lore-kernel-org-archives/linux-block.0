Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71797C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 18:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiF3Sls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiF3Slr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 14:41:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D533CA6A
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2DFF6225B
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5114AC385A9
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656614506;
        bh=RNrWYSlhRGX+DF9kCSqpSb+swXdwIuaTEzbbhXEjF8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q6Y9lma753SQCZGNmH1MB/vpywh3/XtSdNjv8zl69GgLxG76vpciWRkfy01js33ic
         RobdSEYEfl5q70bFT0BsrPZHkM8RRGsley1zcoZAo3uItWeMy5aegRRkSnEjJGuufH
         Bxb3yiF270ZOqNlm37EhufuRrD19yiUj130GhRICn/6KdIMIexmYzkcR9emNlMPqkE
         Nga3iEcW0X0Ocr3UzTK95+W3LEYaBmvng+4kTo15kznpPzgCgUwuVaJ+a7zoc+URpm
         2l2prUKGMFwq25NVUxT+92q7uHb0uGGaazyNOoE0MqUT5gKEp0Sm/RtNzCGW35j55r
         sB7E1ueH/xWEg==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3177f4ce3e2so2081407b3.5
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:41:46 -0700 (PDT)
X-Gm-Message-State: AJIora+/nDny42TvSHRblbQ8xTBCXSXTewepaLkmAk7lTSwV+bLX5qp2
        Y5X5LgTZz5FQE+iSfRdmRrccjqWL4wwB/VaU9Nk=
X-Google-Smtp-Source: AGRyM1tLV9bxhkXKKwXS+INT4frb+ft57JqqxZxP5ckopaep1iY0pQitSpCqyXWFgu1O6A+j9bczQ+hPCsdPAK6SKeM=
X-Received: by 2002:a81:8004:0:b0:318:7e2d:5bd5 with SMTP id
 q4-20020a818004000000b003187e2d5bd5mr11988595ywf.211.1656614505424; Thu, 30
 Jun 2022 11:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220629233145.2779494-1-bvanassche@acm.org> <20220629233145.2779494-36-bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-36-bvanassche@acm.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 30 Jun 2022 11:41:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW76MS0_5nPXfMn1bCo+ukxSQB=Gid6GzkwO380Nxg=9cA@mail.gmail.com>
Message-ID: <CAPhsuW76MS0_5nPXfMn1bCo+ukxSQB=Gid6GzkwO380Nxg=9cA@mail.gmail.com>
Subject: Re: [PATCH v2 35/63] md/raid10: Use the new blk_opf_t type
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
> variables that represent a request flags.
>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/raid10.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 910d3cd73105..ac8bc7d2565a 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1136,8 +1136,8 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
>  {
>         struct r10conf *conf = mddev->private;
>         struct bio *read_bio;
> -       const int op = bio_op(bio);
> -       const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
> +       const enum req_op op = bio_op(bio);
> +       const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
>         int max_sectors;
>         struct md_rdev *rdev;
>         char b[BDEVNAME_SIZE];
> @@ -1230,9 +1230,9 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
>                                   struct bio *bio, bool replacement,
>                                   int n_copy)
>  {
> -       const int op = bio_op(bio);
> -       const unsigned long do_sync = (bio->bi_opf & REQ_SYNC);
> -       const unsigned long do_fua = (bio->bi_opf & REQ_FUA);
> +       const enum req_op op = bio_op(bio);
> +       const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
> +       const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
>         unsigned long flags;
>         struct blk_plug_cb *cb;
>         struct raid1_plug_cb *plug = NULL;
