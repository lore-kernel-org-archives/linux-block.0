Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4321C19F2D
	for <linux-block@archiver.kernel.org>; Sat, 13 Aug 2022 10:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiHMKQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiHMKQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 06:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1DBB11C3A
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660385775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxuhdyECDecFWFU7Cl1otkHgGws3cgxQwNohBZWx2rk=;
        b=eU5LAfdX78Eg9o57TecTcEqaBJBhzbVCbEF3uPi7/lFiNNRDL9bAK0qO9zFNdsBxszTSyB
        AvAr3a72S+p3YRRE6fLpLgVeRgSkW0VHBz0teAJMdYk6TI/9QiwNH6TOpMklNPEXhD+wuu
        /IkaKPrZFpsyUWdxj5O6F2wHWHtuB0Q=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-KFXopwmNMCGTU6w-CEbXZA-1; Sat, 13 Aug 2022 06:16:14 -0400
X-MC-Unique: KFXopwmNMCGTU6w-CEbXZA-1
Received: by mail-yb1-f197.google.com with SMTP id 130-20020a250188000000b006777ce7728cso2565781ybb.4
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 03:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kxuhdyECDecFWFU7Cl1otkHgGws3cgxQwNohBZWx2rk=;
        b=L1jDcdo79Zo1t6GX2w5S30x9vbFpwLcO+17q9CipsBEZRI/ta3BLT1/IZ5SkpElU8x
         Hvw44Ox3EGZK1Fz7Y/+oBv7GBg6qEmzt7x2n7vt0LS9g/LN4FC1XmHAnlrK5ZdCJv1Lj
         CX+U20wweYOL602Ew5OM3PPHWDvJN8TXo5nx8tjE13shShzzETG00YGwu91Wnc+BoCQB
         3TSFjACpTqS6H2jG/vctyLWDPCZYLKGtoGHhShR3Oich0gIloNHZQDElCy8bxocODRaO
         vLN/kSZpczuW3TDza6EbHPVtz8nRyA7xPUz/MCgenCbBz8fVoh8ZG0TRyTqkHYDh+qrO
         XR3Q==
X-Gm-Message-State: ACgBeo07qHeU0yO+UCPLsO1GHSPDcrcwJG3X+O6RO4TWPf4viZF9nlPG
        hyWCMduaG7MbcMPB3v9U40hRRjK8Z+q7dGRqiI+9DAm26ZLZlEzV7DvsIvYhoMI9omSptTs+6g8
        6gPOtm+odPtmiN6SpRLcreutMAzF4xToB0YUTju8=
X-Received: by 2002:a25:4986:0:b0:67b:c97f:6975 with SMTP id w128-20020a254986000000b0067bc97f6975mr5580744yba.520.1660385774126;
        Sat, 13 Aug 2022 03:16:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7NjWJlCpq5v/LdS5iBE5MaUF9Uy4TO9uoUfKHGEPc8tk7Z9Aap2Y03s+8tgahkQ4js9czAizNOCruqQmyJrAM=
X-Received: by 2002:a25:4986:0:b0:67b:c97f:6975 with SMTP id
 w128-20020a254986000000b0067bc97f6975mr5580733yba.520.1660385773904; Sat, 13
 Aug 2022 03:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220809091629.104682-1-ZiyangZhang@linux.alibaba.com> <20220809091629.104682-2-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220809091629.104682-2-ZiyangZhang@linux.alibaba.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Sat, 13 Aug 2022 18:16:02 +0800
Message-ID: <CAFj5m9KacVsDkbLhXpOK71D5jq3Udqao1Gw9uT9boW_Ftr1xaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ublk_drv: check ubq_daemon_is_dying() in __ublk_rq_task_work()
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 9, 2022 at 5:17 PM ZiyangZhang
<ZiyangZhang@linux.alibaba.com> wrote:
>
> Replace direct check on PF_EXITING in __ublk_rq_task_work() by the
> existing wrapper. Also inline ubq_daemon_is_dying().
>
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2b7d1db5c4a7..3797bd64c3c3 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -555,7 +555,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>         return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
>  }
>
> -static bool ubq_daemon_is_dying(struct ublk_queue *ubq)
> +static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
>  {
>         return ubq->ubq_daemon->flags & PF_EXITING;
>  }
> @@ -644,8 +644,7 @@ static inline void __ublk_rq_task_work(struct request *req)
>         struct ublk_device *ub = ubq->dev;
>         int tag = req->tag;
>         struct ublk_io *io = &ubq->ios[tag];
> -       bool task_exiting = current != ubq->ubq_daemon ||
> -               (current->flags & PF_EXITING);
> +       bool task_exiting = current != ubq->ubq_daemon || ubq_daemon_is_dying(ubq);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

