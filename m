Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3CCC43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 06:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CFA2148D
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 06:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umi0KioW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfCQGum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 02:50:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40731 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfCQGul (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 02:50:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so13590129wri.7;
        Sat, 16 Mar 2019 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpZgX3PM3WhaoCNYQcih3EfOTYtstAOy948hv0lgxHI=;
        b=Umi0KioWmUjUSM8yL4RHAxDdlauBoxWV1BNFWNJ77Ajbb87PBdPHVxhW+TvLEuSzOX
         3xvn+wm1OhiSejbYMMc8uhqJksonz9mLMXKTs9IYZi1/wTouqOyKyrTYdaFfqtk7zG1V
         yDy/gDnFIT2FkeVIaisnBPcbtONl9htAUbauXA5bbvwz/lFLZLkUy1PJNB89eb4GuhAl
         sUhMzEMSPl3zy1B9XHL/PTYhPsfkFENFR9kEHIY3usismMer2V+bK7MDG/GkDjwkZZtX
         XaYVXf4+EVW4xZPUdPNTPs753JIs/HkRp7T2JVnWd6k12muQ8DCHYR184FJ3FWnNCUVH
         PvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpZgX3PM3WhaoCNYQcih3EfOTYtstAOy948hv0lgxHI=;
        b=pbJ1b319v8979GkjMhMnDoVH8V1OZqfhXF4HVsnVbrGmCF5ErK4/p6CwPfThPdmJC3
         96oAfXQe5285aGICOlngUTic6vh8HX3aRRCcXSarLwwy44tuHpKGJeSJCoXqNH+YWLuA
         GEpNPnAeIuqUAjwF9iqBDO7bFyA35ILWrScgY3S2ih1YRqXLyGM+eFoTl3qqhSTeUhQ3
         Q1+13xOT318y1PlGM+Tkg5osPFDpADUd4dG95m4h2UhXw9aeFSqMMkCQyd1jRt+lw+kJ
         Q73T4ycDOUOVPNAb4fZnAonH46u2LHDTF+omRO2AhMit3tbEUR5GmW9sr/u+h2R4ApX0
         85wg==
X-Gm-Message-State: APjAAAWP1BPUaTLlnq80HvaeiWmypCBi2rcwtDZUyRatoDg1zaWZBTfL
        zvCGSsUTkU9ZkXSLjXWn721Xcy7I7ShtktP98I4=
X-Google-Smtp-Source: APXvYqw5Pwig+Bkh0aj//up1OVVCPzDTOrMuav3PcPHYUjvfK4gUnEv6WVVQDRP1M8YkjFiD/9Wn3Dh2v/F2Yrtc1KU=
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr7523191wrn.275.1552805439157;
 Sat, 16 Mar 2019 23:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com> <20190315161608.GB15153@localhost.localdomain>
In-Reply-To: <20190315161608.GB15153@localhost.localdomain>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sun, 17 Mar 2019 14:50:27 +0800
Message-ID: <CACVXFVM=r-jS_GnkAuARiiXLr3bQeWV5Gix3+F03B5oYbmdULw@mail.gmail.com>
Subject: Re: [PATCH 2/8] blk-mq: change the method of iterating busy tags of a request_queue
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jsmart2021@gmail.com" <jsmart2021@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "hare@suse.de" <hare@suse.de>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 16, 2019 at 12:15 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Mar 15, 2019 at 01:57:38AM -0700, Jianchao Wang wrote:
> > tags->rqs[] will not been cleaned when free driver tag and there
> > is a window between get driver tag and write tags->rqs[], so we
> > may see stale rq in tags->rqs[] which may have been freed, as
> > following case,
> > blk_mq_get_request         blk_mq_queue_tag_busy_iter
> >   -> blk_mq_get_tag
> >                              -> bt_for_each
> >                                -> bt_iter
> >                                  -> rq = taags->rqs[]
> >                                  -> rq->q
> >   -> blk_mq_rq_ctx_init
> >     -> data->hctx->tags->rqs[rq->tag] = rq;
> >
> > To fix this, the blk_mq_queue_tag_busy_iter is changed in this
> > patch to use tags->static_rqs[] instead of tags->rqs[]. We have
> > to identify whether there is a io scheduler attached to decide
> > to use hctx->tags or hctx->sched_tags. And we will try to get a
> > non-zero q_usage_counter before that, so it is safe to access
> > them. Add 'inflight' parameter to determine to iterate in-flight
> > requests or just busy tags. A correction here is that
> > part_in_flight should count the busy tags instead of rqs that
> > have got driver tags.
> >
> > Moreover, get rid of the 'hctx' parameter in iter function as
> > we could get it from rq->mq_hctx and export this interface for
> > drivers.
> >
> > Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> > ---
> >  block/blk-mq-tag.c     | 76 +++++++++++++++++++++++++++++++++-----------------
> >  block/blk-mq-tag.h     |  2 --
> >  block/blk-mq.c         | 31 ++++++++------------
> >  include/linux/blk-mq.h |  5 ++--
> >  4 files changed, 64 insertions(+), 50 deletions(-)
> >
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index b792537..cdec2cd 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -216,26 +216,38 @@ struct bt_iter_data {
> >       busy_iter_fn *fn;
> >       void *data;
> >       bool reserved;
> > +     bool inflight;
> >  };
> >
> >  static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >  {
> >       struct bt_iter_data *iter_data = data;
> >       struct blk_mq_hw_ctx *hctx = iter_data->hctx;
> > -     struct blk_mq_tags *tags = hctx->tags;
> >       bool reserved = iter_data->reserved;
> > +     struct blk_mq_tags *tags;
> >       struct request *rq;
> >
> > +     tags =  hctx->sched_tags ? hctx->sched_tags : hctx->tags;
> > +
> >       if (!reserved)
> >               bitnr += tags->nr_reserved_tags;
> > -     rq = tags->rqs[bitnr];
> > +     /*
> > +      * Because tags->rqs[] will not been cleaned when free driver tag
> > +      * and there is a window between get driver tag and write tags->rqs[],
> > +      * so we may see stale rq in tags->rqs[] which may have been freed.
> > +      * Using static_rqs[] is safer.
> > +      */
> > +     rq = tags->static_rqs[bitnr];
> >
> >       /*
> > -      * We can hit rq == NULL here, because the tagging functions
> > -      * test and set the bit before assigning ->rqs[].
> > +      * There is a small window between get tag and blk_mq_rq_ctx_init,
> > +      * so rq->q and rq->mq_hctx maybe different.
> >        */
> > -     if (rq && rq->q == hctx->queue)
> > -             return iter_data->fn(hctx, rq, iter_data->data, reserved);
> > +     if (rq && rq->q == hctx->queue &&
> > +         rq->mq_hctx == hctx &&
> > +         (!iter_data->inflight ||
> > +          blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
> > +             return iter_data->fn(rq, iter_data->data, reserved);
>
> There is still a window where the check may succeed, but the request is
> being assigned to a completely different request_queue. The callback
> then operates on a request it doesn't own.

The situation above is only related with 'none' io scheduler.

However, this patch doesn't change behavior for none given .rq[tag] is same with
.static_rq[tag], so I guess your concern may not be related with this patch.

>
> Tag iteration from a driver can be safe only if the driver initiates a
> freeze and quiesced all queues sharing the same tagset first. The nvme
> driver does that, but I think there may need to be an additional grace
> period to wait for the allocation's queue_enter to call queue_exit to
> ensure the request is initialized through blk_mq_rq_ctx_init().

blk_mq_queue_tag_busy_iter() is used by blk-mq core code only for
io accounting or timeout on the specified request_queue, and NVMe's
uses are actually over the whole driver tags.

Thanks,
Ming Lei
