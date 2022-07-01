Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA04C43334
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 04:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGAErr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 00:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGAErq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 00:47:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49B677CC
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 21:47:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k20so1430287edj.13
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 21:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XKumRL0REDbETPlrmyQFCqGhHL9wXNafoTmj/Yv6gc=;
        b=E9zQoob5DZIom1jHLd2YbpVix7UMzA+HeQBvuaJSkZMYqeFTICCyDupC0/2xa9GHAA
         hl2/OzuLFJG17aqzJtjrrr+WMxbcdW3BMTcr/vVc3HcnNCGdZbe+zkGvOwy0wizgtP/X
         CfBr4o9SFFE/jZctzKaOJlLtzhWMP1ObednSU5baDPzrfcFHkskybyaqhdM7BvLFEK/Z
         419jViz4CgNDJkYtvi49tND9sousLw9sBq+PB9QrzaiC320XGLc981OIZ6pwLSPk+q4C
         PXAW5LYm5ZQpSI0r60kdFumub7Vl9n8NDm5mZCFsC4fmfpk3EEph6ousdZySPP4F3cf0
         zaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XKumRL0REDbETPlrmyQFCqGhHL9wXNafoTmj/Yv6gc=;
        b=dSZ7oRYtr8/cB/xNhgJ8bVe7G+8y5sjfGWNPU+KlvW6nQnX4nc9NNZCMB1yLtHLyEc
         HsoNt7SEVs/fxK1ZwRq1XGOjr0zr7lY2hOY/y2h6VOtos7fT52zPu/V2sLhynZECb9TI
         Pdx8Ngm7xooLtbeB5JHy/aivxGt04YTtbydCTNtCawA62mvnMjBZpR9+uP2K3MZJI0Ah
         nGR8CtIuBf3uriOwtag22R5Y8cLREjSrfBg+KpYrLxCYanPeqSh+Pm1VNwmqYUxFLN+S
         X1Fp0jIkpkGwjbrbTBdv4zDURnBnfogNXqXnhcppS0LMEIOgzWepvNAJUGJywHxO4Mzt
         eJ4Q==
X-Gm-Message-State: AJIora9yjUEkf9Cg/CBfaW8fNb9+jvro7/webGVtOET0og/YsQi3mH4g
        bORHkyo2vtGnTMY4OG1z9Tv+30x8WLgppiHkurHa5W7hbvY=
X-Google-Smtp-Source: AGRyM1vh9MHXrfGsFScu0BWXVNjhq6c4a8Nz5plNhFdecScrMMpFp0y9/G9PCsXTNO1yZe/nAHu4TZq1oxZK77rJ8PE=
X-Received: by 2002:a05:6402:430e:b0:435:9e41:6858 with SMTP id
 m14-20020a056402430e00b004359e416858mr16636983edc.69.1656650862930; Thu, 30
 Jun 2022 21:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220629233145.2779494-1-bvanassche@acm.org> <20220629233145.2779494-17-bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-17-bvanassche@acm.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 1 Jul 2022 06:47:32 +0200
Message-ID: <CAMGffE=+9WUbbERgeUVvX5MK6dPieOtHi9znUAysd++UypAxYA@mail.gmail.com>
Subject: Re: [PATCH v2 16/63] block/rnbd: Use blk_opf_t where appropriate
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 30, 2022 at 1:32 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Improve static type checking by using the new blk_opf_t type to represent
> the combination of a request and request flags.
>
> Cc: Md. Haris Iqbal <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thanks!
> ---
>  drivers/block/rnbd/rnbd-proto.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
> index bfb08dd434d1..ea7ac8bca63c 100644
> --- a/drivers/block/rnbd/rnbd-proto.h
> +++ b/drivers/block/rnbd/rnbd-proto.h
> @@ -229,9 +229,9 @@ static inline bool rnbd_flags_supported(u32 flags)
>         return true;
>  }
>
> -static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
> +static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
>  {
> -       u32 bio_opf;
> +       blk_opf_t bio_opf;
>
>         switch (rnbd_op(rnbd_opf)) {
>         case RNBD_OP_READ:
> @@ -286,7 +286,8 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
>                 break;
>         default:
>                 WARN(1, "Unknown request type %d (flags %llu)\n",
> -                    req_op(rq), (unsigned long long)rq->cmd_flags);
> +                    (__force u32)req_op(rq),
> +                    (__force unsigned long long)rq->cmd_flags);
>                 rnbd_opf = 0;
>         }
>
