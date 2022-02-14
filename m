Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 14:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353295AbiBNOu6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:50:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiBNOu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 09:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4906D4C7AB
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644850248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D11+cVAG03IUHV0X0HfzlaSQjb7g4OFzkQbP1NRpCco=;
        b=Iy9h+tG8PtDwDlmqpW1+TYqAaQd6wquGJa39k8ywWDHj8Z4MnBqLV3I60sF1X9HjV6vzXY
        SjopPNT/ub15DVWMfELIhiBl68GqE+sx4DA56leRBRxZ4E+8cmsQe05/ro2pQt4jZUy+tx
        z8L4pICRzvv5t2dSHyuITVWf1715Wxk=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-eTmlwcf5OLGjSD2nnRgLJg-1; Mon, 14 Feb 2022 09:50:47 -0500
X-MC-Unique: eTmlwcf5OLGjSD2nnRgLJg-1
Received: by mail-ua1-f72.google.com with SMTP id q19-20020ab04a13000000b002fef2f854a6so6570070uae.7
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 06:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D11+cVAG03IUHV0X0HfzlaSQjb7g4OFzkQbP1NRpCco=;
        b=qAb9RidPVsol6tJaff+CMWT5LXXEWXniJNdGjtCslmfS90GN5isUmZI5Zr2TDLXwNq
         cvxH6gcYl+d5IT+b0UH+j/8z5Ok6meRHn0AKzhpcrSux+aEHmrY2s7e6fZMFZMDCFbcV
         6g4GwtStPr0bKotQqCE4ju2N6FNvpIjJhX2ZTA3kyu2/XlGKea4ks2JKT6gTpQ3Ac4Lu
         zkuJlWxQVa+8EakFWi2q22J+Lm9qHCcZRHrOf91zs0k8RAZo6X0b9H1Fdq7ex6qqvQTa
         qR9Fl8NReiqWua6IkfD1brlfu/c/yV5YdULwOhsyV53YLT7HaS05MofLV6KDkWh4j0X4
         dyAA==
X-Gm-Message-State: AOAM533bfthq9ZzlX4odEGsk1ucgpkjPeDz/xiujg6wC0XyAtw/1pqjI
        fgama6eUj/WdHaP3EG7mt6ok3qAfG7mp8JEabh/Dz+jMz/ahKq4ILYRMY5CNz1A9kQZxUi13FCY
        2WI+MvuFBmL2c9P5X1AmjRZkFfx9i/EZoa8Rn/Nk=
X-Received: by 2002:a1f:dc03:: with SMTP id t3mr10747vkg.28.1644850246644;
        Mon, 14 Feb 2022 06:50:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4q628KlCa/+wUdfCY2l5tdpIeBtgyv3otR+7O6uT0p81j8fndB1fOtoAgIQwf1FvTSOLT9p91QC6ZtiNFuJE=
X-Received: by 2002:a1f:dc03:: with SMTP id t3mr10729vkg.28.1644850246393;
 Mon, 14 Feb 2022 06:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20220131203337.GA17666@redhat> <CAFj5m9Lej-oZx2x9f1aSiEDyND_J2cSNAbyytLcTEJWrDZJBvA@mail.gmail.com>
In-Reply-To: <CAFj5m9Lej-oZx2x9f1aSiEDyND_J2cSNAbyytLcTEJWrDZJBvA@mail.gmail.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Mon, 14 Feb 2022 09:50:35 -0500
Message-ID: <CA+RJvhynSq7Po=qWiLOTSOU+KVEyKsv42TRzPgStBW+-YDLYDA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues
To:     Ming Lei <ming.lei@redhat.com>
Cc:     David Jeffery <djeffery@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch has now been tested in the customer environment and results
were good (fixed the hangs).

On Mon, Feb 7, 2022 at 9:45 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Feb 1, 2022 at 4:34 AM David Jeffery <djeffery@redhat.com> wrote:
> >
> > When blk_mq_delay_run_hw_queues sets an hctx to run in the future, it can
> > reset the delay length for an already pending delayed work run_work. This
> > creates a scenario where multiple hctx may have their queues set to run,
> > but if one runs first and finds nothing to do, it can reset the delay of
> > another hctx and stall the other hctx's ability to run requests.
> >
> > To avoid this I/O stall when an hctx's run_work is already pending,
> > leave it untouched to run at its current designated time rather than
> > extending its delay. The work will still run which keeps closed the race
> > calling blk_mq_delay_run_hw_queues is needed for while also avoiding the
> > I/O stall.
> >
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > ---
> >  block/blk-mq.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f3bf3358a3bb..ae46eb4bf547 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2177,6 +2177,14 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
> >         queue_for_each_hw_ctx(q, hctx, i) {
> >                 if (blk_mq_hctx_stopped(hctx))
> >                         continue;
> > +               /*
> > +                * If there is already a run_work pending, leave the
> > +                * pending delay untouched. Otherwise, a hctx can stall
> > +                * if another hctx is re-delaying the other's work
> > +                * before the work executes.
> > +                */
> > +               if (delayed_work_pending(&hctx->run_work))
> > +                       continue;
>
> The issue is triggered on BFQ, since BFQ's has_work() may return true,
> however its ->dispatch_request() may return NULL, so
> blk_mq_delay_run_hw_queues()
> is run for delay schedule.
>
> In case of multiple hw queue, the described issue may be triggered, and cause io
> stall for long time. And there are only 3 in-tree callers of
> blk_mq_delay_run_hw_queues(),
> David's fix works well for the 3 users, so this patch looks fine:
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>
> Thanks,
>

