Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE7C433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8AE2067D
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 22:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfHLWY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:24:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfHLWY5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 18:24:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22F053061424;
        Mon, 12 Aug 2019 22:24:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEAD871CBE;
        Mon, 12 Aug 2019 22:24:48 +0000 (UTC)
Date:   Tue, 13 Aug 2019 06:24:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2 3/5] blk-mq: stop to handle IO before hctx's all CPUs
 become offline
Message-ID: <20190812222440.GA17645@ming.t460p>
References: <20190812134312.16732-1-ming.lei@redhat.com>
 <20190812134312.16732-4-ming.lei@redhat.com>
 <7d757a7b-6e8f-3bb4-e9b9-7308cb86e2e3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d757a7b-6e8f-3bb4-e9b9-7308cb86e2e3@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 12 Aug 2019 22:24:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 12, 2019 at 04:24:01PM +0200, Hannes Reinecke wrote:
> On 8/12/19 3:43 PM, Ming Lei wrote:
> > Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> > up queue mapping. Thomas mentioned the following point[1]:
> > 
> > "
> >  That was the constraint of managed interrupts from the very beginning:
> > 
> >   The driver/subsystem has to quiesce the interrupt line and the associated
> >   queue _before_ it gets shutdown in CPU unplug and not fiddle with it
> >   until it's restarted by the core when the CPU is plugged in again.
> > "
> > 
> > However, current blk-mq implementation doesn't quiesce hw queue before
> > the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
> > one cpuhp state handled after the CPU is down, so there isn't any chance
> > to quiesce hctx for blk-mq wrt. CPU hotplug.
> > 
> > Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
> > and wait for completion of in-flight requests.
> > 
> > [1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-tag.c         |  2 +-
> >  block/blk-mq-tag.h         |  2 ++
> >  block/blk-mq.c             | 65 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/blk-mq.h     |  1 +
> >  include/linux/cpuhotplug.h |  1 +
> >  5 files changed, 70 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 008388e82b5c..31828b82552b 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -325,7 +325,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
> >   *		true to continue iterating tags, false to stop.
> >   * @priv:	Will be passed as second argument to @fn.
> >   */
> > -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> > +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> >  		busy_tag_iter_fn *fn, void *priv)
> >  {
> >  	if (tags->nr_reserved_tags)
> > diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> > index 61deab0b5a5a..321fd6f440e6 100644
> > --- a/block/blk-mq-tag.h
> > +++ b/block/blk-mq-tag.h
> > @@ -35,6 +35,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
> >  extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
> >  void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
> >  		void *priv);
> > +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> > +		busy_tag_iter_fn *fn, void *priv);
> >  
> >  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
> >  						 struct blk_mq_hw_ctx *hctx)
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 6968de9d7402..6931b2ba2776 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2206,6 +2206,61 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >  	return -ENOMEM;
> >  }
> >  
> > +static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
> > +				     bool reserved)
> > +{
> > +	unsigned *count = data;
> > +
> > +	if ((blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
> > +		(*count)++;
> > +
> > +	return true;
> > +}
> > +
> > +static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags)
> > +{
> > +	unsigned count = 0;
> > +
> > +	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &count);
> > +
> > +	return count;
> > +}
> > +
> > +static void blk_mq_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	while (1) {
> > +		if (!blk_mq_tags_inflight_rqs(hctx->tags))
> > +			break;
> > +		msleep(5);
> > +	}
> > +}
> > +
> > +static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> > +			struct blk_mq_hw_ctx, cpuhp_online);
> > +	unsigned prev_cpu = -1;
> > +
> > +	while (true) {
> > +		unsigned next_cpu = cpumask_next_and(prev_cpu, hctx->cpumask,
> > +				cpu_online_mask);
> > +
> > +		if (next_cpu >= nr_cpu_ids)
> > +			break;
> > +
> > +		/* return if there is other online CPU on this hctx */
> > +		if (next_cpu != cpu)
> > +			return 0;
> > +
> > +		prev_cpu = next_cpu;
> > +	}
> > +
> > +	set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
> > +	blk_mq_drain_inflight_rqs(hctx);
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * 'cpu' is going away. splice any existing rq_list entries from this
> >   * software queue to the hw queue dispatch list, and ensure that it
> 
> Isn't that inverted?

The above comment is wrong, and you will see it is fixed in patch 4.

blk_mq_hctx_notify_dead() is called when the specified CPU is dead, and
blk_mq_hctx_notify_online() is called before the CPU goes away during
cpuhp path.

> From the function I would assume it'll be called once the CPU is being
> set toe 'online', yet from the description I would have assumed the

No, blk_mq_init() only registers teardown callback for
CPUHP_AP_BLK_MQ_ONLINE, that means blk_mq_hctx_notify_online() is only
called when CPU is going away, still online, so we can stop queue for
quiescing IO on this queue.

> INTERNAL_STOPPED bit is set when the cpu goes offline.
> Care to elaborate?

The idea is to quiesce queue in two stages:

1) in blk_mq_hctx_notify_online(), this CPU isn't dead yet, but is going to
become dead, so we can wait for completion of in-flight IOs. Meantime
stop the hw queue.

2) in blk_mq_hctx_notify_dead(), all CPUs of this hw queue have been
dead, what we can do is to end the request and re-submit the IO, and new
request will be mapped to another active hw queue because
blk_mq_hctx_notify_dead() is always called from one online CPU.


Thanks,
Ming
