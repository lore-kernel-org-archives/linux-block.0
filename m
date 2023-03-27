Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28EAC77B61
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjC0UOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjC0UOW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:22 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D7F1FF7
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:31 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id hf2so9811807qtb.3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKZdoNXFigBuaARZaAptCA6/0fq1wlNkMtf1bLoETbM=;
        b=p/QNZslkrX4o/4mjthzpEq1SoUKkuVf8stN+Zn7w2BU0DsFkfyR8Hv9B48KDbQaqRg
         Ip3Mxw6Xv/XTsAjl3ieQVTgPMHSMv+aKEkUFARaphBeQsCCFwasLSpDZOMWWiZZoVqIk
         ihImU6qGUa8FVLfNQ3AosfTKqgVwc1VctkAnrnqt5XRji/g7n9QEGVQeaoNRK3qqJWzW
         B9CPlslUsbK/duUqq/kZRJPbOQDg3xd/jYjl9eZKFsbyRFOiPlRJB+YS2LpzKjmCExMA
         XF9ufVSNZ2eKdx0jLVD2JLnbawwzKq7b2WI3jLlpFQGhjwfODmVUaXiyl38tF/zeEpjh
         taEw==
X-Gm-Message-State: AO0yUKWEk405oKLfDVmEZ5eon6wMyGD4psMBtm2XDuGlJFaqv09QkNBc
        4E6NcssaoRYjxyykGh6wPTa9
X-Google-Smtp-Source: AK7set9KXUMs1rqs7kAqxN9Yk6OnkJzXX9Ry0bTCMOPwZUEbPgMi3QtSYmMLZ60y5R3fllURrlRHWA==
X-Received: by 2002:a05:622a:647:b0:3bf:d9ee:882d with SMTP id a7-20020a05622a064700b003bfd9ee882dmr22445529qtb.40.1679948010612;
        Mon, 27 Mar 2023 13:13:30 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id j9-20020a05620a288900b0070648cf78bdsm16879656qkp.54.2023.03.27.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:30 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 14/20] dm bio prison v1: improve concurrent IO performance
Date:   Mon, 27 Mar 2023 16:11:37 -0400
Message-Id: <20230327201143.51026-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
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
 drivers/md/dm-bio-prison-v1.c | 87 +++++++++++++++++++++------------
 drivers/md/dm-bio-prison-v1.h | 10 ++++
 drivers/md/dm-thin.c          | 92 ++++++++++++++++++++---------------
 3 files changed, 121 insertions(+), 68 deletions(-)

diff --git a/drivers/md/dm-bio-prison-v1.c b/drivers/md/dm-bio-prison-v1.c
index c4c05d5d8909..2b8af861e5f6 100644
--- a/drivers/md/dm-bio-prison-v1.c
+++ b/drivers/md/dm-bio-prison-v1.c
@@ -16,11 +16,17 @@
 
 /*----------------------------------------------------------------*/
 
+#define NR_LOCKS 64
+#define LOCK_MASK (NR_LOCKS - 1)
 #define MIN_CELLS 1024
 
+struct prison_region {
+	spinlock_t lock;
+	struct rb_root cell;
+} ____cacheline_aligned_in_smp;
+
 struct dm_bio_prison {
-	spinlock_t lock;
-	struct rb_root cells;
+	struct prison_region regions[NR_LOCKS];
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
+		spin_lock_init(&prison->regions[i].lock);
+		prison->regions[i].cell = RB_ROOT;
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
+	spin_lock_irq(&prison->regions[l].lock);
+	r = __bio_detain(&prison->regions[l].cell, key, inmate, cell_prealloc, cell_result);
+	spin_unlock_irq(&prison->regions[l].lock);
 
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
+	spin_lock_irq(&prison->regions[l].lock);
+	__cell_release(&prison->regions[l].cell, cell, bios);
+	spin_unlock_irq(&prison->regions[l].lock);
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
+	spin_lock_irqsave(&prison->regions[l].lock, flags);
+	__cell_release_no_holder(&prison->regions[l].cell, cell, inmates);
+	spin_unlock_irqrestore(&prison->regions[l].lock, flags);
 }
 EXPORT_SYMBOL_GPL(dm_cell_release_no_holder);
 
@@ -248,18 +273,19 @@ void dm_cell_visit_release(struct dm_bio_prison *prison,
 			   void *context,
 			   struct dm_bio_prison_cell *cell)
 {
-	spin_lock_irq(&prison->lock);
+	unsigned l = lock_nr(&cell->key);
+	spin_lock_irq(&prison->regions[l].lock);
 	visit_fn(context, cell);
-	rb_erase(&cell->node, &prison->cells);
-	spin_unlock_irq(&prison->lock);
+	rb_erase(&cell->node, &prison->regions[l].cell);
+	spin_unlock_irq(&prison->regions[l].lock);
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
+	spin_lock_irq(&prison->regions[l].lock);
+	r = __promote_or_release(&prison->regions[l].cell, cell);
+	spin_unlock_irq(&prison->regions[l].lock);
 
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
index 00323428919e..33ad5695f959 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1674,54 +1674,69 @@ static void break_up_discard_bio(struct thin_c *tc, dm_block_t begin, dm_block_t
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
-		if (r)
+		if (r) {
 			/*
 			 * Silently fail, letting any mappings we've
 			 * created complete.
 			 */
 			break;
-
-		build_key(tc->td, PHYSICAL, data_begin, data_begin + (virt_end - virt_begin), &data_key);
-		if (bio_detain(tc->pool, &data_key, NULL, &data_cell)) {
-			/* contention, we'll give up with this range */
-			begin = virt_end;
-			continue;
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
+		data_end = data_begin + (virt_end - virt_begin);
 
 		/*
-		 * The parent bio must not complete before sub discard bios are
-		 * chained to it (see end_discard's bio_chain)!
-		 *
-		 * This per-mapping bi_remaining increment is paired with
-		 * the implicit decrement that occurs via bio_endio() in
-		 * end_discard().
+		 * Make sure the data region obeys the bio prison restrictions.
 		 */
-		bio_inc_remaining(bio);
-		if (!dm_deferred_set_add_work(pool->all_io_ds, &m->list))
-			pool->process_prepared_discard(m);
+		while (data_begin < data_end) {
+			r = ensure_next_mapping(pool);
+			if (r)
+				return; /* we did our best */
+
+			next_boundary = ((data_begin >> BIO_PRISON_MAX_RANGE_SHIFT) + 1)
+				<< BIO_PRISON_MAX_RANGE_SHIFT;
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
+		}
 
 		begin = virt_end;
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

