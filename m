Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727633AbeHJJxW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 05:53:22 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, shhuiw@foxmail.com,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 05/17] bcache: replace Symbolic permissions by octal permission numbers
Date: Fri, 10 Aug 2018 15:23:45 +0800
Message-Id: <20180810072357.19823-6-colyli@suse.de>
In-Reply-To: <20180810072357.19823-1-colyli@suse.de>
References: <20180810072357.19823-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Symbolic permission names are used in bcache, for now octal permission
numbers are encouraged to use for readability. This patch replaces
all symbolic permissions by octal permission numbers.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/bcache.h | 4 ++--
 drivers/md/bcache/sysfs.h  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 031a75a25d3e..66e6d5639b38 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -881,11 +881,11 @@ static inline uint8_t bucket_gc_gen(struct bucket *b)
 #define BUCKET_GC_GEN_MAX	96U
 
 #define kobj_attribute_write(n, fn)					\
-	static struct kobj_attribute ksysfs_##n = __ATTR(n, S_IWUSR, NULL, fn)
+	static struct kobj_attribute ksysfs_##n = __ATTR(n, 0200, NULL, fn)
 
 #define kobj_attribute_rw(n, show, store)				\
 	static struct kobj_attribute ksysfs_##n =			\
-		__ATTR(n, S_IWUSR|S_IRUSR, show, store)
+		__ATTR(n, 0600, show, store)
 
 static inline void wake_up_allocators(struct cache_set *c)
 {
diff --git a/drivers/md/bcache/sysfs.h b/drivers/md/bcache/sysfs.h
index b54fe9602529..3fe82425859c 100644
--- a/drivers/md/bcache/sysfs.h
+++ b/drivers/md/bcache/sysfs.h
@@ -44,9 +44,9 @@ STORE(fn)								\
 	static struct attribute sysfs_##_name =				\
 		{ .name = #_name, .mode = _mode }
 
-#define write_attribute(n)	__sysfs_attribute(n, S_IWUSR)
-#define read_attribute(n)	__sysfs_attribute(n, S_IRUGO)
-#define rw_attribute(n)		__sysfs_attribute(n, S_IRUGO|S_IWUSR)
+#define write_attribute(n)	__sysfs_attribute(n, 0200)
+#define read_attribute(n)	__sysfs_attribute(n, 0444)
+#define rw_attribute(n)		__sysfs_attribute(n, 0644)
 
 #define sysfs_printf(file, fmt, ...)					\
 do {									\
-- 
2.18.0
