Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAA4CDF9
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vgQe7CY/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5i2urZ2P9zhbfl1LD5nmN5CxWc7QuMjdfU2d30kNESY=; b=vgQe7CY/u/PdFIS8Lz9oAdLSi6
	KeZf3Fs5WIqwwSmZASSgEkbQ9tOtzEdve1KQDjww8SQFQeVf/WTj54jWHXBxPor3XC4pErMnB310z
	iXJ2RcnBMPLypeCqdXpeHaw7erP8d3rzKVHaPFLxA+IcKK0TZQi12CuxXcTnTneHAFj4arK8IJjlP
	Zz/+51CdZ2+jRUrEqGo58sMQyuefkVYBMo5kk5ZBQ9p4Y6johAonaWbiIoi+7Sli8AFrYv/odeCXH
	wNF5kIy2VNI5E8rcjoXT6soz6P/6LUPbd2t2bC3vD+BfujQ2FdQlfBIcIaFue0JwmkZGmpRd4jjmh
	Y0UGSg2w==;
Received: from [89.144.222.247] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3Pj-00BxZ3-2Q;
	Tue, 26 Dec 2023 09:07:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] blk-wbt: remove the separate write cache tracking
Date: Tue, 26 Dec 2023 09:07:47 +0000
Message-Id: <20231226090747.204969-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use the queue wide write back cache tracking insted of duplicating the
value in strut rq_wb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c |  2 --
 block/blk-wbt.c      | 13 ++-----------
 block/blk-wbt.h      |  5 -----
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index bb94a3d471f4fb..33b3f767b81e24 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -837,8 +837,6 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 		blk_queue_flag_set(QUEUE_FLAG_FUA, q);
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_FUA, q);
-
-	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0bb613139becbb..5ba3cd574eacbd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -84,8 +84,6 @@ struct rq_wb {
 	u64 sync_issue;
 	void *sync_cookie;
 
-	unsigned int wc;
-
 	unsigned long last_issue;		/* last non-throttled issue */
 	unsigned long last_comp;		/* last non-throttled comp */
 	unsigned long min_lat_nsec;
@@ -207,7 +205,8 @@ static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
 	 */
 	if (wb_acct & WBT_DISCARD)
 		limit = rwb->wb_background;
-	else if (rwb->wc && !wb_recent_wait(rwb))
+	else if (test_bit(QUEUE_FLAG_WC, &rwb->rqos.disk->queue->queue_flags) &&
+	         !wb_recent_wait(rwb))
 		limit = 0;
 	else
 		limit = rwb->wb_normal;
@@ -699,13 +698,6 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 	}
 }
 
-void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-	if (rqos)
-		RQWB(rqos)->wc = write_cache_on;
-}
-
 /*
  * Enable wbt if defaults are configured that way
  */
@@ -918,7 +910,6 @@ int wbt_init(struct gendisk *disk)
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
-	rwb->wc = test_bit(QUEUE_FLAG_WC, &q->queue_flags);
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 	rwb->rq_depth.queue_depth = blk_queue_depth(q);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 8a029e138f7ace..e5fc653b9b76f6 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -12,8 +12,6 @@ u64 wbt_get_min_lat(struct request_queue *q);
 void wbt_set_min_lat(struct request_queue *q, u64 val);
 bool wbt_disabled(struct request_queue *);
 
-void wbt_set_write_cache(struct request_queue *, bool);
-
 u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
@@ -24,9 +22,6 @@ static inline void wbt_disable_default(struct gendisk *disk)
 static inline void wbt_enable_default(struct gendisk *disk)
 {
 }
-static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
-{
-}
 
 #endif /* CONFIG_BLK_WBT */
 
-- 
2.39.2

