Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55813A26F
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730962480; cv=none; b=MZ9LmBX+4YHmYt/NDh6O7WgJ9icNkJ/SJg/VPBQKHsHkdpEh5y01f7HpoGI39cpePWykKmnlmxGf9zEh8e568yPukZOrqWTYNqNeYnUAKfwrRJOIZr4eSbCo2yiSX5k0GkYztIIkocOxcwBh2RjleDoPaMTMXb/pFEDRel1n/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730962480; c=relaxed/simple;
	bh=67gwq1mACllqo3GzIiyCxfkqanNabRASjqwJyZCPITE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHu5/adWkUi8+0yDdx1fCTvpI7kcgdm7moHkGB4g92/MXRaZARZPTC7iaAzQo+dvj4ZoZ+ZP1e5S1OEEhF/IH0x6YTEw8taGg8vO0ahxq/W+jVk+G5pw/WRWTDz+LIcXZ6Y5sscG+kVk1e/5QgL6/DH+8ciNUxlTu7o0ohGl7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHAiH2Bx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHAiH2Bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A668C4CECC;
	Thu,  7 Nov 2024 06:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730962479;
	bh=67gwq1mACllqo3GzIiyCxfkqanNabRASjqwJyZCPITE=;
	h=From:To:Cc:Subject:Date:From;
	b=gHAiH2BxcDEZ6+JPz1XvrOwjOnhm9SDYke7Y1zAduAJKvQXgJu0DR1Xkzyhsq2sct
	 xOyHZ5yXg/1APObih6XK5Xn+Qyw9ubH5kHZUAEO/vuqVBwlnVvF6P0ifN68RilvJLr
	 S9IU1WkF5J/1OPbsZ1jWJMryIrOnOTCW9IJ0UjT4nPZXsUc0LYBB5GnGMm2WZgA9cn
	 GwbqfdW/x0FJfeNF2MseFTfzxBgj+vGrKHOrwbleq+8BL5AIjRNBQ1QVTNjXU+Svf6
	 TSbLotL5kqM9yc5j93N1s+WSqh0I8GcbEjYWJV9L8aiq4Fu5cMjffhrAao5/A+GcjU
	 P6WpzwiSPIr0Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: Switch to using refcount_t for zone write plugs
Date: Thu,  7 Nov 2024 15:54:38 +0900
Message-ID: <20241107065438.236348-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the raw atomic_t reference counting of zone write plugs with a
refcount_t.  No functional changes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411050650.ilIZa8S7-lkp@intel.com/
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 797a5d30ac01..70211751df16 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -18,7 +18,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
 #include <linux/spinlock.h>
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/mempool.h>
 
 #include "blk.h"
@@ -64,7 +64,7 @@ static const char *const zone_cond_name[] = {
 struct blk_zone_wplug {
 	struct hlist_node	node;
 	struct list_head	link;
-	atomic_t		ref;
+	refcount_t		ref;
 	spinlock_t		lock;
 	unsigned int		flags;
 	unsigned int		zone_no;
@@ -404,7 +404,7 @@ static struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
 
 	hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[idx], node) {
 		if (zwplug->zone_no == zno &&
-		    atomic_inc_not_zero(&zwplug->ref)) {
+		    refcount_inc_not_zero(&zwplug->ref)) {
 			rcu_read_unlock();
 			return zwplug;
 		}
@@ -425,7 +425,7 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 
 static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
 {
-	if (atomic_dec_and_test(&zwplug->ref)) {
+	if (refcount_dec_and_test(&zwplug->ref)) {
 		WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
 		WARN_ON_ONCE(!list_empty(&zwplug->link));
 		WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_UNHASHED));
@@ -456,7 +456,7 @@ static inline bool disk_should_remove_zone_wplug(struct gendisk *disk,
 	 * taken when the plug was allocated and another reference taken by the
 	 * caller context).
 	 */
-	if (atomic_read(&zwplug->ref) > 2)
+	if (refcount_read(&zwplug->ref) > 2)
 		return false;
 
 	/* We can remove zone write plugs for zones that are empty or full. */
@@ -526,7 +526,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 
 	INIT_HLIST_NODE(&zwplug->node);
 	INIT_LIST_HEAD(&zwplug->link);
-	atomic_set(&zwplug->ref, 2);
+	refcount_set(&zwplug->ref, 2);
 	spin_lock_init(&zwplug->lock);
 	zwplug->flags = 0;
 	zwplug->zone_no = zno;
@@ -617,7 +617,7 @@ static inline void disk_zone_wplug_set_error(struct gendisk *disk,
 	 * finished.
 	 */
 	zwplug->flags |= BLK_ZONE_WPLUG_ERROR;
-	atomic_inc(&zwplug->ref);
+	refcount_inc(&zwplug->ref);
 
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
 	list_add_tail(&zwplug->link, &disk->zone_wplugs_err_list);
@@ -1092,7 +1092,7 @@ static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
 	 * reference we take here.
 	 */
 	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
-	atomic_inc(&zwplug->ref);
+	refcount_inc(&zwplug->ref);
 	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
 }
 
@@ -1437,7 +1437,7 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 		while (!hlist_empty(&disk->zone_wplugs_hash[i])) {
 			zwplug = hlist_entry(disk->zone_wplugs_hash[i].first,
 					     struct blk_zone_wplug, node);
-			atomic_inc(&zwplug->ref);
+			refcount_inc(&zwplug->ref);
 			disk_remove_zone_wplug(disk, zwplug);
 			disk_put_zone_wplug(zwplug);
 		}
@@ -1851,7 +1851,7 @@ int queue_zone_wplugs_show(void *data, struct seq_file *m)
 			spin_lock_irqsave(&zwplug->lock, flags);
 			zwp_zone_no = zwplug->zone_no;
 			zwp_flags = zwplug->flags;
-			zwp_ref = atomic_read(&zwplug->ref);
+			zwp_ref = refcount_read(&zwplug->ref);
 			zwp_wp_offset = zwplug->wp_offset;
 			zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
 			spin_unlock_irqrestore(&zwplug->lock, flags);
-- 
2.47.0

