Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359AEC47247
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 09:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8C3217BA
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 09:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAfZrfR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgEIJn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 05:43:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21345 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbgEIJn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 May 2020 05:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589017406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8D8Ae345rAYDqawjkcSExOxW2YprJe5XqaST1kNQ6s=;
        b=PAfZrfR31L6LmVFMx1IzzHBXCi0T+ddQIG0EBnys+jasXqD87xlb5fFglZZGITpE3RvT6E
        MlQLl/lBIxRayuZrbkZUa/6ibZAQvjtmT6gyLXn7J7LxBhL3KcSMxPJmHcDNPylsbVEYTj
        Yz0jKeJvWCMmuc2Ei55idL29FV0G+Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-rAyD8qh5NLyXbbJ-2MeO7Q-1; Sat, 09 May 2020 05:43:22 -0400
X-MC-Unique: rAyD8qh5NLyXbbJ-2MeO7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3763C107ACCA;
        Sat,  9 May 2020 09:43:20 +0000 (UTC)
Received: from T590 (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15F1D5D9CD;
        Sat,  9 May 2020 09:43:10 +0000 (UTC)
Date:   Sat, 9 May 2020 17:43:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
Message-ID: <20200509094306.GA1414369@T590>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590>
 <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
 <20200508232222.GA1391368@T590>
 <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 09, 2020 at 04:57:48PM +0800, Baolin Wang wrote:
> On Sat, May 9, 2020 at 7:22 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Hi Sagi,
> >
> > On Fri, May 08, 2020 at 03:19:45PM -0700, Sagi Grimberg wrote:
> > > Hey Ming,
> > >
> > > > > Would it make sense to elevate this flag to a request_queue flag
> > > > > (QUEUE_FLAG_ALWAYS_COMMIT)?
> > > >
> > > > request queue flag usually is writable, however this case just needs
> > > > one read-only flag, so I think it may be better to make it as
> > > > tagset/hctx flag.
> > >
> > > I actually intended it to be writable.
> > >
> > > > > I'm thinking of a possibility that an I/O scheduler may be used
> > > > > to activate this functionality rather than having the driver set
> > > > > it necessarily...
> > > >
> > > > Could you explain a bit why I/O scheduler should activate this
> > > > functionality?
> > >
> > > Sure, I've recently seen some academic work showing the benefits
> > > of batching in tcp/ip based block drivers. The problem with the
> > > approaches taken is that I/O scheduling is exercised deep down in the
> > > driver, which is not the direction I'd like to go if we are want
> > > to adopt some of the batching concepts.
> > >
> > > I spent some (limited) time thinking about this, and it seems to
> > > me that there is an opportunity to implement this as a dedicated
> > > I/O scheduler, and tie it to driver specific LLD stack optimizations
> > > (net-stack for example) relying on the commit_rq/bd->last hints.
> > >
> > > When scanning the scheduler code, I noticed exactly the phenomenon that
> > > this patchset is attempting to solve and Christoph referred me to it.
> > > Now I'm thinking if we can extend this batching optimization for both
> > > use-cases.
> >
> > Got it, thanks for the sharing.
> >
> > >
> > > > batching submission may be good for some drivers, and currently
> > > > we only do it in limited way. One reason is that there is extra
> > > > cost for full batching submission, such as this patch requires
> > > > one extra .commit_rqs() for each dispatch, and lock is often needed
> > > > in this callback.
> > >
> > > That is not necessarily the case at all.
> >
> > So far, all in-tree .commit_rqs() implementation requires lock.
> >
> > >
> > > > IMO it can be a win for some slow driver or device, but may cause
> > > > a little performance drop for fast driver/device especially in workload
> > > > of not-batching submission.
> > >
> > > You're mostly correct. This is exactly why an I/O scheduler may be
> > > applicable here IMO. Mostly because I/O schedulers tend to optimize for
> > > something specific and always present tradeoffs. Users need to
> > > understand what they are optimizing for.
> > >
> > > Hence I'd say this functionality can definitely be available to an I/O
> > > scheduler should one exist.
> > >
> >
> > I guess it is just that there can be multiple requests available from
> > scheduler queue. Actually it can be so for other non-nvme drivers in
> > case of none, such as SCSI.
> >
> > Another way is to use one per-task list(such as plug list) to hold the
> > requests for dispatch, then every drivers may see real .last flag, so they
> > may get chance for optimizing batch queuing. I will think about the
> > idea further and see if it is really doable.
> 
> How about my RFC v1 patch set[1], which allows dispatching more than
> one request from the scheduler to support batch requests?
> 
> [1]
> https://lore.kernel.org/patchwork/patch/1210034/
> https://lore.kernel.org/patchwork/patch/1210035/

Basically, my idea is to dequeue request one by one, and for each
dequeued request:

- we try to get a budget and driver tag, if both succeed, add the
request to one per-task list which can be stored in stack variable,
then continue to dequeue more request

- if either budget or driver tag can't be allocated for this request,
marks the last request in the per-task list as .last, and send the
batching requests stored in the list to LLD

- when queueing batching requests to LLD, if one request isn't queued
to driver successfully, calling .commit_rqs() like before, meantime
adding the remained requests in the per-task list back to scheduler
queue or hctx->dispatch.

One issue is that this way might degrade sequential IO performance if
the LLD just tells queue busy to blk-mq via return value of .queue_rq(),
so I guess we still may need one flag, such as BLK_MQ_F_BATCHING_SUBMISSION.


thanks, 
Ming

