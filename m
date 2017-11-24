Return-Path: <mlyle@lyle.org>
Return-Path: <mlyle@lyle.org>
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	Michael Lyle <mlyle@lyle.org>
Subject: [PATCH 4/4] bcache: check return value of register_shrinker
Date: Fri, 24 Nov 2017 15:14:27 -0800
Message-Id: <20171124231427.9563-5-mlyle@lyle.org>
In-Reply-To: <20171124231427.9563-1-mlyle@lyle.org>
References: <20171124231427.9563-1-mlyle@lyle.org>
List-ID: <linux-block@vger.kernel.org>

register_shrinker is now __must_check, so check it to kill a warning.
Caller of bch_btree_cache_alloc in super.c appropriately checks return
value so this is fully plumbed through.

This V2 fixes checkpatch warnings and improves the commit description,
as I was too hasty getting the previous version out.

Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Vojtech Pavlik <vojtech@suse.com>
---
 drivers/md/bcache/btree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 11c5503d31dc..81e8dc3dbe5e 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -807,7 +807,10 @@ int bch_btree_cache_alloc(struct cache_set *c)
 	c->shrink.scan_objects = bch_mca_scan;
 	c->shrink.seeks = 4;
 	c->shrink.batch = c->btree_pages * 2;
-	register_shrinker(&c->shrink);
+
+	if (register_shrinker(&c->shrink))
+		pr_warn("bcache: %s: could not register shrinker",
+				__func__);
 
 	return 0;
 }
-- 
2.14.1
