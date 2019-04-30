Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0928C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 00:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86AE21655
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 00:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfD3Asx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:48:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfD3Asx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 20:48:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DC1B59445;
        Tue, 30 Apr 2019 00:48:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C8817C5D;
        Tue, 30 Apr 2019 00:48:43 +0000 (UTC)
Date:   Tue, 30 Apr 2019 08:48:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V8 1/7] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
Message-ID: <20190430004837.GA18120@ming.t460p>
References: <20190428081408.27331-1-ming.lei@redhat.com>
 <20190428081408.27331-2-ming.lei@redhat.com>
 <1556561379.161891.164.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556561379.161891.164.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 30 Apr 2019 00:48:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 29, 2019 at 11:09:39AM -0700, Bart Van Assche wrote:
> On Sun, 2019-04-28 at 16:14 +0800, Ming Lei wrote:
> > Just like aio/io_uring, we need to grab 2 refcount for queuing one
> > request, one is for submission, another is for completion.
> > 
> > If the request isn't queued from plug code path, the refcount grabbed
> > in generic_make_request() serves for submission. In theroy, this
> > refcount should have been released after the sumission(async run queue)
> > is done. blk_freeze_queue() works with blk_sync_queue() together
> > for avoiding race between cleanup queue and IO submission, given async
> > run queue activities are canceled because hctx->run_work is scheduled with
> > the refcount held, so it is fine to not hold the refcount when
> > running the run queue work function for dispatch IO.
> > 
> > However, if request is staggered into plug list, and finally queued
> > from plug code path, the refcount in submission side is actually missed.
> > And we may start to run queue after queue is removed because the queue's
> > kobject refcount isn't guaranteed to be grabbed in flushing plug list
> > context, then kernel oops is triggered, see the following race:
> > 
> > blk_mq_flush_plug_list():
> >         blk_mq_sched_insert_requests()
> >                 insert requests to sw queue or scheduler queue
> >                 blk_mq_run_hw_queue
> > 
> > Because of concurrent run queue, all requests inserted above may be
> > completed before calling the above blk_mq_run_hw_queue. Then queue can
> > be freed during the above blk_mq_run_hw_queue().
> > 
> > Fixes the issue by grab .q_usage_counter before calling
> > blk_mq_sched_insert_requests() in blk_mq_flush_plug_list(). This way is
> > safe because the queue is absolutely alive before inserting request.
> > 
> > Cc: Dongli Zhang <dongli.zhang@oracle.com>
> > Cc: James Smart <james.smart@broadcom.com>
> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: linux-scsi@vger.kernel.org,
> > Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> > Cc: Christoph Hellwig <hch@lst.de>,
> > Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> > Reviewed-by: Hannes Reinecke <hare@suse.com>
> > Tested-by: James Smart <james.smart@broadcom.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> I added my "Reviewed-by" to a previous version of this patch but not
> to this version of this patch. Several "Reviewed-by" tags probably
> should be removed.

Fine.

> 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index aa6bc5c02643..dfe83e7935d6 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -414,6 +414,13 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
> >  {
> >         struct elevator_queue *e;
> >  
> > +       /*
> > +        * blk_mq_sched_insert_requests() is called from flush plug
> > +        * context only, and hold one usage counter to prevent queue
> > +        * from being released.
> > +        */
> > +       percpu_ref_get(&hctx->queue->q_usage_counter);
> > +
> >         e = hctx->queue->elevator;
> >         if (e && e->type->ops.insert_requests)
> >                 e->type->ops.insert_requests(hctx, list, false);
> > @@ -432,6 +439,8 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
> >         }
> >  
> >         blk_mq_run_hw_queue(hctx, run_queue_async);
> > +
> > +       percpu_ref_put(&hctx->queue->q_usage_counter);
> >  }
> 
> I think that 'hctx' can disappear if all requests queued by this function
> finish just before blk_mq_run_hw_queue() returns and if the number of hardware
> queues is changed from another thread.

updating nr_hw_queues needs to freeze queues in the same tagset first,
and the added percpu_ref_get() will prevent that from happening.

> Shouldn't the request queue pointer be
> stored in a local variable instead of reading hctx->queue twice?

Yeah, it is much cleaner, will do it in V9.

BTW, one big problem in this patch(V8) is that the usage counter isn't
put in the early return branch.

thanks,
Ming
