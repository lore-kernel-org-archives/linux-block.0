Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA2C2BA19
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636B22087E
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVIChNvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgDYDsG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:48:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39476 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgDYDsG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587786484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLIDLSSuTbhx0EZsWNKvaaIUuenZQE3Gs5ykr+S0AqU=;
        b=cVIChNvgKQjno5IG4+Z2/RAsP2t3OC80vD+jgTaeu0FvhMX4tUAeMhHEY/iNBzPISL7b8X
        OwpXfGiEemUucZQMQYdCdYvOFzRN3z5An1akKdCH8RzrTVFQlAVhe1jJcPKA54LhEgCjg1
        Dljox6rquQlAx284/PASOx0vKiuBVQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-SXHZ2Th1O4-kZvEMMApzkg-1; Fri, 24 Apr 2020 23:48:00 -0400
X-MC-Unique: SXHZ2Th1O4-kZvEMMApzkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A85B100A8E9;
        Sat, 25 Apr 2020 03:47:59 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 422175C1D2;
        Sat, 25 Apr 2020 03:47:50 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:47:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 08/11] block: add blk_end_flush_machinery
Message-ID: <20200425034745.GH477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-9-ming.lei@redhat.com>
 <390e713c-8289-ba35-4e4a-86f0d1ba0cf4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390e713c-8289-ba35-4e4a-86f0d1ba0cf4@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 03:47:28PM +0200, Hannes Reinecke wrote:
> On 4/24/20 12:23 PM, Ming Lei wrote:
> > Flush requests aren't same with normal FS request:
> > 
> > 1) one dedicated per-hctx flush rq is pre-allocated for sending flush request
> > 
> > 2) flush request si issued to hardware via one machinary so that flush merge
> > can be applied
> > 
> > We can't simply re-submit flush rqs via blk_steal_bios(), so add
> > blk_end_flush_machinery to collect flush requests which needs to
> > be resubmitted:
> > 
> > - if one flush command without DATA is enough, send one flush, complete this
> > kind of requests
> > 
> > - otherwise, add the request into a list and let caller re-submit it.
> > 
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-flush.c | 123 +++++++++++++++++++++++++++++++++++++++++++---
> >   block/blk.h       |   4 ++
> >   2 files changed, 120 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/blk-flush.c b/block/blk-flush.c
> > index 977edf95d711..745d878697ed 100644
> > --- a/block/blk-flush.c
> > +++ b/block/blk-flush.c
> > @@ -170,10 +170,11 @@ static void blk_flush_complete_seq(struct request *rq,
> >   	unsigned int cmd_flags;
> >   	BUG_ON(rq->flush.seq & seq);
> > -	rq->flush.seq |= seq;
> > +	if (!error)
> > +		rq->flush.seq |= seq;
> >   	cmd_flags = rq->cmd_flags;
> > -	if (likely(!error))
> > +	if (likely(!error && !fq->flush_queue_terminating))
> >   		seq = blk_flush_cur_seq(rq);
> >   	else
> >   		seq = REQ_FSEQ_DONE;
> > @@ -200,9 +201,15 @@ static void blk_flush_complete_seq(struct request *rq,
> >   		 * normal completion and end it.
> >   		 */
> >   		BUG_ON(!list_empty(&rq->queuelist));
> > -		list_del_init(&rq->flush.list);
> > -		blk_flush_restore_request(rq);
> > -		blk_mq_end_request(rq, error);
> > +
> > +		/* Terminating code will end the request from flush queue */
> > +		if (likely(!fq->flush_queue_terminating)) {
> > +			list_del_init(&rq->flush.list);
> > +			blk_flush_restore_request(rq);
> > +			blk_mq_end_request(rq, error);
> > +		} else {
> > +			list_move_tail(&rq->flush.list, pending);
> > +		}
> >   		break;
> >   	default:
> > @@ -279,7 +286,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
> >   	struct request *flush_rq = fq->flush_rq;
> >   	/* C1 described at the top of this file */
> > -	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
> > +	if (fq->flush_pending_idx != fq->flush_running_idx ||
> > +			list_empty(pending) || fq->flush_queue_terminating)
> >   		return;
> >   	/* C2 and C3
> > @@ -331,7 +339,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
> >   	struct blk_flush_queue *fq = blk_get_flush_queue(q, ctx);
> >   	if (q->elevator) {
> > -		WARN_ON(rq->tag < 0);
> > +		WARN_ON(rq->tag < 0 && !fq->flush_queue_terminating);
> >   		blk_mq_put_driver_tag(rq);
> >   	}
> > @@ -503,3 +511,104 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
> >   	kfree(fq->flush_rq);
> >   	kfree(fq);
> >   }
> > +
> > +static void __blk_end_queued_flush(struct blk_flush_queue *fq,
> > +		unsigned int queue_idx, struct list_head *resubmit_list,
> > +		struct list_head *flush_list)
> > +{
> > +	struct list_head *queue = &fq->flush_queue[queue_idx];
> > +	struct request *rq, *nxt;
> > +
> > +	list_for_each_entry_safe(rq, nxt, queue, flush.list) {
> > +		unsigned int seq = blk_flush_cur_seq(rq);
> > +
> > +		list_del_init(&rq->flush.list);
> > +		blk_flush_restore_request(rq);
> > +		if (!blk_rq_sectors(rq) || seq == REQ_FSEQ_POSTFLUSH )
> > +			list_add_tail(&rq->queuelist, flush_list);
> > +		else
> > +			list_add_tail(&rq->queuelist, resubmit_list);
> > +	}
> > +}
> > +
> > +static void blk_end_queued_flush(struct blk_flush_queue *fq,
> > +		struct list_head *resubmit_list, struct list_head *flush_list)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fq->mq_flush_lock, flags);
> > +	__blk_end_queued_flush(fq, 0, resubmit_list, flush_list);
> > +	__blk_end_queued_flush(fq, 1, resubmit_list, flush_list);
> > +	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
> > +}
> > +
> > +/* complete requests which just requires one flush command */
> > +static void blk_complete_flush_requests(struct blk_flush_queue *fq,
> > +		struct list_head *flush_list)
> > +{
> > +	struct block_device *bdev;
> > +	struct request *rq;
> > +	int error = -ENXIO;
> > +
> > +	if (list_empty(flush_list))
> > +		return;
> > +
> > +	rq = list_first_entry(flush_list, struct request, queuelist);
> > +
> > +	/* Send flush via one active hctx so we can move on */
> > +	bdev = bdget_disk(rq->rq_disk, 0);
> > +	if (bdev) {
> > +		error = blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
> > +		bdput(bdev);
> > +	}
> > +
> > +	while (!list_empty(flush_list)) {
> > +		rq = list_first_entry(flush_list, struct request, queuelist);
> > +		list_del_init(&rq->queuelist);
> > +		blk_mq_end_request(rq, error);
> > +	}
> > +}
> > +
> I must admit I'm getting nervous if one mixes direct request manipulations
> with high-level 'blkdev_XXX' calls.
> Can't we just requeue everything including the flush itself, and letting the
> requeue algorithm pick a new hctx?

No, the biggest problem is that rq->mq_hctx is bound to the hctx(becomes inactive now)
since request allocation, so we can't requeue them simply.

What we need here is simply one flush command, blkdev_issue_flush() does
exactly what we want.

Thanks,
Ming

