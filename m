Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C76C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 02:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADBC613D5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 02:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhJECR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 22:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230237AbhJECR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Oct 2021 22:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633400168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKhwVBXPV3EPfZIuh6noCeVhYkqhAE0CGyHLoUqHWKs=;
        b=MWPwjAlgxgzi+iqnh9GHPxAKZ8xOfaC6VNgSh9LQgsNAdyn74orp7bSsf8nWsRF1vFhesV
        5LEJWZ5Chqd1bHwGFn5WOxYvwtanV2HFF0xCNgBsylxBzHE7N4k3kWK6c1bUouxiaomIs0
        k319BI1C3rOqhEYhHUCW+sGhJB2QXXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-x086-MvbOcu24lF2RIBwlw-1; Mon, 04 Oct 2021 22:16:06 -0400
X-MC-Unique: x086-MvbOcu24lF2RIBwlw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FDE7824FAD;
        Tue,  5 Oct 2021 02:16:05 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA5A260C05;
        Tue,  5 Oct 2021 02:16:01 +0000 (UTC)
Date:   Tue, 5 Oct 2021 10:15:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 4/5] block: drain file system I/O on del_gendisk
Message-ID: <YVu1XBbKC5Mb2e3e@T590>
References: <20210929071241.934472-1-hch@lst.de>
 <20210929071241.934472-5-hch@lst.de>
 <YVQg/a6GnELfPV1S@T590>
 <20211001041348.GA17306@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001041348.GA17306@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 01, 2021 at 06:13:48AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 29, 2021 at 04:17:01PM +0800, Ming Lei wrote:
> 
> [full quote deleted]
> 
> > Draining request won't fix the problem completely:
> > 
> > 1) blk-mq dispatch code may still be in-progress after q_usage_counter
> > becomes zero, see the story in 662156641bc4 ("block: don't drain in-progress dispatch in
> > blk_cleanup_queue()")
> 
> That commit does not have a good explanation on what it actually fixed.

The commit log mentions that:

    Now freeing hw queue resource is moved to hctx's release handler,
    we don't need to worry about the race between blk_cleanup_queue and
    run queue any more.

So the hctx queue resource is fine to be referred during cleaning up
queue, since freeing hctx related resources are moved to queue release
handler.

Or you can see the point in commit c2856ae2f315 ("blk-mq: quiesce queue before
freeing queue"), which explains the issue in enough details. That said
even though after .q_usage_counter is zero, the block layer code is
still running and queue or disk can still be referred.

> 
> > 2) elevator code / blkcg code may still be called after blk_cleanup_queue(), such
> > as kyber, trace_kyber_latency()(q->disk is referred) is called in kyber's timer
> > handler, and the timer is deleted via del_timer_sync() via kyber_exit_sched()
> > from blk_release_queue().
> 
> Yes.  There's two things we can do here:
> 
>  - stop using the dev_t in tracing a request_queue
>  - exit the I/O schedules in del_gendisk, because they are only used
>    for file system I/O that requires the gendisk anyway
> 
> we'll probably want both eventually.

Not sure if it is easy to do, one thing is that we can't slow down
blk_cleanup_queue() too much. Usually we added quiesing queue in
blk_cleanup_queue(), but people complained and the change is removed.

> 
> > 
> > > +
> > > +	rq_qos_exit(q);
> > > +	blk_sync_queue(q);
> > > +	blk_flush_integrity();
> > > +	/*
> > > +	 * Allow using passthrough request again after the queue is torn down.
> > > +	 */
> > > +	blk_mq_unfreeze_queue(q);
> > 
> > Again, one FS bio is still possible to enter queue now: submit_bio_checks()
> > is done before set_capacity(0), and submitted after blk_mq_unfreeze_queue()
> > returns.
> 
> Not with the new patch 1 in this series.

OK, looks you get the .q_usage_counter before checking bio.

> 
> Jens - can you take a look at the series that fixes the crashes people
> are sending while I'm looking at the rest of the corner cases?

But draining .q_usage_counter can't address this kind of issue completely, can
it? Not mention the io scheduler code can still refer to q->disk after
blk_cleanup_queue().


Thanks,
Ming

