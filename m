Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35093C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 19:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC5C64E75
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhBHTBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:01:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234670AbhBHS7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Feb 2021 13:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612810697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z552II2iY7BYWfkaIB5xZqJZQyV+he+lkpb3Svc6M2g=;
        b=J4k+2NNrmHhtDKoK/RwqDG5XLznl5gxNvLOx7XIZDW6Ui1GKpLpvlq2o5kD6sgA0+r0wuy
        k1mjpoHjoh48CkNwCGJcya8ykJgJKVmrwkqpKJpZUUJAFfSkz2Caa9DEhy4cZEoDpGJ08h
        ujI+I66FqSORx/EgrxkCJYGx5V03Xm0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-6Q28GzzyNdiZy2gVfl_Ihg-1; Mon, 08 Feb 2021 13:58:15 -0500
X-MC-Unique: 6Q28GzzyNdiZy2gVfl_Ihg-1
Received: by mail-ot1-f71.google.com with SMTP id x60so8864297ota.15
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 10:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z552II2iY7BYWfkaIB5xZqJZQyV+he+lkpb3Svc6M2g=;
        b=nnro9PfiM9Bf3xvHG91aEfadDXQzEsbW5blOV2q9ljyLxuOkJMyvDAIs2eJz8SNJzC
         eojM+UQBrW+KvMUZE1C9hV60N6swIgPGQAuOuknLN/dNwnWwX3gOAs91JZg8zeg1J4co
         Fc7NB5qVb7jwXAuwMXrBF53QF44EOU2RoY+hgZH5mYUga4FJ1jkmMX2Li9ZcOdtKzd2b
         yBG9/3Ro+5BibTE9PapFD8CUfMq7zUyBW9WKFDgnxjLUJy1QWKth45z48hRbbzdOiRr4
         FkxAJiLoEbRbrI0++cp94i4YvT3EhamxvWf9KFndDnA0igiPqeDyPw2l0jmbtsNNtQMP
         Yl7g==
X-Gm-Message-State: AOAM533auVNoiYfRb8gvVuXsH9aqR5A/QPBoCxTmn+8JlF3m0kdkGk8n
        4vW8eUPRiJIhZGH+NTIIWINc153A2/w12q/zuHXaCzT4MQs/MmfF03N0KFK6/QTPoqo5nDUV+fc
        gE0kXr/3d1snYQqUsL7wWycX8Ofr9OiX9EDIBfyY=
X-Received: by 2002:aca:5249:: with SMTP id g70mr139274oib.68.1612810695058;
        Mon, 08 Feb 2021 10:58:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPH5wtYwnU+wpUUXoLKqxQQE07ThxdHnis1/JNZmkYb1uiooNuYLTsJu5bFhs1FY6h/DyorVv7iZ0rHkJ8zzE=
X-Received: by 2002:aca:5249:: with SMTP id g70mr139264oib.68.1612810694886;
 Mon, 08 Feb 2021 10:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20210201164850.391332-1-djeffery@redhat.com> <20210204022740.GB1108591@T590>
 <8ce70420d1dcb5dd0ffc73aaa38d8ce61eb19cff.camel@redhat.com>
In-Reply-To: <8ce70420d1dcb5dd0ffc73aaa38d8ce61eb19cff.camel@redhat.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Mon, 8 Feb 2021 13:58:04 -0500
Message-ID: <CA+RJvhyNymmqyQdZ=7hT0abP7eHz6UX0zapHbdFQesahJrRCLQ@mail.gmail.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        David Jeffery <djeffery@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, when you get a moment, could you take a quick look at this one for ack?

On Thu, Feb 4, 2021 at 11:49 AM Laurence Oberman <loberman@redhat.com> wrote:
>
> On Thu, 2021-02-04 at 10:27 +0800, Ming Lei wrote:
> > On Mon, Feb 01, 2021 at 11:48:50AM -0500, David Jeffery wrote:
> > > When a stacked block device inserts a request into another block
> > > device
> > > using blk_insert_cloned_request, the request's nr_phys_segments
> > > field gets
> > > recalculated by a call to blk_recalc_rq_segments in
> > > blk_cloned_rq_check_limits. But blk_recalc_rq_segments does not
> > > know how to
> > > handle multi-segment discards. For disk types which can handle
> > > multi-segment discards like nvme, this results in discard requests
> > > which
> > > claim a single segment when it should report several, triggering a
> > > warning
> > > in nvme and causing nvme to fail the discard from the invalid
> > > state.
> > >
> > >  WARNING: CPU: 5 PID: 191 at drivers/nvme/host/core.c:700
> > > nvme_setup_discard+0x170/0x1e0 [nvme_core]
> > >  ...
> > >  nvme_setup_cmd+0x217/0x270 [nvme_core]
> > >  nvme_loop_queue_rq+0x51/0x1b0 [nvme_loop]
> > >  __blk_mq_try_issue_directly+0xe7/0x1b0
> > >  blk_mq_request_issue_directly+0x41/0x70
> > >  ? blk_account_io_start+0x40/0x50
> > >  dm_mq_queue_rq+0x200/0x3e0
> > >  blk_mq_dispatch_rq_list+0x10a/0x7d0
> > >  ? __sbitmap_queue_get+0x25/0x90
> > >  ? elv_rb_del+0x1f/0x30
> > >  ? deadline_remove_request+0x55/0xb0
> > >  ? dd_dispatch_request+0x181/0x210
> > >  __blk_mq_do_dispatch_sched+0x144/0x290
> > >  ? bio_attempt_discard_merge+0x134/0x1f0
> > >  __blk_mq_sched_dispatch_requests+0x129/0x180
> > >  blk_mq_sched_dispatch_requests+0x30/0x60
> > >  __blk_mq_run_hw_queue+0x47/0xe0
> > >  __blk_mq_delay_run_hw_queue+0x15b/0x170
> > >  blk_mq_sched_insert_requests+0x68/0xe0
> > >  blk_mq_flush_plug_list+0xf0/0x170
> > >  blk_finish_plug+0x36/0x50
> > >  xlog_cil_committed+0x19f/0x290 [xfs]
> > >  xlog_cil_process_committed+0x57/0x80 [xfs]
> > >  xlog_state_do_callback+0x1e0/0x2a0 [xfs]
> > >  xlog_ioend_work+0x2f/0x80 [xfs]
> > >  process_one_work+0x1b6/0x350
> > >  worker_thread+0x53/0x3e0
> > >  ? process_one_work+0x350/0x350
> > >  kthread+0x11b/0x140
> > >  ? __kthread_bind_mask+0x60/0x60
> > >  ret_from_fork+0x22/0x30
> > >
> > > This patch fixes blk_recalc_rq_segments to be aware of devices
> > > which can
> > > have multi-segment discards. It calculates the correct discard
> > > segment
> > > count by counting the number of bio as each discard bio is
> > > considered its
> > > own segment.
> > >
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > ---
> > >  block/blk-merge.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > > index 808768f6b174..fe7358bd5d09 100644
> > > --- a/block/blk-merge.c
> > > +++ b/block/blk-merge.c
> > > @@ -382,6 +382,13 @@ unsigned int blk_recalc_rq_segments(struct
> > > request *rq)
> > >
> > >     switch (bio_op(rq->bio)) {
> > >     case REQ_OP_DISCARD:
> > > +           if (queue_max_discard_segments(rq->q) > 1) {
> > > +                   struct bio *bio = rq->bio;
> > > +                   for_each_bio(bio)
> > > +                           nr_phys_segs++;
> > > +                   return nr_phys_segs;
> > > +           }
> > > +           /* fall through */
> > >     case REQ_OP_SECURE_ERASE:
> > >     case REQ_OP_WRITE_ZEROES:
> > >             return 0;
> >
> > blk_rq_nr_discard_segments() always returns >=1 segments, so no
> > similar
> > issue in case of single range discard.
> >
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> >
> > And it can be thought as:
> >
> > Fixes: 1e739730c5b9 ("block: optionally merge discontiguous discard
> > bios into a single request")
> >
> >
>
> Great, can we get enough acks and push this through its urgent for me
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
>

