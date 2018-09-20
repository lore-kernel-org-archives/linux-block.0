Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35818 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbeITTJd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Sep 2018 15:09:33 -0400
MIME-Version: 1.0
From: Junhui Tang <tang.junhui.linux@gmail.com>
Date: Thu, 20 Sep 2018 21:26:58 +0800
Message-ID: <CA+NNRhHpArYXt7YofXcH0h8yhcPvFhWC9ZKnRTcPhXziSPDHPg@mail.gmail.com>
Subject: [PATCH] bcache: add a command to show bcache topology
To: colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From 647ac21a0068df1fafb038a628791d2fcc135462 Mon Sep 17 00:00:00 2001
From: Tang Junhui <tang.junhui.linux@gmail.com>
Date: Fri, 21 Sep 2018 04:52:20 +0800
Subject: [PATCH] bcache: add a command to show bcache topology

This patch add a command to show bcache topology as bellow:
[root@ceph x86_64]# cat /sys/fs/bcache/show
( sdb ) : ( sdg:bcache4 sdf:bcache3 sde:bcache2 sdd:bcache1 sdc:bcache0 )
( sdh ) : ( sdm:bcache9 sdl:bcache8 sdk:bcache7 sdj:bcache6 sdi:bcache5 )
In the output result, each line shows cache devices in the first () and
its cached devices in the second (). By this command, we can be easily
to know cached device bcache4 base on backing device sdg and cache device
sdb, we also can see bcache0 bcache1 bcache2 bcache3 and bcache4 are in
the same cache set.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
---
 drivers/md/bcache/bcache.h |  3 +++
 drivers/md/bcache/super.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 05f82ff6..52ef9b3 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -881,6 +881,9 @@ static inline uint8_t bucket_gc_gen(struct bucket *b)
 #define kobj_attribute_write(n, fn) \
  static struct kobj_attribute ksysfs_##n = __ATTR(n, S_IWUSR, NULL, fn)

+#define kobj_attribute_read(n, fn) \
+ static struct kobj_attribute ksysfs_##n = __ATTR(n, 0400, fn, NULL)
+
 #define kobj_attribute_rw(n, show, store) \
  static struct kobj_attribute ksysfs_##n = \
  __ATTR(n, S_IWUSR|S_IRUSR, show, store)
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 55a3764..d0d5484 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2129,8 +2129,11 @@ static int register_cache(struct cache_sb *sb,
struct page *sb_page,

 static ssize_t register_bcache(struct kobject *, struct kobj_attribute *,
         const char *, size_t);
+static ssize_t show_bcache(struct kobject *, struct kobj_attribute *,
+        char *);

 kobj_attribute_write(register, register_bcache);
+kobj_attribute_read(show, show_bcache);
 kobj_attribute_write(register_quiet, register_bcache);

 static bool bch_is_open_backing(struct block_device *bdev) {
@@ -2246,6 +2249,52 @@ static ssize_t register_bcache(struct kobject
*k, struct kobj_attribute *attr,
  goto out;
 }

+static ssize_t show_bcache(struct kobject *k, struct kobj_attribute *attr,
+        char *buffer)
+{
+ unsigned int i;
+ struct cache_set *c, *tc;
+ struct cache *ca;
+ struct cached_dev *dc, *t;
+ ssize_t ret = 0;
+ bool uncached = false;
+ char name[BDEVNAME_SIZE];
+
+ if (!try_module_get(THIS_MODULE))
+ return -EBUSY;
+ mutex_lock(&bch_register_lock);
+
+ list_for_each_entry_safe(c, tc, &bch_cache_sets, list) {
+ ret += scnprintf(buffer + ret, PAGE_SIZE - ret, "%s", "(");
+ for_each_cache(ca, c, i)
+ ret += scnprintf(buffer + ret, PAGE_SIZE - ret, " %s",
+ bdevname(ca->bdev, name));
+ ret += scnprintf(buffer + ret, PAGE_SIZE - ret, "%s", " ) : (");
+ list_for_each_entry_safe(dc, t, &c->cached_devs, list)
+ ret += scnprintf(buffer + ret, PAGE_SIZE - ret,
+ " %s:%s",
+ bdevname(dc->bdev, name),
+ dc->disk.disk ? dc->disk.disk->disk_name : " ");
+ ret += scnprintf(buffer + ret, PAGE_SIZE - ret, "%s", " )\n");
+ }
+ list_for_each_entry_safe(dc, t, &uncached_devices, list) {
+ if (!uncached) {
+ ret += scnprintf(buffer + ret, PAGE_SIZE - ret,
+ "%s", "( ) : (");
+ uncached = true;
+ }
+ ret += scnprintf(buffer + ret, PAGE_SIZE - ret, " %s:%s",
+ bdevname(dc->bdev, name),
+ dc->disk.disk ? dc->disk.disk->disk_name : " ");
+ }
+ if (uncached)
+ ret += scnprintf(buffer + ret, PAGE_SIZE - ret, "%s", " )\n");
+
+ mutex_unlock(&bch_register_lock);
+ module_put(THIS_MODULE);
+ return ret;
+}
+
 static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
 {
  if (code == SYS_DOWN ||
@@ -2326,6 +2375,7 @@ static int __init bcache_init(void)
 {
  static const struct attribute *files[] = {
  &ksysfs_register.attr,
+ &ksysfs_show.attr,
  &ksysfs_register_quiet.attr,
  NULL
  };
-- 
1.8.3.1
