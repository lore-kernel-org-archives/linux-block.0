Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7921E3DE8;
	Fri,  5 Dec 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764898355; cv=none; b=ikRJXB5gJqwMwx2bsE1QMxB0ZYM2Oz+09fZvoZTK6WhZ7lVS+Le7ROpFssL+JXv0+4YQ3Ebngp6ohOwRv+e+utwxMbVmoou1IMpNyxexAYCMn9zohgJL6QEm+JmIhbpTjzlqBzVGrFdNd/rcUcczZPS+/O8vCB5vVTYl9U2MxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764898355; c=relaxed/simple;
	bh=pxNpud6SPuV2Tsg7/VCl59/BJtMaAvz016grT0C/JDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnVqwNMMUSw+9y9eyUgAVXSJg+IMAttTOav3fIAZr9AUwCjvtuVq0s4cDy/KECMoNxYFlTsSB3vgQiNWTbs50MzP/yTLawrGQyG4vSD+PEkXNJmaQi3HPePacX1ZcPpeRlaztcRbWZTeaPNkLp/RxDsRs2DDh2pRBRA3AV3cEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YERX3tEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YERX3tEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E8DC4CEFB;
	Fri,  5 Dec 2025 01:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764898354;
	bh=pxNpud6SPuV2Tsg7/VCl59/BJtMaAvz016grT0C/JDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YERX3tEfzaVyhxrxN5PHqGse9+7mIo0fnRAaM5hTTR7QLLW4UZT5bSnmNio0eCkJJ
	 UkaAW328SHwxjJMOJQXbdx5oi9RRjbz69I/vTsKqzHkh2PRj95ZYObz6qzspKH6koO
	 Iy1tcpjlCgLYG0aHiTFpHuJBWkzveIcj3Jd9CpKFDAGOJ1XPmo4nW07utqmJcDx/EZ
	 4SebuxioQEqoYDgmNhDNCgEbMQ+BUfbqNAnansrTvHiAWL9ilWLatm8XlSp7RynhHJ
	 1drdkAvEdaFpf498U/vx4vjebXDBsvAMeg+7NiBPl5kt2zm8/RlqjBalU99E5xF2cz
	 IIj4F7ZaoDrbw==
Date: Thu, 4 Dec 2025 18:32:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <aTI2L6j50VWjp7aW@kbusch-mbp>
References: <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
 <aTH8opTiwJxH2PMA@kbusch-mbp>
 <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org>

On Thu, Dec 04, 2025 at 01:22:49PM -1000, Bart Van Assche wrote:
> 
> On 12/4/25 11:26 AM, Keith Busch wrote:
> > On Thu, Dec 04, 2025 at 10:24:03AM -1000, Bart Van Assche wrote:>> Hence, the deadlock can be
> > > solved by removing the blk_mq_quiesce_tagset() call from nvme_timeout()
> > > and by failing I/O from inside nvme_timeout(). If nvme_timeout() fails
> > > I/O and does not call blk_mq_quiesce_tagset() then the
> > > blk_mq_freeze_queue_wait() call will finish instead of triggering a
> > > deadlock. However, I do not know whether this proposal seems acceptable
> > > to the NVMe maintainers.
> > 
> > You periodically make this suggestion, but there's never a reason
> > offered to introduce yet another work queue for the driver to
> > synchronize with at various points. The whole point of making blk-mq
> > timeout handler in a work queue (it used to be a timer) was so that we
> > could do blocking actions like this.
> Hi Keith,
> 
> The blk_mq_quiesce_tagset() call from the NVMe timeout handler is
> unfortunate because it triggers a deadlock with
> blk_mq_update_tag_set_shared().

So in this scenario, the driver is modifying a tagset list from two
queues to one, which causes blk-mq to clear the "shared" flags. The
remaining one just so happens to have hit a timeout at the same time,
which runs in a context with an elevated "q_usage_counter". The current
rule, then, is you can not take the tag_list_lock from any context using
any queue in the tag list.

> I proposed to modify the NVMe driver because I think that's a better
> approach than introducing a new synchronize_rcu() call in the block
> layer core.

I'm not interested in introducing rcu synchronize here either. I guess I
would make it so you can quiesce a tagset from a context that entered
the queue. So quick shot at that here:

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e96bb2462475..20450017b9512 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4262,11 +4262,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
  * Caller needs to ensure that we're either frozen/quiesced, or that
  * the queue isn't live yet.
  */
-static void queue_set_hctx_shared(struct request_queue *q, bool shared)
+static void queue_set_hctx_shared_locked(struct request_queue *q)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
+	bool shared;
+
+	lockdep_assert_held(&set->tag_list_lock);
 
+	shared = set->flags & BLK_MQ_F_TAG_QUEUE_SHARED;
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (shared) {
 			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
@@ -4277,24 +4282,22 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 	}
 }
 
-static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
-					 bool shared)
+static void queue_set_hctx_shared(struct request_queue *q)
 {
-	struct request_queue *q;
+	struct blk_mq_tag_set *set = q->tag_set;
 	unsigned int memflags;
 
-	lockdep_assert_held(&set->tag_list_lock);
-
-	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		memflags = blk_mq_freeze_queue(q);
-		queue_set_hctx_shared(q, shared);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&set->tag_list_lock);
+	queue_set_hctx_shared_locked(q);
+	mutex_unlock(&set->tag_list_lock);
+	blk_mq_unfreeze_queue(q, memflags);
 }
 
 static void blk_mq_del_queue_tag_set(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
+	struct request_queue *shared = NULL;
 
 	mutex_lock(&set->tag_list_lock);
 	list_del(&q->tag_set_list);
@@ -4302,15 +4305,25 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
 		/* update existing queue */
-		blk_mq_update_tag_set_shared(set, false);
+		shared = list_first_entry(&set->tag_list, struct request_queue,
+					  tag_set_list);
+		if (!blk_get_queue(shared))
+			shared = NULL;
 	}
 	mutex_unlock(&set->tag_list_lock);
 	INIT_LIST_HEAD(&q->tag_set_list);
+
+	if (shared) {
+		queue_set_hctx_shared(shared);
+		blk_put_queue(shared);
+	}
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
+	struct request_queue *shared = NULL;
+
 	mutex_lock(&set->tag_list_lock);
 
 	/*
@@ -4318,15 +4331,24 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	 */
 	if (!list_empty(&set->tag_list) &&
 	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
-		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
 		/* update existing queue */
-		blk_mq_update_tag_set_shared(set, true);
+		shared = list_first_entry(&set->tag_list, struct request_queue,
+					  tag_set_list);
+		if (!blk_get_queue(shared))
+			shared = NULL;
+		else
+			set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
 	}
 	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		queue_set_hctx_shared(q, true);
+		queue_set_hctx_shared_locked(q);
 	list_add_tail(&q->tag_set_list, &set->tag_list);
 
 	mutex_unlock(&set->tag_list_lock);
+
+	if (shared) {
+		queue_set_hctx_shared(shared);
+		blk_put_queue(shared);
+	}
 }
 
 /* All allocations will be freed in release handler of q->mq_kobj */
--
