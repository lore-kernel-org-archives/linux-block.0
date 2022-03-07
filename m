Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4614AC4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 07:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiCGHud (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiCGHuc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:50:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B3425F8F8
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646639377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/VX0FHOvhOeCjYII2f7oOAxgLmnVM3cTaBiiICV0Nc=;
        b=a4qhK5/2TrL93Z1GVUroFoadgYLCk41+Wkm2Sn5fCspGF7qDFMXdYQDfDzhcOyv5b9qa5Q
        6XporMoCK8BlgJHBWP6xExJ+EcPD3gWiVERk+NynMH2SEruS8UIF4u12RwUT8kHmkFOQm4
        +Cz4AP1/T8JGTVydlHnvza3HHlN/XKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-pyKmd8RcPwihc4ix5ODjhA-1; Mon, 07 Mar 2022 02:49:35 -0500
X-MC-Unique: pyKmd8RcPwihc4ix5ODjhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47FA7180FD75;
        Mon,  7 Mar 2022 07:49:34 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1323D1006872;
        Mon,  7 Mar 2022 07:49:26 +0000 (UTC)
Date:   Mon, 7 Mar 2022 15:49:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 6/6] blk-mq: manage hctx map via xarray
Message-ID: <YiW5Apu5V85bgtM3@T590>
References: <20220307064401.30056-1-ming.lei@redhat.com>
 <20220307064401.30056-7-ming.lei@redhat.com>
 <065432ee-7e1b-8c21-4536-2c4a7bb6734b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065432ee-7e1b-8c21-4536-2c4a7bb6734b@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07, 2022 at 08:44:24AM +0100, Hannes Reinecke wrote:
> On 3/7/22 07:44, Ming Lei wrote:
> > Firstly code becomes more clean by switching to xarray from plain array.
> > 
> > Secondly use-after-free on q->queue_hw_ctx can be fixed because
> > queue_for_each_hw_ctx() may be run when updating nr_hw_queues is
> > in-progress. With this patch, q->hctx_table is defined as xarray, and
> > this structure will share same lifetime with request queue, so
> > queue_for_each_hw_ctx() can use q->hctx_table to lookup hctx reliably.
> > 
> > Reported-by: Yu Kuai <yukuai3@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-tag.c     |  2 +-
> >   block/blk-mq.c         | 55 ++++++++++++++++++------------------------
> >   block/blk-mq.h         |  2 +-
> >   include/linux/blk-mq.h |  3 +--
> >   include/linux/blkdev.h |  2 +-
> >   5 files changed, 28 insertions(+), 36 deletions(-)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 1850a4225e12..68ac23d0b640 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -498,7 +498,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
> >   		void *priv)
> >   {
> >   	/*
> > -	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
> > +	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
> >   	 * while the queue is frozen. So we can use q_usage_counter to avoid
> >   	 * racing with it.
> >   	 */
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index bffdd71c670d..a15d12fb227c 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -71,7 +71,8 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
> >   static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
> >   		blk_qc_t qc)
> >   {
> > -	return q->queue_hw_ctx[(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT];
> > +	return xa_load(&q->hctx_table,
> > +			(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT);
> >   }
> >   static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
> > @@ -573,7 +574,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >   	 * If not tell the caller that it should skip this queue.
> >   	 */
> >   	ret = -EXDEV;
> > -	data.hctx = q->queue_hw_ctx[hctx_idx];
> > +	data.hctx = xa_load(&q->hctx_table, hctx_idx);
> >   	if (!blk_mq_hw_queue_mapped(data.hctx))
> >   		goto out_queue_exit;
> >   	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > @@ -3437,6 +3438,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
> >   	blk_mq_remove_cpuhp(hctx);
> > +	xa_erase(&q->hctx_table, hctx_idx);
> > +
> >   	spin_lock(&q->unused_hctx_lock);
> >   	list_add(&hctx->hctx_list, &q->unused_hctx_list);
> >   	spin_unlock(&q->unused_hctx_lock);
> > @@ -3476,8 +3479,15 @@ static int blk_mq_init_hctx(struct request_queue *q,
> >   	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
> >   				hctx->numa_node))
> >   		goto exit_hctx;
> > +
> > +	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
> > +		goto exit_flush_rq;
> > +
> >   	return 0;
> >    > + exit_flush_rq:
> > +	if (set->ops->exit_request)
> > +		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
> 
> Why is this here? It's not directly related to the xarray conversion, so it
> should rather go into a separate patch.

This new error handling is only needed if xa_insert() fails.

> 
> >    exit_hctx:
> >   	if (set->ops->exit_hctx)
> >   		set->ops->exit_hctx(hctx, hctx_idx);
> > @@ -3856,7 +3866,7 @@ void blk_mq_release(struct request_queue *q)
> >   		kobject_put(&hctx->kobj);
> >   	}
> > -	kfree(q->queue_hw_ctx);
> > +	xa_destroy(&q->hctx_table);
> >   	/*
> >   	 * release .mq_kobj and sw queue's kobject now because
> > @@ -3946,45 +3956,28 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >   						struct request_queue *q)
> >   {
> >   	int i, j, end;
> > -	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
> > -
> > -	if (q->nr_hw_queues < set->nr_hw_queues) {
> > -		struct blk_mq_hw_ctx **new_hctxs;
> > -
> > -		new_hctxs = kcalloc_node(set->nr_hw_queues,
> > -				       sizeof(*new_hctxs), GFP_KERNEL,
> > -				       set->numa_node);
> > -		if (!new_hctxs)
> > -			return;
> > -		if (hctxs)
> > -			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
> > -			       sizeof(*hctxs));
> > -		q->queue_hw_ctx = new_hctxs;
> > -		kfree(hctxs);
> > -		hctxs = new_hctxs;
> > -	}
> >   	/* protect against switching io scheduler  */
> >   	mutex_lock(&q->sysfs_lock);
> >   	for (i = 0; i < set->nr_hw_queues; i++) {
> >   		int old_node;
> >   		int node = blk_mq_get_hctx_node(set, i);
> > -		struct blk_mq_hw_ctx *old_hctx = hctxs[i];
> > +		struct blk_mq_hw_ctx *old_hctx = xa_load(&q->hctx_table, i);
> >   		if (old_hctx) {
> >   			old_node = old_hctx->numa_node;
> >   			blk_mq_exit_hctx(q, set, old_hctx, i);
> >   		}
> > -		hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i, node);
> > -		if (!hctxs[i]) {
> > +		if (!blk_mq_alloc_and_init_hctx(set, q, i, node)) {
> > +			struct blk_mq_hw_ctx *hctx;
> > +
> >   			if (!old_hctx)
> >   				break;
> >   			pr_warn("Allocate new hctx on node %d fails, fallback to previous one on node %d\n",
> >   					node, old_node);
> > -			hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i,
> > -					old_node);
> > -			WARN_ON_ONCE(!hctxs[i]);
> > +			hctx = blk_mq_alloc_and_init_hctx(set, q, i, old_node);
> > +			WARN_ON_ONCE(!hctx);
> >   		}
> >   	}
> >   	/*
> > @@ -4001,12 +3994,10 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >   	}
> >   	for (; j < end; j++) {
> > -		struct blk_mq_hw_ctx *hctx = hctxs[j];
> > +		struct blk_mq_hw_ctx *hctx = xa_load(&q->hctx_table, j);
> > -		if (hctx) {
> > +		if (hctx)
> >   			blk_mq_exit_hctx(q, set, hctx, j);
> > -			hctxs[j] = NULL;
> > -		}
> 
> Do you need to call 'xa_load' here? Isn't it sufficient to call
> blk_mq_exit_hctx() and have it skip any non-present entries?

As Christoph suggested, xa_for_each_range() can be used here for
exiting any present entry.


Thanks,
Ming

