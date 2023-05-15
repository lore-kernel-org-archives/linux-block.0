Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F61C77B7D
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjEOOek (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbjEOOeW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 10:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311412D69
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684161128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0YlzrDkJCQzUta2ENUmXIhOAuUIAL02Q3h7L6AXVYY=;
        b=SUnTBfkzy7k4zkIMUpeUiUAYMM57WHD+fVKbW3dsNVDJxLHB5rXLmB8ljnGqxhljBGBGdT
        VrPco+ntF5sZdy/2tGUDOd7dr5TrS8ZVFnq/TQcpOa/2l8yPEbWoJEP0syMSORNCkiBc3W
        nPei2Wi1jJlVU8+4jcPkkKaKpG8rfVI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-sZeI-VZWNhOqBIzb8fkpgw-1; Mon, 15 May 2023 10:32:07 -0400
X-MC-Unique: sZeI-VZWNhOqBIzb8fkpgw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-644c382a49aso6076423b3a.2
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 07:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161126; x=1686753126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0YlzrDkJCQzUta2ENUmXIhOAuUIAL02Q3h7L6AXVYY=;
        b=aWwUiNvlAhM18oBLol/eGwICeNzFuYSTbu2KvdDLDzE+q0ObIHDToO0SvVOkivxX9t
         CKwb/m0hTHmFJbhU3B3/0vOsGn0HHdqM5Llo0M91DXb1D0Qqn3kKFqUM7Tp4cinIL0W0
         7rUzy8QUi52iqswjl3MMmDO5x4ETzZsM/HT+QOa/jfHwOrFfvorF73+7ti3fQH++BcYB
         0jwzZEDy30DLcepNfdxOva/o9oCi9GrDOgQTOBHyiZ+oRhRl9EGqM6BW2GWe0AnAxDJd
         AnoLr93hUE+rxkqeqeIYXioLdnEIhDC+jyr0d5pRjjdiev4LfKzl0C9eaxeH1VYZHE7L
         FLug==
X-Gm-Message-State: AC+VfDy8wd5+/7+dEakrM3Jhv9yifhIw2QbNQj8A5hmihMBvfJoMJvHa
        KZ6UbczdHwUcEgpmGrilzBN4OUt10siVF/yhGkdmaXQNAIcQSyDy+DP011odGv6awYmsctDcSAz
        GT7kAtxQs7MG7Hhcxw/U5LXShiIpKu+6YzX5NCbnwSWiDPgTdB9wp
X-Received: by 2002:a05:6a00:1881:b0:643:b489:246d with SMTP id x1-20020a056a00188100b00643b489246dmr43668778pfh.3.1684161125883;
        Mon, 15 May 2023 07:32:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kp7XKM70rdTJcxhaybJMHtkUbVmp2hLUY49y6nOUgpd5aDBPt5aZmRe/yAaYKftRHH7qOcVHu1GL31fAUp88=
X-Received: by 2002:a05:6a00:1881:b0:643:b489:246d with SMTP id
 x1-20020a056a00188100b00643b489246dmr43668745pfh.3.1684161125563; Mon, 15 May
 2023 07:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230512150328.192908-1-ming.lei@redhat.com>
In-Reply-To: <20230512150328.192908-1-ming.lei@redhat.com>
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Mon, 15 May 2023 22:33:11 +0800
Message-ID: <CAGS2=YoBgc3FJ+P7Z29ssDvHu+cOc7+KyptHUq2cY_YFdTrOGw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai1@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After reinstalling the upstream kernel, I also hit the reset issue, so
 the issue isn't related to mingl's patch.
The reset issue has opened before, please have a look.
https://lore.kernel.org/linux-scsi/CAGS2=3DYrmwbhMpNA2REnBybvm5dehGRyKBX5Sq=
5BqY=3Dex=3DmwaUg@mail.gmail.com/


Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=94 23:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Passthrough(pt) request shouldn't be queued to scheduler, especially some
> schedulers(such as bfq) supposes that req->bio is always available and
> blk-cgroup can be retrieved via bio.
>
> Sometimes pt request could be part of error handling, so it is better to =
always
> queue it into hctx->dispatch directly.
>
> Fix this issue by queuing pt request from plug list to hctx->dispatch
> directly.
>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Investigated-by: Yu Kuai <yukuai1@huaweicloud.com>
> Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> Guang Wu, please test this patch and provide us the result.
>
>  block/blk-mq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f6dad0886a2f..11efaefa26c3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2711,6 +2711,7 @@ static void blk_mq_dispatch_plug_list(struct blk_pl=
ug *plug, bool from_sched)
>         struct request *requeue_list =3D NULL;
>         struct request **requeue_lastp =3D &requeue_list;
>         unsigned int depth =3D 0;
> +       bool pt =3D false;
>         LIST_HEAD(list);
>
>         do {
> @@ -2719,7 +2720,9 @@ static void blk_mq_dispatch_plug_list(struct blk_pl=
ug *plug, bool from_sched)
>                 if (!this_hctx) {
>                         this_hctx =3D rq->mq_hctx;
>                         this_ctx =3D rq->mq_ctx;
> -               } else if (this_hctx !=3D rq->mq_hctx || this_ctx !=3D rq=
->mq_ctx) {
> +                       pt =3D blk_rq_is_passthrough(rq);
> +               } else if (this_hctx !=3D rq->mq_hctx || this_ctx !=3D rq=
->mq_ctx ||
> +                               pt !=3D blk_rq_is_passthrough(rq)) {
>                         rq_list_add_tail(&requeue_lastp, rq);
>                         continue;
>                 }
> @@ -2731,10 +2734,15 @@ static void blk_mq_dispatch_plug_list(struct blk_=
plug *plug, bool from_sched)
>         trace_block_unplug(this_hctx->queue, depth, !from_sched);
>
>         percpu_ref_get(&this_hctx->queue->q_usage_counter);
> -       if (this_hctx->queue->elevator) {
> +       if (this_hctx->queue->elevator && !pt) {
>                 this_hctx->queue->elevator->type->ops.insert_requests(thi=
s_hctx,
>                                 &list, 0);
>                 blk_mq_run_hw_queue(this_hctx, from_sched);
> +       } else if (pt) {
> +               spin_lock(&this_hctx->lock);
> +               list_splice_tail_init(&list, &this_hctx->dispatch);
> +               spin_unlock(&this_hctx->lock);
> +               blk_mq_run_hw_queue(this_hctx, from_sched);
>         } else {
>                 blk_mq_insert_requests(this_hctx, this_ctx, &list, from_s=
ched);
>         }
> --
> 2.38.1
>

