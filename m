Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF11774A;
	Tue, 13 Feb 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809733; cv=none; b=GBGhrkZsYQaRb99NE1JTKmo5j2T0sXK2S1dH3qxeqAGbU0MlXEUJcqtHPa1kHlPE1Zku2/v9crfsj9f4THqsc6+4dzXpBeV0G9mk/BIoERcZn1Oa7FiHx2ErOfTyNoxjK8947q06zDnh3r766ya0hzs/r+PRlnvHU0MqPggp0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809733; c=relaxed/simple;
	bh=o/Yc8Hf0LkYKhW0o28X4+1L7kw1yIBZ50hlkIsD5Hsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eX2Zm47fd5ZhdbRX3elSPI5VpeuPIxqCiPZW9G6ksMch533EvEsRJmUozkUhj9qb19om5YxWPQZezJV1TJhGI3p0cZS3ZCI+bOAuTM+t/UkoIegKA4+7uY9F6ioDoe17TR3SCj97tMQptFfvbY6f5hhduVyxjk1I7P9Igc3Q6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r1DsPbld; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r1DsPbld"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4RA8RNcj1r2POGaU6oBQhNHQ07riwM0wIJLHNwezztU=; b=r1DsPbldlozKRLVyrMk0keHIaG
	hzNHuW1b1Jj1Zuj2WOk74i5SQTfgpDDTP42VQ9OavSJbndYqZj05chosAvSfBrzf8IWBVdaiWHI79
	xpUNtIdE5t/4WmE39Jz9soeecm/3hPCccBbviiIS8pp1Z4gUsEQiMI3LqyRRrrOicOeWZk3K3DgMU
	WjTpic+d6llCgOxS3zv/WmIsJUsUT3WKLdo4yqyWWkDTQic97gZtQ1T48LkPdg91ZpbAYFx2ShURG
	1BeVP165al57os2oF73KwFWfojckmXq20FneVwF/F36SBhqtEWe1W47mkdB89ZP+EofjvEHlsHc4E
	+jM4+sJw==;
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnK9-00000008GY2-0cZF;
	Tue, 13 Feb 2024 07:35:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH 08/15] block: pass a queue_limits argument to blk_alloc_queue
Date: Tue, 13 Feb 2024 08:34:18 +0100
Message-Id: <20240213073425.1621680-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass a queue_limits to blk_alloc_queue and apply it after validating and
capping the values using blk_validate_limits.  This will allow allocating
queues with valid queue limits instead of setting the values one at a
time later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-core.c | 26 ++++++++++++++++++--------
 block/blk-mq.c   |  7 ++++---
 block/blk.h      |  2 +-
 block/genhd.c    |  5 +++--
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cb56724a8dfb25..a16b5abdbbf56f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -394,24 +394,34 @@ static void blk_timeout_work(struct work_struct *work)
 {
 }
 
-struct request_queue *blk_alloc_queue(int node_id)
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 {
 	struct request_queue *q;
+	int error;
 
 	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
 				  node_id);
 	if (!q)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	q->last_merge = NULL;
 
 	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
-	if (q->id < 0)
+	if (q->id < 0) {
+		error = q->id;
 		goto fail_q;
+	}
 
 	q->stats = blk_alloc_queue_stats();
-	if (!q->stats)
+	if (!q->stats) {
+		error = -ENOMEM;
 		goto fail_id;
+	}
+
+	error = blk_set_default_limits(lim);
+	if (error)
+		goto fail_stats;
+	q->limits = *lim;
 
 	q->node = node_id;
 
@@ -436,12 +446,12 @@ struct request_queue *blk_alloc_queue(int node_id)
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
 	 * See blk_register_queue() for details.
 	 */
-	if (percpu_ref_init(&q->q_usage_counter,
+	error = percpu_ref_init(&q->q_usage_counter,
 				blk_queue_usage_counter_release,
-				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
+				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
+	if (error)
 		goto fail_stats;
 
-	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
 	return q;
@@ -452,7 +462,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	ida_free(&blk_queue_ida, q->id);
 fail_q:
 	kmem_cache_free(blk_requestq_cachep, q);
-	return NULL;
+	return ERR_PTR(error);
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6d2f7b5caa01d8..9dd8055cc5246d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4086,12 +4086,13 @@ void blk_mq_release(struct request_queue *q)
 static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 		void *queuedata)
 {
+	struct queue_limits lim = { };
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(set->numa_node);
-	if (!q)
-		return ERR_PTR(-ENOMEM);
+	q = blk_alloc_queue(&lim, set->numa_node);
+	if (IS_ERR(q))
+		return q;
 	q->queuedata = queuedata;
 	ret = blk_mq_init_allocated_queue(set, q);
 	if (ret) {
diff --git a/block/blk.h b/block/blk.h
index 43c7e9180b3028..7c30e2ac8ebcd3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -448,7 +448,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 		unpin_user_page(page);
 }
 
-struct request_queue *blk_alloc_queue(int node_id);
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
 
diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae6818..7a8fd57c51f73c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1393,11 +1393,12 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 
 struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 {
+	struct queue_limits lim = { };
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node);
-	if (!q)
+	q = blk_alloc_queue(&lim, node);
+	if (IS_ERR(q))
 		return NULL;
 
 	disk = __alloc_disk_node(q, node, lkclass);
-- 
2.39.2

