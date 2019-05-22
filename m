Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA6DC072B5
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 01:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAA4217D9
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 01:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfEVB4o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 21:56:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfEVB4o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 21:56:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7D7183F3D;
        Wed, 22 May 2019 01:56:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B141F60C78;
        Wed, 22 May 2019 01:56:26 +0000 (UTC)
Date:   Wed, 22 May 2019 09:56:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
Message-ID: <20190522015620.GA11959@ming.t460p>
References: <20190517091424.19751-1-ming.lei@redhat.com>
 <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 22 May 2019 01:56:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi John,

On Tue, May 21, 2019 at 02:50:06PM +0100, John Garry wrote:
> On 17/05/2019 10:14, Ming Lei wrote:
> > Managed interrupts can not migrate affinity when their CPUs are offline.
> > If the CPU is allowed to shutdown before they're returned, commands
> > dispatched to managed queues won't be able to complete through their
> > irq handlers.
> > 
> > Wait in cpu hotplug handler until all inflight requests on the tags
> > are completed or timeout. Wait once for each tags, so we can save time
> > in case of shared tags.
> > 
> > Based on the following patch from Keith, and use simple delay-spin
> > instead.
> > 
> > https://lore.kernel.org/linux-block/20190405215920.27085-1-keith.busch@intel.com/
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-tag.c |  2 +-
> >  block/blk-mq-tag.h |  5 ++++
> >  block/blk-mq.c     | 65 +++++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 70 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 7513c8eaabee..b24334f99c5d 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -332,7 +332,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
> >   *		true to continue iterating tags, false to stop.
> >   * @priv:	Will be passed as second argument to @fn.
> >   */
> > -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> > +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> >  		busy_tag_iter_fn *fn, void *priv)
> >  {
> >  	if (tags->nr_reserved_tags)
> > diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> > index 61deab0b5a5a..f8de50485b42 100644
> > --- a/block/blk-mq-tag.h
> > +++ b/block/blk-mq-tag.h
> > @@ -19,6 +19,9 @@ struct blk_mq_tags {
> >  	struct request **rqs;
> >  	struct request **static_rqs;
> >  	struct list_head page_list;
> > +
> > +	#define BLK_MQ_TAGS_DRAINED           0
> > +	unsigned long flags;
> >  };
> > 
> > 
> > @@ -35,6 +38,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
> >  extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
> >  void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
> >  		void *priv);
> > +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> > +		busy_tag_iter_fn *fn, void *priv);
> > 
> >  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
> >  						 struct blk_mq_hw_ctx *hctx)
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 08a6248d8536..d1d1b1a9628f 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2214,6 +2214,60 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >  	return -ENOMEM;
> >  }
> > 
> > +static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct blk_mq_hw_ctx	*hctx;
> > +	struct blk_mq_tags	*tags;
> > +
> > +	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> > +	tags = hctx->tags;
> > +
> > +	if (tags)
> > +		clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
> > +
> 
> Hi Ming,
> 
> Thanks for the effort here.
> 
> I would like to make an assertion on a related topic, which I hope you can
> comment on:
> 
> For this drain mechanism to work, the blk_mq_hw_ctx’s (and related cpu
> masks) for a request queue are required to match the hw queues used in the
> LLDD (if using managed interrupts).
> 
> In others words, a SCSI LLDD needs to expose all hw queues for this to work.
> 
> The reason I say this is because if the LLDD does not expose the hw queues
> and manages them internally - as some SCSI LLDDs do - yet uses managed
> interrupts to spread the hw queue MSI vectors across all CPUs, then we still
> only have a single blk_mq_hw_ctx per rq with a cpumask covering all cpus,
> which is not what we would want.

Good catch!

This drain mechanism won't address the issue for these SCSI LLDDs in which:

	1) blk_mq_hw_ctx serves as submission hw queue

	2) one private reply queue serves as completion queue, for which one
	MSI vector with cpumask is setup via pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY).

What we should only drain is the completion queue if all its mapped
CPUs are offline.

Looks you suggest to expose all completion(reply) queues as 'struct blk_mq_hw_ctx',
which may involve in another more hard problem: how to split the single
hostwide tags into each reply queue. I'd rather not work towards that
direction because:

1) it is very hard to partition global resources into several parts,
especially it is hard to make every part happy.

2) sbitmap is smart/efficient enough for this global allocation

3) no obvious improvement is obtained from the resource partition, according
to previous experiment result done by Kashyap.

I think we could implement the drain mechanism in the following way:

1) if 'struct blk_mq_hw_ctx' serves as completion queue, use the
approach in the patch

2) otherwise:
- introduce one callbcack of .prep_queue_dead(hctx, down_cpu) to
'struct blk_mq_ops'

- call .prep_queue_dead from blk_mq_hctx_notify_dead() 

3) inside .prep_queue_dead():
- the driver checks if all mapped CPU on the completion queue is offline
- if yes, wait for in-flight requests originated from all CPUs mapped to
this completion queue, and it can be implemented as one block layer API

Any comments on the above approach?

Thanks,
Ming
