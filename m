Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F415FD02
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307026; cv=none; b=W7D6FsLaWbqvb30QlNk07U3ssybggAd8HkjCPo+RCcHjwA3EnseBVYKZiaznHXJtFJLS4pOnQnzuuJmg/IUyBPFR4em2KMWcUtYqMxGXy7f1IGGutUPARrxUhf2aebF50JiyQ3TLpayXF780v02VOmB+dSZjjmTnObQCCtvyuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307026; c=relaxed/simple;
	bh=RBj8p3mWhhLhXEPAyMM8tVdwgwbF7FIUqczM8lpNDbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TE2Klb4kwdnxgyKRlrg9XY3UDLAK8nVhBWX8tYpIFxN+Hos0fqcIfWVgexLtzlwJYx2A3YlKZBdpsqaAE8n4dcRkOAHIocIG+EdtKSZep64TzJaT7bZJaeB9POO8mgQK3y66RahUxR8yOFmfdpOqIGo09GVOKgToFCFZZf+F2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U47jdWuG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U47jdWuG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=67RbcitXjGhdxYICEHJs5qtxfksyJvfrfHB2oqLRNNQ=; b=U47jdWuGrfZH2e1APgMW4GWMR9
	Qk/IvWNnv2VNHm8IRgrqmJgB8xO2t/1ZDl4G5Q4AbBgg2+K6IqneMaxXywi+lNUvUGC84diP/Rrak
	ilZfvfBN9GCKaAQPqwHywI/byRfrh6pTX8zy0Dqbtrg37yBC4JDlvlfsXrOytEBN4yznch9ItXwDW
	WrbQqhjiu2pNTQ5j5L+JpDcnAzKRn6ovVAvwqtYBieHTliKxfUsqkGNj+bCLsSwm9PUsp+Mo90I0C
	vUsOQ+l6Kc2H2abyMaFFZu+6k8DnKKibyvXT9FzlcLvfGgy70rszz1NtCM3B1ZiBDx+eR9/iHZ8Qo
	5bDS8HGA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsfHD-000000061VK-0YvW;
	Fri, 05 Apr 2024 08:50:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: work around sparse in queue_limits_commit_update
Date: Fri,  5 Apr 2024 10:50:18 +0200
Message-Id: <20240405085018.243260-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The spare lock context tracking warns about the mutex unlock in
queue_limits_commit_update despite the __releases annoation:

block/blk-settings.c:263:9: warning: context imbalance in 'queue_limits_commit_update' - wrong
count at exit

As far as I can tell that is because the sparse lock tracking code is
busted for inline functions.  Work around it by splitting an inline
wrapper out of queue_limits_commit_update and doing the unlock there.

Reported-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 40 +++++++++++++++++-----------------------
 include/linux/blkdev.h | 32 +++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index cdbaef159c4bc3..9ef52b80965dc1 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -239,31 +239,20 @@ int blk_set_default_limits(struct queue_limits *lim)
 	return blk_validate_limits(lim);
 }
 
-/**
- * queue_limits_commit_update - commit an atomic update of queue limits
- * @q:		queue to update
- * @lim:	limits to apply
- *
- * Apply the limits in @lim that were obtained from queue_limits_start_update()
- * and updated by the caller to @q.
- *
- * Returns 0 if successful, else a negative error code.
- */
-int queue_limits_commit_update(struct request_queue *q,
+int __queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim)
-	__releases(q->limits_lock)
 {
-	int error = blk_validate_limits(lim);
-
-	if (!error) {
-		q->limits = *lim;
-		if (q->disk)
-			blk_apply_bdi_limits(q->disk->bdi, lim);
-	}
-	mutex_unlock(&q->limits_lock);
-	return error;
+	int error;
+
+	error = blk_validate_limits(lim);
+	if (error)
+		return error;
+	q->limits = *lim;
+	if (q->disk)
+		blk_apply_bdi_limits(q->disk->bdi, lim);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(queue_limits_commit_update);
+EXPORT_SYMBOL_GPL(__queue_limits_commit_update);
 
 /**
  * queue_limits_set - apply queue limits to queue
@@ -278,8 +267,13 @@ EXPORT_SYMBOL_GPL(queue_limits_commit_update);
  */
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim)
 {
+	int error;
+
 	mutex_lock(&q->limits_lock);
-	return queue_limits_commit_update(q, lim);
+	error = __queue_limits_commit_update(q, lim);
+	mutex_unlock(&q->limits_lock);
+
+	return error;
 }
 EXPORT_SYMBOL_GPL(queue_limits_set);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be9e..99f1d2fcec4a2a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -869,6 +869,15 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
 	return chunk_sectors - (offset & (chunk_sectors - 1));
 }
 
+/*
+ * Note: we want queue_limits_start_update to be inline to avoid passing a huge
+ * strut by value.  This in turn requires the part of queue_limits_commit_update
+ * that unlocks the mutex to be inline as well to not confuse the sparse lock
+ * context tracking.  Never use __queue_limits_commit_update directly.
+ */
+int __queue_limits_commit_update(struct request_queue *q,
+		struct queue_limits *lim);
+
 /**
  * queue_limits_start_update - start an atomic update of queue limits
  * @q:		queue to update
@@ -883,13 +892,30 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
  */
 static inline struct queue_limits
 queue_limits_start_update(struct request_queue *q)
-	__acquires(q->limits_lock)
 {
 	mutex_lock(&q->limits_lock);
 	return q->limits;
 }
-int queue_limits_commit_update(struct request_queue *q,
-		struct queue_limits *lim);
+
+/**
+ * queue_limits_commit_update - commit an atomic update of queue limits
+ * @q:		queue to update
+ * @lim:	limits to apply
+ *
+ * Apply the limits in @lim that were obtained from queue_limits_start_update()
+ * and updated by the caller to @q.
+ *
+ * Returns 0 if successful, else a negative error code.
+ */
+static inline int queue_limits_commit_update(struct request_queue *q,
+		struct queue_limits *lim)
+{
+	int error = __queue_limits_commit_update(q, lim);
+
+	mutex_unlock(&q->limits_lock);
+	return error;
+}
+
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
 
 /*
-- 
2.39.2

