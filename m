Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2315D5C1
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717018778; cv=none; b=sDJcjwfez8n9iDvBHaUkjG9ECqtVED+ymIHj/YovHpyAtmnepQnXBlhedHyTzlhEK7F5rz5UvLqTZ2HD1DSsxBZKv8nd4gnYO00+aeXizgdJinSPbHDBeSNQbgn6i0rCl+H6RJuvtWmWjOCm3N+DAf4IDgVRqO9qi9v/ADSiIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717018778; c=relaxed/simple;
	bh=w86uK9bIhr/5J0Ww4MYHXrXFe42eqkZ29Ke5wDg2JLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aV2oEcb5m1ITT+gqUSodQ+jsWwluRG51jBsMpzl1HdTT91XKgkJAlY9ztDkdClN2Aj6OZB+Jt1Yzlg6Bcm0M9T0FbM4qzRarwQJeyHSQsIgOB8Bq4g2SY1oUEY1hu7ikhTz6x4+zL0cqiwo3m2TGR0FuLCzg6DE+xqnL0gqFlh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sINVLjkD; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sINVLjkD"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VqN7q6VdtzlgMVV;
	Wed, 29 May 2024 21:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1717018767; x=1719610768; bh=ykfjuivg1+1GMFYASZ3ua4kJdJkLbQZji4k
	POrZAFx8=; b=sINVLjkD2vIUG45aA0ClVrTcl4hxTVW7DWwqffVnuaRFUNA3HUi
	4RNC3zXvtfTb+FzGFq08FU8z0W/9HPvQrnW+Qtd7vSgR+4Kw0pJYggR6DfNl7JNr
	/jveNIm5iNnF9taYJRY5FzsHVYP321h7jIrd4DXvtqjzSBbV9allayIn3OPtk4Fe
	a41uTuaayE0utl2Tj00iWkL6pbBc4qrK5o26XgcFRtKnrMaFlc1P0GISLAJZ+AWh
	l7HT+3XPCoVyFYddV5UEtOxD/2cnGJiFpzWkHsW2TwG4YpXvI/8pM0txYZlH60Eh
	XptwDEL5+aH9alGICIkrgZhCOhsB+UZ/Wjw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jmrBrhhL1e_q; Wed, 29 May 2024 21:39:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VqN7f6VwszlgMVR;
	Wed, 29 May 2024 21:39:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v7] block: Improve IOPS by removing the fairness code
Date: Wed, 29 May 2024 14:39:20 -0700
Message-ID: <20240529213921.3166462-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is an algorithm in the block layer for maintaining fairness
across queues that share a tag set. The sbitmap implementation has
improved so much that we don't need the block layer fairness algorithm
anymore and that we can rely on the sbitmap implementation to guarantee
fairness.

On my test setup (x86 VM with 72 CPU cores) this patch results in 2.9% mo=
re
IOPS. IOPS have been measured as follows:

$ modprobe null_blk nr_devices=3D1 completion_nsec=3D0
$ fio --bs=3D4096 --disable_clat=3D1 --disable_slat=3D1 --group_reporting=
=3D1 \
      --gtod_reduce=3D1 --invalidate=3D1 --ioengine=3Dpsync --ioscheduler=
=3Dnone \
      --norandommap --runtime=3D60 --rw=3Drandread --thread --time_based=3D=
1 \
      --buffered=3D0 --numjobs=3D64 --name=3D/dev/nullb0 --filename=3D/de=
v/nullb0

Additionally, it has been verified as follows that all request queues tha=
t
share a tag set process I/O even if the completion times are different (s=
ee
also test block/035):
- Create a first request queue with completion time 1 ms and queue
  depth 64.
- Create a second request queue with completion time 100 ms and that
  shares the tag set of the first request queue.
- Submit I/O to both request queues with fio.

Tests have shown that the IOPS for this test case are 29859 and 318 or a
ratio of about 94. This ratio is close to the completion time ratio.
While this is unfair, both request queues make progress at a consistent
pace.

This patch removes the following code and structure members:
- The function hctx_may_queue().
- blk_mq_hw_ctx.nr_active and request_queue.nr_active_requests_shared_tag=
s
  and also all the code that modifies these two member variables.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v6: rebased on top of Jens' for-next branch and impro=
ved
                        patch description.
Changes compared to v5: rebased on top of Jens' for-next branch.
Changes compared to v4: rebased on top of Jens' for-next branch.
Changes compared to v3: removed a "Fixes:" tag that got added accidentall=
y.
Changes compared to v2: improved patch description.
Changes compared to v1: improved the debugfs code.

 block/blk-core.c       |   2 -
 block/blk-mq-debugfs.c |  22 ++++++++-
 block/blk-mq-tag.c     |   4 --
 block/blk-mq.c         |  17 +------
 block/blk-mq.h         | 100 -----------------------------------------
 include/linux/blk-mq.h |   6 ---
 include/linux/blkdev.h |   2 -
 7 files changed, 22 insertions(+), 131 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 82c3ae22d76d..9a11b786ecd4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -425,8 +425,6 @@ struct request_queue *blk_alloc_queue(struct queue_li=
mits *lim, int node_id)
=20
 	q->node =3D node_id;
=20
-	atomic_set(&q->nr_active_requests_shared_tags, 0);
-
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 770c0c2b72fa..3231e4eee098 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -478,11 +478,31 @@ static int hctx_sched_tags_bitmap_show(void *data, =
struct seq_file *m)
 	return res;
 }
=20
+struct count_active_params {
+	struct blk_mq_hw_ctx	*hctx;
+	int			*active;
+};
+
+static bool hctx_count_active(struct request *rq, void *data)
+{
+	const struct count_active_params *params =3D data;
+
+	if (rq->mq_hctx =3D=3D params->hctx)
+		(*params->active)++;
+
+	return true;
+}
+
 static int hctx_active_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx =3D data;
+	int active =3D 0;
+	struct count_active_params params =3D { .hctx =3D hctx, .active =3D &ac=
tive };
+
+	blk_mq_all_tag_iter(hctx->sched_tags ?: hctx->tags, hctx_count_active,
+			    &params);
=20
-	seq_printf(m, "%d\n", __blk_mq_active_requests(hctx));
+	seq_printf(m, "%d\n", active);
 	return 0;
 }
=20
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..25334bfcabf8 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -105,10 +105,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
-	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
-			!hctx_may_queue(data->hctx, bt))
-		return BLK_MQ_NO_TAG;
-
 	if (data->shallow_depth)
 		return sbitmap_queue_get_shallow(bt, data->shallow_depth);
 	else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b4df8e5ac9e..7ae2cf08320b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -425,8 +425,6 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_dat=
a *data)
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
-		blk_mq_add_active_requests(data->hctx, nr);
 	/* caller already holds a reference, add for remainder */
 	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
 	data->nr_tags -=3D nr;
@@ -511,8 +509,6 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 		goto retry;
 	}
=20
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
-		blk_mq_inc_active_requests(data->hctx);
 	rq =3D blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	return rq;
@@ -672,8 +668,6 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
 	tag =3D blk_mq_get_tag(&data);
 	if (tag =3D=3D BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	if (!(data.rq_flags & RQF_SCHED_TAGS))
-		blk_mq_inc_active_requests(data.hctx);
 	rq =3D blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len =3D 0;
@@ -715,10 +709,8 @@ static void __blk_mq_free_request(struct request *rq=
)
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx =3D NULL;
=20
-	if (rq->tag !=3D BLK_MQ_NO_TAG) {
-		blk_mq_dec_active_requests(hctx);
+	if (rq->tag !=3D BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
-	}
 	if (sched_tag !=3D BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
@@ -1067,8 +1059,6 @@ static inline void blk_mq_flush_tag_batch(struct bl=
k_mq_hw_ctx *hctx,
 {
 	struct request_queue *q =3D hctx->queue;
=20
-	blk_mq_sub_active_requests(hctx, nr_tags);
-
 	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
 	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
 }
@@ -1758,9 +1748,6 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) =
{
 		bt =3D &rq->mq_hctx->tags->breserved_tags;
 		tag_offset =3D 0;
-	} else {
-		if (!hctx_may_queue(rq->mq_hctx, bt))
-			return false;
 	}
=20
 	tag =3D __sbitmap_queue_get(bt);
@@ -1768,7 +1755,6 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
 		return false;
=20
 	rq->tag =3D tag + tag_offset;
-	blk_mq_inc_active_requests(rq->mq_hctx);
 	return true;
 }
=20
@@ -3738,7 +3724,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct b=
lk_mq_tag_set *set,
 	if (!zalloc_cpumask_var_node(&hctx->cpumask, gfp, node))
 		goto free_hctx;
=20
-	atomic_set(&hctx->nr_active, 0);
 	if (node =3D=3D NUMA_NO_NODE)
 		node =3D set->numa_node;
 	hctx->numa_node =3D node;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 260beea8e332..db3b999e433a 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -271,70 +271,9 @@ static inline int blk_mq_get_rq_budget_token(struct =
request *rq)
 	return -1;
 }
=20
-static inline void __blk_mq_add_active_requests(struct blk_mq_hw_ctx *hc=
tx,
-						int val)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_add(val, &hctx->queue->nr_active_requests_shared_tags);
-	else
-		atomic_add(val, &hctx->nr_active);
-}
-
-static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hc=
tx)
-{
-	__blk_mq_add_active_requests(hctx, 1);
-}
-
-static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hc=
tx,
-		int val)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_sub(val, &hctx->queue->nr_active_requests_shared_tags);
-	else
-		atomic_sub(val, &hctx->nr_active);
-}
-
-static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hc=
tx)
-{
-	__blk_mq_sub_active_requests(hctx, 1);
-}
-
-static inline void blk_mq_add_active_requests(struct blk_mq_hw_ctx *hctx=
,
-					      int val)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_add_active_requests(hctx, val);
-}
-
-static inline void blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx=
)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_inc_active_requests(hctx);
-}
-
-static inline void blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx=
,
-					      int val)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_sub_active_requests(hctx, val);
-}
-
-static inline void blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx=
)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_dec_active_requests(hctx);
-}
-
-static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		return atomic_read(&hctx->queue->nr_active_requests_shared_tags);
-	return atomic_read(&hctx->nr_active);
-}
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
-	blk_mq_dec_active_requests(hctx);
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rq->tag =3D BLK_MQ_NO_TAG;
 }
@@ -376,45 +315,6 @@ static inline void blk_mq_free_requests(struct list_=
head *list)
 	}
 }
=20
-/*
- * For shared tag users, we track the number of currently active users
- * and attempt to provide a fair share of the tag depth for each of them=
.
- */
-static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
-				  struct sbitmap_queue *bt)
-{
-	unsigned int depth, users;
-
-	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return true;
-
-	/*
-	 * Don't try dividing an ant
-	 */
-	if (bt->sb.depth =3D=3D 1)
-		return true;
-
-	if (blk_mq_is_shared_tags(hctx->flags)) {
-		struct request_queue *q =3D hctx->queue;
-
-		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
-			return true;
-	} else {
-		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
-			return true;
-	}
-
-	users =3D READ_ONCE(hctx->tags->active_queues);
-	if (!users)
-		return true;
-
-	/*
-	 * Allow at least some tags
-	 */
-	depth =3D max((bt->sb.depth + users - 1) / users, 4U);
-	return __blk_mq_active_requests(hctx) < depth;
-}
-
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
 #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
 do {								\
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 89ba6b16fe8b..daec5471197b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -398,12 +398,6 @@ struct blk_mq_hw_ctx {
 	/** @queue_num: Index of this hardware queue. */
 	unsigned int		queue_num;
=20
-	/**
-	 * @nr_active: Number of active requests. Only used when a tag set is
-	 * shared across request queues.
-	 */
-	atomic_t		nr_active;
-
 	/** @cpuhp_online: List to store request if CPU is going to die */
 	struct hlist_node	cpuhp_online;
 	/** @cpuhp_dead: List to store request if some CPU die. */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index aefdda9f4ec7..b9faa05a9139 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -453,8 +453,6 @@ struct request_queue {
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
=20
-	atomic_t		nr_active_requests_shared_tags;
-
 	struct blk_mq_tags	*sched_shared_tags;
=20
 	struct list_head	icq_list;
