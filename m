Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: colyli@suse.de,
	axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH 7/9] bcache: do not assign in if condition in bcache_init()
Date: Thu, 26 Jul 2018 12:17:39 +0800
Message-Id: <20180726041741.1669-8-colyli@suse.de>
In-Reply-To: <20180726041741.1669-1-colyli@suse.de>
References: <20180726041741.1669-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Florian Schmaus <flo@geekplace.eu>

Fixes an error condition reported by checkpatch.pl which is caused by
assigning a variable in an if condition.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 093b3789ce05..a852018964ad 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2330,9 +2330,15 @@ static int __init bcache_init(void)
 		return bcache_major;
 	}
 
-	if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
-	    !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
-	    bch_request_init() ||
+	bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0);
+	if (!bcache_wq)
+		goto err;
+
+	bcache_kobj = kobject_create_and_add("bcache", fs_kobj);
+	if (!bcache_kobj)
+		goto err;
+
+	if (bch_request_init() ||
 	    bch_debug_init(bcache_kobj) || closure_debug_init() ||
 	    sysfs_create_files(bcache_kobj, files))
 		goto err;
-- 
2.17.1
