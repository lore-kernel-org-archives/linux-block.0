Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3828AC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B2F2086D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfF1MAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:00:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbfF1MAw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:00:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB082B627;
        Fri, 28 Jun 2019 12:00:50 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 10/37] bcache: add return value check to bch_cached_dev_run()
Date:   Fri, 28 Jun 2019 19:59:33 +0800
Message-Id: <20190628120000.40753-11-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds return value check to bch_cached_dev_run(), now if there
is error happens inside bch_cached_dev_run(), it can be catched.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h |  2 +-
 drivers/md/bcache/super.c  | 33 ++++++++++++++++++++++++++-------
 drivers/md/bcache/sysfs.c  |  7 +++++--
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index fdf75352e16a..73a97586a2ef 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -1006,7 +1006,7 @@ int bch_flash_dev_create(struct cache_set *c, uint64_t size);
 int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 			  uint8_t *set_uuid);
 void bch_cached_dev_detach(struct cached_dev *dc);
-void bch_cached_dev_run(struct cached_dev *dc);
+int bch_cached_dev_run(struct cached_dev *dc);
 void bcache_device_stop(struct bcache_device *d);
 
 void bch_cache_set_unregister(struct cache_set *c);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 73466bda12a7..0abee44092bf 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -910,7 +910,7 @@ static int cached_dev_status_update(void *arg)
 }
 
 
-void bch_cached_dev_run(struct cached_dev *dc)
+int bch_cached_dev_run(struct cached_dev *dc)
 {
 	struct bcache_device *d = &dc->disk;
 	char *buf = kmemdup_nul(dc->sb.label, SB_LABEL_SIZE, GFP_KERNEL);
@@ -921,11 +921,14 @@ void bch_cached_dev_run(struct cached_dev *dc)
 		NULL,
 	};
 
+	if (dc->io_disable)
+		return -EIO;
+
 	if (atomic_xchg(&dc->running, 1)) {
 		kfree(env[1]);
 		kfree(env[2]);
 		kfree(buf);
-		return;
+		return -EBUSY;
 	}
 
 	if (!d->c &&
@@ -951,8 +954,11 @@ void bch_cached_dev_run(struct cached_dev *dc)
 	kfree(buf);
 
 	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
-	    sysfs_create_link(&disk_to_dev(d->disk)->kobj, &d->kobj, "bcache"))
+	    sysfs_create_link(&disk_to_dev(d->disk)->kobj,
+			      &d->kobj, "bcache")) {
 		pr_debug("error creating sysfs link");
+		return -ENOMEM;
+	}
 
 	dc->status_update_thread = kthread_run(cached_dev_status_update,
 					       dc, "bcache_status_update");
@@ -961,6 +967,8 @@ void bch_cached_dev_run(struct cached_dev *dc)
 			"continue to run without monitoring backing "
 			"device status");
 	}
+
+	return 0;
 }
 
 /*
@@ -1056,6 +1064,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 	uint32_t rtime = cpu_to_le32((u32)ktime_get_real_seconds());
 	struct uuid_entry *u;
 	struct cached_dev *exist_dc, *t;
+	int ret = 0;
 
 	if ((set_uuid && memcmp(set_uuid, c->sb.set_uuid, 16)) ||
 	    (!set_uuid && memcmp(dc->sb.set_uuid, c->sb.set_uuid, 16)))
@@ -1165,7 +1174,12 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 
 	bch_sectors_dirty_init(&dc->disk);
 
-	bch_cached_dev_run(dc);
+	ret = bch_cached_dev_run(dc);
+	if (ret && (ret != -EBUSY)) {
+		up_write(&dc->writeback_lock);
+		return ret;
+	}
+
 	bcache_device_link(&dc->disk, c, "bdev");
 	atomic_inc(&c->attached_dev_nr);
 
@@ -1292,6 +1306,7 @@ static int register_bdev(struct cache_sb *sb, struct page *sb_page,
 {
 	const char *err = "cannot allocate memory";
 	struct cache_set *c;
+	int ret = -ENOMEM;
 
 	bdevname(bdev, dc->backing_dev_name);
 	memcpy(&dc->sb, sb, sizeof(struct cache_sb));
@@ -1321,14 +1336,18 @@ static int register_bdev(struct cache_sb *sb, struct page *sb_page,
 		bch_cached_dev_attach(dc, c, NULL);
 
 	if (BDEV_STATE(&dc->sb) == BDEV_STATE_NONE ||
-	    BDEV_STATE(&dc->sb) == BDEV_STATE_STALE)
-		bch_cached_dev_run(dc);
+	    BDEV_STATE(&dc->sb) == BDEV_STATE_STALE) {
+		err = "failed to run cached device";
+		ret = bch_cached_dev_run(dc);
+		if (ret)
+			goto err;
+	}
 
 	return 0;
 err:
 	pr_notice("error %s: %s", dc->backing_dev_name, err);
 	bcache_device_stop(&dc->disk);
-	return -EIO;
+	return ret;
 }
 
 /* Flash only volumes */
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 760cf8951338..eb678e43ac00 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -325,8 +325,11 @@ STORE(__cached_dev)
 		bch_cache_accounting_clear(&dc->accounting);
 
 	if (attr == &sysfs_running &&
-	    strtoul_or_return(buf))
-		bch_cached_dev_run(dc);
+	    strtoul_or_return(buf)) {
+		v = bch_cached_dev_run(dc);
+		if (v)
+			return v;
+	}
 
 	if (attr == &sysfs_cache_mode) {
 		v = sysfs_match_string(bch_cache_modes, buf);
-- 
2.16.4

