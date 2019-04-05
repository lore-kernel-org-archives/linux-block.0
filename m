Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F27EC4360F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1680D21738
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 13:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfDENw6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:52:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDENw6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 09:52:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75B1770D71;
        Fri,  5 Apr 2019 13:52:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E34D060CDA;
        Fri,  5 Apr 2019 13:52:49 +0000 (UTC)
Date:   Fri, 5 Apr 2019 21:52:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V4 1/7] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
Message-ID: <20190405135244.GA1672@ming.t460p>
References: <20190404084320.24681-1-ming.lei@redhat.com>
 <20190404084320.24681-2-ming.lei@redhat.com>
 <d4aca4e1-efe5-887b-bb48-f49eaebd5283@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4aca4e1-efe5-887b-bb48-f49eaebd5283@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 05 Apr 2019 13:52:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 05, 2019 at 05:26:24PM +0800, Dongli Zhang wrote:
> Hi Ming,
> 
> On 04/04/2019 04:43 PM, Ming Lei wrote:
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
> > Cc: jianchao wang <jianchao.w.wang@oracle.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 3ff3d7b49969..5b586affee09 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1728,9 +1728,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> >  		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
> >  			if (this_hctx) {
> >  				trace_block_unplug(this_q, depth, !from_schedule);
> > +
> > +				percpu_ref_get(&this_q->q_usage_counter);
> 
> Sorry to bother but I would just like to double confirm the reason to use
> "percpu_ref_get()" here which does not check whether the queue has been frozen.
> 
> Is it because there is assumption that any direct/indirect caller of
> blk_mq_flush_plug_list() much have already grabbed q_usage_counter, which is
> similar to blk_queue_enter_live()?

Because there is request in the plug list to be queued.

Thanks,
Ming
