Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034212AbeE1PWS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 May 2018 11:22:18 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 2/4] bcache: Move couple of string arrays to sysfs.c
Date: Mon, 28 May 2018 15:37:42 +0800
Message-Id: <20180528073744.71258-3-colyli@suse.de>
In-Reply-To: <20180528073744.71258-1-colyli@suse.de>
References: <20180528073744.71258-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is couple of string arrays that are used exclusively in sysfs.c.
Move it to there and make them static.

Besides above, it will allow further clean up.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h |  2 --
 drivers/md/bcache/super.c  | 18 ------------------
 drivers/md/bcache/sysfs.c  | 18 ++++++++++++++++++
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index ba98547c4ca0..6220cbda55c1 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -958,8 +958,6 @@ void bch_prio_write(struct cache *);
 void bch_write_bdev_super(struct cached_dev *, struct closure *);
 
 extern struct workqueue_struct *bcache_wq;
-extern const char * const bch_cache_modes[];
-extern const char * const bch_stop_on_failure_modes[];
 extern struct mutex bch_register_lock;
 extern struct list_head bch_cache_sets;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a16b5b1df62a..bd438e96b742 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -37,24 +37,6 @@ static const char invalid_uuid[] = {
 	0xc8, 0x50, 0xfc, 0x5e, 0xcb, 0x16, 0xcd, 0x99
 };
 
-/* Default is -1; we skip past it for struct cached_dev's cache mode */
-const char * const bch_cache_modes[] = {
-	"default",
-	"writethrough",
-	"writeback",
-	"writearound",
-	"none",
-	NULL
-};
-
-/* Default is -1; we skip past it for stop_when_cache_set_failed */
-const char * const bch_stop_on_failure_modes[] = {
-	"default",
-	"auto",
-	"always",
-	NULL
-};
-
 static struct kobject *bcache_kobj;
 struct mutex bch_register_lock;
 LIST_HEAD(bch_cache_sets);
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index dfeef583ee50..0275450a0da9 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -16,6 +16,24 @@
 #include <linux/sort.h>
 #include <linux/sched/clock.h>
 
+/* Default is -1; we skip past it for struct cached_dev's cache mode */
+static const char * const bch_cache_modes[] = {
+	"default",
+	"writethrough",
+	"writeback",
+	"writearound",
+	"none",
+	NULL
+};
+
+/* Default is -1; we skip past it for stop_when_cache_set_failed */
+static const char * const bch_stop_on_failure_modes[] = {
+	"default",
+	"auto",
+	"always",
+	NULL
+};
+
 static const char * const cache_replacement_policies[] = {
 	"lru",
 	"fifo",
-- 
2.17.0
