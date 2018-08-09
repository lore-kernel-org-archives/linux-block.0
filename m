Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727237AbeHIJIi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 05:08:38 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 12/17] bcache: fix code comments style
Date: Thu,  9 Aug 2018 14:43:15 +0800
Message-Id: <20180809064320.10229-13-colyli@suse.de>
In-Reply-To: <20180809064320.10229-1-colyli@suse.de>
References: <20180809064320.10229-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch fixes 3 style issues warned by checkpatch.pl,
- Comment lines are not aligned
- Comments use "/*" on subsequent lines
- Comment lines use a trailing "*/"

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index eac0d5d1ada3..a8b751ba3ebc 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -465,8 +465,8 @@ static struct uuid_entry *uuid_find_empty(struct cache_set *c)
  * Bucket priorities/gens:
  *
  * For each bucket, we store on disk its
-   * 8 bit gen
-   * 16 bit priority
+ *   8 bit gen
+ *  16 bit priority
  *
  * See alloc.c for an explanation of the gen. The priority is used to implement
  * lru (and in the future other) cache replacement policies; for most purposes
@@ -934,8 +934,10 @@ void bch_cached_dev_run(struct cached_dev *dc)
 
 	add_disk(d->disk);
 	bd_link_disk_holder(dc->bdev, dc->disk.disk);
-	/* won't show up in the uevent file, use udevadm monitor -e instead
-	 * only class / kset properties are persistent */
+	/*
+	 * won't show up in the uevent file, use udevadm monitor -e instead
+	 * only class / kset properties are persistent
+	 */
 	kobject_uevent_env(&disk_to_dev(d->disk)->kobj, KOBJ_CHANGE, env);
 	kfree(env[1]);
 	kfree(env[2]);
@@ -1104,8 +1106,9 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 		}
 	}
 
-	/* Deadlocks since we're called via sysfs...
-	sysfs_remove_file(&dc->kobj, &sysfs_attach);
+	/*
+	 * Deadlocks since we're called via sysfs...
+	 * sysfs_remove_file(&dc->kobj, &sysfs_attach);
 	 */
 
 	if (bch_is_zero(u->uuid, 16)) {
@@ -1468,9 +1471,10 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
 	if (test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
 		pr_info("CACHE_SET_IO_DISABLE already set");
 
-	/* XXX: we can be called from atomic context
-	acquire_console_sem();
-	*/
+	/*
+	 * XXX: we can be called from atomic context
+	 * acquire_console_sem();
+	 */
 
 	pr_err("bcache: error on %pU: ", c->sb.set_uuid);
 
-- 
2.18.0
