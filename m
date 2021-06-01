Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59548C4708F
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3646861370
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 10:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhFAKDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jun 2021 06:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhFAKDX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Jun 2021 06:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622541702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQIGb7JjWf1QpCFDmD94FmQmJaM9cRwiXrs1uUE3Z1w=;
        b=ElexamF1UbXrFELpkroMDGulne4CekO3FIkfDc1Zsq+VnWv2pFbDt7RAiKXb5UT3sVbMDd
        GN/kICPxl+D9qDEAOk5wD8S5y4s6SYKV3rj8ZoCROkHL6w1SibvdeZyq9RB0NQOiOO93Xt
        VGY3Vmrl/d3hgu2VxtgaodDJh+mXr70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-j89jdyztO0-MUoBAnM5GDg-1; Tue, 01 Jun 2021 06:01:41 -0400
X-MC-Unique: j89jdyztO0-MUoBAnM5GDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0019B107ACE3;
        Tue,  1 Jun 2021 10:01:39 +0000 (UTC)
Received: from T590 (ovpn-13-30.pek2.redhat.com [10.72.13.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 150FD2B4DE;
        Tue,  1 Jun 2021 10:01:33 +0000 (UTC)
Date:   Tue, 1 Jun 2021 18:01:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: update hctx->dispatch_busy in case of real
 scheduler
Message-ID: <YLYFeVtej9B7VVzZ@T590>
References: <20210528032055.2242080-1-ming.lei@redhat.com>
 <20210528122631.GA28653@quack2.suse.cz>
 <YLQ9vdTarVAA+y+Z@T590>
 <20210531120434.GB5349@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531120434.GB5349@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 31, 2021 at 02:04:34PM +0200, Jan Kara wrote:
> On Mon 31-05-21 09:37:01, Ming Lei wrote:
> > On Fri, May 28, 2021 at 02:26:31PM +0200, Jan Kara wrote:
> > > On Fri 28-05-21 11:20:55, Ming Lei wrote:
> > > > Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> > > > starts to support io batching submission by using hctx->dispatch_busy.
> > > > 
> > > > However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
> > > > in that commit, so fix the issue by updating hctx->dispatch_busy in case
> > > > of real scheduler.
> > > > 
> > > > Reported-by: Jan Kara <jack@suse.cz>
> > > > Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  block/blk-mq.c | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > 
> > > Looks good to me. You can add:
> > > 
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > 
> > > BTW: Do you plan to submit also your improvement to
> > > __blk_mq_do_dispatch_sched() to update dispatch_busy during the fetching
> > > requests from the scheduler to avoid draining all requests from the IO
> > > scheduler?
> > 
> > I understand that kind of change isn't needed. When more requests are
> > dequeued, hctx->dispatch_busy will be updated, then __blk_mq_do_dispatch_sched()
> > won't dequeue at batch any more if either .queue_rq() returns
> > STS_RESOURCE or running out of driver tag/budget.
> > 
> > Or do you still see related issues after this patch is applied?
> 
> I was suspicious that __blk_mq_do_dispatch_sched() would be still pulling
> requests too aggressively from the IO scheduler (which effectively defeats
> impact of cgroup IO weights on observed throughput). Now I did a few more
> experiments with the workload doing multiple iterations for each kernel and
> comparing ratios of achieved throughput when cgroup weights were in 2:1
> ratio.
> 
> With this patch alone, I've got no significant distinction between IO from
> two cgroups in 4 out of 5 test iterations. With your patch to update
> max_dispatch in __blk_mq_do_dispatch_sched() applied on top the results
> were not significantly different (my previous test result was likely a
> lucky chance). With my original patch to allocate driver tags early in
> __blk_mq_do_dispatch_sched() I get reliable distinction between cgroups -
> the worst ratio from all the iterations is 1.4, average ratio is ~1.75.
> This last result is btw very similar to ratios I can see when using
> virtio-scsi instead of virtio-blk for the backing storage which is kind of
> natural because virtio-scsi ends up using the dispatch-budget logic of SCSI
> subsystem. I'm not saying my patch is the right way to do things but it
> clearly shows that __blk_mq_do_dispatch_sched() is still too aggressive
> pulling requests out of the IO scheduler.

IMO getting driver tag before dequeue should be one good way for this
issue, and that is exactly what the legacy request IO code path did. Not
only address this issue, but also get better leverage between batching
dispatch and IO request merge.

But it can't work by simply adding blk_mq_get_driver_tag() in
__blk_mq_do_dispatch_sched(), and one big problem is that how to re-run
queue in case of running out of getting driver tag. That said we need to
refactor blk_mq_dispatch_rq_list(), such as moving handling of running
out of driver tag into __blk_mq_do_dispatch_sched(). I will investigate a
bit on this change.


Thanks,
Ming

