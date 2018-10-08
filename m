Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Dongbo Cao <cdbdyx@163.com>,
	Coly Li <colyli@suse.de>
Subject: [PATCH 15/15] bcache: panic fix for making cache device
Date: Mon,  8 Oct 2018 20:41:21 +0800
Message-Id: <20181008124121.20192-16-colyli@suse.de>
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
References: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Dongbo Cao <cdbdyx@163.com>

when the nbuckets of cache device is smaller than 1024, making cache
device will trigger BUG_ON in kernel, add a condition to avoid this.

Reported-by: nitroxis <n@nxs.re>
Signed-off-by: Dongbo Cao <cdbdyx@163.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2a362a7ba995..563f75686100 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2070,6 +2070,11 @@ static int cache_alloc(struct cache *ca)
 	 */
 	btree_buckets = ca->sb.njournal_buckets ?: 8;
 	free = roundup_pow_of_two(ca->sb.nbuckets) >> 10;
+	if (!free) {
+		ret = -EPERM;
+		err = "ca->sb.nbuckets is too small";
+		goto err_free;
+	}
 
 	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets,
 						GFP_KERNEL)) {
@@ -2147,6 +2152,7 @@ static int cache_alloc(struct cache *ca)
 err_prio_alloc:
 	free_fifo(&ca->free[RESERVE_BTREE]);
 err_btree_alloc:
+err_free:
 	module_put(THIS_MODULE);
 	if (err)
 		pr_notice("error %s: %s", ca->cache_dev_name, err);
@@ -2176,6 +2182,8 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
 		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 		if (ret == -ENOMEM)
 			err = "cache_alloc(): -ENOMEM";
+		else if (ret == -EPERM)
+			err = "cache_alloc(): cache device is too small";
 		else
 			err = "cache_alloc(): unknown error";
 		goto err;
-- 
2.19.0
