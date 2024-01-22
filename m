Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B259B53;
	Mon, 22 Jan 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945041; cv=none; b=jkbj+BsTNFA5myj6sf63CmXVWkwEuQS9o3wKTBuNsHekwZnNkc2dCyOcou9BlZ7yfZtBRai8q/W3cVjmvLFMkkFsrjRRrNYHV+3/t8r8HT7Lm2cgYcwg/FZW666nSSbYX0gE0O9KUH4jiXv12iKcWZOFMwIIZ5hWsePJi0m7tg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945041; c=relaxed/simple;
	bh=TTfubNTYXW/dhYmX8/SyCsIgSHfPqonf1hxM9wbg/Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cK5fX5Zigrr7T4klAXH58zwIwHrKND33upgaWbH3GwQg8XYuiMAhQmHRo2tYqGOIfYy0EuhCAKkyqGAJtrAd675h2bOyLBaTd5AoOfNafLFNH3CCHw+PL0ZK1+m2Jm5kKajeEGo959qcd2l/eK4UCLN/8xuJfLS1krEFfHq7JEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XB6jjMt2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XB6jjMt2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GFsm6Z0ZOj4NO7BetyaWjqDWyq0Bbowczg+Ibj1xwSQ=; b=XB6jjMt2ezKcECx536gKmMq5gK
	eE+c2nUFZXnSLeiZCB+TnAChugVIg9Hghdq3N2TFE/ALDRka2XxJXLGZcI7NHPbt1NPvZeywhBr0t
	D8t6tWxfiWlMesUMm3LcM7iQWnCR2KhiSMaqYWwogDnHAX9shgc1sbXNVQO+4GDwutZCY/s32lVuW
	Ou4khvNOuS+sHff3MzLRmR+qwAtKDzrxKm3CC4/TVUxt5QUpNrpkCOO54GDcvisTOcKBVOHojNJqm
	0Y4RH5IE7FVb2/xXewdtyo7V/XFTH59g7/Krv9aAMB0Psz8HXG8f8mhkquCTp2mN4HHAZLXe3gYdh
	ywgm8QcQ==;
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEQ-00DGnI-1n;
	Mon, 22 Jan 2024 17:37:11 +0000
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
Date: Mon, 22 Jan 2024 18:36:38 +0100
Message-Id: <20240122173645.1686078-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122173645.1686078-1-hch@lst.de>
References: <20240122173645.1686078-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass a queue_limits to blk_alloc_queue and apply it if non-NULL.  This
will allow allocating queues with valid queue limits instead of setting
the values one at a time later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 28 +++++++++++++++++++++-------
 block/blk-mq.c   |  6 +++---
 block/blk.h      |  2 +-
 block/genhd.c    |  4 ++--
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 09f4a44a4aa3cc..9f1af8fba4dcd2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -393,9 +393,10 @@ static void blk_timeout_work(struct work_struct *work)
 {
 }
 
-struct request_queue *blk_alloc_queue(int node_id)
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 {
 	struct request_queue *q;
+	int error;
 
 	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
 				  node_id);
@@ -404,13 +405,26 @@ struct request_queue *blk_alloc_queue(int node_id)
 
 	q->last_merge = NULL;
 
+	if (lim) {
+		error = blk_validate_limits(lim);
+		if (error)
+			goto fail_q;
+		q->limits = *lim;
+	} else {
+		blk_set_default_limits(&q->limits);
+	}
+
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
 
 	q->node = node_id;
 
@@ -435,12 +449,12 @@ struct request_queue *blk_alloc_queue(int node_id)
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
@@ -451,7 +465,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	ida_free(&blk_queue_ida, q->id);
 fail_q:
 	kmem_cache_free(blk_requestq_cachep, q);
-	return NULL;
+	return ERR_PTR(error);
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ecfc..2ddbefdeae93e4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4092,9 +4092,9 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(set->numa_node);
-	if (!q)
-		return ERR_PTR(-ENOMEM);
+	q = blk_alloc_queue(NULL, set->numa_node);
+	if (IS_ERR(q))
+		return q;
 	q->queuedata = queuedata;
 	ret = blk_mq_init_allocated_queue(set, q);
 	if (ret) {
diff --git a/block/blk.h b/block/blk.h
index 58b5dbac2a487d..100c7a02854bfd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -448,7 +448,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 }
 
 int blk_validate_limits(struct queue_limits *lim);
-struct request_queue *blk_alloc_queue(int node_id);
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
 
diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae6818..defcd35b421bdd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1396,8 +1396,8 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node);
-	if (!q)
+	q = blk_alloc_queue(NULL, node);
+	if (IS_ERR(q))
 		return NULL;
 
 	disk = __alloc_disk_node(q, node, lkclass);
-- 
2.39.2

