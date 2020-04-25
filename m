Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884ACC2BA19
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 04:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAD82076C
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 04:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPNwyGY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgDYEAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 00:00:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39619 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDYEAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 00:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587787208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o8Nj8dyJDx7V0pmy1IruyzY0hM7KC3rDuYz5FtLyfzA=;
        b=dPNwyGY+LsBhDRxBGXKIUDPeoEQOGi70vx0P25s4JmkUqfUnzpgjiiDInX4TBezcUXz8nR
        CeAMFiyIYTVoEZobrZYFm2f5oKIDL4Z3rNxlG9IJNzm24vT1HFyohvEFIYk/2ToW16Exmb
        s4ALewnJBiesgFBaiyHaLgKwQEnLxE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-8msk19lzNZ-1gBn0ajFbCg-1; Fri, 24 Apr 2020 23:59:59 -0400
X-MC-Unique: 8msk19lzNZ-1gBn0ajFbCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 163DE45F;
        Sat, 25 Apr 2020 03:59:58 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 040F11002383;
        Sat, 25 Apr 2020 03:59:48 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:59:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 10/11] blk-mq: re-submit IO in case that hctx is
 inactive
Message-ID: <20200425035943.GK477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-11-ming.lei@redhat.com>
 <1bba5ed8-21db-751b-e638-4b287db14cd0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bba5ed8-21db-751b-e638-4b287db14cd0@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 03:55:35PM +0200, Hannes Reinecke wrote:
> On 4/24/20 12:23 PM, Ming Lei wrote:
> > When all CPUs in one hctx are offline and this hctx becomes inactive, we
> > shouldn't run this hw queue for completing request any more.
> > 
> > So allocate request from one live hctx, and clone & resubmit the request,
> > either it is from sw queue or scheduler queue.
> > 
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 98 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 0759e0d606b3..a4a26bb23533 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2370,6 +2370,98 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> >   	return 0;
> >   }
> > +static void blk_mq_resubmit_end_rq(struct request *rq, blk_status_t error)
> > +{
> > +	struct request *orig_rq = rq->end_io_data;
> > +
> > +	blk_mq_cleanup_rq(orig_rq);
> > +	blk_mq_end_request(orig_rq, error);
> > +
> > +	blk_put_request(rq);
> > +}
> > +
> > +static void blk_mq_resubmit_rq(struct request *rq)
> > +{
> > +	struct request *nrq;
> > +	unsigned int flags = 0;
> > +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> > +	struct blk_mq_tags *tags = rq->q->elevator ? hctx->sched_tags :
> > +		hctx->tags;
> > +	bool reserved = blk_mq_tag_is_reserved(tags, rq->internal_tag);
> > +
> > +	if (rq->rq_flags & RQF_PREEMPT)
> > +		flags |= BLK_MQ_REQ_PREEMPT;
> > +	if (reserved)
> > +		flags |= BLK_MQ_REQ_RESERVED;
> > +
> > +	/* avoid allocation failure by clearing NOWAIT */
> > +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> > +	if (!nrq)
> > +		return;
> > +
> 
> Ah-ha. So what happens if we don't get a request here?

So far it isn't possible if NOWAIT is cleared because the two requests
belong to different hctx.

> 
> > +	blk_rq_copy_request(nrq, rq);
> > +
> > +	nrq->timeout = rq->timeout;
> > +	nrq->rq_disk = rq->rq_disk;
> > +	nrq->part = rq->part;
> > +
> > +	memcpy(blk_mq_rq_to_pdu(nrq), blk_mq_rq_to_pdu(rq),
> > +			rq->q->tag_set->cmd_size);
> > +
> > +	nrq->end_io = blk_mq_resubmit_end_rq;
> > +	nrq->end_io_data = rq;
> > +	nrq->bio = rq->bio;
> > +	nrq->biotail = rq->biotail;
> > +
> > +	if (blk_insert_cloned_request(nrq->q, nrq) != BLK_STS_OK)
> > +		blk_mq_request_bypass_insert(nrq, false, true);
> > +}
> > +
> 
> Not sure if that is a good idea.
> With the above code we would having to allocate an additional
> tag per request; if we're running full throttle with all tags active where
> should they be coming from?

The two requests are from different hctx, and we don't have
per-request-queue throttle in blk-mq, and scsi does have, however
no requests from this inactive hctx exists in LLD.

So no the throttle you worry about.

> 
> And all the while we _have_ perfectly valid tags; the tag of the original
> request _is_ perfectly valid, and we have made sure that it's not inflight

No, we are talking request in sw queue and scheduler queue, which aren't
assigned tag yet.

> (because if it were we would have to wait for to be completed by the
> hardware anyway).
> 
> So why can't we re-use the existing tag here?

No, the tag doesn't exist.


Thanks,
Ming

