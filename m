Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09E24677B
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198711; cv=none; b=bO9RI/RhKAJJCZyX2R79Btr4eNHu77npPkYjbr0Gu/O9LFat/yhifKTI2k8sHfblcf+OmN8+2XYHUIXGxMP8GJ/3J3vz+R9aVaX8g5zwnCdc9IAPlXCgiUmmW5/BW9NYsoZhiqodusxINTFVtxgP/sN6uGgzDRjg9XUOAj16sYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198711; c=relaxed/simple;
	bh=rAtQV/RwNJ/gUum9EHZD7wt/BKywfLSycmcOWsvv8Ek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3/Xan31XM0k1F7LLlOAzJM2jmqwcjasIyoY3GkCJsZ8i4t/8xc12bHBaiRy3l9VF0UTdpPC1AOpGdCZX8ib/mAb6PLPo75J7vhOXeCIUrLIng9M0qFKz0X19ahYETeFAxnNqKLVWS/nFaqNXW8wA8U/K5QQngLavILKc9pNj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtkQGOEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtkQGOEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCC7C19425;
	Fri, 27 Feb 2026 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198711;
	bh=rAtQV/RwNJ/gUum9EHZD7wt/BKywfLSycmcOWsvv8Ek=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZtkQGOElXE/3Bzrm5r+VzGh8sn4qCNjpE8cvPNOA0VYFCUkheY4wVNcMePS/WYI0B
	 LO+jYsk9mWDUsSK9Ti7Iyikfk/B/6xmmsAOD7tZzZi+4qIM5Fqw0zY5yjE7T1LYVEh
	 ZwWJ8V7LnbksP6izVlLCCswe4VVowQgTr0eaRZZ/uwN29d098A1bvE9r4cLfi3MVFS
	 mAWzBfFMAJzUkGSvW5hlLyt7OR/QUk1UEUmtu5Z0P3dB9lA1C5Un5Sis/qL701oy9l
	 go70jW9HIiNjJI9h9y2fT9meh0V8VcCdN7xcQoqDXsBICSmqlrz8THaMvx+Rad93uY
	 PU9GBVurbqY2A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v4 5/8] block: rename struct gendisk zone_wplugs_lock field
Date: Fri, 27 Feb 2026 22:19:48 +0900
Message-ID: <20260227131951.2464150-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227131951.2464150-1-dlemoal@kernel.org>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 23 ++++++++++++-----------
 include/linux/blkdev.h |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 26c2aa79faf6..78810e726222 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -514,10 +514,11 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
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
@@ -529,7 +530,7 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 	 * necessarilly in the active condition.
 	 */
 	zones_cond = rcu_dereference_check(disk->zones_cond,
-				lockdep_is_held(&disk->zone_wplugs_lock));
+				lockdep_is_held(&disk->zone_wplugs_hash_lock));
 	if (zones_cond)
 		zwplug->cond = zones_cond[zwplug->zone_no];
 	else
@@ -537,7 +538,7 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 
 	hlist_add_head_rcu(&zwplug->node, &disk->zone_wplugs_hash[idx]);
 	atomic_inc(&disk->nr_zone_wplugs);
-	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
+	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
 
 	return true;
 }
@@ -590,13 +591,13 @@ static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
 	WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
 	WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
 
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
 
 	call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
 }
@@ -1739,7 +1740,7 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 
 void disk_init_zone_resources(struct gendisk *disk)
 {
-	spin_lock_init(&disk->zone_wplugs_lock);
+	spin_lock_init(&disk->zone_wplugs_hash_lock);
 }
 
 /*
@@ -1829,10 +1830,10 @@ static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
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

