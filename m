Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91702836F
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634971; cv=none; b=Qn3it5HYn6rjhlJ7y6pHjREEV7D0z9SONsN4xs8++t2B3GvegN95v+XZPDeA+1CU+pDVANXOVthoCurfKKJqh4VcjZiyfcWmy26W153nihSxJSOohcO325vjHaGH7uZQdKuQwf35UsLJ1Bp5NZ/Tek3edSoIMl+KX7z087hKyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634971; c=relaxed/simple;
	bh=XlBEzIL+fw22vQXFDzUeQva9ROmitPWQsJxZWWgyN5E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/f12AK4fPyPwJJpR2/yUIz4WdCvQEp6ShYHp/Q5Hi2SsjdmyP1eiM5TrYNktJllfnL59Ny6/Ilfx65JNVlHnsy4FDTIGqXYk+QpG6uaMZXGzfEZagTb76u4vmebC5s26qPSNII4HqWKjoM3NFJ+nanKZ85Ke4rDv67MtdTpO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Wti/Qf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Wti/Qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69225C116D0;
	Sat, 21 Feb 2026 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634971;
	bh=XlBEzIL+fw22vQXFDzUeQva9ROmitPWQsJxZWWgyN5E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c3Wti/QfAcQx2g614X8MxuTSRgWaMH7rA/jcnfpIMBvgOLheFqOMzQOKX//aCY7zk
	 lqV4DqnA3lSkSiTKiUKCZqZ9DYIVEsbcWJhDWTNMWdb4NIctrVrgATNqS1rKFCW+x6
	 vVFAKTxrZUcvYNwnN8VBbRjKG4Nqr899PLTKXCW8bWyjl1tFwOHib2sjlOoNdWzy6B
	 6sfODLgzFpqcyG/vocE3nwyneHhlLMlBKGCVwf5l0aU3JI7dTPmUIxEISgnqwETQk+
	 RLMMXN55X3zGneNYlulMRLviFSfAol9yToUoxfH0p7fm3y36tLc55AL5J8STB+AnC8
	 S/fE4+aOXzzIA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 5/8] block: rename struct gendisk zone_wplugs_lock field
Date: Sat, 21 Feb 2026 09:44:08 +0900
Message-ID: <20260221004411.548482-6-dlemoal@kernel.org>
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

Rename struct gendisk zone_wplugs_lock field to zone_wplugs_hash_lock to
clearly indicates that this is the spinlock used for manipulating the
hash table of zone write plugs.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 23 ++++++++++++-----------
 include/linux/blkdev.h |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4b388ae1acaa..ee77330e14e2 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -506,10 +506,11 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 	 * are racing with other submission context, so we may already have a
 	 * zone write plug for the same zone.
 	 */
-	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+	spin_lock_irqsave(&disk->zone_wplugs_hash_lock, flags);
 	hlist_for_each_entry_rcu(zwplg, &disk->zone_wplugs_hash[idx], node) {
 		if (zwplg->zone_no == zwplug->zone_no) {
-			spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
+			spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock,
+					       flags);
 			return false;
 		}
 	}
@@ -521,7 +522,7 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 	 * necessarilly in the active condition.
 	 */
 	zones_cond = rcu_dereference_check(disk->zones_cond,
-				lockdep_is_held(&disk->zone_wplugs_lock));
+				lockdep_is_held(&disk->zone_wplugs_hash_lock));
 	if (zones_cond)
 		zwplug->cond = zones_cond[zwplug->zone_no];
 	else
@@ -529,7 +530,7 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 
 	hlist_add_head_rcu(&zwplug->node, &disk->zone_wplugs_hash[idx]);
 	atomic_inc(&disk->nr_zone_wplugs);
-	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
+	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
 
 	return true;
 }
@@ -629,13 +630,13 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
 	 * the zone write plug and drop the extra reference we took when the
 	 * plug was inserted in the hash table.
 	 */
-	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+	spin_lock_irqsave(&disk->zone_wplugs_hash_lock, flags);
 	blk_zone_set_cond(rcu_dereference_check(disk->zones_cond,
-				lockdep_is_held(&disk->zone_wplugs_lock)),
+				lockdep_is_held(&disk->zone_wplugs_hash_lock)),
 			  zwplug->zone_no, zwplug->cond);
 	hlist_del_init_rcu(&zwplug->node);
 	atomic_dec(&disk->nr_zone_wplugs);
-	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
+	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
 	disk_put_zone_wplug(zwplug);
 }
 
@@ -1784,7 +1785,7 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 
 void disk_init_zone_resources(struct gendisk *disk)
 {
-	spin_lock_init(&disk->zone_wplugs_lock);
+	spin_lock_init(&disk->zone_wplugs_hash_lock);
 }
 
 /*
@@ -1874,10 +1875,10 @@ static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+	spin_lock_irqsave(&disk->zone_wplugs_hash_lock, flags);
 	zones_cond = rcu_replace_pointer(disk->zones_cond, zones_cond,
-				lockdep_is_held(&disk->zone_wplugs_lock));
-	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
+				lockdep_is_held(&disk->zone_wplugs_hash_lock));
+	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
 
 	kfree_rcu_mightsleep(zones_cond);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d463b9b5a0a5..689090023770 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -200,7 +200,7 @@ struct gendisk {
 	u8 __rcu		*zones_cond;
 	unsigned int		zone_wplugs_hash_bits;
 	atomic_t		nr_zone_wplugs;
-	spinlock_t		zone_wplugs_lock;
+	spinlock_t		zone_wplugs_hash_lock;
 	struct mempool		*zone_wplugs_pool;
 	struct hlist_head	*zone_wplugs_hash;
 	struct workqueue_struct *zone_wplugs_wq;
-- 
2.53.0

