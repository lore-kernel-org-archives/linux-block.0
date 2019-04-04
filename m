Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7DC4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F4320882
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV5BXuda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfDDUpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:45:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51703 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbfDDUpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 16:45:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so4549091wmf.1;
        Thu, 04 Apr 2019 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJ3LqH3+9kLJ8YsOxpsT4Qk2MjhrkIZKxxyjNP5fxVs=;
        b=qV5BXudaQafV5J89PZSeMQuhY8IRexHtqOg+8/CIUSG/MFmKvDWmQValHS+GhBZTyF
         FBq1ixjLVtP2O+9hV+nCdl5fSIi+oAGhdvujhjN+npzngdx9YqlR4j7gn8iYzr5VxSa7
         O242AlW3QdxN6XQ7HoepW78d31ghVt5P6vlLrrSUPKElbgQumqrMfLqm9VchMvoAS+Nl
         KurznzNzsC9PGBHFlVvdDSLpfkPkAdF5sEYIl+HTjNOOHJQu22B6pX3Sp/G+hkSA2yNk
         dAAG/2HmhlbronjL3giAXudbZHBUzWzaXSjO0WSTJyv1I9CWuVeIbk+3vg4eQdpD5M3K
         6wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJ3LqH3+9kLJ8YsOxpsT4Qk2MjhrkIZKxxyjNP5fxVs=;
        b=tI7tlugxiwEnjsq3DqDF5wnf1Vr19VDhyTKAAVfnAE4epQwtxQV9Lf8DY36xGoV6pL
         Ov45mBCzOPWJm3lrp8TGJCv42vyAikR+f1UvIHrdihYyfEXNad6+vPkY4dGuaP3zMtm5
         gFMI/R4IHYVBbgT2Y4QeasYihJdxl+Darkv/4My0dHdNdGoTqD3WVyGzKMR7aPuQClg5
         N3WziTuPfrj3NTmJWfBdkorO67Dj7JtBsPHLnz+L7JaNUHxF/AAFHuXUjhwVeTh7RA1z
         /QKjlV9gBVw08qC4GwYWZ0ZwYKif8+85gwe9lHnWgZQgoxO+/oO6nShfeSaFP4KFxb/2
         G5Lw==
X-Gm-Message-State: APjAAAV1nj3V8IiPpbU3/r+W2J6rX7T5sxupygPLjKdVqFyCGDupBeLD
        NcELNRaah/JSskuqAZnC4QSABy8y5k6LlnZO8JE=
X-Google-Smtp-Source: APXvYqwPTeMf9c79JFfY4EXf1JmTErJsXTybIDc2XRpwsKvvrGgoIlKFMeRVeDX0tB6ikSH7buM8NxQo3Haafuf1EyQ=
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr5193641wmb.23.1554410714573;
 Thu, 04 Apr 2019 13:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190404084320.24681-1-ming.lei@redhat.com> <20190404084320.24681-2-ming.lei@redhat.com>
 <1554393507.118779.251.camel@acm.org>
In-Reply-To: <1554393507.118779.251.camel@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 5 Apr 2019 04:45:03 +0800
Message-ID: <CACVXFVP8C4ZVA+s8FTZ2sZcpn96AQXBAbYS0-5cxB-GT=vTLhw@mail.gmail.com>
Subject: Re: [PATCH V4 1/7] blk-mq: grab .q_usage_counter when queuing request
 from plug code path
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 4, 2019 at 11:58 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2019-04-04 at 16:43 +0800, Ming Lei wrote:
> > Just like aio/io_uring, we need to grab 2 refcount for queuing one
> > request, one is for submission, another is for completion.
> >
> > If the request isn't queued from plug code path, the refcount grabbed
> > in generic_make_request() serves for submission. In theroy, this
> > refcount should have been released after the sumission(async run queue)
> > is done. blk_freeze_queue() works with blk_sync_queue() together
> > for avoiding race between cleanup queue and IO submission, given async
> > run queue activities are canceled because hctx->run_work is scheduled with
> > the refcount held, so it is fine to not hold the refcount when
> > running the run queue work function for dispatch IO.
> >
> > However, if request is staggered into plug list, and finally queued
> > from plug code path, the refcount in submission side is actually missed.
> > And we may start to run queue after queue is removed because the queue's
> > kobject refcount isn't guaranteed to be grabbed in flushing plug list
> > context, then kernel oops is triggered, see the following race:
> >
> > blk_mq_flush_plug_list():
> >         blk_mq_sched_insert_requests()
> >                 insert requests to sw queue or scheduler queue
> >                 blk_mq_run_hw_queue
> >
> > Because of concurrent run queue, all requests inserted above may be
> > completed before calling the above blk_mq_run_hw_queue. Then queue can
> > be freed during the above blk_mq_run_hw_queue().
> >
> > Fixes the issue by grab .q_usage_counter before calling
> > blk_mq_sched_insert_requests() in blk_mq_flush_plug_list(). This way is
> > safe because the queue is absolutely alive before inserting request.
> >
> > Cc: Dongli Zhang <dongli.zhang@oracle.com>
> > Cc: James Smart <james.smart@broadcom.com>
> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: linux-scsi@vger.kernel.org,
> > Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> > Cc: Christoph Hellwig <hch@lst.de>,
> > Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> > Cc: jianchao wang <jianchao.w.wang@oracle.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 3ff3d7b49969..5b586affee09 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1728,9 +1728,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> >                 if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
> >                         if (this_hctx) {
> >                                 trace_block_unplug(this_q, depth, !from_schedule);
> > +
> > +                               percpu_ref_get(&this_q->q_usage_counter);
> >                                 blk_mq_sched_insert_requests(this_hctx, this_ctx,
> >                                                                 &rq_list,
> >                                                                 from_schedule);
> > +                               percpu_ref_put(&this_q->q_usage_counter);
> >                         }
> >
> >                         this_q = rq->q;
> > @@ -1749,8 +1752,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> >          */
> >         if (this_hctx) {
> >                 trace_block_unplug(this_q, depth, !from_schedule);
> > +
> > +               percpu_ref_get(&this_q->q_usage_counter);
> >                 blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
> >                                                 from_schedule);
> > +               percpu_ref_put(&this_q->q_usage_counter);
> >         }
> >  }
>
> Although this patch looks fine to me: have you considered to insert one
> percpu_ref_get() call at the start of blk_mq_flush_plug_list() and one
> percpu_ref_put() call at the end of the same function?

Requests from different request queues can be added to the same per-task
plug list, so we can't do that way simply.

Thanks,
Ming Lei
