Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF637AA74
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079342; cv=none; b=HJ5LC8v1y7g8Xi37TlIuOGUHWer+eBgxjmMZLM47Jkp05BwnAmg07irChl1acVOYRRPEjmrVe1oBbPqZSnGr/suYjwYal8KKrjobIEazMUGoBQwmlEtd4F8aeIyChaOMDFD0HVO5sR+3pPtj6amu2GoMokT39eYVWq65Gpodsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079342; c=relaxed/simple;
	bh=J5NI2gUXtRHiseF8E9Lk2nXn5dq0y2ab1iBop8Aytw0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raEfEPb36LdnwHHvb8JYQo69GGY67e3C7P0yWhyp+2/yP+luKCLTSlrj0vIRw6tbl0BHoMUTKw09/4l1/A87tsHWPeeXb7mKsknhJlPtv+9KQux9KDmIA9PhrLX5qn/lZYBaNC/8vTJ4yfItxMnb6Dd8jkYYO6FKpB6uOlPLbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+s4OnX2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+s4OnX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0EBC19425;
	Thu, 26 Feb 2026 04:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079341;
	bh=J5NI2gUXtRHiseF8E9Lk2nXn5dq0y2ab1iBop8Aytw0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X+s4OnX2+HJ9NLcGoK327ZHeuXuSQ9fub3HCiRSBF2yWBnZIogm2hWPltywlLjJlB
	 VzTGUCtcrRzsWVhJbSdmmS0Zs9vef3caiX91rhf6keqRhB/YnhIYAc3r3pTbemEmqf
	 EIN84q4ONn4W4f16DPoO9vKYXNhkJbzG+iiQVEq5VQEo+USlTfoQkURAIbatpIFkzM
	 SS+02t1umKPXJIdfUzl77Nj3DWZsa3UJ3QWAf2IfMu0lndrnVGUZkWl4fjgSG6kUhi
	 crDoz/Qv5E18dwWwAlvrdFszEoox2UxWtzxdnPLcFQhhkTqxd+XVV8GyMnq5yB6NmF
	 D2b5gfqyNQY5Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 1/7] block: fix zone write plug removal
Date: Thu, 26 Feb 2026 13:10:18 +0900
Message-ID: <20260226041024.2154806-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226041024.2154806-1-dlemoal@kernel.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7b295187287e ("block: Do not remove zone write plugs still in
use") modified disk_should_remove_zone_wplug() to add a check on the
reference count of a zone write plug to prevent removing zone write
plugs from a disk hash table when the plugs are still being referenced
by BIOs or requests in-flight. However, this check does not take into
account that a BIO completion may happen right after its submission by
a zone write plug BIO work, and before the zone write plug BIO work
releases the zone write plug reference count. This situation leads to
disk_should_remove_zone_wplug() returning false as in this case the zone
write plug reference count is at least equal to 3. If the BIO that
completes in such manner transitioned the zone to the FULL condition,
the zone write plug for the FULL zone will remain in the disk hash
table.

Furthermore, relying on a particular value of a zone write plug
reference count to set the BLK_ZONE_WPLUG_UNHASHED flag is fragile as
reading the atomic reference count and doing a comparison with some
value is not overall atomic at all.

Address these issues by reworking the reference counting of zone write
plugs so that removing plugs from a disk hash table can be done
directly from disk_put_zone_wplug() when the last reference on a plug
is dropped.

To do so, replace the function disk_remove_zone_wplug() with
disk_mark_zone_wplug_dead(). This new function sets the zone write plug
flag BLK_ZONE_WPLUG_DEAD (which replaces BLK_ZONE_WPLUG_UNHASHED) and
drops the initial reference on the zone write plug taken when the plug
was added to the disk hash table. This function is called either for
zones that are empty or full, or directly in the case of a forced plug
removal (e.g. when the disk hash table is being destroyed on disk
removal). With this change, disk_should_remove_zone_wplug() is also
removed.

disk_put_zone_wplug() is modified to call the function
disk_free_zone_wplug() to remove a zone write plug from a disk hash
table and free the plug structure (with a call_rcu()), when the last
reference on a zone write plug is dropped. disk_free_zone_wplug()
always checks that the BLK_ZONE_WPLUG_DEAD flag is set.

In order to avoid having multiple zone write plugs for the same zone in
the disk hash table, disk_get_and_lock_zone_wplug() is modified to
restore to a normal state a zone write plug that is flagged with
BLK_ZONE_WPLUG_DEAD. To do so, the BLK_ZONE_WPLUG_DEAD flag is cleared
and the reference count of the zone write plug increased to restore the
initial reference on the zone write plug taken when the plug was added
to the disk hash table. This restores the dead plug to a normal state,
similar to a newly allocated plug.

Fixes: 7b295187287e ("block: Do not remove zone write plugs still in use")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 143 +++++++++++++++++-----------------------------
 1 file changed, 52 insertions(+), 91 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9d1dd6ccfad7..fd404bdd5fa2 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -99,17 +99,17 @@ static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
  *    being executed or the zone write plug bio list is not empty.
  *  - BLK_ZONE_WPLUG_NEED_WP_UPDATE: Indicates that we lost track of a zone
  *    write pointer offset and need to update it.
- *  - BLK_ZONE_WPLUG_UNHASHED: Indicates that the zone write plug was removed
- *    from the disk hash table and that the initial reference to the zone
- *    write plug set when the plug was first added to the hash table has been
- *    dropped. This flag is set when a zone is reset, finished or become full,
- *    to prevent new references to the zone write plug to be taken for
- *    newly incoming BIOs. A zone write plug flagged with this flag will be
- *    freed once all remaining references from BIOs or functions are dropped.
+ *  - BLK_ZONE_WPLUG_DEAD: Indicates that the zone write plug will be
+ *    removed from the disk hash table of zone write plugs when the last
+ *    reference on the zone write plug is dropped. If set, this flag also
+ *    indicates that the initial extra reference on the zone write plug was
+ *    dropped, meaning that the reference count indicates the current number of
+ *    active users (code context or BIOs and requests in flight). This flag is
+ *    set when a zone is reset, finished or becomes full.
  */
 #define BLK_ZONE_WPLUG_PLUGGED		(1U << 0)
 #define BLK_ZONE_WPLUG_NEED_WP_UPDATE	(1U << 1)
-#define BLK_ZONE_WPLUG_UNHASHED		(1U << 2)
+#define BLK_ZONE_WPLUG_DEAD		(1U << 2)
 
 /**
  * blk_zone_cond_str - Return a zone condition name string
@@ -587,64 +587,15 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
 }
 
-static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
-{
-	if (refcount_dec_and_test(&zwplug->ref)) {
-		WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
-		WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
-		WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_UNHASHED));
-
-		call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
-	}
-}
-
-static inline bool disk_should_remove_zone_wplug(struct gendisk *disk,
-						 struct blk_zone_wplug *zwplug)
-{
-	lockdep_assert_held(&zwplug->lock);
-
-	/* If the zone write plug was already removed, we are done. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
-		return false;
-
-	/* If the zone write plug is still plugged, it cannot be removed. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
-		return false;
-
-	/*
-	 * Completions of BIOs with blk_zone_write_plug_bio_endio() may
-	 * happen after handling a request completion with
-	 * blk_zone_write_plug_finish_request() (e.g. with split BIOs
-	 * that are chained). In such case, disk_zone_wplug_unplug_bio()
-	 * should not attempt to remove the zone write plug until all BIO
-	 * completions are seen. Check by looking at the zone write plug
-	 * reference count, which is 2 when the plug is unused (one reference
-	 * taken when the plug was allocated and another reference taken by the
-	 * caller context).
-	 */
-	if (refcount_read(&zwplug->ref) > 2)
-		return false;
-
-	/* We can remove zone write plugs for zones that are empty or full. */
-	return !zwplug->wp_offset || disk_zone_wplug_is_full(disk, zwplug);
-}
-
-static void disk_remove_zone_wplug(struct gendisk *disk,
-				   struct blk_zone_wplug *zwplug)
+static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
 {
+	struct gendisk *disk = zwplug->disk;
 	unsigned long flags;
 
-	/* If the zone write plug was already removed, we have nothing to do. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
-		return;
+	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_DEAD));
+	WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
+	WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
 
-	/*
-	 * Mark the zone write plug as unhashed and drop the extra reference we
-	 * took when the plug was inserted in the hash table. Also update the
-	 * disk zone condition array with the current condition of the zone
-	 * write plug.
-	 */
-	zwplug->flags |= BLK_ZONE_WPLUG_UNHASHED;
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
 	blk_zone_set_cond(rcu_dereference_check(disk->zones_cond,
 				lockdep_is_held(&disk->zone_wplugs_lock)),
@@ -652,7 +603,29 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
 	hlist_del_init_rcu(&zwplug->node);
 	atomic_dec(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
-	disk_put_zone_wplug(zwplug);
+
+	call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
+}
+
+static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
+{
+	if (refcount_dec_and_test(&zwplug->ref))
+		disk_free_zone_wplug(zwplug);
+}
+
+/*
+ * Flag the zone write plug as dead and drop the initial reference we got when
+ * the zone write plug was added to the hash table. The zone write plug will be
+ * unhashed when its last reference is dropped.
+ */
+static void disk_mark_zone_wplug_dead(struct blk_zone_wplug *zwplug)
+{
+	lockdep_assert_held(&zwplug->lock);
+
+	if (!(zwplug->flags & BLK_ZONE_WPLUG_DEAD)) {
+		zwplug->flags |= BLK_ZONE_WPLUG_DEAD;
+		disk_put_zone_wplug(zwplug);
+	}
 }
 
 static void blk_zone_wplug_bio_work(struct work_struct *work);
@@ -673,16 +646,16 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 	zwplug = disk_get_zone_wplug(disk, sector);
 	if (zwplug) {
 		/*
-		 * Check that a BIO completion or a zone reset or finish
-		 * operation has not already removed the zone write plug from
-		 * the hash table and dropped its reference count. In such case,
-		 * we need to get a new plug so start over from the beginning.
+		 * We already have a zone write plug. If it is flagged as dead,
+		 * its initial reference count was already dropped. In
+		 * this case, increment the reference count and clear the dead
+		 * flag to restore the plug to a state similar to a newly
+		 * allocated zone write plug.
 		 */
 		spin_lock_irqsave(&zwplug->lock, *flags);
-		if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED) {
-			spin_unlock_irqrestore(&zwplug->lock, *flags);
-			disk_put_zone_wplug(zwplug);
-			goto again;
+		if (zwplug->flags & BLK_ZONE_WPLUG_DEAD) {
+			refcount_inc(&zwplug->ref);
+			zwplug->flags &= ~BLK_ZONE_WPLUG_DEAD;
 		}
 		return zwplug;
 	}
@@ -788,14 +761,8 @@ static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 	disk_zone_wplug_update_cond(disk, zwplug);
 
 	disk_zone_wplug_abort(zwplug);
-
-	/*
-	 * The zone write plug now has no BIO plugged: remove it from the
-	 * hash table so that it cannot be seen. The plug will be freed
-	 * when the last reference is dropped.
-	 */
-	if (disk_should_remove_zone_wplug(disk, zwplug))
-		disk_remove_zone_wplug(disk, zwplug);
+	if (!zwplug->wp_offset || disk_zone_wplug_is_full(disk, zwplug))
+		disk_mark_zone_wplug_dead(zwplug);
 }
 
 static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
@@ -1527,7 +1494,7 @@ static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
 				    disk->disk_name, zwplug->zone_no);
 		disk_zone_wplug_abort(zwplug);
 	}
-	disk_remove_zone_wplug(disk, zwplug);
+	disk_mark_zone_wplug_dead(zwplug);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	disk_put_zone_wplug(zwplug);
@@ -1630,14 +1597,8 @@ static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 	}
 
 	zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
-
-	/*
-	 * If the zone is full (it was fully written or finished, or empty
-	 * (it was reset), remove its zone write plug from the hash table.
-	 */
-	if (disk_should_remove_zone_wplug(disk, zwplug))
-		disk_remove_zone_wplug(disk, zwplug);
-
+	if (!zwplug->wp_offset || disk_zone_wplug_is_full(disk, zwplug))
+		disk_mark_zone_wplug_dead(zwplug);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 }
 
@@ -1848,9 +1809,9 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 		while (!hlist_empty(&disk->zone_wplugs_hash[i])) {
 			zwplug = hlist_entry(disk->zone_wplugs_hash[i].first,
 					     struct blk_zone_wplug, node);
-			refcount_inc(&zwplug->ref);
-			disk_remove_zone_wplug(disk, zwplug);
-			disk_put_zone_wplug(zwplug);
+			spin_lock_irq(&zwplug->lock);
+			disk_mark_zone_wplug_dead(zwplug);
+			spin_unlock_irq(&zwplug->lock);
 		}
 	}
 
-- 
2.53.0

