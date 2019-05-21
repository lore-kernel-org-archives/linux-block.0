Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3833CC04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 08:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164582173C
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 08:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfEUIDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 04:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfEUIDo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 04:03:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FEA5C05B1CD;
        Tue, 21 May 2019 08:03:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B63C19C5B;
        Tue, 21 May 2019 08:03:27 +0000 (UTC)
Date:   Tue, 21 May 2019 16:03:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
Message-ID: <20190521080322.GA27095@ming.t460p>
References: <20190517091424.19751-1-ming.lei@redhat.com>
 <20190521074019.GA31265@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521074019.GA31265@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 21 May 2019 08:03:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 09:40:19AM +0200, Christoph Hellwig wrote:
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
> 
> How about moving blk_mq_tags_inflight_rqs to blk-mq-tag.c instead?

OK.

> 
> > +	#define BLK_MQ_TAGS_DRAINED           0
> 
> Please don't indent #defines.

OK.

> 
> >  
> > +static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct blk_mq_hw_ctx	*hctx;
> > +	struct blk_mq_tags	*tags;
> > +
> > +	tags = hctx->tags;
> > +
> > +	if (tags)
> > +		clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
> > +
> > +	return 0;
> 
> I'd write this as:
> 
> {
> 	struct blk_mq_hw_ctx	*hctx = 
> 		hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> 
> 	if (hctx->tags)
> 		clear_bit(BLK_MQ_TAGS_DRAINED, &hctx->tags->flags);
> 	return 0;
> }

OK.

> 
> > +static void blk_mq_drain_inflight_rqs(struct blk_mq_tags *tags, int dead_cpu)
> > +{
> > +	unsigned long msecs_left = 1000 * 5;
> > +
> > +	if (!tags)
> > +		return;
> > +
> > +	if (test_and_set_bit(BLK_MQ_TAGS_DRAINED, &tags->flags))
> > +		return;
> > +
> > +	while (msecs_left > 0) {
> > +		if (!blk_mq_tags_inflight_rqs(tags))
> > +			break;
> > +		msleep(5);
> > +		msecs_left -= 5;
> > +	}
> > +
> > +	if (msecs_left > 0)
> > +		printk(KERN_WARNING "requests not completed from dead "
> > +				"CPU %d\n", dead_cpu);
> > +}
> 
> Isn't this condition inverted?  If we break out early msecs_left will
> be larger than 0 and we are fine.

Yeah, I saw that just after the patch was posted.

> 
> Why not:
> 
> 	for (attempts = 0; attempts < 1000; attempts++) {
> 		if (!blk_mq_tags_inflight_rqs(tags))
> 			return;
> 	}

Fine.

> 
> 	...
> 
> But more importantly I'm not sure we can just give up that easily.
> Shouldn't we at lest wait the same timeout we otherwise have for
> requests, and if the command isn't finished in time kick off error
> handling?

The default 30sec timeout is too long here, and may cause new bug
report on CPU hotplug.

Also it makes no difference by waiting 30sec, given timeout
handler will be triggered when request is really timed out.

However, one problem is that some drivers may simply return RESET_TIMER
in their timeout handler, then no simple solution for these drivers.


Thanks,
Ming
