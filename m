Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D75C433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 22:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F272067D
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 22:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfHLWao (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:30:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfHLWao (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 18:30:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D75B30615BF;
        Mon, 12 Aug 2019 22:30:43 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB7698036E;
        Mon, 12 Aug 2019 22:30:36 +0000 (UTC)
Date:   Tue, 13 Aug 2019 06:30:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2 4/5] blk-mq: re-submit IO in case that hctx is dead
Message-ID: <20190812223028.GB17645@ming.t460p>
References: <20190812134312.16732-1-ming.lei@redhat.com>
 <20190812134312.16732-5-ming.lei@redhat.com>
 <03516e51-a9ff-9ff2-9da0-d57cea7336f9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03516e51-a9ff-9ff2-9da0-d57cea7336f9@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 12 Aug 2019 22:30:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 12, 2019 at 04:26:42PM +0200, Hannes Reinecke wrote:
> On 8/12/19 3:43 PM, Ming Lei wrote:
> > When all CPUs in one hctx are offline, we shouldn't run this hw queue
> > for completing request any more.
> > 
> > So steal bios from the request, and resubmit them, and finally free
> > the request in blk_mq_hctx_notify_dead().
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 41 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 6931b2ba2776..ed334fd867c4 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2261,10 +2261,30 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> >  	return 0;
> >  }
> >  
> > +static void blk_mq_resubmit_io(struct request *rq)
> > +{
> > +	struct bio_list list;
> > +	struct bio *bio;
> > +
> > +	bio_list_init(&list);
> > +	blk_steal_bios(&list, rq);
> > +
> > +	while (true) {
> > +		bio = bio_list_pop(&list);
> > +		if (!bio)
> > +			break;
> > +
> > +		generic_make_request(bio);
> > +	}
> > +
> > +	blk_mq_cleanup_rq(rq);
> > +	blk_mq_end_request(rq, 0);
> > +}
> > +
> >  /*
> > - * 'cpu' is going away. splice any existing rq_list entries from this
> > - * software queue to the hw queue dispatch list, and ensure that it
> > - * gets run.
> > + * 'cpu' has gone away. If this hctx is dead, we can't dispatch request
> > + * to the hctx any more, so steal bios from requests of this hctx, and
> > + * re-submit them to the request queue, and free these requests finally.
> >   */
> >  static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> >  {
> > @@ -2272,6 +2292,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> >  	struct blk_mq_ctx *ctx;
> >  	LIST_HEAD(tmp);
> >  	enum hctx_type type;
> > +	bool hctx_dead;
> > +	struct request *rq;
> >  
> >  	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> >  	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
> > @@ -2279,6 +2301,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> >  
> >  	clear_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
> >  
> > +	hctx_dead = cpumask_first_and(hctx->cpumask, cpu_online_mask) >=
> > +		nr_cpu_ids;
> > +
> >  	spin_lock(&ctx->lock);
> >  	if (!list_empty(&ctx->rq_lists[type])) {
> >  		list_splice_init(&ctx->rq_lists[type], &tmp);
> > @@ -2289,11 +2314,20 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> >  	if (list_empty(&tmp))
> >  		return 0;
> >  
> > -	spin_lock(&hctx->lock);
> > -	list_splice_tail_init(&tmp, &hctx->dispatch);
> > -	spin_unlock(&hctx->lock);
> > +	if (!hctx_dead) {
> > +		spin_lock(&hctx->lock);
> > +		list_splice_tail_init(&tmp, &hctx->dispatch);
> > +		spin_unlock(&hctx->lock);
> > +		blk_mq_run_hw_queue(hctx, true);
> > +		return 0;
> > +	}
> > +
> > +	while (!list_empty(&tmp)) {
> > +		rq = list_entry(tmp.next, struct request, queuelist);
> > +		list_del_init(&rq->queuelist);
> > +		blk_mq_resubmit_io(rq);
> > +	}
> >  
> > -	blk_mq_run_hw_queue(hctx, true);
> >  	return 0;
> >  }
> >  
> > 
> So what happens when all CPUs assigned to a hardware queue go offline?
> Wouldn't blk_steal_bios() etc resend the I/O to the same hw queue,
> causing an infinite loop?

No, blk_mq_hctx_notify_dead() is always called on one online CPU, so the I/O
won't be remapped to same hw queue.

> 
> Don't we have to rearrange the hardware queues here?

No, we use static queue mapping for managed IRQ, all possible CPUs have
been spread on all hw queues.

Thanks,
Ming
