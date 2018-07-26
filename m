Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: colyli@suse.de,
	axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH 5/9] bcache: do not assign in if condition register_bcache()
Date: Thu, 26 Jul 2018 12:17:37 +0800
Message-Id: <20180726041741.1669-6-colyli@suse.de>
In-Reply-To: <20180726041741.1669-1-colyli@suse.de>
References: <20180726041741.1669-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Florian Schmaus <flo@geekplace.eu>

Fixes an error condition reported by checkpatch.pl which is caused by
assigning a variable in an if condition.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index cea2a42ea276..093b3789ce05 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2165,8 +2165,12 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	if (!try_module_get(THIS_MODULE))
 		return -EBUSY;
 
-	if (!(path = kstrndup(buffer, size, GFP_KERNEL)) ||
-	    !(sb = kmalloc(sizeof(struct cache_sb), GFP_KERNEL)))
+	path = kstrndup(buffer, size, GFP_KERNEL);
+	if (!path)
+		goto err;
+
+	sb = kmalloc(sizeof(struct cache_sb), GFP_KERNEL);
+	if (!sb)
 		goto err;
 
 	err = "failed to open device";
-- 
2.17.1
