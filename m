Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C434C38A2A
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA84207FF
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/TptMQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEKBaC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 May 2020 21:30:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728381AbgEKBaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 21:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589160600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dC309k+ibsw/3VjV9/ejnOFqXLiqMyJIRDkc+VSBHTM=;
        b=T/TptMQlcU7Uk3YyhOfg2KN5HhhcjWDJ3sZ/mMIuPtBoPUdxbGR2Y19AzkZGij7sODwV5O
        x0K/PIxRshWtpY3yPcD1ejR2dBlfG6O0gNjxRRRJFgSffqzsg6jTr8bHIPy6IUZiCaXULr
        ozcsrvKmnQXnwEKhEO4Di+Mv+iNuEv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-L0Dlu4ofNQ2Eftgkm3b_uA-1; Sun, 10 May 2020 21:29:58 -0400
X-MC-Unique: L0Dlu4ofNQ2Eftgkm3b_uA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65B2880058A;
        Mon, 11 May 2020 01:29:56 +0000 (UTC)
Received: from T590 (ovpn-13-75.pek2.redhat.com [10.72.13.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEB425D77B;
        Mon, 11 May 2020 01:29:46 +0000 (UTC)
Date:   Mon, 11 May 2020 09:29:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
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
Message-ID: <20200511012942.GA1418834@T590>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590>
 <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
 <20200508232222.GA1391368@T590>
 <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
 <20200509094306.GA1414369@T590>
 <6579459b-aa98-78f2-f805-a6cd46f37b6c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6579459b-aa98-78f2-f805-a6cd46f37b6c@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 10, 2020 at 12:44:53AM -0700, Sagi Grimberg wrote:
> 
> > > > > You're mostly correct. This is exactly why an I/O scheduler may be
> > > > > applicable here IMO. Mostly because I/O schedulers tend to optimize for
> > > > > something specific and always present tradeoffs. Users need to
> > > > > understand what they are optimizing for.
> > > > > 
> > > > > Hence I'd say this functionality can definitely be available to an I/O
> > > > > scheduler should one exist.
> > > > > 
> > > > 
> > > > I guess it is just that there can be multiple requests available from
> > > > scheduler queue. Actually it can be so for other non-nvme drivers in
> > > > case of none, such as SCSI.
> > > > 
> > > > Another way is to use one per-task list(such as plug list) to hold the
> > > > requests for dispatch, then every drivers may see real .last flag, so they
> > > > may get chance for optimizing batch queuing. I will think about the
> > > > idea further and see if it is really doable.
> > > 
> > > How about my RFC v1 patch set[1], which allows dispatching more than
> > > one request from the scheduler to support batch requests?
> > > 
> > > [1]
> > > https://lore.kernel.org/patchwork/patch/1210034/
> > > https://lore.kernel.org/patchwork/patch/1210035/
> > 
> > Basically, my idea is to dequeue request one by one, and for each
> > dequeued request:
> > 
> > - we try to get a budget and driver tag, if both succeed, add the
> > request to one per-task list which can be stored in stack variable,
> > then continue to dequeue more request
> > 
> > - if either budget or driver tag can't be allocated for this request,
> > marks the last request in the per-task list as .last, and send the
> > batching requests stored in the list to LLD
> > 
> > - when queueing batching requests to LLD, if one request isn't queued
> > to driver successfully, calling .commit_rqs() like before, meantime
> > adding the remained requests in the per-task list back to scheduler
> > queue or hctx->dispatch.
> 
> Sounds good to me.
> 
> > One issue is that this way might degrade sequential IO performance if
> > the LLD just tells queue busy to blk-mq via return value of .queue_rq(),
> > so I guess we still may need one flag, such as BLK_MQ_F_BATCHING_SUBMISSION.
> 
> Why is that degrading sequential I/O performance? because the specific

Some devices may only return BLK_STS_RESOURCE from .queue_rq(), then more
requests are dequeued from scheduler queue if we always queue batching IOs
to LLD, and chance of IO merge is reduced, so sequential IO performance will
be effected.

Such as some scsi device which doesn't use sdev->queue_depth for
throttling IOs.

For virtio-scsi or virtio-blk, we may stop queue for avoiding the
potential affect.

> device will do better without batching submissions? If so, the driver

It isn't related with batching submission, IMO.


Thanks,
Ming

