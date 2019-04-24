Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF72C10F03
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 01:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C787218D3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 01:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfDXBpw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:45:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729191AbfDXBpw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 21:45:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47B021219D4;
        Wed, 24 Apr 2019 01:45:51 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A684D608A4;
        Wed, 24 Apr 2019 01:45:41 +0000 (UTC)
Date:   Wed, 24 Apr 2019 09:45:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V6 6/9] blk-mq: always free hctx after request queue is
 freed
Message-ID: <20190424014535.GD634@ming.t460p>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-7-ming.lei@redhat.com>
 <63c09210-c20e-6b4a-56fa-b9eac2807cc1@suse.de>
 <20190417125943.GB5007@ming.t460p>
 <20190422033057.GC21375@ming.t460p>
 <9d93cb74-0683-bb42-2545-b4bb2bfbb831@suse.de>
 <20190423133015.GA31728@ming.t460p>
 <b7e1ad43-9ea1-8ecf-6e1f-97343c45b82f@suse.de>
 <20190424011242.GB634@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424011242.GB634@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 24 Apr 2019 01:45:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 09:12:42AM +0800, Ming Lei wrote:
> On Tue, Apr 23, 2019 at 04:07:49PM +0200, Hannes Reinecke wrote:
> > On 4/23/19 3:30 PM, Ming Lei wrote:
> > > Hi Hannes,
> > > 
> > > Thanks for your response.
> > > 
> > > On Tue, Apr 23, 2019 at 01:19:33PM +0200, Hannes Reinecke wrote:
> > > > On 4/22/19 5:30 AM, Ming Lei wrote:
> > [ .. ]
> > > > > 
> > > > > Hi Hannes,
> > > > > 
> > > > > Could you please let us know if you have better idea for this issue?
> > > > > Otherwise, I think we need to move on since it is real issue, and users
> > > > > want to fix that.
> > > > > 
> > > > Okay. Having looked over the problem and possible alternatives, it looks
> > > > indeed like a viable solution.
> > > > I do agree that it's a sensible design to have an additional holding area
> > > > for hardware context elements, given that they might be reassigned during
> > > > blk_mq_realloc_hw_ctxs().
> > > > 
> > > > However, I would rename the 'dead' elements to 'unused' (ie unused_hctx_list
> > > > etc).
> > > 
> > > OK, looks the name of 'unused' is better.
> > > 
> > > > 
> > > > And I would deallocate q->queue_hw_ctx in blk_mq_exit_queue() to make things
> > > > more consistent.
> > > 
> > > No, that is wrong.
> > > 
> > > The request queue's refcount is often held when blk_cleanup_queue() is running,
> > > and blk_mq_exit_queue() is called directly by blk_cleanup_queue(). One invariant
> > > is that we have to allow most APIs running well if the request queue is live
> > > from kobject view. If q->queue_hw_ctx is freed in blk_mq_exit_queue(),
> > > it is quite easy to cause use-after-free.
> > > 
> > Ah. Thought as much.
> > But then in most cases the ->queue_hw_ctx pointer is immaterial as we're
> > accessing things via the hctx pointer, which remains valid.
> > 
> > > > Problem with the current patch is that in blk_mq_release() we iterate
> > > > the 'dead_hctx_list' and free up everything in there, but then blindly call
> > > > 'kfree(q->queue_hw_ctx)' without checking if there are any context pointers
> > > > left.
> > > 
> > > If request queue is dead, it is safe to assume that there isn't any
> > > reference to request queue and q->queue_hw_ctx. Otherwise, it must be
> > > a bug somewhere.
> > > 
> > Precisely.
> > What I'm trying to achieve with this is to protect against such issues,
> > which are quite easy to introduce given the complexity of the code ...
> 
> But releasing q->queue_hw_ctx in blk_cleanup_queue() is easy to cause
> use-after-free even though the request queue's refcount is held. We can't
> do that simply.
> 
> If someone is still trying to use q->queue_hw_ctx[] after the request
> queue is dead, the bug is in the caller of block layer API, not in
> block layer.
> 
> What the patchset is trying to fix is the race in block layer, not
> users of block layer, not drivers. So far, I don't see such driver
> issue.
> 
> Just thought q->queue_hw_ctx as the request queue's resource, you will
> see it is pretty reasonable to free q->queue_hw_ctx in the queue's
> release handler.
> 
> > 
> > > > When moving the call to blk_mq_exit_queue() we could to a simple
> > > > WARN_ON(q->queue_hw_ctx) in blk_mq_release() to ensure that everything got
> > > > deallocated properly.
> > > 
> > > At that time, hctx instance might be active, but that is fine given hctx
> > > is covered by its own kobject. What we need to do is to make sure that no
> > > any references to q->queue_hw_ctx and the request queue.
> > > 
> > My point being here:
> > void blk_mq_release(struct request_queue *q)
> > {
> >         struct blk_mq_hw_ctx *hctx, *next;
> > 
> >         cancel_delayed_work_sync(&q->requeue_work);
> > 
> >         /* all hctx are in .dead_hctx_list now */
> >         list_for_each_entry_safe(hctx, next, &q->dead_hctx_list, hctx_list)
> > {
> >                 list_del_init(&hctx->hctx_list);
> >                 kobject_put(&hctx->kobj);
> >         }
> > 
> >         kfree(q->queue_hw_ctx);
> > 
> >         /*
> >          * release .mq_kobj and sw queue's kobject now because
> >          * both share lifetime with request queue.
> >          */
> >         blk_mq_sysfs_deinit(q);
> > }
> > 
> > This assumes that _all_ hctx pointers are being removed from
> > q->queue_hw_ctx, and are moved to the 'dead' list.
> > If for some reason this is not the case we'll be leaking hctx pointers here.
> 
> IMO, there aren't such some reasons. When blk_mq_release() is called,
> every hctx of this request queue has been "exited" via blk_mq_exit_hctx(),
> either from blk_mq_update_nr_hw_queues() or blk_cleanup_queue().
> 
> If there are hctxs not moved to the 'dead'(or 'unused') list here, it is
> simply a bug in blk-mq. However, I don't see such case now.

Or we can add the following check in blk_mq_release() for capturing
the impossible blk-mq bug:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2ca4395f794d..f0d08087b8f6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2366,6 +2366,8 @@ blk_mq_alloc_hctx(struct request_queue *q,
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 
+	INIT_LIST_HEAD(&hctx->hctx_list);
+
 	/*
 	 * Allocate space for all possible cpus to avoid allocation at
 	 * runtime
@@ -2680,9 +2682,14 @@ static int blk_mq_alloc_ctxs(struct request_queue *q)
 void blk_mq_release(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx, *next;
+	int i;
 
 	cancel_delayed_work_sync(&q->requeue_work);
 
+	/* warn if live hctx is found, that shouldn't happen */
+	queue_for_each_hw_ctx(q, hctx, i)
+		WARN_ON_ONCE(hctx && list_empty(&hctx->hctx_list));
+
 	/* all hctx are in .dead_hctx_list now */
 	list_for_each_entry_safe(hctx, next, &q->dead_hctx_list, hctx_list) {
 		list_del_init(&hctx->hctx_list);

Thanks,
Ming
