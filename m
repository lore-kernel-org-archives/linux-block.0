Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5597C32774
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 16:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiHVQXV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiHVQXU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 12:23:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6739B52
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 09:23:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j21so16873934ejs.0
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EE1aqTdlibrHEF4utdqSiRW8iT6Z8Qft9Gec3pOWS0g=;
        b=h4OKsmPm8lcsxxenj4LPbgeTgsMkILQHX3JN0PBkW0ER9H/i6rbclf2vnROuC539tp
         q1ttjv/U6JRT7tEp+89YY/EGYs+zSR694DFa/0SQutGl712zsHCAzACH8e55HrPCrO8M
         c8rha1v1NRRwdWTCNZ9LxX30Qha4oZ09F7qQnguyjrb9dCy35aM6Qhlau7q2hhO6N/er
         w6w9wcbj70eUw3ZrM8SzfTGiTX9/V+2n1p/RMQwh14Vjt4esnKKKtw4oZLrulcczG1kR
         TLrTaHNYMZcX2Wg77LWORSeDFEgjCkPN6Qela44dsUkC91askOcGTcmsrE0YdvjidBnM
         Wdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EE1aqTdlibrHEF4utdqSiRW8iT6Z8Qft9Gec3pOWS0g=;
        b=RLcLZ+ai/Ga3EwLYFTjuIdp71fZoYlYh/mceJBVmG/41iS0tVzG97IwCST4FIaWW5Q
         ZystFD7yoMoctXGpeCfNTR/0UusPnrnwDwJhqdoUihWrHBz0uR0m7GOoF5bTuYV1+Jmx
         TXu5KqHbCKBYrA2zNbupXCRfvve9a9Z1o+9WH6bSlBqoadszmT2pLio7lf95+cs9okMZ
         AaA+FfFv+04b9z2JKjea+tXyh89r2KiTbRlwZ7OAAZJwnC6Pwnga4r2O6D+08ORGTSAZ
         7hgptINqzqRzWWdbjPq1UwZpEgPj/vdhtns/3zeMn9l5uN9WkeFRzxD8mS8QVy3e+nbC
         KVAA==
X-Gm-Message-State: ACgBeo2KMaZnQR359QHsvUEqYVbVBBAJZoOjvJcGRVFDyQ2XeQZQDn4p
        /r1c7R1fGGGIIwwHZosEbjIq/lUcQAUgOOOpbig=
X-Google-Smtp-Source: AA6agR78XtD4OIwdwPqQCsdn94fsZCYoTrPNaBPJO2Yudx4dlxP/Qh2vppqjJ8UjkUieYCp7EXOT5OOvMxfq5vBElD4=
X-Received: by 2002:a17:907:2816:b0:73d:7af2:37f5 with SMTP id
 eb22-20020a170907281600b0073d7af237f5mr4639645ejc.588.1661185393254; Mon, 22
 Aug 2022 09:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBb6MUP5sH2Ohgrm4UE9ygOF2nKK4dEYWsrwfDUbSMH5Lb=ew@mail.gmail.com>
 <CAFNWusbavuD9vMuTjV0fEFjTCnMCd1+HPkUC+GsF2FYewrDJ_Q@mail.gmail.com>
 <CAPBb6MW0Ou8CcWCD-n+9-B0daiviP1Uk9A9C0QBp=B2oFECF3w@mail.gmail.com>
 <CAFNWusYr_3FjZtALxjq8ty=-FvWqzW=j1K7Mynuz0W9Vh8tD5A@mail.gmail.com> <CAPBb6MV74xgOKUBfej3etF4ZDuVEHhGciCwYyzOBfOBY27v2qg@mail.gmail.com>
In-Reply-To: <CAPBb6MV74xgOKUBfej3etF4ZDuVEHhGciCwYyzOBfOBY27v2qg@mail.gmail.com>
From:   Kim Suwan <suwan.kim027@gmail.com>
Date:   Tue, 23 Aug 2022 01:23:02 +0900
Message-ID: <CAFNWusYobFdqaEj12ND7Ee9pT+GRxPQwYNEEAG1LMEXCgUQjDA@mail.gmail.com>
Subject: Re: WARN_ON_ONCE reached with "virtio-blk: support mq_ops->queue_rqs()"
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alexandre,

On Mon, Aug 22, 2022 at 4:03 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> Hi Suwan, apologies for taking so long to come back to this.
>
> On Tue, Aug 2, 2022 at 11:50 PM Kim Suwan <suwan.kim027@gmail.com> wrote:
> >
> > Hi Alexandre
> >
> > On Tue, Aug 2, 2022 at 11:12 AM Alexandre Courbot <acourbot@chromium.org> wrote:
> > >
> > >  Hi Suwan,
> > >
> > > Thanks for the fast reply!
> > >
> > > On Tue, Aug 2, 2022 at 1:55 AM Kim Suwan <suwan.kim027@gmail.com> wrote:
> > > >
> > > > Hi Alexandre,
> > > >
> > > > Thanks for reporting the issue.
> > > >
> > > > I think a possible scenario is that request fails at
> > > > virtio_queue_rqs() and it is passed to normal path (virtio_queue_rq).
> > > >
> > > > In this procedure, It is possible that blk_mq_start_request()
> > > > was called twice changing request state from MQ_RQ_IN_FLIGHT to
> > > > MQ_RQ_IN_FLIGHT.
> > >
> > > I have checked whether virtblk_prep_rq_batch() within
> > > virtio_queue_rqs() ever returns 0, and it looks like it never happens.
> > > So as far as I can tell all virtio_queue_rqs() are processed
> > > successfully - but maybe the request can also fail further down the
> > > line? Is there some extra instrumentation I can do to check that?
> > >
> >
> > I'm looking at one more suspicious code.
> > If virtblk_add_req() fails within virtblk_add_req_batch(),
> > virtio_queue_rqs() passes the failed request to the normal path also
> > (virtio_queue_rq). Then, it can call blk_mq_start_request() twice.
> >
> > Because I can't reproduce the issue on my vm, Could you test
> > the below patch?
> > I defer the blk_mq_start_request() call after virtblk_add_req()
> > to ensure that we call blk_mq_start_request() after all the
> > preparations finish.
>
> Your patch seems to solve the problem! I am not seeing the warning
> anymore and the block device looks happy.

Good news! Thanks for the test!

> Let me know if I can do anything else.

Could you test one more patch?
I move blk_mq_start_request(req) before spinlock() to reduce time
holding the lock within virtio_queue_rq().
If it is ok, I will send the patch.

Regards,
Suwan Kim

---
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf181..73a0620a7cff 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -322,8 +322,6 @@ static blk_status_t virtblk_prep_rq(struct
blk_mq_hw_ctx *hctx,
        if (unlikely(status))
                return status;

-       blk_mq_start_request(req);
-
        vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
        if (unlikely(vbr->sg_table.nents < 0)) {
                virtblk_cleanup_cmd(req);
@@ -349,6 +347,8 @@ static blk_status_t virtio_queue_rq(struct
blk_mq_hw_ctx *hctx,
        if (unlikely(status))
                return status;

+       blk_mq_start_request(req);
+
        spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
        err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
        if (err) {
@@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
                        virtblk_unmap_data(req, vbr);
                        virtblk_cleanup_cmd(req);
                        rq_list_add(requeue_list, req);
+               } else {
+                       blk_mq_start_request(req);
                }
        }
