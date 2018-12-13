Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE0C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5052086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5052086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeLMOzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:55:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:51640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728612AbeLMOzr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:55:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1998AD5C;
        Thu, 13 Dec 2018 14:55:45 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 08/12] bcache: option to automatically run gc thread after writeback accomplished
Date:   Thu, 13 Dec 2018 22:53:53 +0800
Message-Id: <20181213145357.38528-9-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The option gc_after_writeback is disabled by default, because garbage
collection will discard SSD data which drops cached data.

Echo 1 into /sys/fs/bcache/<UUID>/internal/gc_after_writeback will enable
this option, which wakes up gc thread when writeback accomplished and all
cached data is clean.

This option is helpful for people who cares writing performance more.
In heavy writing workload, all cached data can be clean only happens when
writeback thread cleans all cached data in I/O idle time. In such
situation a following gc running may help to shrink bcache B+ tree and
discard more clean data, which may be helpful for future writing requests.

If you are not sure whether this is helpful for your own workload, please
leave it as disabled by default.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h    | 14 ++++++++++++++
 drivers/md/bcache/sysfs.c     |  9 +++++++++
 drivers/md/bcache/writeback.c | 27 +++++++++++++++++++++++++++
 drivers/md/bcache/writeback.h |  2 ++
 4 files changed, 52 insertions(+)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 96d2213f279e..fdf75352e16a 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -626,6 +626,20 @@ struct cache_set {
 	/* Where in the btree gc currently is */
 	struct bkey		gc_done;
 
+	/*
+	 * For automatical garbage collection after writeback completed, this
+	 * varialbe is used as bit fields,
+	 * - 0000 0001b (BCH_ENABLE_AUTO_GC): enable gc after writeback
+	 * - 0000 0010b (BCH_DO_AUTO_GC):     do gc after writeback
+	 * This is an optimization for following write request after writeback
+	 * finished, but read hit rate dropped due to clean data on cache is
+	 * discarded. Unless user explicitly sets it via sysfs, it won't be
+	 * enabled.
+	 */
+#define BCH_ENABLE_AUTO_GC	1
+#define BCH_DO_AUTO_GC		2
+	uint8_t			gc_after_writeback;
+
 	/*
 	 * The allocation code needs gc_mark in struct bucket to be correct, but
 	 * it's not while a gc is in progress. Protected by bucket_lock.
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index c09748497cdc..621186b4240f 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -128,6 +128,7 @@ rw_attribute(expensive_debug_checks);
 rw_attribute(cache_replacement_policy);
 rw_attribute(btree_shrinker_disabled);
 rw_attribute(copy_gc_enabled);
+rw_attribute(gc_after_writeback);
 rw_attribute(size);
 
 static ssize_t bch_snprint_string_list(char *buf,
@@ -693,6 +694,7 @@ SHOW(__bch_cache_set)
 	sysfs_printf(gc_always_rewrite,		"%i", c->gc_always_rewrite);
 	sysfs_printf(btree_shrinker_disabled,	"%i", c->shrinker_disabled);
 	sysfs_printf(copy_gc_enabled,		"%i", c->copy_gc_enabled);
+	sysfs_printf(gc_after_writeback,	"%i", c->gc_after_writeback);
 	sysfs_printf(io_disable,		"%i",
 		     test_bit(CACHE_SET_IO_DISABLE, &c->flags));
 
@@ -793,6 +795,12 @@ STORE(__bch_cache_set)
 	sysfs_strtoul(gc_always_rewrite,	c->gc_always_rewrite);
 	sysfs_strtoul(btree_shrinker_disabled,	c->shrinker_disabled);
 	sysfs_strtoul(copy_gc_enabled,		c->copy_gc_enabled);
+	/*
+	 * write gc_after_writeback here may overwrite an already set
+	 * BCH_DO_AUTO_GC, it doesn't matter because this flag will be
+	 * set in next chance.
+	 */
+	sysfs_strtoul_clamp(gc_after_writeback, c->gc_after_writeback, 0, 1);
 
 	return size;
 }
@@ -873,6 +881,7 @@ static struct attribute *bch_cache_set_internal_files[] = {
 	&sysfs_gc_always_rewrite,
 	&sysfs_btree_shrinker_disabled,
 	&sysfs_copy_gc_enabled,
+	&sysfs_gc_after_writeback,
 	&sysfs_io_disable,
 	NULL
 };
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 1696b212ec4e..73f0efac2b9f 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -17,6 +17,15 @@
 #include <linux/sched/clock.h>
 #include <trace/events/bcache.h>
 
+static void update_gc_after_writeback(struct cache_set *c)
+{
+	if (c->gc_after_writeback != (BCH_ENABLE_AUTO_GC) ||
+	    c->gc_stats.in_use < BCH_AUTO_GC_DIRTY_THRESHOLD)
+		return;
+
+	c->gc_after_writeback |= BCH_DO_AUTO_GC;
+}
+
 /* Rate limiting */
 static uint64_t __calc_target_rate(struct cached_dev *dc)
 {
@@ -191,6 +200,7 @@ static void update_writeback_rate(struct work_struct *work)
 		if (!set_at_max_writeback_rate(c, dc)) {
 			down_read(&dc->writeback_lock);
 			__update_writeback_rate(dc);
+			update_gc_after_writeback(c);
 			up_read(&dc->writeback_lock);
 		}
 	}
@@ -689,6 +699,23 @@ static int bch_writeback_thread(void *arg)
 				up_write(&dc->writeback_lock);
 				break;
 			}
+
+			/*
+			 * When dirty data rate is high (e.g. 50%+), there might
+			 * be heavy buckets fragmentation after writeback
+			 * finished, which hurts following write performance.
+			 * If users really care about write performance they
+			 * may set BCH_ENABLE_AUTO_GC via sysfs, then when
+			 * BCH_DO_AUTO_GC is set, garbage collection thread
+			 * will be wake up here. After moving gc, the shrunk
+			 * btree and discarded free buckets SSD space may be
+			 * helpful for following write requests.
+			 */
+			if (c->gc_after_writeback ==
+			    (BCH_ENABLE_AUTO_GC|BCH_DO_AUTO_GC)) {
+				c->gc_after_writeback &= ~BCH_DO_AUTO_GC;
+				force_wake_up_gc(c);
+			}
 		}
 
 		up_write(&dc->writeback_lock);
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index d2b9fdbc8994..ce63be98a39d 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -11,6 +11,8 @@
 #define WRITEBACK_RATE_UPDATE_SECS_MAX		60
 #define WRITEBACK_RATE_UPDATE_SECS_DEFAULT	5
 
+#define BCH_AUTO_GC_DIRTY_THRESHOLD	50
+
 /*
  * 14 (16384ths) is chosen here as something that each backing device
  * should be a reasonable fraction of the share, and not to blow up
-- 
2.16.4

