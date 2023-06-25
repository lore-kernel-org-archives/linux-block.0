Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B32FEB64DC
	for <linux-block@archiver.kernel.org>; Sun, 25 Jun 2023 08:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjFYIbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jun 2023 04:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjFYIbY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jun 2023 04:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76A10F2
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687681823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Swn+PxcH0UIWySoZatq2pB89Yb16EqEAu3zpeh14NbU=;
        b=cHOq26wrUnLbN65kn7cthvcIb92uiStyAJMGnAZMSarFT5RxaEH+M3SAmN1b8WMxDnngUw
        swhN4vQNv5uWwAH2Se/tQ7pRGFkJrjXtQcX/e7h/SVQ1RmTofwh0dcAFRjxzPht8+UZMyn
        xCm8oQXVNbnThAl+sETscvXjWt/Z6dA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-Xto3Smq6MeiTfJNcnZUi2w-1; Sun, 25 Jun 2023 04:30:21 -0400
X-MC-Unique: Xto3Smq6MeiTfJNcnZUi2w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso174916466b.2
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 01:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687681820; x=1690273820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swn+PxcH0UIWySoZatq2pB89Yb16EqEAu3zpeh14NbU=;
        b=W//KNq6nb/WuAfIOCYPpedKuGB7ObsU0ytAOsR9dJJcNe4Yq06DRIB4H2PsJ/TJtbE
         KWemGYxDx0YmFjpmVg/0f87fJ7CzcRsbb1mxFKsCqaZ0aNH6o/RvGR57py6i+7zGGiQH
         Zvpxr/5mIbRyno7udUT12ebZnhPEs4/wE4VaNYhO/wsIvtg1EB766+duV6Q+XazRcSbY
         giYskz4cLQulVQbJfsEX1OILM5IzrwuFRxKcvJeTE6WEt7HIrArgT03UMbr+h9WgKSmN
         JvAANZ/CJ5X2b45feQjYP2SpJyi6dZR4ATt1q+dRciJOmwls1kSAjHXe5kbsNeg3WFpP
         NvhA==
X-Gm-Message-State: AC+VfDzxd6Dp+UP+kO3ulWn2rIq+xMmKsD6VyAZ6lmq6Lh1H0E6+/Xtx
        sFVswY//e4gjiVK7MEY8bo/MphFpM8eLxNEFHRmbgUVmiUVwqGpmR5izH3WFxypvMnDJIWaT0Am
        D1gs5Buc63UcHRhjd7C1dc92Ki1AYywbgkSMjYx8=
X-Received: by 2002:aa7:d319:0:b0:51d:809a:bde5 with SMTP id p25-20020aa7d319000000b0051d809abde5mr2265017edq.15.1687681820330;
        Sun, 25 Jun 2023 01:30:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73iuATkJ23rvdHZxJ4FCAd0DXHEKu7aWIdIH2Awt4l3tIepSCFXSpAcTIz20FZOV2VlmbmwUuC/piXrqCrtHM=
X-Received: by 2002:aa7:d319:0:b0:51d:809a:bde5 with SMTP id
 p25-20020aa7d319000000b0051d809abde5mr2265009edq.15.1687681820085; Sun, 25
 Jun 2023 01:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230624130105.1443879-1-ming.lei@redhat.com>
In-Reply-To: <20230624130105.1443879-1-ming.lei@redhat.com>
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Sun, 25 Jun 2023 16:31:26 +0800
Message-ID: <CAGS2=Yr_xL3ikGuJKg3MrK1pGnmW8MDFmBTDXfLR76moO=wNjA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix two misuses on RQF_USE_SCHED
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Ming
Could not hit the error after apply your patch. good job!

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=85=AD 21:01=E5=86=99=E9=81=93=EF=BC=9A

>
> Request allocated from sched tags can't be issued via ->queue_rqs()
> directly, since driver tag isn't allocated yet. This is the 1st misuse
> of RQF_USE_SCHED for figuring out plug->has_elevator.
>
> Request allocated from sched tags can't be ended by
> blk_mq_end_request_batch() too, fix the 2nd RQF_USE_SCHED misuse
> in blk_mq_add_to_batch().
>
> Without this patch, NVMe uring cmd passthrough IO workload can run into
> hang easily with real io scheduler.
>
> Fixes: dd6216bb16e8 ("blk-mq: make sure elevator callbacks aren't called =
for passthrough request")
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Closes: https://lore.kernel.org/linux-block/CAGS2=3DYrBjpLPOKa-gzcKuuOG60=
AGth5794PNCDwatdnnscB9ug@mail.gmail.com/
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c         | 6 +++++-
>  include/linux/blk-mq.h | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1628873d7587..0aba08a9ded6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1302,7 +1302,11 @@ static void blk_add_rq_to_plug(struct blk_plug *pl=
ug, struct request *rq)
>
>         if (!plug->multiple_queues && last && last->q !=3D rq->q)
>                 plug->multiple_queues =3D true;
> -       if (!plug->has_elevator && (rq->rq_flags & RQF_USE_SCHED))
> +       /*
> +        * Any request allocated from sched tags can't be issued to
> +        * ->queue_rqs() directly
> +        */
> +       if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
>                 plug->has_elevator =3D true;
>         rq->rq_next =3D NULL;
>         rq_list_add(&plug->mq_list, rq);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index fa265e85d753..12103d5654f5 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -852,7 +852,11 @@ static inline bool blk_mq_add_to_batch(struct reques=
t *req,
>                                        struct io_comp_batch *iob, int ioe=
rror,
>                                        void (*complete)(struct io_comp_ba=
tch *))
>  {
> -       if (!iob || (req->rq_flags & RQF_USE_SCHED) || ioerror ||
> +       /*
> +        * blk_mq_end_request_batch() can't end request allocated from
> +        * sched tags
> +        */
> +       if (!iob || (req->rq_flags & RQF_SCHED_TAGS) || ioerror ||
>                         (req->end_io && !blk_rq_is_passthrough(req)))
>                 return false;
>
> --
> 2.40.1
>


--
Guangwu Zhang
Thanks

