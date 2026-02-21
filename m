Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72431A05E
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634970; cv=none; b=Oe+jnR0dYOwv+w4ZhErcRJUct9kdC4DHlSkAMM+tYj4g9xN8CrVceBH/8LD2JtmuUw5QsuwLc0+liuqGS/hwuuyfGiggKgVKPzr8Hg01gV7P9lju0zOc1OmtyDRe9sTzdy9/5ItE9CFZKcVHCDePq+IKrAZDdBPcqXt6DGnH37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634970; c=relaxed/simple;
	bh=izQPxcRoa++tclAOWIWzS941z2LDIpQCRd/j0+JM6bg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfAO+ZcEkT9ojDRjVQ8cnmf7UJ1Qb5ohBVGlV/JGfF9rZTN37L2mMjqVULJo4KUleyVyGNVL5u2gyYE2S4M/J7FjiySt0b2pkTHExX8bC/I2ewI8TI6GVvaR1SwnSnADOwbt9JXQx88PEqfn2G/OX4OHwY2hdzKvTQBm33Bf8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+rMlTxa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+rMlTxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6171C116D0;
	Sat, 21 Feb 2026 00:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634969;
	bh=izQPxcRoa++tclAOWIWzS941z2LDIpQCRd/j0+JM6bg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R+rMlTxa/Q5AZajWXv3zcj9QPUKf010rpNAibTbcp3VmmkWJUYfscj8+VTHGZkPVa
	 1m+EZqJstm84IGyyc62SVEP123ivkecE9IdrNJy83clASsub++UsDrk+8LvYRZ08jI
	 LG+8oxdGbdKg9R3SFgRHqR6Z45hLVJ5oruOZdrdqk8Tvj/825BVLWY3e5Lo+kSY4GT
	 YHOqxz6ZHJUJX5ehX3G7IYqGnyRjxCLpitFcuBQ5M3hfush6f4aNoCPj1Wuz32YoXg
	 eWBVATp8CorITnbyw+fClgNhX/v/pa7/bvqtcHM5jogFEg/McIFisu7q9WbTcnM1Yl
	 yhQb1ojKS8lJA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/8] block: remove BLK_ZONE_WPLUG_UNHASHED
Date: Sat, 21 Feb 2026 09:44:05 +0900
Message-ID: <20260221004411.548482-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221004411.548482-1-dlemoal@kernel.org>
References: <20260221004411.548482-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detecting that a zone write plug has been removed from a disk hash table
can be done using hlist_unhashed(), so there is no need for the zone
write plug flag BLK_ZONE_WPLUG_UNHASHED. Remove this flag and convert
all tests using it to use hlist_unhashed().

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9c38497e7258..3dd50b2ba2bb 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -99,17 +99,9 @@ static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
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
  */
 #define BLK_ZONE_WPLUG_PLUGGED		(1U << 0)
 #define BLK_ZONE_WPLUG_NEED_WP_UPDATE	(1U << 1)
-#define BLK_ZONE_WPLUG_UNHASHED		(1U << 2)
 
 /**
  * blk_zone_cond_str - Return a zone condition name string
@@ -592,7 +584,7 @@ static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
 	if (refcount_dec_and_test(&zwplug->ref)) {
 		WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
 		WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
-		WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_UNHASHED));
+		WARN_ON_ONCE(!hlist_unhashed_lockless(&zwplug->node));
 
 		call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
 	}
@@ -603,14 +595,14 @@ static inline bool disk_should_remove_zone_wplug(struct gendisk *disk,
 {
 	lockdep_assert_held(&zwplug->lock);
 
-	/* If the zone write plug was already removed, we are done. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
-		return false;
-
 	/* If the zone write plug is still plugged, it cannot be removed. */
 	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
 		return false;
 
+	/* If the zone write plug was already removed, we have nothing to do. */
+	if (hlist_unhashed(&zwplug->node))
+		return false;
+
 	/*
 	 * Completions of BIOs with blk_zone_write_plug_bio_endio() may
 	 * happen after handling a request completion with
@@ -635,16 +627,14 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
 	unsigned long flags;
 
 	/* If the zone write plug was already removed, we have nothing to do. */
-	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
+	if (hlist_unhashed(&zwplug->node))
 		return;
 
 	/*
-	 * Mark the zone write plug as unhashed and drop the extra reference we
-	 * took when the plug was inserted in the hash table. Also update the
-	 * disk zone condition array with the current condition of the zone
-	 * write plug.
+	 * Update the disk zone condition array with the current condition of
+	 * the zone write plug and drop the extra reference we took when the
+	 * plug was inserted in the hash table.
 	 */
-	zwplug->flags |= BLK_ZONE_WPLUG_UNHASHED;
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
 	blk_zone_set_cond(rcu_dereference_check(disk->zones_cond,
 				lockdep_is_held(&disk->zone_wplugs_lock)),
@@ -702,7 +692,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 		 * we need to get a new plug so start over from the beginning.
 		 */
 		spin_lock_irqsave(&zwplug->lock, *flags);
-		if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED) {
+		if (hlist_unhashed(&zwplug->node)) {
 			spin_unlock_irqrestore(&zwplug->lock, *flags);
 			disk_put_zone_wplug(zwplug);
 			goto again;
-- 
2.53.0

