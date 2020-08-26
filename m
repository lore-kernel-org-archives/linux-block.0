Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD8DC433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F852080C
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 12:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv6OTYB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgHZMY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:24:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24798 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729263AbgHZMYZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 08:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598444664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WfE95hu3+dO4SyorVBl8fz8F13Vgxu58IeFAhghlKng=;
        b=Mv6OTYB3/aDWg0aKkFQ6gjlKwPBdVSmyCrDPT2SyRyyQfN7OW0ZjmsjNbXvVotuwv9S3Mp
        +CwRe55PUIhvh3h71g27pau9ewLAwBHOADtdutCnFRnRdNYlXasiuhPnGuofv8u/ij+fwF
        MVtq0TR6pqHi1ekOUJzm3NQ6/ee00A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-RPXoYo1INAq1Daa7laIBfw-1; Wed, 26 Aug 2020 08:24:20 -0400
X-MC-Unique: RPXoYo1INAq1Daa7laIBfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3404F80F043;
        Wed, 26 Aug 2020 12:24:19 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 679C51002D53;
        Wed, 26 Aug 2020 12:24:12 +0000 (UTC)
Date:   Wed, 26 Aug 2020 20:24:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] blk-mq: fix use-after-free on stale request
Message-ID: <20200826122407.GA126130@T590>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
 <accb98d8-8186-2e74-a5c3-e0f09ce2b3ff@acm.org>
 <20200821024949.GA3110165@T590>
 <e42f1c04-eb34-63aa-c9c8-57c58d4b28b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42f1c04-eb34-63aa-c9c8-57c58d4b28b0@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 26, 2020 at 01:03:37PM +0100, John Garry wrote:
> On 21/08/2020 03:49, Ming Lei wrote:
> > Hello Bart,
> > 
> > On Thu, Aug 20, 2020 at 01:30:38PM -0700, Bart Van Assche wrote:
> > > On 8/20/20 11:03 AM, Ming Lei wrote:
> > > > We can't run allocating driver tag and updating tags->rqs[tag] atomically,
> > > > so stale request may be retrieved from tags->rqs[tag]. More seriously, the
> > > > stale request may have been freed via updating nr_requests or switching
> > > > elevator or other use cases.
> > > > 
> > > > It is one long-term issue, and Jianchao previous worked towards using
> > > > static_rqs[] for iterating request, one problem is that it can be hard
> > > > to use when iterating over tagset.
> > > > 
> > > > This patchset takes another different approach for fixing the issue: cache
> > > > freed rqs pages and release them until all tags->rqs[] references on these
> > > > pages are gone.
> > > 
> > > Hi Ming,
> > > 
> > > Is this the only possible solution? Would it e.g. be possible to protect the
> > > code that iterates over all tags with rcu_read_lock() / rcu_read_unlock() and
> > > to free pages that contain request pointers only after an RCU grace period has
> > > expired?
> > 
> > That can't work, tags->rqs[] is host-wide, request pool belongs to scheduler tag
> > and it is owned by request queue actually. When one elevator is switched on this
> > request queue or updating nr_requests, the old request pool of this queue is freed,
> > but IOs are still queued from other request queues in this tagset. Elevator switch
> > or updating nr_requests on one request queue shouldn't or can't other request queues
> > in the same tagset.
> > 
> > Meantime the reference in tags->rqs[] may stay a bit long, and RCU can't cover this
> > case.
> > 
> > Also we can't reset the related tags->rqs[tag] simply somewhere, cause it may
> > race with new driver tag allocation.
> 
> How about iterate all tags->rqs[] for all scheduler tags when exiting the
> scheduler, etc, and clear any scheduler requests references, like this:
> 
> cmpxchg(&hctx->tags->rqs[tag], scheduler_rq, 0);
> 
> So we NULLify any tags->rqs[] entries which contain a scheduler request of
> concern atomically, cleaning up any references.

Looks this approach can work given cmpxchg() will prevent new store on
this address.

> 
> I quickly tried it and it looks to work, but maybe not so elegant.

I think this way is good enough.


thanks, 
Ming

