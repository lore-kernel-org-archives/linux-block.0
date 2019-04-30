Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92690C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 00:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6592021734
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 00:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfD3Au0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:50:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfD3Au0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 20:50:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1931B30833C5;
        Tue, 30 Apr 2019 00:50:26 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16B8017C5D;
        Tue, 30 Apr 2019 00:50:17 +0000 (UTC)
Date:   Tue, 30 Apr 2019 08:50:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V8 4/7] blk-mq: split blk_mq_alloc_and_init_hctx into two
 parts
Message-ID: <20190430005011.GB18120@ming.t460p>
References: <20190428081408.27331-1-ming.lei@redhat.com>
 <20190428081408.27331-5-ming.lei@redhat.com>
 <24ecd123-5707-9b70-d284-b3228951813f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ecd123-5707-9b70-d284-b3228951813f@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 30 Apr 2019 00:50:26 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 29, 2019 at 08:05:30AM +0200, Hannes Reinecke wrote:
> On 4/28/19 10:14 AM, Ming Lei wrote:
> > Split blk_mq_alloc_and_init_hctx into two parts, and one is
> > blk_mq_alloc_hctx() for allocating all hctx resources, another
> > is blk_mq_init_hctx() for initializing hctx, which serves as
> > counter-part of blk_mq_exit_hctx().
> > 
> > Cc: Dongli Zhang <dongli.zhang@oracle.com>
> > Cc: James Smart <james.smart@broadcom.com>
> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: linux-scsi@vger.kernel.org,
> > Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> > Cc: Christoph Hellwig <hch@lst.de>,
> > Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> > Reviewed-by: Hannes Reinecke <hare@suse.com>
> > Tested-by: James Smart <james.smart@broadcom.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq.c | 138 ++++++++++++++++++++++++++++++++-------------------------
> >   1 file changed, 77 insertions(+), 61 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d98cb9614dfa..44ecca6b0cac 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2284,15 +2284,70 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
> >   	}
> >   }
> > +static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
> > +{
> > +	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
> > +
> > +	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
> > +			   __alignof__(struct blk_mq_hw_ctx)) !=
> > +		     sizeof(struct blk_mq_hw_ctx));
> > +
> > +	if (tag_set->flags & BLK_MQ_F_BLOCKING)
> > +		hw_ctx_size += sizeof(struct srcu_struct);
> > +
> > +	return hw_ctx_size;
> > +}
> > +
> >   static int blk_mq_init_hctx(struct request_queue *q,
> >   		struct blk_mq_tag_set *set,
> >   		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
> >   {
> > -	int node;
> > +	hctx->queue_num = hctx_idx;
> > -	node = hctx->numa_node;
> > +	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
> > +
> > +	hctx->tags = set->tags[hctx_idx];
> > +
> > +	if (set->ops->init_hctx &&
> > +	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
> > +		goto unregister_cpu_notifier;
> > +
> > +	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
> > +				hctx->numa_node))
> > +		goto exit_hctx;
> > +	return 0;
> > +
> > + exit_hctx:
> > +	if (set->ops->exit_hctx)
> > +		set->ops->exit_hctx(hctx, hctx_idx);
> > + unregister_cpu_notifier:
> > +	blk_mq_remove_cpuhp(hctx);
> > +	return -1;
> > +}
> > +
> > +static struct blk_mq_hw_ctx *
> > +blk_mq_alloc_hctx(struct request_queue *q,
> > +		struct blk_mq_tag_set *set,
> > +		unsigned hctx_idx, int node)
> > +{
> > +	struct blk_mq_hw_ctx *hctx;
> > +
> > +	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
> > +			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
> > +			node);
> > +	if (!hctx)
> > +		goto fail_alloc_hctx;
> > +
> > +	if (!zalloc_cpumask_var_node(&hctx->cpumask,
> > +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
> > +				node))
> > +		goto free_hctx;
> > +
> > +	atomic_set(&hctx->nr_active, 0);
> > +	hctx->numa_node = node;
> >   	if (node == NUMA_NO_NODE)
> > -		node = hctx->numa_node = set->numa_node;
> > +		hctx->numa_node = set->numa_node;
> > +	node = hctx->numa_node;
> >   	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
> >   	spin_lock_init(&hctx->lock);
> The 'hctx_idx' argument is now unused, and should be removed from the
> function definition.

OK, will do it in V9.

Thanks,
Ming
