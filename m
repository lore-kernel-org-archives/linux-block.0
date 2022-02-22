Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B0C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 14:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiBVOcV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiBVOcV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 09:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EF142C114
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 06:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645540314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/MfXT3qroBzfFO3fjprIbMKzxr4laxeq5/PUsTOK68=;
        b=WKDUqNLPUe7FHDEU63DDByS7gB/X1YEM0y3zItHMd6TwMhYPCJSp93pCxqDvtlQDArRLVv
        BxJJcAIjO6iMv5dwuDUjKx011R/p135fTjvBvDxwrFhhQRtymSmQMZhZA0WXTrdO5bkUqK
        WKCyooqaMBkDSh7yKDKVtPk9p3VwIFM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-iR0BMdv-N72SgRV5LdePgw-1; Tue, 22 Feb 2022 09:31:53 -0500
X-MC-Unique: iR0BMdv-N72SgRV5LdePgw-1
Received: by mail-qk1-f198.google.com with SMTP id f17-20020a05620a069100b0060dfbbb52cfso13566881qkh.1
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 06:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/MfXT3qroBzfFO3fjprIbMKzxr4laxeq5/PUsTOK68=;
        b=0klcPWgfARErYjMW5YUIGWa/H3OzR6ADtef/vjzlp7InoL4Xa8LWZg/Gnexkku8Kv3
         nZuyhA/N4/2MhlKmvN8csoGlU8QSNO3aZAhF/DAJPVrdU98wDqkvFkRrxY9C/mPOgue6
         g7hm2ULPWLL5FwUU33B88rG/jY62lKekOCj6wHxlTHcH32g+dPtG7imJwTUhKv+zgMwD
         rZDTxd4ZwQ9/ihKXrDafDSgv1Ee+MMAwGGwjc0S0J7Qi8LEpkU5HMHbry3lQhS0KAC9i
         KLTm7/i8Z7UtB7omun8QViSeJQ6zOUEQMGoI8imLOhoEf7FK/j5xU6hmFzyL7zfyArSU
         jgDQ==
X-Gm-Message-State: AOAM532SRywNf61hJVK7ZBomXq6XstCtkbxUFp0BjL6ZjR6UtCGJAv61
        +BmcUz8xTrFyVU6G6AoAKSLsfHaxkdx6mJSXg57rWGCvtor11tb0492ZJlGyWfwjFToAJCvljeA
        6GO9+lOQNQTeMbdfi6f7JadE=
X-Received: by 2002:a05:6214:d0a:b0:42c:9090:5fc5 with SMTP id 10-20020a0562140d0a00b0042c90905fc5mr18923089qvh.97.1645540311889;
        Tue, 22 Feb 2022 06:31:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPbqkJk3XYzV48rBWd61sVc51Cq9qZ0o4JSiT8kL2L8PdSt6GGtuK32h+zKnPg1uQL9JJIDg==
X-Received: by 2002:a05:6214:d0a:b0:42c:9090:5fc5 with SMTP id 10-20020a0562140d0a00b0042c90905fc5mr18923057qvh.97.1645540311456;
        Tue, 22 Feb 2022 06:31:51 -0800 (PST)
Received: from loberhel ([2600:6c64:4e7f:cee0:729d:61b6:700c:6b56])
        by smtp.gmail.com with ESMTPSA id h7sm2574606qkp.69.2022.02.22.06.31.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:31:50 -0800 (PST)
Message-ID: <fbeb2fead45c427bd681ffc6be77e25420f57399.camel@redhat.com>
Subject: Re: [PATCH] blk-mq: avoid extending delays of active hctx from
 blk_mq_delay_run_hw_queues
From:   Laurence Oberman <loberman@redhat.com>
To:     John Pittman <jpittman@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     David Jeffery <djeffery@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Date:   Tue, 22 Feb 2022 09:31:50 -0500
In-Reply-To: <CA+RJvhynSq7Po=qWiLOTSOU+KVEyKsv42TRzPgStBW+-YDLYDA@mail.gmail.com>
References: <20220131203337.GA17666@redhat>
         <CAFj5m9Lej-oZx2x9f1aSiEDyND_J2cSNAbyytLcTEJWrDZJBvA@mail.gmail.com>
         <CA+RJvhynSq7Po=qWiLOTSOU+KVEyKsv42TRzPgStBW+-YDLYDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2022-02-14 at 09:50 -0500, John Pittman wrote:
> This patch has now been tested in the customer environment and
> results
> were good (fixed the hangs).
> 
> On Mon, Feb 7, 2022 at 9:45 PM Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > On Tue, Feb 1, 2022 at 4:34 AM David Jeffery <djeffery@redhat.com>
> > wrote:
> > > 
> > > When blk_mq_delay_run_hw_queues sets an hctx to run in the
> > > future, it can
> > > reset the delay length for an already pending delayed work
> > > run_work. This
> > > creates a scenario where multiple hctx may have their queues set
> > > to run,
> > > but if one runs first and finds nothing to do, it can reset the
> > > delay of
> > > another hctx and stall the other hctx's ability to run requests.
> > > 
> > > To avoid this I/O stall when an hctx's run_work is already
> > > pending,
> > > leave it untouched to run at its current designated time rather
> > > than
> > > extending its delay. The work will still run which keeps closed
> > > the race
> > > calling blk_mq_delay_run_hw_queues is needed for while also
> > > avoiding the
> > > I/O stall.
> > > 

Hello
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > ---
> > >  block/blk-mq.c |    8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index f3bf3358a3bb..ae46eb4bf547 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -2177,6 +2177,14 @@ void blk_mq_delay_run_hw_queues(struct
> > > request_queue *q, unsigned long msecs)
> > >         queue_for_each_hw_ctx(q, hctx, i) {
> > >                 if (blk_mq_hctx_stopped(hctx))
> > >                         continue;
> > > +               /*
> > > +                * If there is already a run_work pending, leave
> > > the
> > > +                * pending delay untouched. Otherwise, a hctx can
> > > stall
> > > +                * if another hctx is re-delaying the other's
> > > work
> > > +                * before the work executes.
> > > +                */
> > > +               if (delayed_work_pending(&hctx->run_work))
> > > +                       continue;
> > 
> > The issue is triggered on BFQ, since BFQ's has_work() may return
> > true,
> > however its ->dispatch_request() may return NULL, so
> > blk_mq_delay_run_hw_queues()
> > is run for delay schedule.
> > 
> > In case of multiple hw queue, the described issue may be triggered,
> > and cause io
> > stall for long time. And there are only 3 in-tree callers of
> > blk_mq_delay_run_hw_queues(),
> > David's fix works well for the 3 users, so this patch looks fine:
> > 
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > 
> > Thanks,
> > 
> 
> 

Hello

Jens, gentle ping, can we get this in please
Sincerely

Laurence and the RH team

