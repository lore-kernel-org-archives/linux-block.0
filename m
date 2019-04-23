Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94039C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 13:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A59214AE
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 13:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfDWNae (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWNae (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 09:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 814BE18DF7A;
        Tue, 23 Apr 2019 13:30:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FBC15D9C8;
        Tue, 23 Apr 2019 13:30:21 +0000 (UTC)
Date:   Tue, 23 Apr 2019 21:30:17 +0800
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
Message-ID: <20190423133015.GA31728@ming.t460p>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-7-ming.lei@redhat.com>
 <63c09210-c20e-6b4a-56fa-b9eac2807cc1@suse.de>
 <20190417125943.GB5007@ming.t460p>
 <20190422033057.GC21375@ming.t460p>
 <9d93cb74-0683-bb42-2545-b4bb2bfbb831@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d93cb74-0683-bb42-2545-b4bb2bfbb831@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 23 Apr 2019 13:30:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hannes,

Thanks for your response.

On Tue, Apr 23, 2019 at 01:19:33PM +0200, Hannes Reinecke wrote:
> On 4/22/19 5:30 AM, Ming Lei wrote:
> > On Wed, Apr 17, 2019 at 08:59:43PM +0800, Ming Lei wrote:
> > > On Wed, Apr 17, 2019 at 02:08:59PM +0200, Hannes Reinecke wrote:
> > > > On 4/17/19 5:44 AM, Ming Lei wrote:
> > > > > In normal queue cleanup path, hctx is released after request queue
> > > > > is freed, see blk_mq_release().
> > > > > 
> > > > > However, in __blk_mq_update_nr_hw_queues(), hctx may be freed because
> > > > > of hw queues shrinking. This way is easy to cause use-after-free,
> > > > > because: one implicit rule is that it is safe to call almost all block
> > > > > layer APIs if the request queue is alive; and one hctx may be retrieved
> > > > > by one API, then the hctx can be freed by blk_mq_update_nr_hw_queues();
> > > > > finally use-after-free is triggered.
> > > > > 
> > > > > Fixes this issue by always freeing hctx after releasing request queue.
> > > > > If some hctxs are removed in blk_mq_update_nr_hw_queues(), introduce
> > > > > a per-queue list to hold them, then try to resuse these hctxs if numa
> > > > > node is matched.
> > > > > 
> > > > > Cc: Dongli Zhang <dongli.zhang@oracle.com>
> > > > > Cc: James Smart <james.smart@broadcom.com>
> > > > > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> > > > > Cc: linux-scsi@vger.kernel.org,
> > > > > Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> > > > > Cc: Christoph Hellwig <hch@lst.de>,
> > > > > Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> > > > > Cc: jianchao wang <jianchao.w.wang@oracle.com>
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >    block/blk-mq.c         | 40 +++++++++++++++++++++++++++-------------
> > > > >    include/linux/blk-mq.h |  2 ++
> > > > >    include/linux/blkdev.h |  7 +++++++
> > > > >    3 files changed, 36 insertions(+), 13 deletions(-)
> > > > > 
> > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > index eeebba6ec0f7..2ca4395f794d 100644
> > > > > --- a/block/blk-mq.c
> > > > > +++ b/block/blk-mq.c
> > > > > @@ -2274,6 +2274,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
> > > > >    		set->ops->exit_hctx(hctx, hctx_idx);
> > > > >    	blk_mq_remove_cpuhp(hctx);
> > > > > +
> > > > > +	spin_lock(&q->dead_hctx_lock);
> > > > > +	list_add(&hctx->hctx_list, &q->dead_hctx_list);
> > > > > +	spin_unlock(&q->dead_hctx_lock);
> > > > >    }
> > > > >    static void blk_mq_exit_hw_queues(struct request_queue *q,
> > > > > @@ -2675,15 +2679,13 @@ static int blk_mq_alloc_ctxs(struct request_queue *q)
> > > > >     */
> > > > >    void blk_mq_release(struct request_queue *q)
> > > > >    {
> > > > > -	struct blk_mq_hw_ctx *hctx;
> > > > > -	unsigned int i;
> > > > > +	struct blk_mq_hw_ctx *hctx, *next;
> > > > >    	cancel_delayed_work_sync(&q->requeue_work);
> > > > > -	/* hctx kobj stays in hctx */
> > > > > -	queue_for_each_hw_ctx(q, hctx, i) {
> > > > > -		if (!hctx)
> > > > > -			continue;
> > > > > +	/* all hctx are in .dead_hctx_list now */
> > > > > +	list_for_each_entry_safe(hctx, next, &q->dead_hctx_list, hctx_list) {
> > > > > +		list_del_init(&hctx->hctx_list);
> > > > >    		kobject_put(&hctx->kobj);
> > > > >    	}
> > > > > @@ -2750,9 +2752,22 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
> > > > >    		struct blk_mq_tag_set *set, struct request_queue *q,
> > > > >    		int hctx_idx, int node)
> > > > >    {
> > > > > -	struct blk_mq_hw_ctx *hctx;
> > > > > +	struct blk_mq_hw_ctx *hctx = NULL, *tmp;
> > > > > +
> > > > > +	/* reuse dead hctx first */
> > > > > +	spin_lock(&q->dead_hctx_lock);
> > > > > +	list_for_each_entry(tmp, &q->dead_hctx_list, hctx_list) {
> > > > > +		if (tmp->numa_node == node) {
> > > > > +			hctx = tmp;
> > > > > +			break;
> > > > > +		}
> > > > > +	}
> > > > > +	if (hctx)
> > > > > +		list_del_init(&hctx->hctx_list);
> > > > > +	spin_unlock(&q->dead_hctx_lock);
> > > > > -	hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
> > > > > +	if (!hctx)
> > > > > +		hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
> > > > >    	if (!hctx)
> > > > >    		goto fail;
> > > > > @@ -2790,10 +2805,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > > > >    		hctx = blk_mq_alloc_and_init_hctx(set, q, i, node);
> > > > >    		if (hctx) {
> > > > > -			if (hctxs[i]) {
> > > > > +			if (hctxs[i])
> > > > >    				blk_mq_exit_hctx(q, set, hctxs[i], i);
> > > > > -				kobject_put(&hctxs[i]->kobj);
> > > > > -			}
> > > > >    			hctxs[i] = hctx;
> > > > >    		} else {
> > > > >    			if (hctxs[i])
> > > > > @@ -2824,9 +2837,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > > > >    			if (hctx->tags)
> > > > >    				blk_mq_free_map_and_requests(set, j);
> > > > >    			blk_mq_exit_hctx(q, set, hctx, j);
> > > > > -			kobject_put(&hctx->kobj);
> > > > >    			hctxs[j] = NULL;
> > > > > -
> > > > >    		}
> > > > >    	}
> > > > >    	mutex_unlock(&q->sysfs_lock);
> > > > > @@ -2869,6 +2880,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> > > > >    	if (!q->queue_hw_ctx)
> > > > >    		goto err_sys_init;
> > > > > +	INIT_LIST_HEAD(&q->dead_hctx_list);
> > > > > +	spin_lock_init(&q->dead_hctx_lock);
> > > > > +
> > > > >    	blk_mq_realloc_hw_ctxs(set, q);
> > > > >    	if (!q->nr_hw_queues)
> > > > >    		goto err_hctxs;
> > > > > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > > > > index db29928de467..15d1aa53d96c 100644
> > > > > --- a/include/linux/blk-mq.h
> > > > > +++ b/include/linux/blk-mq.h
> > > > > @@ -70,6 +70,8 @@ struct blk_mq_hw_ctx {
> > > > >    	struct dentry		*sched_debugfs_dir;
> > > > >    #endif
> > > > > +	struct list_head	hctx_list;
> > > > > +
> > > > >    	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
> > > > >    	struct srcu_struct	srcu[0];
> > > > >    };
> > > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > > index 4b85dc066264..1325f941f0be 100644
> > > > > --- a/include/linux/blkdev.h
> > > > > +++ b/include/linux/blkdev.h
> > > > > @@ -535,6 +535,13 @@ struct request_queue {
> > > > >    	struct mutex		sysfs_lock;
> > > > > +	/*
> > > > > +	 * for reusing dead hctx instance in case of updating
> > > > > +	 * nr_hw_queues
> > > > > +	 */
> > > > > +	struct list_head	dead_hctx_list;
> > > > > +	spinlock_t		dead_hctx_lock;
> > > > > +
> > > > >    	atomic_t		mq_freeze_depth;
> > > > >    #if defined(CONFIG_BLK_DEV_BSG)
> > > > > 
> > > > Hmm.
> > > > I don't particularly like this approach.
> > > > The much saner approach would be to avoid having I/O in-flight in the first
> > > > place by setting the queue to something else than live, no?
> > > 
> > > There isn't any in-flight IO since blk_mq_freeze_queue() is returned
> > > from __blk_mq_update_nr_hw_queues().
> > > 
> > > However, there can be reference to hctx in other code paths via
> > > arbitrary block layer APIs.
> > > 
> > > Quiesce can't avoid the use-after-free too given RCU read lock may
> > > not be held in lots of reference to hctx, such as queue_for_each_hw_ctx().
> > > 
> > > So this patch might be the simplest approach to fix this issue, IMO.
> > > 
> > > However, I am open to any solution for this issue.
> > 
> > Hi Hannes,
> > 
> > Could you please let us know if you have better idea for this issue?
> > Otherwise, I think we need to move on since it is real issue, and users
> > want to fix that.
> > 
> Okay. Having looked over the problem and possible alternatives, it looks
> indeed like a viable solution.
> I do agree that it's a sensible design to have an additional holding area
> for hardware context elements, given that they might be reassigned during
> blk_mq_realloc_hw_ctxs().
> 
> However, I would rename the 'dead' elements to 'unused' (ie unused_hctx_list
> etc).

OK, looks the name of 'unused' is better.

> 
> And I would deallocate q->queue_hw_ctx in blk_mq_exit_queue() to make things
> more consistent.

No, that is wrong.

The request queue's refcount is often held when blk_cleanup_queue() is running,
and blk_mq_exit_queue() is called directly by blk_cleanup_queue(). One invariant
is that we have to allow most APIs running well if the request queue is live
from kobject view. If q->queue_hw_ctx is freed in blk_mq_exit_queue(),
it is quite easy to cause use-after-free.

> Problem with the current patch is that in blk_mq_release() we iterate
> the 'dead_hctx_list' and free up everything in there, but then blindly call
> 'kfree(q->queue_hw_ctx)' without checking if there are any context pointers
> left.

If request queue is dead, it is safe to assume that there isn't any
reference to request queue and q->queue_hw_ctx. Otherwise, it must be
a bug somewhere.

> When moving the call to blk_mq_exit_queue() we could to a simple
> WARN_ON(q->queue_hw_ctx) in blk_mq_release() to ensure that everything got
> deallocated properly.

At that time, hctx instance might be active, but that is fine given hctx
is covered by its own kobject. What we need to do is to make sure that no
any references to q->queue_hw_ctx and the request queue.

Thanks,
Ming
