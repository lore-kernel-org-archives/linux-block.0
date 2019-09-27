Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0AFC4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 13:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B340221906
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 13:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="TCNyAOxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfI0NIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:08:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34761 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0NIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 09:08:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so2468214lja.1
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RExgLv+pAFXtRH4z4VbgybzHgNsxdWhODH/VeLzEMw=;
        b=TCNyAOxFFu4JS8KRbwkp8OswGTb/vlYPPEJx9mFogADwO9rh0eDCaiy1+xTGIhJG1h
         pekR/Ggwo8WP1BltjBSNzV0ytasICI8HdHlrMiV9rSKdOzDZt3n9zpzWLm+SEjUtYkeZ
         kJI1UPsOF/K8czh1BrdNBvNWjjgIlaQ6gz/JJi+3dS9S3ndF096DeVsZliHlRAN4Jj69
         Zb+cFn16UIOCGs/G2TZoZdUU9yksHJoBG6CX+TTzJKGEX0Fc3bNPLB6cpgpSwprw5+UX
         bSntZUkUQ24+74uXmM4/fCIDGk4QH8GlB2Y0InqoVRbs14deqnLYuxMxFOY/KLDjF/sH
         ebdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RExgLv+pAFXtRH4z4VbgybzHgNsxdWhODH/VeLzEMw=;
        b=hlHvxODNPk/ltbSCYAdfCEl/mESWcfxvJdjir6iSeGh9k/ZU3XkR6L2QOAqLVuJtio
         PAIrwk4UJ9QOzfiTk0UlMGAvV0j0tw2lawriaPdr+AykL5zTxeoDEHfY60pVOxIOatW4
         LZpVlIAaLfrA+yNzaPRBkgJPIpUpeXnH7MkHNcoX1L+3TtB/Gucyn763LHpn69DJOBli
         IQ+SWejAsrY7F/cdcKVlApscT/yKtjY86Tc20A+qGArU4H/7QEIju7DGPFKy+7W9Ql8Y
         a2QyuVtsAQEtSabL5P3EGfMR7nerpU0k0JDt6Y0ZiBt64VQAHnM2bvB4QyD3BrIBxH0b
         9IBw==
X-Gm-Message-State: APjAAAVKGdXlMmeyJpoQZR/HrRI5v7XBE1FNfdK7amdVdoJGqObt+AhD
        L/EzW2qPMFHTlrHBojuUgKrMKVRbBCzKw21KCPrEHw==
X-Google-Smtp-Source: APXvYqxA0n7C1ZotlsSkCEQ9rElVNk38vsHvjDaXtKTw5PYLMISEFovZ75cBfOHklHKKBI1l66uY1p4RDvnNxz7xE1w=
X-Received: by 2002:a2e:1246:: with SMTP id t67mr2928723lje.174.1569589683719;
 Fri, 27 Sep 2019 06:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190927072431.23901-1-ming.lei@redhat.com> <20190927072431.23901-2-ming.lei@redhat.com>
In-Reply-To: <20190927072431.23901-2-ming.lei@redhat.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Fri, 27 Sep 2019 15:07:52 +0200
Message-ID: <CANr-nt3duYaBebJX7tfQOMP-5dfiQYNN_bdPhFy9rcnqgCOc-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] blk-mq: respect io scheduler
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 27, 2019 at 9:25 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Now in case of real MQ, io scheduler may be bypassed, and not only this
> way may hurt performance for some slow MQ device, but also break zoned
> device which depends on mq-deadline for respecting the write order in
> one zone.
>
> So don't bypass io scheduler if we have one setup.
>
> This patch can double sequential write performance basically on MQ
> scsi_debug when mq-deadline is applied.
>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 20a49be536b5..d7aed6518e62 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2003,6 +2003,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>                 }
>
>                 blk_add_rq_to_plug(plug, rq);
> +       } else if (q->elevator) {
> +               blk_mq_sched_insert_request(rq, false, true, true);
>         } else if (plug && !blk_queue_nomerges(q)) {
>                 /*
>                  * We do limited plugging. If the bio can be merged, do that.
> @@ -2026,8 +2028,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>                         blk_mq_try_issue_directly(data.hctx, same_queue_rq,
>                                         &cookie);
>                 }
> -       } else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
> -                       !data.hctx->dispatch_busy)) {
> +       } else if ((q->nr_hw_queues > 1 && is_sync) ||
> +                       !data.hctx->dispatch_busy) {
>                 blk_mq_try_issue_directly(data.hctx, rq, &cookie);
>         } else {
>                 blk_mq_sched_insert_request(rq, false, true, true);
> --
> 2.20.1
>

I've verified that the issue I saw with zone locking being skipped due
to scheduler bypass is resolved with this patch.

Thanks,
Hans
