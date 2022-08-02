Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCE5C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 14:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiHBOuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHBOuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 10:50:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54AA1EED0
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 07:50:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o22so2473286edc.10
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4sH8YTZZDXQ1WTUIHKhwfQKEK1Ts7SykO93SDg3BII8=;
        b=YczgOKXXrSIdApFsbJEx+bGeubq/JICKORGpIKkyTemHaidO48DOFDFf7fUDqAErLM
         y0v+EvF4APZH2poQIX+LTuD3FHzcLDxgEYklE4ociV9kT9BGH1osJa88eMNpxEApPGV9
         WDCDB6eA2zErmTwtZb4Blwrqlxis8fS70K5wF/45HDQydH6tofywfeB5J6409tZnnRHU
         2mtfe46kDOLXYDmCLioC/RuFTPwCzOR2uM7sQie2okrlKKa/Dwzfl1KnKC+LNCFA3guy
         ++Hu4h4u3Gnf2GO27kebi6RsKK8P/v6iadUOZOrApe0FN9wUXIg+kU/iHfQvEYoNgX58
         hetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4sH8YTZZDXQ1WTUIHKhwfQKEK1Ts7SykO93SDg3BII8=;
        b=Q979/YdcwXuvCTWx3jHGOuEQy7Lsoai9YcOCZBPYzJJI4PRddnR6NeJaeYm2dNtjNy
         1tcnU6XBbPBnc7CpiC8sKGJM2yYG1XKP8TyN83tIuhMYN48cYds8wdrMFSorEVDR1A+F
         e16HLKDuRNjmx2XHyG5CGTTa3AbecykCs6MQRtatMYcBvZzCcCF4fLF0DAdvXh81/i/b
         NRFeRy60ZbbF+IYjXetRNmm3vZoWaqanWS8xvT5huC8ZcFijJRfcgjjTnaGcJDzvDg/7
         NbHv1TjDQMy3HQ37AlY1vO4NSYSv8T5rDVUY8FYvWH6XBxZqCZKIaydRNhKlZvnEXjKf
         Tadw==
X-Gm-Message-State: AJIora+EgKvTQ6O7vMB2+07gcodOrPQKKrojdGLgvzNlU2P7/xWiGuS1
        CslIgzlDbfJKt3uJRMTmW2mq8MpfP8V8NTPbTuA=
X-Google-Smtp-Source: AGRyM1tZuh/ZhqXMF6yyVVmw0vJo3T35yFsAf1CwzJLAWJ9i2PfaDQAfqpWi2k09rJULOlMtp460Qt4kSw9bjJ/DJPg=
X-Received: by 2002:a05:6402:5418:b0:435:5a48:daa9 with SMTP id
 ev24-20020a056402541800b004355a48daa9mr21252241edb.304.1659451807351; Tue, 02
 Aug 2022 07:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBb6MUP5sH2Ohgrm4UE9ygOF2nKK4dEYWsrwfDUbSMH5Lb=ew@mail.gmail.com>
 <CAFNWusbavuD9vMuTjV0fEFjTCnMCd1+HPkUC+GsF2FYewrDJ_Q@mail.gmail.com> <CAPBb6MW0Ou8CcWCD-n+9-B0daiviP1Uk9A9C0QBp=B2oFECF3w@mail.gmail.com>
In-Reply-To: <CAPBb6MW0Ou8CcWCD-n+9-B0daiviP1Uk9A9C0QBp=B2oFECF3w@mail.gmail.com>
From:   Kim Suwan <suwan.kim027@gmail.com>
Date:   Tue, 2 Aug 2022 23:49:56 +0900
Message-ID: <CAFNWusYr_3FjZtALxjq8ty=-FvWqzW=j1K7Mynuz0W9Vh8tD5A@mail.gmail.com>
Subject: Re: WARN_ON_ONCE reached with "virtio-blk: support mq_ops->queue_rqs()"
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alexandre

On Tue, Aug 2, 2022 at 11:12 AM Alexandre Courbot <acourbot@chromium.org> wrote:
>
>  Hi Suwan,
>
> Thanks for the fast reply!
>
> On Tue, Aug 2, 2022 at 1:55 AM Kim Suwan <suwan.kim027@gmail.com> wrote:
> >
> > Hi Alexandre,
> >
> > Thanks for reporting the issue.
> >
> > I think a possible scenario is that request fails at
> > virtio_queue_rqs() and it is passed to normal path (virtio_queue_rq).
> >
> > In this procedure, It is possible that blk_mq_start_request()
> > was called twice changing request state from MQ_RQ_IN_FLIGHT to
> > MQ_RQ_IN_FLIGHT.
>
> I have checked whether virtblk_prep_rq_batch() within
> virtio_queue_rqs() ever returns 0, and it looks like it never happens.
> So as far as I can tell all virtio_queue_rqs() are processed
> successfully - but maybe the request can also fail further down the
> line? Is there some extra instrumentation I can do to check that?
>

I'm looking at one more suspicious code.
If virtblk_add_req() fails within virtblk_add_req_batch(),
virtio_queue_rqs() passes the failed request to the normal path also
(virtio_queue_rq). Then, it can call blk_mq_start_request() twice.

Because I can't reproduce the issue on my vm, Could you test
the below patch?
I defer the blk_mq_start_request() call after virtblk_add_req()
to ensure that we call blk_mq_start_request() after all the
preparations finish.

> >
> > Could I know if the issue occurs every booting time?
>
> This is consistently happening at every boot, yes. However as I
> started adding printks here and there to try and figure out what was
> happening I have a harder time hitting that warning, suggesting a race
> condition somewhere...
>
> FWIW I have checked the status of the request that triggered the
> warning and as expected it is IN_FLIGHT.
>

I will look if there can be a race condition at virtio_queue_rqs().
Or maybe you can dump the two queues? (rqlist, requeue_list)

Regards,
Suwan Kim

---
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6fc7850c2b0a..300c442d656d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -314,8 +314,6 @@ static blk_status_t virtblk_prep_rq(struct
blk_mq_hw_ctx *hctx,
        if (unlikely(status))
                return status;

-       blk_mq_start_request(req);
-
        vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
        if (unlikely(vbr->sg_table.nents < 0)) {
                virtblk_cleanup_cmd(req);
@@ -363,6 +361,8 @@ static blk_status_t virtio_queue_rq(struct
blk_mq_hw_ctx *hctx,
                }
        }

+       blk_mq_start_request(req);
+
        if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
                notify = true;
        spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
@@ -401,6 +401,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
                        virtblk_unmap_data(req, vbr);
                        virtblk_cleanup_cmd(req);
                        rq_list_add(requeue_list, req);
+               } else {
+                       blk_mq_start_request(req);
                }
        }
