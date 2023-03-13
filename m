Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD9EC61DA4
	for <linux-block@archiver.kernel.org>; Mon, 13 Mar 2023 16:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCMQkY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCMQkW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 12:40:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961F834C08
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 09:39:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z5so13254644ljc.8
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678725597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPRkX0mUr1AJvKdMORqEhprvgQoUoDS6vqO2T9atDeQ=;
        b=IRE3v+Uz6+HoVZO7d52ezrQARY8IKWzRb9yeFd33curCQktTxyFiYRKmOXZHZsfxyl
         MUlM/scDCzzXXaLCjJy4WVRTGaMxiAU1zmyG19EMELk54cZ4q7ZP0VMeSQczFeOG1vBb
         l9v4MOecl71J+f/DB9IrwV1itJUkI8F3yMsaCCE6Rlq31bOkXPUtMP4Coeqkyt7ke3hB
         eH7dm8ky3LycBD43aHyVpIYTJUhVPi3Og9D82wTKHKGANTWl2+r3jOdJSLbAEmo6YR2L
         VR2o1lUdKH5fkghpWtBHECAsz4rDD3yFBDr1MVqoq2Y1dfatSdeFzVTc5NEHQXXkQMLd
         zo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPRkX0mUr1AJvKdMORqEhprvgQoUoDS6vqO2T9atDeQ=;
        b=WFiipC/edIEDAuoOc3Uf+LuT11yia+3g+r1hjDEpVTZ1Dp9UC95cnyQHQOl8+VX1HR
         fL2pUNn15xiwF7NIu37rZCgRyqfOR5n/GGmWBIP7P58dR0+IJknZmfWkzzy7SapWprpu
         eLIRlcTMRTuRO/rVrPotKrqtawRNFPAT8Pcu8sBIqGnIsajqkhJFljYCeEoydIlr0dtn
         lGOsrjKDe9AEC2Y2JtTOsQAjqNIs+9BNX9+iBkisl+Moxry6tpLAArd8oorhDOMacQzQ
         k6e4arUx3RiPV+b5WxRICGgP6pCBWUmPc6tOXg2JdKFvSQJ89K3t4vK9IDID2gbHRksX
         aoeA==
X-Gm-Message-State: AO0yUKVsjMnG6PtNYv8LidkzIYGKdepUiGm86xhBm3XH8CFTSOB7degm
        5SFwRVukDmdFhsN07zGFLyDAbSaJT98gYEB0FqiHWfi/R+I=
X-Google-Smtp-Source: AK7set/XH7wIUemkbLN2QMbPdKxFveLry4cro/aukU3S8dblB4ek1qn6Z9nv2uwEhly5L5/NxjAd+SAhdUKE3Gv7fc0=
X-Received: by 2002:a2e:b544:0:b0:295:b597:c903 with SMTP id
 a4-20020a2eb544000000b00295b597c903mr10738944ljn.3.1678725596713; Mon, 13 Mar
 2023 09:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230312123556.12298-1-akinobu.mita@gmail.com> <49cfce8b-042e-7248-928f-4a5c5f7d0e31@opensource.wdc.com>
In-Reply-To: <49cfce8b-042e-7248-928f-4a5c5f7d0e31@opensource.wdc.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 14 Mar 2023 01:39:44 +0900
Message-ID: <CAC5umyhT7wJNaOM89iJ63VnbajX3_8g+uLt7jDeeNJCxXoMLDg@mail.gmail.com>
Subject: Re: [PATCH] null_blk: execute complete callback for fake timeout request
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

2023=E5=B9=B43=E6=9C=8813=E6=97=A5(=E6=9C=88) 10:00 Damien Le Moal <damien.=
lemoal@opensource.wdc.com>:
>
> On 3/12/23 21:35, Akinobu Mita wrote:
> > When injecting a fake timeout into the null_blk driver by fail_io_timeo=
ut,
> > the request timeout handler doen't execute blk_mq_complete_request(), s=
o
> > the complete callback will never be executed for that timed out request=
.
> >
> > The null_blk driver also has a driver-specific fake timeout mechanism a=
nd
> > does not have the problem that occur when using the generic one.
> > Fix the problem by doing similar to what the driver-specific one does.
> >
> > Fixes: de3510e52b0a ("null_blk: fix command timeout completion handling=
")
> > Cc: Damien Le Moal <damien.lemoal@wdc.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  drivers/block/null_blk/main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/mai=
n.c
> > index 4c601ca9552a..69250b3cfecd 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -1413,7 +1413,9 @@ static inline void nullb_complete_cmd(struct null=
b_cmd *cmd)
> >       case NULL_IRQ_SOFTIRQ:
> >               switch (cmd->nq->dev->queue_mode) {
> >               case NULL_Q_MQ:
> > -                     if (likely(!blk_should_fake_timeout(cmd->rq->q)))
> > +                     if (unlikely(blk_should_fake_timeout(cmd->rq->q))=
)
> > +                             cmd->fake_timeout =3D true;
> > +                     else
> >                               blk_mq_complete_request(cmd->rq);
> >                       break;
> >               case NULL_Q_BIO:
>
> I have not checked, but does this work ?

Yes it worked.

Tested-by: Akinobu Mita <akinobu.mita@gmail.com>

> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index 4c601ca9552a..52d689aa3171 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1413,7 +1413,7 @@ static inline void nullb_complete_cmd(struct nullb_=
cmd *cmd)
>         case NULL_IRQ_SOFTIRQ:
>                 switch (cmd->nq->dev->queue_mode) {
>                 case NULL_Q_MQ:
> -                       if (likely(!blk_should_fake_timeout(cmd->rq->q)))
> +                       if (!cmd->fake_timeout)
>                                 blk_mq_complete_request(cmd->rq);
>                         break;
>                 case NULL_Q_BIO:
> @@ -1675,7 +1675,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_=
ctx *hctx,
>         cmd->rq =3D bd->rq;
>         cmd->error =3D BLK_STS_OK;
>         cmd->nq =3D nq;
> -       cmd->fake_timeout =3D should_timeout_request(bd->rq);
> +       cmd->fake_timeout =3D should_timeout_request(bd->rq) ||
> +               blk_should_fake_timeout(bd->rq->q);
>
>         blk_mq_start_request(bd->rq);
>
>
> It is I think cleaner as it unifies the internal fake timeout and
> blk_should_fake_timeout().

I also prefer this one.
