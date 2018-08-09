Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 04/10] bcache: add a comment in super.c
Date: Thu,  9 Aug 2018 15:48:45 +0800
Message-Id: <20180809074851.11027-5-colyli@suse.de>
In-Reply-To: <20180809074851.11027-1-colyli@suse.de>
References: <20180809074851.11027-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

This patch adds a line of code comment in super.c:register_bdev(), to
make code to be more comprehensible.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index c7ffa6ef3f82..f517d7d1fa10 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1291,6 +1291,7 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
 	pr_info("registered backing device %s", dc->backing_dev_name);
 
 	list_add(&dc->list, &uncached_devices);
+	/* attch to a matched cache set if it exists */
 	list_for_each_entry(c, &bch_cache_sets, list)
 		bch_cached_dev_attach(dc, c, NULL);
 
-- 
2.18.0
