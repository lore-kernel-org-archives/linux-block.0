Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B57C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 15:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5BA20685
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 15:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5BA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437625AbeKWB75 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:59:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:45272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730517AbeKWB75 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 20:59:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E9DEADD7;
        Thu, 22 Nov 2018 15:20:06 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 4/5] bcache: make cutoff_writeback and cutoff_writeback_sync tunnable
Date:   Thu, 22 Nov 2018 23:19:23 +0800
Message-Id: <20181122151924.103644-5-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181122151924.103644-1-colyli@suse.de>
References: <20181122151924.103644-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the cutoff writeback and cutoff writeback sync thresholds are
defined by CUTOFF_WRITEBACK (40) and CUTOFF_WRITEBACK_SYNC (70) as static
values. Most of time these they work fine, but when people want to do
research on bcache writeback mode performance tuning, there is no chance
to modify the soft and hard cutoff writeback values.

This patch introduces two module parameters bch_cutoff_writeback_sync and
bch_cutoff_writeback which permit people to tune the values when loading
bcache.ko. If they are not specified by module loading, current values
CUTOFF_WRITEBACK_SYNC and CUTOFF_WRITEBACK will be used as default and
nothing changes.

When people want to tune this two values,
- cutoff_writeback can be set in range [1, 70]
- cutoff_writeback_sync can be set in range [1, 90]
- cutoff_writeback always <= cutoff_writeback_sync

The default values are strongly recommended to most of users for most of
workloads. Anyway, if people wants to take their own risk to do research
on new writeback cutoff tuning for their own workload, now they can
make it.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/md/bcache/sysfs.c     |  7 +++++++
 drivers/md/bcache/writeback.h | 10 ++++++++--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 61d3b63fa617..4dee119c3664 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -25,6 +25,9 @@
 #include <linux/reboot.h>
 #include <linux/sysfs.h>
 
+unsigned int bch_cutoff_writeback;
+unsigned int bch_cutoff_writeback_sync;
+
 static const char bcache_magic[] = {
 	0xc6, 0x85, 0x73, 0xf6, 0x4e, 0x1a, 0x45, 0xca,
 	0x82, 0x65, 0xf5, 0x7f, 0x48, 0xba, 0x6d, 0x81
@@ -2420,6 +2423,32 @@ static void bcache_exit(void)
 	mutex_destroy(&bch_register_lock);
 }
 
+/* Check and fixup module parameters */
+static void check_module_parameters(void)
+{
+	if (bch_cutoff_writeback_sync == 0)
+		bch_cutoff_writeback_sync = CUTOFF_WRITEBACK_SYNC;
+	else if (bch_cutoff_writeback_sync > CUTOFF_WRITEBACK_SYNC_MAX) {
+		pr_warn("set bch_cutoff_writeback_sync (%u) to max value %u",
+			bch_cutoff_writeback_sync, CUTOFF_WRITEBACK_SYNC_MAX);
+		bch_cutoff_writeback_sync = CUTOFF_WRITEBACK_SYNC_MAX;
+	}
+
+	if (bch_cutoff_writeback == 0)
+		bch_cutoff_writeback = CUTOFF_WRITEBACK;
+	else if (bch_cutoff_writeback > CUTOFF_WRITEBACK_MAX) {
+		pr_warn("set bch_cutoff_writeback (%u) to max value %u",
+			bch_cutoff_writeback, CUTOFF_WRITEBACK_MAX);
+		bch_cutoff_writeback = CUTOFF_WRITEBACK_MAX;
+	}
+
+	if (bch_cutoff_writeback > bch_cutoff_writeback_sync) {
+		pr_warn("set bch_cutoff_writeback (%u) to %u",
+			bch_cutoff_writeback, bch_cutoff_writeback_sync);
+		bch_cutoff_writeback = bch_cutoff_writeback_sync;
+	}
+}
+
 static int __init bcache_init(void)
 {
 	static const struct attribute *files[] = {
@@ -2428,6 +2457,8 @@ static int __init bcache_init(void)
 		NULL
 	};
 
+	check_module_parameters();
+
 	mutex_init(&bch_register_lock);
 	init_waitqueue_head(&unregister_wait);
 	register_reboot_notifier(&reboot);
@@ -2464,9 +2495,18 @@ static int __init bcache_init(void)
 	return -ENOMEM;
 }
 
+/*
+ * Module hooks
+ */
 module_exit(bcache_exit);
 module_init(bcache_init);
 
+module_param(bch_cutoff_writeback, uint, 0);
+MODULE_PARM_DESC(bch_cutoff_writeback, "threshold to cutoff writeback");
+
+module_param(bch_cutoff_writeback_sync, uint, 0);
+MODULE_PARM_DESC(bch_cutoff_writeback_sync, "hard threshold to cutoff writeback");
+
 MODULE_DESCRIPTION("Bcache: a Linux block layer cache");
 MODULE_AUTHOR("Kent Overstreet <kent.overstreet@gmail.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index a38a74dffda4..27fbc2dd1734 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -88,6 +88,8 @@ read_attribute(writeback_keys_done);
 read_attribute(writeback_keys_failed);
 read_attribute(io_errors);
 read_attribute(congested);
+read_attribute(cutoff_writeback);
+read_attribute(cutoff_writeback_sync);
 rw_attribute(congested_read_threshold_us);
 rw_attribute(congested_write_threshold_us);
 
@@ -669,6 +671,9 @@ SHOW(__bch_cache_set)
 	sysfs_print(congested_write_threshold_us,
 		    c->congested_write_threshold_us);
 
+	sysfs_print(cutoff_writeback, bch_cutoff_writeback);
+	sysfs_print(cutoff_writeback_sync, bch_cutoff_writeback_sync);
+
 	sysfs_print(active_journal_entries,	fifo_used(&c->journal.pin));
 	sysfs_printf(verify,			"%i", c->verify);
 	sysfs_printf(key_merging_disabled,	"%i", c->key_merging_disabled);
@@ -866,6 +871,8 @@ static struct attribute *bch_cache_set_internal_files[] = {
 	&sysfs_copy_gc_enabled,
 	&sysfs_gc_after_writeback,
 	&sysfs_io_disable,
+	&sysfs_cutoff_writeback,
+	&sysfs_cutoff_writeback_sync,
 	NULL
 };
 KTYPE(bch_cache_set_internal);
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index ce63be98a39d..6a743d3bb338 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -5,6 +5,9 @@
 #define CUTOFF_WRITEBACK	40
 #define CUTOFF_WRITEBACK_SYNC	70
 
+#define CUTOFF_WRITEBACK_MAX		70
+#define CUTOFF_WRITEBACK_SYNC_MAX	90
+
 #define MAX_WRITEBACKS_IN_PASS  5
 #define MAX_WRITESIZE_IN_PASS   5000	/* *512b */
 
@@ -55,6 +58,9 @@ static inline bool bcache_dev_stripe_dirty(struct cached_dev *dc,
 	}
 }
 
+extern unsigned int bch_cutoff_writeback;
+extern unsigned int bch_cutoff_writeback_sync;
+
 static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
 				    unsigned int cache_mode, bool would_skip)
 {
@@ -62,7 +68,7 @@ static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
 
 	if (cache_mode != CACHE_MODE_WRITEBACK ||
 	    test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags) ||
-	    in_use > CUTOFF_WRITEBACK_SYNC)
+	    in_use > bch_cutoff_writeback_sync)
 		return false;
 
 	if (dc->partial_stripes_expensive &&
@@ -75,7 +81,7 @@ static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
 
 	return (op_is_sync(bio->bi_opf) ||
 		bio->bi_opf & (REQ_META|REQ_PRIO) ||
-		in_use <= CUTOFF_WRITEBACK);
+		in_use <= bch_cutoff_writeback);
 }
 
 static inline void bch_writeback_queue(struct cached_dev *dc)
-- 
2.16.4

