Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B641FC2BA1A
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F1420748
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHIdvm/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgDYDar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:30:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726040AbgDYDar (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587785444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3X1wry2Pw8oVpXlm//mFjv2y5YAESGu+9v+6ZZUCv9U=;
        b=WHIdvm/YWLAbrFSq6J9I9+o+heiCTUSgopNKdUsDIPEXkzp3qxNAGhkDXsP+QCN5eYMUJy
        SZOH96JmNCCabDWYUuMdZwLlkpY+doJ0t7GSHphuTpzIfunRcAKx44gTRSfAIGshGV+H0I
        o9dhUCmTXu6d9P/B9+7ZX3cNvBmnJJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-wbS4J9WHOOmLPaR45Bd5Zg-1; Fri, 24 Apr 2020 23:30:42 -0400
X-MC-Unique: wbS4J9WHOOmLPaR45Bd5Zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59A3B8005B7;
        Sat, 25 Apr 2020 03:30:41 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68BAD60300;
        Sat, 25 Apr 2020 03:30:31 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:30:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200425033026.GE477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <69554493-db0b-228c-94a1-0f6f50580675@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69554493-db0b-228c-94a1-0f6f50580675@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 03:27:45PM +0200, Hannes Reinecke wrote:
> On 4/24/20 12:23 PM, Ming Lei wrote:
> > Before one CPU becomes offline, check if it is the last online CPU of hctx.
> > If yes, mark this hctx as inactive, meantime wait for completion of all
> > in-flight IOs originated from this hctx. Meantime check if this hctx has
> > become inactive in blk_mq_get_driver_tag(), if yes, release the
> > allocated tag.
> > 
> > This way guarantees that there isn't any inflight IO before shutdowning
> > the managed IRQ line when all CPUs of this IRQ line is offline.
> > 
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-debugfs.c |   1 +
> >   block/blk-mq.c         | 124 +++++++++++++++++++++++++++++++++++++----
> >   include/linux/blk-mq.h |   3 +
> >   3 files changed, 117 insertions(+), 11 deletions(-)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 8e745826eb86..b62390918ca5 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -213,6 +213,7 @@ static const char *const hctx_state_name[] = {
> >   	HCTX_STATE_NAME(STOPPED),
> >   	HCTX_STATE_NAME(TAG_ACTIVE),
> >   	HCTX_STATE_NAME(SCHED_RESTART),
> > +	HCTX_STATE_NAME(INACTIVE),
> >   };
> >   #undef HCTX_STATE_NAME
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d432cc74ef78..4d0c271d9f6f 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1050,11 +1050,31 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
> >   	return true;
> >   }
> > -static bool blk_mq_get_driver_tag(struct request *rq)
> > +static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
> >   {
> >   	if (rq->tag != -1)
> >   		return true;
> > -	return __blk_mq_get_driver_tag(rq);
> > +
> > +	if (!__blk_mq_get_driver_tag(rq))
> > +		return false;
> > +	/*
> > +	 * Add one memory barrier in case that direct issue IO process is
> > +	 * migrated to other CPU which may not belong to this hctx, so we can
> > +	 * order driver tag assignment and checking BLK_MQ_S_INACTIVE.
> > +	 * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
> > +	 * and driver tag assignment are run on the same CPU in case that
> > +	 * BLK_MQ_S_INACTIVE is set.
> > +	 */
> > +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> > +		smp_mb();
> > +	else
> > +		barrier();
> > +
> > +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
> > +		blk_mq_put_driver_tag(rq);
> > +		return false;
> > +	}
> > +	return true;
> >   }
> >   static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
> > @@ -1103,7 +1123,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
> >   		 * Don't clear RESTART here, someone else could have set it.
> >   		 * At most this will cost an extra queue run.
> >   		 */
> > -		return blk_mq_get_driver_tag(rq);
> > +		return blk_mq_get_driver_tag(rq, false);
> >   	}
> >   	wait = &hctx->dispatch_wait;
> > @@ -1129,7 +1149,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
> >   	 * allocation failure and adding the hardware queue to the wait
> >   	 * queue.
> >   	 */
> > -	ret = blk_mq_get_driver_tag(rq);
> > +	ret = blk_mq_get_driver_tag(rq, false);
> >   	if (!ret) {
> >   		spin_unlock(&hctx->dispatch_wait_lock);
> >   		spin_unlock_irq(&wq->lock);
> > @@ -1228,7 +1248,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> >   			break;
> >   		}
> > -		if (!blk_mq_get_driver_tag(rq)) {
> > +		if (!blk_mq_get_driver_tag(rq, false)) {
> >   			/*
> >   			 * The initial allocation attempt failed, so we need to
> >   			 * rerun the hardware queue when a tag is freed. The
> > @@ -1260,7 +1280,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> >   			bd.last = true;
> >   		else {
> >   			nxt = list_first_entry(list, struct request, queuelist);
> > -			bd.last = !blk_mq_get_driver_tag(nxt);
> > +			bd.last = !blk_mq_get_driver_tag(nxt, false);
> >   		}
> >   		ret = q->mq_ops->queue_rq(hctx, &bd);
> > @@ -1853,7 +1873,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> >   	if (!blk_mq_get_dispatch_budget(hctx))
> >   		goto insert;
> > -	if (!blk_mq_get_driver_tag(rq)) {
> > +	if (!blk_mq_get_driver_tag(rq, true)) {
> >   		blk_mq_put_dispatch_budget(hctx);
> >   		goto insert;
> >   	}
> > @@ -2261,13 +2281,92 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >   	return -ENOMEM;
> >   }
> > -static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> > +struct count_inflight_data {
> > +	unsigned count;
> > +	struct blk_mq_hw_ctx *hctx;
> > +};
> > +
> > +static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
> > +				     bool reserved)
> >   {
> > -	return 0;
> > +	struct count_inflight_data *count_data = data;
> > +
> > +	/*
> > +	 * Can't check rq's state because it is updated to MQ_RQ_IN_FLIGHT
> > +	 * in blk_mq_start_request(), at that time we can't prevent this rq
> > +	 * from being issued.
> > +	 *
> > +	 * So check if driver tag is assigned, if yes, count this rq as
> > +	 * inflight.
> > +	 */
> > +	if (rq->tag >= 0 && rq->mq_hctx == count_data->hctx)
> > +		count_data->count++;
> > +
> > +	return true;
> > +}
> > +
> > +static bool blk_mq_inflight_rq(struct request *rq, void *data,
> > +			       bool reserved)
> > +{
> > +	return rq->tag >= 0;
> > +}
> > +
> > +static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	struct count_inflight_data count_data = {
> > +		.count	= 0,
> > +		.hctx	= hctx,
> > +	};
> > +
> > +	blk_mq_all_tag_busy_iter(hctx->tags, blk_mq_count_inflight_rq,
> > +			blk_mq_inflight_rq, &count_data);
> > +
> > +	return count_data.count;
> > +}
> > +
> 
> Remind me again: Why do we need the 'filter' function here?
> Can't we just move the filter function into the main iterator and
> stay with the original implementation?

This is a good question, cause it takes John and me days for figuring
out reason of one IO hang.

The main iterator only iterates requests which blk_mq_request_started()
returns true, see bt_tags_iter().

However, we prevent rq from being allocated a driver tag in
blk_mq_get_driver_tag(). There is still some distance between assigning
driver tag and calling into blk_mq_start_request() which is called from
.queue_rq().

More importantly we can check nothing in blk_mq_start_request().


Thanks, 
Ming

