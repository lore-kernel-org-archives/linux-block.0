Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:49670 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBBDqp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Feb 2018 22:46:45 -0500
From: tang.junhui@zte.com.cn
To: colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: [PATCH] bcache: return attach error when no cache set exist
Date: Fri, 2 Feb 2018 11:49:14 +0800
Message-Id: <1517543354-3745-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

I attach a back-end device to a cache set, and the cache set is not
registered yet, this back-end device did not attach successfully, and no
error returned:
[root]# echo 87859280-fec6-4bcc-20df7ca8f86b > /sys/block/sde/bcache/attach
[root]#

In sysfs_attach(), the return value "v" is initialized to "size" in
the beginning, and if no cache set exist in bch_cache_sets, the "v" value
would not change any more, and return to sysfs, sysfs regard it as success
since the "size" is a positive number.

This patch fixes this issue by assigning "v" with "-ENOENT" in the
initialization.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index b418409..9c8fdd5 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -195,7 +195,7 @@
 {
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
 					     disk.kobj);
-	ssize_t v = size;
+	ssize_t v;
 	struct cache_set *c;
 	struct kobj_uevent_env *env;
 
@@ -270,6 +270,7 @@
 		if (bch_parse_uuid(buf, dc->sb.set_uuid) < 16)
 			return -EINVAL;
 
+		v = -ENOENT;
 		list_for_each_entry(c, &bch_cache_sets, list) {
 			v = bch_cached_dev_attach(dc, c);
 			if (!v)
@@ -277,7 +278,7 @@
 		}
 
 		pr_err("Can't attach %s: cache set not found", buf);
-		size = v;
+		return v;
 	}
 
 	if (attr == &sysfs_detach && dc->disk.c)
-- 
1.8.3.1
