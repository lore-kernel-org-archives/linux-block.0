Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530BBC433E2
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 09:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184F921D42
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 09:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxdUdHUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgIHJ1x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728739AbgIHJ1v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Sep 2020 05:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599557269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g5ft5xTYHFgq+z8DisEseZUWT/cJ+6NfUyGwEQdJBtc=;
        b=fxdUdHUQu3JgskuAkLjfp1/IreJy3Adv8EFQzxsmyRdbZLXKL2wLxl0CCBLKurzcXQ+iez
        /eXvju823Tz+B1frZul308/OFC8VEoqLMTk9GwjM82o8g2XPb4ibQRNK7bAASUOGTtzN7w
        qxv+hvzDivCymVbalKRI0gRTEhPHQRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-oHFY9PPGPNCCJhtG_cIHOQ-1; Tue, 08 Sep 2020 05:27:45 -0400
X-MC-Unique: oHFY9PPGPNCCJhtG_cIHOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71CE210054FF;
        Tue,  8 Sep 2020 09:27:43 +0000 (UTC)
Received: from T590 (ovpn-12-217.pek2.redhat.com [10.72.12.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 117CA5D9E2;
        Tue,  8 Sep 2020 09:27:34 +0000 (UTC)
Date:   Tue, 8 Sep 2020 17:27:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V3 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200908092723.GA1094743@T590>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-3-ming.lei@redhat.com>
 <6aa24c1e-d127-27fc-9ca7-3299e026aa0a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa24c1e-d127-27fc-9ca7-3299e026aa0a@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 08, 2020 at 05:13:22PM +0800, Chao Leng wrote:
> 
> 
> On 2020/9/8 16:15, Ming Lei wrote:
> > In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
> > section during dispatching request, then request queue quiesce is based on
> > SRCU. What we want to get is low cost added in fast path.
> > 
> > With percpu-ref, it is cleaner and simpler & enough for implementing queue
> > quiesce. The main requirement is to make sure all read sections to observe
> > QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.
> > 
> > Also it becomes much easier to add interface of async queue quiesce.
> > 
> > Meantime memory footprint can be reduced with per-request-queue percpu-ref.
> > 
> > > From implementation viewpoint, in fast path, not see percpu_ref is
> > slower than SRCU, and srcu tree(default option in most distributions)
> > could be slower since memory barrier is required in both lock & unlock,
> > and rcu_read_lock()/rcu_read_unlock() should be much cheap than
> > smp_mb().
> > 
> > 1) percpu_ref just hold the rcu_read_lock, then run a check &
> >     increase/decrease on the percpu variable:
> > 
> >     rcu_read_lock()
> >     if (__ref_is_percpu(ref, &percpu_count))
> > 	this_cpu_inc(*percpu_count);
> >     rcu_read_unlock()
> > 
> > 2) srcu tree:
> >          idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> >          this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> >          smp_mb(); /* B */  /* Avoid leaking the critical section. */
> > 
> > Also from my test on null_blk(blocking), not observe percpu-ref performs
> > worse than srcu, see the following test:
> > 
> > 1) test steps:
> > 
> > rmmod null_blk > /dev/null 2>&1
> > modprobe null_blk nr_devices=1 submit_queues=1 blocking=1
> > fio --bs=4k --size=512G  --rw=randread --norandommap --direct=1 --ioengine=libaio \
> > 	--iodepth=64 --runtime=60 --group_reporting=1  --name=nullb0 \
> > 	--filename=/dev/nullb0 --numjobs=32
> > 
> > test machine: HP DL380, 16 cpu cores, 2 threads per core, dual
> > sockets/numa, Intel(R) Xeon(R) Silver 4110 CPU @ 2.10GHz
> > 
> > 2) test result:
> > - srcu quiesce: 6063K IOPS
> > - percpu-ref quiesce: 6113K IOPS
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > Cc: Chao Leng <lengchao@huawei.com>
> > ---
> >   block/blk-mq-sysfs.c   |   2 -
> >   block/blk-mq.c         | 130 +++++++++++++++++++++--------------------
> >   block/blk-sysfs.c      |   6 +-
> >   include/linux/blk-mq.h |   8 ---
> >   include/linux/blkdev.h |   4 ++
> >   5 files changed, 77 insertions(+), 73 deletions(-)
> > 
> > diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> > index 062229395a50..799db7937105 100644
> > --- a/block/blk-mq-sysfs.c
> > +++ b/block/blk-mq-sysfs.c
> > @@ -38,8 +38,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
> >   	cancel_delayed_work_sync(&hctx->run_work);
> > -	if (hctx->flags & BLK_MQ_F_BLOCKING)
> > -		cleanup_srcu_struct(hctx->srcu);
> >   	blk_free_flush_queue(hctx->fq);
> >   	sbitmap_free(&hctx->ctx_map);
> >   	free_cpumask_var(hctx->cpumask);
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 13cc10b89629..60630a720449 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -220,26 +220,22 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
> >    */
> >   void blk_mq_quiesce_queue(struct request_queue *q)
> >   {
> > -	struct blk_mq_hw_ctx *hctx;
> > -	unsigned int i;
> > -	bool rcu = false;
> > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> >   	mutex_lock(&q->mq_quiesce_lock);
> > -	if (blk_queue_quiesced(q))
> > -		goto exit;
> > -
> > -	blk_mq_quiesce_queue_nowait(q);
> > -
> > -	queue_for_each_hw_ctx(q, hctx, i) {
> > -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > -			synchronize_srcu(hctx->srcu);
> > -		else
> > -			rcu = true;
> > +	if (!blk_queue_quiesced(q)) {
> > +		blk_mq_quiesce_queue_nowait(q);
> > +		if (blocking)
> > +			percpu_ref_kill(&q->dispatch_counter);
> >   	}
> > -	if (rcu)
> > +
> > +	if (blocking)
> > +		wait_event(q->mq_quiesce_wq,
> > +			   percpu_ref_is_zero(&q->dispatch_counter));
> > +	else
> >   		synchronize_rcu();
> > - exit:
> > +
> >   	mutex_unlock(&q->mq_quiesce_lock);
> >   }
> >   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
> > @@ -255,7 +251,12 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
> >   {
> >   	mutex_lock(&q->mq_quiesce_lock);
> > -	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> > +	if (blk_queue_quiesced(q)) {
> > +		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> > +
> > +		if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> > +			percpu_ref_resurrect(&q->dispatch_counter);
> > +	}
> >   	/* dispatch requests which are inserted during quiescing */
> >   	blk_mq_run_hw_queues(q, true);
> > @@ -710,24 +711,21 @@ void blk_mq_complete_request(struct request *rq)
> >   }
> >   EXPORT_SYMBOL(blk_mq_complete_request);
> > -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> > -	__releases(hctx->srcu)
> > +static void hctx_unlock(struct blk_mq_hw_ctx *hctx)
> >   {
> > -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> > -		rcu_read_unlock();
> > +	if (hctx->flags & BLK_MQ_F_BLOCKING)
> > +		percpu_ref_put(&hctx->queue->dispatch_counter);
> >   	else
> > -		srcu_read_unlock(hctx->srcu, srcu_idx);
> > +		rcu_read_unlock();
> >   }
> > -static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
> > -	__acquires(hctx->srcu)
> > +/* Returning false means that queue is being quiesced */
> > +static inline bool hctx_lock(struct blk_mq_hw_ctx *hctx)
> >   {
> > -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> > -		/* shut up gcc false positive */
> > -		*srcu_idx = 0;
> > -		rcu_read_lock();
> > -	} else
> > -		*srcu_idx = srcu_read_lock(hctx->srcu);
> > +	if (hctx->flags & BLK_MQ_F_BLOCKING)
> > +		return percpu_ref_tryget_live(&hctx->queue->dispatch_counter);
> > +	rcu_read_lock();
> > +	return true;
> >   }
> >   /**
> > @@ -1506,8 +1504,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
> >    */
> >   static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> >   {
> > -	int srcu_idx;
> > -
> >   	/*
> >   	 * We should be running this queue from one of the CPUs that
> >   	 * are mapped to it.
> > @@ -1541,9 +1537,10 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> >   	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
> > -	hctx_lock(hctx, &srcu_idx);
> > -	blk_mq_sched_dispatch_requests(hctx);
> > -	hctx_unlock(hctx, srcu_idx);
> > +	if (hctx_lock(hctx)) {
> > +		blk_mq_sched_dispatch_requests(hctx);
> > +		hctx_unlock(hctx);
> > +	}
> >   }
> >   static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
> > @@ -1655,7 +1652,6 @@ EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
> >    */
> >   void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
> >   {
> > -	int srcu_idx;
> >   	bool need_run;
> >   	/*
> > @@ -1666,10 +1662,12 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
> >   	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
> >   	 * quiesced.
> >   	 */
> > -	hctx_lock(hctx, &srcu_idx);
> > +	if (!hctx_lock(hctx))
> > +		return;
> > +
> >   	need_run = !blk_queue_quiesced(hctx->queue) &&
> >   		blk_mq_hctx_has_pending(hctx);
> > -	hctx_unlock(hctx, srcu_idx);
> > +	hctx_unlock(hctx);
> >   	if (need_run)
> >   		__blk_mq_delay_run_hw_queue(hctx, async, 0);
> > @@ -2009,7 +2007,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> >   	bool run_queue = true;
> >   	/*
> > -	 * RCU or SRCU read lock is needed before checking quiesced flag.
> > +	 * hctx_lock() is needed before checking quiesced flag.
> >   	 *
> >   	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
> >   	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
> > @@ -2057,11 +2055,14 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> >   		struct request *rq, blk_qc_t *cookie)
> >   {
> >   	blk_status_t ret;
> > -	int srcu_idx;
> >   	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
> > -	hctx_lock(hctx, &srcu_idx);
> > +	/* Insert request to queue in case of being quiesced */
> > +	if (!hctx_lock(hctx)) {
> > +		blk_mq_sched_insert_request(rq, false, false, false);
> Suggest: use blk_mq_request_bypass_insert, the rq should do first.

No, when request is issued directly, it never be queued to LLD, so we
should insert it to scheduler queue, see commit:

db03f88fae8a ("blk-mq: insert request not through ->queue_rq into sw/scheduler queue")



Thanks,
Ming

