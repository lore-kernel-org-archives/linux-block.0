Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A817FC433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 02:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiBHCpg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 21:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiBHCpg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 21:45:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BA31C061A73
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 18:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644288333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6BN0mbmYU8WOmip3d/Bn0GB9f6Qt0Wj318qmPKW2Vg=;
        b=RTdQBVtFAzERSUrtRiGFOdY8sNpg4zipXZoqB+BVJLCYIQxJmfUyUGK2bVVKKNCTgjZAWl
        GnCLwSJekn2X3B9tMFDgUjC84wLKG4YaKzKcz7QeYz4lwznciRupq4gaUhCr7T8ym4fgce
        WAY6rj5zBxdu6wIKZDmyBiLowGwS2ac=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-J3qsk1EhOV6yvnCd995dxg-1; Mon, 07 Feb 2022 21:45:32 -0500
X-MC-Unique: J3qsk1EhOV6yvnCd995dxg-1
Received: by mail-lj1-f197.google.com with SMTP id c31-20020a2ebf1f000000b0022d87a28911so5333475ljr.1
        for <linux-block@vger.kernel.org>; Mon, 07 Feb 2022 18:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6BN0mbmYU8WOmip3d/Bn0GB9f6Qt0Wj318qmPKW2Vg=;
        b=RXAwypTRTqENNJ1EWai6U/sSMDl2lT72IYlden5/Ifrhrw6laMuBDm+8ma3QlttKPd
         8BZpNhPPYbp3Jq1vjjx4bZ2qIMf0SizekaA6vG5sPIRVPVbIwCXOrGeWTJWK4expfp7T
         L0AwCq4rQBjYK4EGbyAirCqARowkaxXRQ4RstWB2ynhHPQjtiAAnjZ1de8/8bNIR/6kx
         44LcYfR13RM4tLCn+e4CDsvUuTKUGgyO1SD0JncUvsrsaE/4Q6E0kSV3bruB2p5cxpo9
         bUKq+z/Aq8T3DPVmi6lKglUtD9AU7Ntsch4TYZcsbuD/iczd8AGCaF7a2efm528BII/4
         Tq4Q==
X-Gm-Message-State: AOAM530ZZRy75/o0h9k/STuJ43Ee3IrK2nQisnGOHCiBlPt4wa9JFTy8
        uN3DV1dGLcl/VLzKwvrNIFYjdECBXMwy6gLF6dZoa6jfqCwQXhYWJ2F2symbNh/97qLWRZR1cMN
        ESU0U2jZAxquGvxJXknqFKAb7ujpbtz7Jzl4atGM=
X-Received: by 2002:a05:6512:3f8b:: with SMTP id x11mr1571728lfa.143.1644288330597;
        Mon, 07 Feb 2022 18:45:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1TAhwHY9GylL3uHGRpR1eOK8dYpLAq74qmePzcrTOkaF7IQM0aBiynkrg4PdTCxVdXxVt12uYOwHqnpsBQeo=
X-Received: by 2002:a05:6512:3f8b:: with SMTP id x11mr1571722lfa.143.1644288330353;
 Mon, 07 Feb 2022 18:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20220131203337.GA17666@redhat>
In-Reply-To: <20220131203337.GA17666@redhat>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 8 Feb 2022 10:45:18 +0800
Message-ID: <CAFj5m9Lej-oZx2x9f1aSiEDyND_J2cSNAbyytLcTEJWrDZJBvA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 1, 2022 at 4:34 AM David Jeffery <djeffery@redhat.com> wrote:
>
> When blk_mq_delay_run_hw_queues sets an hctx to run in the future, it can
> reset the delay length for an already pending delayed work run_work. This
> creates a scenario where multiple hctx may have their queues set to run,
> but if one runs first and finds nothing to do, it can reset the delay of
> another hctx and stall the other hctx's ability to run requests.
>
> To avoid this I/O stall when an hctx's run_work is already pending,
> leave it untouched to run at its current designated time rather than
> extending its delay. The work will still run which keeps closed the race
> calling blk_mq_delay_run_hw_queues is needed for while also avoiding the
> I/O stall.
>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  block/blk-mq.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f3bf3358a3bb..ae46eb4bf547 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2177,6 +2177,14 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
>         queue_for_each_hw_ctx(q, hctx, i) {
>                 if (blk_mq_hctx_stopped(hctx))
>                         continue;
> +               /*
> +                * If there is already a run_work pending, leave the
> +                * pending delay untouched. Otherwise, a hctx can stall
> +                * if another hctx is re-delaying the other's work
> +                * before the work executes.
> +                */
> +               if (delayed_work_pending(&hctx->run_work))
> +                       continue;

The issue is triggered on BFQ, since BFQ's has_work() may return true,
however its ->dispatch_request() may return NULL, so
blk_mq_delay_run_hw_queues()
is run for delay schedule.

In case of multiple hw queue, the described issue may be triggered, and cause io
stall for long time. And there are only 3 in-tree callers of
blk_mq_delay_run_hw_queues(),
David's fix works well for the 3 users, so this patch looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

