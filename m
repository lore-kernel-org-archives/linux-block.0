Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA0C54E4B
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 11:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30942075E
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 11:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuCHmTpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgEKLrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 07:47:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36037 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729661AbgEKLrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 07:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589197671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3w35s2VPWNSVC4QQTyJuFQK6xGQBwZTv524lsRRQU4Y=;
        b=UuCHmTpLYbqr0HtFbWb6kVOgjf2hyzQTZ4Yki1lF6fq2YDXCzawF2y2dNc+JGpMmoHs06V
        3O/dLnl28VmG73zbSeOmmFSNs1uKM6jxgWdSMX9t1RmcZc0pGZ0Pj7vVtQI/M2T0c8anPh
        wTRd01KjJIJESr7Bs/y3GmC1u4RusiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-yydiaoxdN2W6BzEXr0MpJA-1; Mon, 11 May 2020 07:47:48 -0400
X-MC-Unique: yydiaoxdN2W6BzEXr0MpJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 111578010FA;
        Mon, 11 May 2020 11:47:46 +0000 (UTC)
Received: from T590 (ovpn-13-75.pek2.redhat.com [10.72.13.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C0787526B;
        Mon, 11 May 2020 11:47:35 +0000 (UTC)
Date:   Mon, 11 May 2020 19:47:31 +0800
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
Message-ID: <20200511114731.GA1525935@T590>
References: <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590>
 <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
 <20200508232222.GA1391368@T590>
 <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
 <20200509094306.GA1414369@T590>
 <6579459b-aa98-78f2-f805-a6cd46f37b6c@grimberg.me>
 <20200511012942.GA1418834@T590>
 <8f2ddabc-01d0-dae9-f958-1b26a6bdf58c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2ddabc-01d0-dae9-f958-1b26a6bdf58c@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 11, 2020 at 02:23:14AM -0700, Sagi Grimberg wrote:
> 
> > > > Basically, my idea is to dequeue request one by one, and for each
> > > > dequeued request:
> > > > 
> > > > - we try to get a budget and driver tag, if both succeed, add the
> > > > request to one per-task list which can be stored in stack variable,
> > > > then continue to dequeue more request
> > > > 
> > > > - if either budget or driver tag can't be allocated for this request,
> > > > marks the last request in the per-task list as .last, and send the
> > > > batching requests stored in the list to LLD
> > > > 
> > > > - when queueing batching requests to LLD, if one request isn't queued
> > > > to driver successfully, calling .commit_rqs() like before, meantime
> > > > adding the remained requests in the per-task list back to scheduler
> > > > queue or hctx->dispatch.
> > > 
> > > Sounds good to me.
> > > 
> > > > One issue is that this way might degrade sequential IO performance if
> > > > the LLD just tells queue busy to blk-mq via return value of .queue_rq(),
> > > > so I guess we still may need one flag, such as BLK_MQ_F_BATCHING_SUBMISSION.
> > > 
> > > Why is that degrading sequential I/O performance? because the specific
> > 
> > Some devices may only return BLK_STS_RESOURCE from .queue_rq(), then more
> > requests are dequeued from scheduler queue if we always queue batching IOs
> > to LLD, and chance of IO merge is reduced, so sequential IO performance will
> > be effected.
> > 
> > Such as some scsi device which doesn't use sdev->queue_depth for
> > throttling IOs.
> > 
> > For virtio-scsi or virtio-blk, we may stop queue for avoiding the
> > potential affect.
> 
> Do we have a way to characterize such devices? I'd assume that most

It may not be easy.

> devices will benefit from the batching so maybe the flag needs to be
> inverted? BLK_MQ_F_DONT_BATCHING_SUBMISSION?

Actually I'd rather to not add any flag, and we may use some algorithm
(maybe EWMA or other intelligent stuff, or use hctx->dispatch_busy directly)
to figure out one dynamic batching number which is used to dequeue requests
from scheduler or sw queue.

Then just one single dispatch io code path is enough.

Thanks, 
Ming

