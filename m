Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090A17585
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904523; cv=none; b=j8isuQXoTIGiEUSTMYj6O2Jdr1VZ3xTmCrROeVyKs6IyX9dMDvtsH4wjWh8ii/hRqz3d6Nv6Z5vp/6i2PqiHzX1PbN7rHoolfHOGX6/TKgbPcTqri713MLUq6eCwe3p0XG8pxrFCAVRowplpBHK+wMIkDB79c6hxyEWFRCmvvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904523; c=relaxed/simple;
	bh=XO9wUPEu+/qery7LKiB3LIhSZjkFnuxDExk0Tru3FfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHecautQQGMLHX2z5c1DT6CP4saL+Fqiu2ryuwQATFS1EvlY9NvOAwka+fARl/Lwe6rGsE25XgCVxS90oHMp3cJANYXIw2uU1tyL3Pz5WPsfsr95Yf+w2Cig+xu8ka9E2xX+7wAFxW0692I2hdIjqZCdgNgzcboAfCkgl7Y2ZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AKK0C10H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKK0C10H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=92g6NEdsykvXzG4PpBIVqSCAItF5hLEKl/frsbNgBdI=; b=AKK0C10H1sUuOjgF2dhgulOmrz
	yXowt+QYsYfvuEk3HLkZmeoiEX8x0gGtgUqEETZ3up+9BfqO4TebN6t4jolFHSartvvRSPVG0YPdD
	yKwR/SSfxNAtUBgFAB8unJ5KDhS4oxQYsiMPxx1mCNzVFVhBhRbkW4xr4FSpRS48bigydMJE87ytA
	CZvDCl/B5n6pBm1cjU5iENd+bGFlJZTc1rvve3BXnJ9bWKG+w/JY6VUXAvmzPzZGEQYqpybxGk9no
	pd6A7ohsV9ZJ+rWdNYUtNfRRQ+zw24DECEw5J40F9E2vyv+20vto/EQzIHZqbxlQ51LJyeCJ4XwZw
	RNKbtfiA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raBz7-0000000CSEn-2NtI;
	Wed, 14 Feb 2024 09:55:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/5] null_blk: refactor tag_set setup
Date: Wed, 14 Feb 2024 10:54:59 +0100
Message-Id: <20240214095501.1883819-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214095501.1883819-1-hch@lst.de>
References: <20240214095501.1883819-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the tagset initialization out of null_add_dev into a new
null_setup_tagset helper, and move the shared vs local differences
out of null_init_tag_set into the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk/main.c | 106 ++++++++++++++++------------------
 1 file changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 89e63d1c610362..03c3917a56fa28 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1759,55 +1759,65 @@ static int null_gendisk_register(struct nullb *nullb)
 	return add_disk(disk);
 }
 
-static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
+static int null_init_tag_set(struct blk_mq_tag_set *set, int poll_queues)
 {
-	unsigned int flags = BLK_MQ_F_SHOULD_MERGE;
-	int hw_queues, numa_node;
-	unsigned int queue_depth;
-	int poll_queues;
-
-	if (nullb) {
-		hw_queues = nullb->dev->submit_queues;
-		poll_queues = nullb->dev->poll_queues;
-		queue_depth = nullb->dev->hw_queue_depth;
-		numa_node = nullb->dev->home_node;
-		if (nullb->dev->no_sched)
-			flags |= BLK_MQ_F_NO_SCHED;
-		if (nullb->dev->shared_tag_bitmap)
-			flags |= BLK_MQ_F_TAG_HCTX_SHARED;
-		if (nullb->dev->blocking)
-			flags |= BLK_MQ_F_BLOCKING;
-	} else {
-		hw_queues = g_submit_queues;
-		poll_queues = g_poll_queues;
-		queue_depth = g_hw_queue_depth;
-		numa_node = g_home_node;
-		if (g_no_sched)
-			flags |= BLK_MQ_F_NO_SCHED;
-		if (g_shared_tag_bitmap)
-			flags |= BLK_MQ_F_TAG_HCTX_SHARED;
-		if (g_blocking)
-			flags |= BLK_MQ_F_BLOCKING;
-	}
-
 	set->ops = &null_mq_ops;
-	set->cmd_size	= sizeof(struct nullb_cmd);
-	set->flags = flags;
-	set->driver_data = nullb;
-	set->nr_hw_queues = hw_queues;
-	set->queue_depth = queue_depth;
-	set->numa_node = numa_node;
+	set->cmd_size = sizeof(struct nullb_cmd);
 	set->timeout = 5 * HZ;
+	set->nr_maps = 1;
 	if (poll_queues) {
 		set->nr_hw_queues += poll_queues;
-		set->nr_maps = 3;
-	} else {
-		set->nr_maps = 1;
+		set->nr_maps += 2;
 	}
-
 	return blk_mq_alloc_tag_set(set);
 }
 
+static int null_init_global_tag_set(void)
+{
+	int error;
+
+	if (tag_set.ops)
+		return 0;
+
+	tag_set.nr_hw_queues = g_submit_queues;
+	tag_set.queue_depth = g_hw_queue_depth;
+	tag_set.numa_node = g_home_node;
+	tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	if (g_no_sched)
+		tag_set.flags |= BLK_MQ_F_NO_SCHED;
+	if (g_shared_tag_bitmap)
+		tag_set.flags |= BLK_MQ_F_TAG_HCTX_SHARED;
+	if (g_blocking)
+		tag_set.flags |= BLK_MQ_F_BLOCKING;
+
+	error = null_init_tag_set(&tag_set, g_poll_queues);
+	if (error)
+		tag_set.ops = NULL;
+	return error;
+}
+
+static int null_setup_tagset(struct nullb *nullb)
+{
+	if (nullb->dev->shared_tags) {
+		nullb->tag_set = &tag_set;
+		return null_init_global_tag_set();
+	}
+
+	nullb->tag_set = &nullb->__tag_set;
+	nullb->tag_set->driver_data = nullb;
+	nullb->tag_set->nr_hw_queues = nullb->dev->submit_queues;
+	nullb->tag_set->queue_depth = nullb->dev->hw_queue_depth;
+	nullb->tag_set->numa_node = nullb->dev->home_node;
+	nullb->tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
+	if (nullb->dev->no_sched)
+		nullb->tag_set->flags |= BLK_MQ_F_NO_SCHED;
+	if (nullb->dev->shared_tag_bitmap)
+		nullb->tag_set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
+	if (nullb->dev->blocking)
+		nullb->tag_set->flags |= BLK_MQ_F_BLOCKING;
+	return null_init_tag_set(nullb->tag_set, nullb->dev->poll_queues);
+}
+
 static int null_validate_conf(struct nullb_device *dev)
 {
 	if (dev->queue_mode == NULL_Q_RQ) {
@@ -1904,21 +1914,7 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_free_nullb;
 
-	if (dev->shared_tags) {
-		if (!tag_set.ops) {
-			rv = null_init_tag_set(NULL, &tag_set);
-			if (rv) {
-				tag_set.ops = NULL;
-				goto out_cleanup_queues;
-			}
-		}
-		nullb->tag_set = &tag_set;
-		rv = 0;
-	} else {
-		nullb->tag_set = &nullb->__tag_set;
-		rv = null_init_tag_set(nullb, nullb->tag_set);
-	}
-
+	rv = null_setup_tagset(nullb);
 	if (rv)
 		goto out_cleanup_queues;
 
-- 
2.39.2

