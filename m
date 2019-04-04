Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AB8C10F0C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 06:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540BA2147C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 06:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDDGkp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:40:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDGkp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 02:40:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CD956439B;
        Thu,  4 Apr 2019 06:40:44 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 327BC84D86;
        Thu,  4 Apr 2019 06:40:31 +0000 (UTC)
Date:   Thu, 4 Apr 2019 14:40:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH V3 3/6] blk-mq: free hw queue's resource in hctx's
 release handler
Message-ID: <20190404064024.GA5004@ming.t460p>
References: <20190403102609.18707-1-ming.lei@redhat.com>
 <20190403102609.18707-4-ming.lei@redhat.com>
 <1554308792.118779.221.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554308792.118779.221.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 04 Apr 2019 06:40:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 03, 2019 at 09:26:32AM -0700, Bart Van Assche wrote:
> On Wed, 2019-04-03 at 18:26 +0800, Ming Lei wrote:
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 6583d67f3e34..20298aa5a77c 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -374,7 +374,7 @@ void blk_cleanup_queue(struct request_queue *q)
> >         blk_exit_queue(q);
> >  
> >         if (queue_is_mq(q))
> > -               blk_mq_free_queue(q);
> > +               blk_mq_exit_queue(q);
> >  
> >         percpu_ref_exit(&q->q_usage_counter);
> >  
> > diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> > index 3f9c3f4ac44c..4040e62c3737 100644
> > --- a/block/blk-mq-sysfs.c
> > +++ b/block/blk-mq-sysfs.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/smp.h>
> >  
> >  #include <linux/blk-mq.h>
> > +#include "blk.h"
> >  #include "blk-mq.h"
> >  #include "blk-mq-tag.h"
> >  
> > @@ -33,6 +34,11 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
> >  {
> >         struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
> >                                                   kobj);
> > +
> > +       if (hctx->flags & BLK_MQ_F_BLOCKING)
> > +               cleanup_srcu_struct(hctx->srcu);
> > +       blk_free_flush_queue(hctx->fq);
> > +       sbitmap_free(&hctx->ctx_map);
> >         free_cpumask_var(hctx->cpumask);
> >         kfree(hctx->ctxs);
> >         kfree(hctx);
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index b512ba0cb359..afc9912e2e42 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2259,12 +2259,7 @@ static void blk_mq_exit_hctx(struct request_queue *q,
> >         if (set->ops->exit_hctx)
> >                 set->ops->exit_hctx(hctx, hctx_idx);
> >  
> > -       if (hctx->flags & BLK_MQ_F_BLOCKING)
> > -               cleanup_srcu_struct(hctx->srcu);
> > -
> >         blk_mq_remove_cpuhp(hctx);
> > -       blk_free_flush_queue(hctx->fq);
> > -       sbitmap_free(&hctx->ctx_map);
> >  }
> >  
> >  static void blk_mq_exit_hw_queues(struct request_queue *q,
> > @@ -2899,7 +2894,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> >  }
> >  EXPORT_SYMBOL(blk_mq_init_allocated_queue);
> >  
> > -void blk_mq_free_queue(struct request_queue *q)
> > +/* tags can _not_ be used after returning from blk_mq_exit_queue */
> > +void blk_mq_exit_queue(struct request_queue *q)
> >  {
> >         struct blk_mq_tag_set   *set = q->tag_set;
> >  
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index d704fc7766f4..c421e3a16e36 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -37,7 +37,7 @@ struct blk_mq_ctx {
> >         struct kobject          kobj;
> >  } ____cacheline_aligned_in_smp;
> >  
> > -void blk_mq_free_queue(struct request_queue *q);
> > +void blk_mq_exit_queue(struct request_queue *q);
> >  int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
> >  void blk_mq_wake_waiters(struct request_queue *q);
> >  bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *, bool);
> 
> Isn't this an incomplete solution? The above patch fixes the race between
> cleaning up a queue and running a queue but does not address the race between
> running a queue and changing the number of hardware queues.

In blk_mq_realloc_hw_ctxs(), we still cover hctx's lifetime via kboject.

When new hctx is created, there can't be run queue activity on new hctx.

For hctx to be removed, the following code is run:

        for (; j < end; j++) {
                struct blk_mq_hw_ctx *hctx = hctxs[j];

                if (hctx) {
                        if (hctx->tags)
                                blk_mq_free_map_and_requests(set, j);
                        blk_mq_exit_hctx(q, set, hctx, j);
                        kobject_put(&hctx->kobj);
                        hctxs[j] = NULL;

                }
        }

So the un-completed run queue activity still can be run until queue's
kobject refcount is released, this way is same with blk_cleanup_queue().

So could you explain what the race between run queue and
blk_mq_update_nr_hw_queues() is?


Thanks, 
Ming
