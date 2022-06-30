Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D81C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 18:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiF3SmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiF3SmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 14:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2853C70E
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14CA26225B
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC8CC385A2
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656614519;
        bh=BwyWx6EG0PC8BCh8euqMKwz8QqWJZT0ImQw5aob0egE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mxDga5BLng3duilRhsRMi5KsDKXAP5Xp85g1G2niFizUyCi0dBTFu3zaKkNJAXiSe
         B56dWDQdqyG/fEtgWgKmG04bxPPUis0XoEOHRecx7t6f65eby+BWr+Aamwk+uhNxU+
         mZGtE84BrlsMCQwlkViZgnuMusquBWAHKWoT00R9uXCfo2McYsiii+Nmm5YMjt1hOe
         8Y66zAaayXuIWNwaFejMnoWxYlFfiuwwIuun5SM5fxIkqETOPh0Hpm5sOrMMJLZ78H
         jAH8kP32ITRVQFwMGGD1gw/BAF8HCFtv8S32q//mrf3AFL9OHujs300k8kDE8KK5QS
         kDZ+E09CH3h/Q==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-318889e6a2cso2283407b3.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 11:41:59 -0700 (PDT)
X-Gm-Message-State: AJIora8tf7COPd6+YAKAopKda3+NAJN9V3PI/7/E44DO+jwoYw3Vawai
        vTW+NgwFzZ1yTq9VbPBzTBdj3OEcjOYDmhGAwxg=
X-Google-Smtp-Source: AGRyM1ue16TualwmL8ZN2YviRDIN1eG44wWkZOQJVuCq0ngufusGEi1m07SWi6W9Paz/ku9fKEIteMiO5Z7BP8MJmj8=
X-Received: by 2002:a81:4fd3:0:b0:31b:7a89:5e16 with SMTP id
 d202-20020a814fd3000000b0031b7a895e16mr12119160ywb.472.1656614518569; Thu, 30
 Jun 2022 11:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220629233145.2779494-1-bvanassche@acm.org> <20220629233145.2779494-37-bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-37-bvanassche@acm.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 30 Jun 2022 11:41:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6YXmYX3f=tUVR+J_1LLfRSBEPWT-mvH1MXxLJMmKdhLg@mail.gmail.com>
Message-ID: <CAPhsuW6YXmYX3f=tUVR+J_1LLfRSBEPWT-mvH1MXxLJMmKdhLg@mail.gmail.com>
Subject: Re: [PATCH v2 36/63] md/raid5: Use the enum req_op and blk_opf_t types
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 4:32 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags.
>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/raid5.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 5d09256d7f81..b11d8b6a2dc2 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -1082,7 +1082,8 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
>         should_defer = conf->batch_bio_dispatch && conf->group_cnt;
>
>         for (i = disks; i--; ) {
> -               int op, op_flags = 0;
> +               enum req_op op;
> +               blk_opf_t op_flags = 0;
>                 int replace_only = 0;
>                 struct bio *bi, *rbi;
>                 struct md_rdev *rdev, *rrdev = NULL;
> @@ -5896,7 +5897,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
>                         (unsigned long long)logical_sector);
>
>                 sh = raid5_get_active_stripe(conf, new_sector, previous,
> -                                      (bi->bi_opf & REQ_RAHEAD), 0);
> +                                            !!(bi->bi_opf & REQ_RAHEAD), 0);
>                 if (sh) {
>                         if (unlikely(previous)) {
>                                 /* expansion might have moved on while waiting for a
