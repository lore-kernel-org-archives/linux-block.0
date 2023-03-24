Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E37DC6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCXSFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjCXSEJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 14:04:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC2B1D91F
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 11:02:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id ga7so2219645qtb.2
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 11:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Odv7AxC3HRZXWm+J0LYvmR5fqL4QLl4x0VH2IAYLdbo=;
        b=T4bnaY8XekW+fKFNO5kFxAcNyS78yzlkpVi/urOKJkNMdj2UkGMBdy05wrCic9ZbLX
         hK6pZ9CvvcQNR6tEVCs78Dcl7mQDA0DOTfuzmbQ7qbv9/4Vvo5+DnmxXau0/M6jfs1DA
         zSd7aDxafQ70etDSU7Pxfz/81PEfYva23hsVs9Yw1TW7tByDZqu+cdkoWwwask1FF1PY
         0/Pu3dMCgE51yXflgqxAllIZZSsBI0FQEQA1T1ZzSvLb9NMFrW/Wu35M4+yiOtuqQ9Xz
         87MhS/RWF7/cVfXaEmG7aVs7ExLZxCZlE7zBHpEjNDNUK0RlkqVMQZSKOXSvq/R7FtF9
         WQNQ==
X-Gm-Message-State: AO0yUKW4PTMRCxn3a2aTuS1sEq1z98kxvEo6Ok4EBEq/qvICSTeyHeiQ
        h07jbcB5ewKuQ6+nLdQghtjx
X-Google-Smtp-Source: AK7set+fQBojZUgmuHDlH+OB0KbjCCij3sFa+MoTKOMo/eVjeZYYE5ThEHLU+nbJQDdAyiZp4XisIQ==
X-Received: by 2002:a05:622a:11d5:b0:3dd:9050:9c4b with SMTP id n21-20020a05622a11d500b003dd90509c4bmr6640431qtk.62.1679680633775;
        Fri, 24 Mar 2023 10:57:13 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 6-20020ac85646000000b003e3897d8505sm4232267qtt.54.2023.03.24.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:13 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 9/9] dm bio prison v1: improve concurrent IO performance
Date:   Fri, 24 Mar 2023 13:56:56 -0400
Message-Id: <20230324175656.85082-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324175656.85082-1-snitzer@kernel.org>
References: <20230324175656.85082-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

Split the bio prison into multiple regions, with a separate rbtree and
associated lock for each region.

To get fast bio prison locking and not damage the performance of
discards too much the bio-prison now stipulates that discards should
not cross a BIO_PRISON_MAX_RANGE boundary.

Because the range of a key (block_end - block_begin) must not exceed
BIO_PRISON_MAX_RANGE: break_up_discard_bio() now ensures the data
range reflected in PHYSICAL key doesn't exceed BIO_PRISON_MAX_RANGE.
And splitting the thin target's discards (handled with VIRTUAL key) is
achieved by updating dm-thin.c to set limits->max_discard_sectors in
terms of BIO_PRISON_MAX_RANGE _and_ setting the thin and thin-pool
targets' max_discard_granularity to true.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bio-prison-v1.c | 87 ++++++++++++++++++++-----------
 drivers/md/dm-bio-prison-v1.h | 10 ++++
 drivers/md/dm-thin.c          | 96 ++++++++++++++++++++---------------
 3 files changed, 123 insertions(+), 70 deletions(-)

diff --git a/drivers/md/dm-bio-prison-v1.c b/drivers/md/dm-bio-prison-v1.c
index c4c05d5d8909..e35ed236e0dc 100644
--- a/drivers/md/dm-bio-prison-v1.c
+++ b/drivers/md/dm-bio-prison-v1.c
@@ -16,11 +16,17 @@
 
 /*----------------------------------------------------------------*/
 
+#define NR_LOCKS 64
+#define LOCK_MASK (NR_LOCKS - 1)
 #define MIN_CELLS 1024
 
+struct lock {
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
 struct dm_bio_prison {
-	spinlock_t lock;
-	struct rb_root cells;
+	struct lock lock[NR_LOCKS];
+	struct rb_root cells[NR_LOCKS];
 	mempool_t cell_pool;
 };
 
@@ -34,13 +40,17 @@ static struct kmem_cache *_cell_cache;
  */
 struct dm_bio_prison *dm_bio_prison_create(void)
 {
-	struct dm_bio_prison *prison = kzalloc(sizeof(*prison), GFP_KERNEL);
 	int ret;
+	unsigned i;
+	struct dm_bio_prison *prison = kzalloc(sizeof(*prison), GFP_KERNEL);
 
 	if (!prison)
 		return NULL;
 
-	spin_lock_init(&prison->lock);
+	for (i = 0; i < NR_LOCKS; i++) {
+		spin_lock_init(&prison->lock[i].lock);
+		prison->cells[i] = RB_ROOT;
+	}
 
 	ret = mempool_init_slab_pool(&prison->cell_pool, MIN_CELLS, _cell_cache);
 	if (ret) {
@@ -48,8 +58,6 @@ struct dm_bio_prison *dm_bio_prison_create(void)
 		return NULL;
 	}
 
-	prison->cells = RB_ROOT;
-
 	return prison;
 }
 EXPORT_SYMBOL_GPL(dm_bio_prison_create);
@@ -107,14 +115,26 @@ static int cmp_keys(struct dm_cell_key *lhs,
 	return 0;
 }
 
-static int __bio_detain(struct dm_bio_prison *prison,
+static unsigned lock_nr(struct dm_cell_key *key)
+{
+	return (key->block_begin >> BIO_PRISON_MAX_RANGE_SHIFT) & LOCK_MASK;
+}
+
+static void check_range(struct dm_cell_key *key)
+{
+	BUG_ON(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE);
+	BUG_ON((key->block_begin >> BIO_PRISON_MAX_RANGE_SHIFT) !=
+	       ((key->block_end - 1) >> BIO_PRISON_MAX_RANGE_SHIFT));
+}
+
+static int __bio_detain(struct rb_root *root,
 			struct dm_cell_key *key,
 			struct bio *inmate,
 			struct dm_bio_prison_cell *cell_prealloc,
 			struct dm_bio_prison_cell **cell_result)
 {
 	int r;
-	struct rb_node **new = &prison->cells.rb_node, *parent = NULL;
+	struct rb_node **new = &root->rb_node, *parent = NULL;
 
 	while (*new) {
 		struct dm_bio_prison_cell *cell =
@@ -139,7 +159,7 @@ static int __bio_detain(struct dm_bio_prison *prison,
 	*cell_result = cell_prealloc;
 
 	rb_link_node(&cell_prealloc->node, parent, new);
-	rb_insert_color(&cell_prealloc->node, &prison->cells);
+	rb_insert_color(&cell_prealloc->node, root);
 
 	return 0;
 }
@@ -151,10 +171,12 @@ static int bio_detain(struct dm_bio_prison *prison,
 		      struct dm_bio_prison_cell **cell_result)
 {
 	int r;
+	unsigned l = lock_nr(key);
+	check_range(key);
 
-	spin_lock_irq(&prison->lock);
-	r = __bio_detain(prison, key, inmate, cell_prealloc, cell_result);
-	spin_unlock_irq(&prison->lock);
+	spin_lock_irq(&prison->lock[l].lock);
+	r = __bio_detain(&prison->cells[l], key, inmate, cell_prealloc, cell_result);
+	spin_unlock_irq(&prison->lock[l].lock);
 
 	return r;
 }
@@ -181,11 +203,11 @@ EXPORT_SYMBOL_GPL(dm_get_cell);
 /*
  * @inmates must have been initialised prior to this call
  */
-static void __cell_release(struct dm_bio_prison *prison,
+static void __cell_release(struct rb_root *root,
 			   struct dm_bio_prison_cell *cell,
 			   struct bio_list *inmates)
 {
-	rb_erase(&cell->node, &prison->cells);
+	rb_erase(&cell->node, root);
 
 	if (inmates) {
 		if (cell->holder)
@@ -198,20 +220,22 @@ void dm_cell_release(struct dm_bio_prison *prison,
 		     struct dm_bio_prison_cell *cell,
 		     struct bio_list *bios)
 {
-	spin_lock_irq(&prison->lock);
-	__cell_release(prison, cell, bios);
-	spin_unlock_irq(&prison->lock);
+	unsigned l = lock_nr(&cell->key);
+
+	spin_lock_irq(&prison->lock[l].lock);
+	__cell_release(&prison->cells[l], cell, bios);
+	spin_unlock_irq(&prison->lock[l].lock);
 }
 EXPORT_SYMBOL_GPL(dm_cell_release);
 
 /*
  * Sometimes we don't want the holder, just the additional bios.
  */
-static void __cell_release_no_holder(struct dm_bio_prison *prison,
+static void __cell_release_no_holder(struct rb_root *root,
 				     struct dm_bio_prison_cell *cell,
 				     struct bio_list *inmates)
 {
-	rb_erase(&cell->node, &prison->cells);
+	rb_erase(&cell->node, root);
 	bio_list_merge(inmates, &cell->bios);
 }
 
@@ -219,11 +243,12 @@ void dm_cell_release_no_holder(struct dm_bio_prison *prison,
 			       struct dm_bio_prison_cell *cell,
 			       struct bio_list *inmates)
 {
+	unsigned l = lock_nr(&cell->key);
 	unsigned long flags;
 
-	spin_lock_irqsave(&prison->lock, flags);
-	__cell_release_no_holder(prison, cell, inmates);
-	spin_unlock_irqrestore(&prison->lock, flags);
+	spin_lock_irqsave(&prison->lock[l].lock, flags);
+	__cell_release_no_holder(&prison->cells[l], cell, inmates);
+	spin_unlock_irqrestore(&prison->lock[l].lock, flags);
 }
 EXPORT_SYMBOL_GPL(dm_cell_release_no_holder);
 
@@ -248,18 +273,19 @@ void dm_cell_visit_release(struct dm_bio_prison *prison,
 			   void *context,
 			   struct dm_bio_prison_cell *cell)
 {
-	spin_lock_irq(&prison->lock);
+	unsigned l = lock_nr(&cell->key);
+	spin_lock_irq(&prison->lock[l].lock);
 	visit_fn(context, cell);
-	rb_erase(&cell->node, &prison->cells);
-	spin_unlock_irq(&prison->lock);
+	rb_erase(&cell->node, &prison->cells[l]);
+	spin_unlock_irq(&prison->lock[l].lock);
 }
 EXPORT_SYMBOL_GPL(dm_cell_visit_release);
 
-static int __promote_or_release(struct dm_bio_prison *prison,
+static int __promote_or_release(struct rb_root *root,
 				struct dm_bio_prison_cell *cell)
 {
 	if (bio_list_empty(&cell->bios)) {
-		rb_erase(&cell->node, &prison->cells);
+		rb_erase(&cell->node, root);
 		return 1;
 	}
 
@@ -271,10 +297,11 @@ int dm_cell_promote_or_release(struct dm_bio_prison *prison,
 			       struct dm_bio_prison_cell *cell)
 {
 	int r;
+	unsigned l = lock_nr(&cell->key);
 
-	spin_lock_irq(&prison->lock);
-	r = __promote_or_release(prison, cell);
-	spin_unlock_irq(&prison->lock);
+	spin_lock_irq(&prison->lock[l].lock);
+	r = __promote_or_release(&prison->cells[l], cell);
+	spin_unlock_irq(&prison->lock[l].lock);
 
 	return r;
 }
diff --git a/drivers/md/dm-bio-prison-v1.h b/drivers/md/dm-bio-prison-v1.h
index dfbf1e94cb75..0b8acd6708fb 100644
--- a/drivers/md/dm-bio-prison-v1.h
+++ b/drivers/md/dm-bio-prison-v1.h
@@ -34,6 +34,16 @@ struct dm_cell_key {
 	dm_block_t block_begin, block_end;
 };
 
+/*
+ * The range of a key (block_end - block_begin) must not
+ * exceed BIO_PRISON_MAX_RANGE.  Also the range must not
+ * cross a similarly sized boundary.
+ *
+ * Must be a power of 2.
+ */
+#define BIO_PRISON_MAX_RANGE 1024
+#define BIO_PRISON_MAX_RANGE_SHIFT 10
+
 /*
  * Treat this as opaque, only in header so callers can manage allocation
  * themselves.
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 00323428919e..18f18f9d66cc 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1674,14 +1674,10 @@ static void break_up_discard_bio(struct thin_c *tc, dm_block_t begin, dm_block_t
 	struct dm_cell_key data_key;
 	struct dm_bio_prison_cell *data_cell;
 	struct dm_thin_new_mapping *m;
-	dm_block_t virt_begin, virt_end, data_begin;
+	dm_block_t virt_begin, virt_end, data_begin, data_end;
+	dm_block_t len, next_boundary;
 
 	while (begin != end) {
-		r = ensure_next_mapping(pool);
-		if (r)
-			/* we did our best */
-			return;
-
 		r = dm_thin_find_mapped_range(tc->td, begin, end, &virt_begin, &virt_end,
 					      &data_begin, &maybe_shared);
 		if (r)
@@ -1691,38 +1687,57 @@ static void break_up_discard_bio(struct thin_c *tc, dm_block_t begin, dm_block_t
 			 */
 			break;
 
-		build_key(tc->td, PHYSICAL, data_begin, data_begin + (virt_end - virt_begin), &data_key);
-		if (bio_detain(tc->pool, &data_key, NULL, &data_cell)) {
-			/* contention, we'll give up with this range */
-			begin = virt_end;
-			continue;
+		data_end = data_begin + (virt_end - virt_begin);
+
+		/*
+		 * Make sure the data region obeys the bio prison restrictions.
+		 */
+		while (data_begin < data_end) {
+			r = ensure_next_mapping(pool);
+			if (r)
+				/* we did our best */
+				return;
+
+			next_boundary = ((data_begin >> BIO_PRISON_MAX_RANGE_SHIFT) + 1)
+				 << BIO_PRISON_MAX_RANGE_SHIFT;
+			len = min_t(sector_t, data_end - data_begin, next_boundary - data_begin);
+
+			build_key(tc->td, PHYSICAL, data_begin, data_begin + len, &data_key);
+			if (bio_detain(tc->pool, &data_key, NULL, &data_cell)) {
+				/* contention, we'll give up with this range */
+				data_begin += len;
+				continue;
+			}
+
+			/*
+			 * IO may still be going to the destination block.  We must
+			 * quiesce before we can do the removal.
+			 */
+			m = get_next_mapping(pool);
+			m->tc = tc;
+			m->maybe_shared = maybe_shared;
+			m->virt_begin = virt_begin;
+			m->virt_end = virt_begin + len;
+			m->data_block = data_begin;
+			m->cell = data_cell;
+			m->bio = bio;
+
+			/*
+			 * The parent bio must not complete before sub discard bios are
+			 * chained to it (see end_discard's bio_chain)!
+			 *
+			 * This per-mapping bi_remaining increment is paired with
+			 * the implicit decrement that occurs via bio_endio() in
+			 * end_discard().
+			 */
+			bio_inc_remaining(bio);
+			if (!dm_deferred_set_add_work(pool->all_io_ds, &m->list))
+				pool->process_prepared_discard(m);
+
+			virt_begin += len;
+			data_begin += len;
 		}
 
-		/*
-		 * IO may still be going to the destination block.  We must
-		 * quiesce before we can do the removal.
-		 */
-		m = get_next_mapping(pool);
-		m->tc = tc;
-		m->maybe_shared = maybe_shared;
-		m->virt_begin = virt_begin;
-		m->virt_end = virt_end;
-		m->data_block = data_begin;
-		m->cell = data_cell;
-		m->bio = bio;
-
-		/*
-		 * The parent bio must not complete before sub discard bios are
-		 * chained to it (see end_discard's bio_chain)!
-		 *
-		 * This per-mapping bi_remaining increment is paired with
-		 * the implicit decrement that occurs via bio_endio() in
-		 * end_discard().
-		 */
-		bio_inc_remaining(bio);
-		if (!dm_deferred_set_add_work(pool->all_io_ds, &m->list))
-			pool->process_prepared_discard(m);
-
 		begin = virt_end;
 	}
 }
@@ -3380,13 +3395,13 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	 */
 	if (pf.discard_enabled && pf.discard_passdown) {
 		ti->num_discard_bios = 1;
-
 		/*
 		 * Setting 'discards_supported' circumvents the normal
 		 * stacking of discard limits (this keeps the pool and
 		 * thin devices' discard limits consistent).
 		 */
 		ti->discards_supported = true;
+		ti->max_discard_granularity = true;
 	}
 	ti->private = pt;
 
@@ -4096,7 +4111,7 @@ static struct target_type pool_target = {
 	.name = "thin-pool",
 	.features = DM_TARGET_SINGLETON | DM_TARGET_ALWAYS_WRITEABLE |
 		    DM_TARGET_IMMUTABLE,
-	.version = {1, 22, 0},
+	.version = {1, 23, 0},
 	.module = THIS_MODULE,
 	.ctr = pool_ctr,
 	.dtr = pool_dtr,
@@ -4261,6 +4276,7 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	if (tc->pool->pf.discard_enabled) {
 		ti->discards_supported = true;
 		ti->num_discard_bios = 1;
+		ti->max_discard_granularity = true;
 	}
 
 	mutex_unlock(&dm_thin_pool_table.mutex);
@@ -4476,12 +4492,12 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		return;
 
 	limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
-	limits->max_discard_sectors = 2048 * 1024 * 16; /* 16G */
+	limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
 }
 
 static struct target_type thin_target = {
 	.name = "thin",
-	.version = {1, 22, 0},
+	.version = {1, 23, 0},
 	.module	= THIS_MODULE,
 	.ctr = thin_ctr,
 	.dtr = thin_dtr,
-- 
2.40.0

