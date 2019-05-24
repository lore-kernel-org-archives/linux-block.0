Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A6C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 12:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB882081C
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 12:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391289AbfEXMQU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 08:16:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45599 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbfEXMQU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 08:16:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id t24so8455446otl.12
        for <linux-block@vger.kernel.org>; Fri, 24 May 2019 05:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oKTwkde9XEJOFpcJOnGspoMofZM+LnbPvQVIhROM6s=;
        b=n7vbDCirk6msBJnOZZ4oaAP2AXRTuRnf7IgYFV5uPQDNgeXnMiqD9L5Q4zrx90w1KM
         rcbZ+2UrgXuQsZVqM/qX+ZTEZGUSYbQMnrZmNTFA7T7lbXRofdiUXcpl90ZhNekM79B1
         PSBYH1/aTrgAakN6ihwPRNuIKZRMDivINXAje3wHm/kkNp0ReRHY0UIys8AfgPAWFoGz
         V43jUDajHHBiuTdDaCmjvhF+LItYrQrpE55jP1mUBqUQYJen3yMMIIwDDPzOVJy39hfC
         jue8qdlD2iERTlts6Gjjnf0PfBScZtxp65gM6szrS+Lrq+8CRIRAwCbpbdHRMRwnF5Ez
         GTmQ==
X-Gm-Message-State: APjAAAWg2xKt1fE59qdYES0K+0Yaf7ViLVSasEoyQ7N2tJLjtvavWA4J
        +Arul0BIpZ5aLA5gTraib9b6KzzcMJf7Tt2yrEdzvQ==
X-Google-Smtp-Source: APXvYqxazIFqgvL6u5aVzpH6WHlSgorriA+H9vzek+eGtqx0gS/lpZLKygdMQDHfJnmyLHrmAXZln0j9ZIPe2DD3Xek=
X-Received: by 2002:a9d:6a86:: with SMTP id l6mr1942853otq.93.1558700179814;
 Fri, 24 May 2019 05:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190523214939.30277-1-jpittman@redhat.com> <CACVXFVNr_-A2u=8=Uni4K7HgfEBc2g1JAFfW98TY2tZKzcH9+g@mail.gmail.com>
In-Reply-To: <CACVXFVNr_-A2u=8=Uni4K7HgfEBc2g1JAFfW98TY2tZKzcH9+g@mail.gmail.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Fri, 24 May 2019 08:16:08 -0400
Message-ID: <CA+RJvhxLnS+OhxfeYHY16By0njt-yd0C5R66SU81sXY7fpvzfw@mail.gmail.com>
Subject: Re: [PATCH] block: print offending values when cloned rq limits are exceeded
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming; thanks for reviewing.  I've not seen anything in 5.x.
Currently, we have a RHEL case for kernel 3.x where we've hit this
error, but we've yet to identify root cause.  As part of debugging,
the techs involved are having to grab the values via systemtap (which
the end-user is resisting).  Please feel free to contact me off-list
if you want the details on the case.  If the patch is approved here, I
was planning to see if you would pull it into the RHEL stream for 4.x
so we would not have to mess w/ systemtap next time.  Generally, in
support, when we see this error it's from an admin or script setting
bad stacking values.

On Thu, May 23, 2019 at 9:58 PM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Fri, May 24, 2019 at 5:50 AM John Pittman <jpittman@redhat.com> wrote:
> >
> > While troubleshooting issues where cloned request limits have been
> > exceeded, it is often beneficial to know the actual values that
> > have been breached.  Print these values, assisting in ease of
> > identification of root cause of the breach.
> >
> > Signed-off-by: John Pittman <jpittman@redhat.com>
> > ---
> >  block/blk-core.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 419d600e6637..af62150bb1ba 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1199,7 +1199,9 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
> >                                       struct request *rq)
> >  {
> >         if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
> > -               printk(KERN_ERR "%s: over max size limit.\n", __func__);
> > +               printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
> > +                       __func__, blk_rq_sectors(rq),
> > +                       blk_queue_get_max_sectors(q, req_op(rq)));
> >                 return -EIO;
> >         }
> >
> > @@ -1211,7 +1213,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
> >          */
> >         blk_recalc_rq_segments(rq);
> >         if (rq->nr_phys_segments > queue_max_segments(q)) {
> > -               printk(KERN_ERR "%s: over max segments limit.\n", __func__);
> > +               printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
> > +                       __func__, rq->nr_phys_segments, queue_max_segments(q));
> >                 return -EIO;
> >         }
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> BTW, do you still see such kind of warning since v5.1? If yes, could
> you share something
> more?
>
> Thanks,
> Ming Lei
