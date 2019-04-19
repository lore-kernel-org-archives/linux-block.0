Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5BFC282E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFB4222CC
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfDSSYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:24:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727871AbfDSSXr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21C9AAFBB;
        Fri, 19 Apr 2019 16:05:56 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 09/16] bcache: add error check for calling register_bdev()
Date:   Sat, 20 Apr 2019 00:05:02 +0800
Message-Id: <20190419160509.66298-10-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190419160509.66298-1-colyli@suse.de>
References: <20190419160509.66298-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds return value to register_bdev(). Then if failure happens
inside register_bdev(), its caller register_bcache() may detect and
handle the failure more properly.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 400af446c372..a435c506edba 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1281,7 +1281,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 
 /* Cached device - bcache superblock */
 
-static void register_bdev(struct cache_sb *sb, struct page *sb_page,
+static int register_bdev(struct cache_sb *sb, struct page *sb_page,
 				 struct block_device *bdev,
 				 struct cached_dev *dc)
 {
@@ -1319,10 +1319,11 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
 	    BDEV_STATE(&dc->sb) == BDEV_STATE_STALE)
 		bch_cached_dev_run(dc);
 
-	return;
+	return 0;
 err:
 	pr_notice("error %s: %s", dc->backing_dev_name, err);
 	bcache_device_stop(&dc->disk);
+	return -EIO;
 }
 
 /* Flash only volumes */
@@ -2273,7 +2274,7 @@ static bool bch_is_open(struct block_device *bdev)
 static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			       const char *buffer, size_t size)
 {
-	ssize_t ret = size;
+	ssize_t ret = -EINVAL;
 	const char *err = "cannot allocate memory";
 	char *path = NULL;
 	struct cache_sb *sb = NULL;
@@ -2307,7 +2308,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			if (!IS_ERR(bdev))
 				bdput(bdev);
 			if (attr == &ksysfs_register_quiet)
-				goto out;
+				goto quiet_out;
 		}
 		goto err;
 	}
@@ -2328,8 +2329,10 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			goto err_close;
 
 		mutex_lock(&bch_register_lock);
-		register_bdev(sb, sb_page, bdev, dc);
+		ret = register_bdev(sb, sb_page, bdev, dc);
 		mutex_unlock(&bch_register_lock);
+		if (ret < 0)
+			goto err;
 	} else {
 		struct cache *ca = kzalloc(sizeof(*ca), GFP_KERNEL);
 
@@ -2339,6 +2342,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		if (register_cache(sb, sb_page, bdev, ca) != 0)
 			goto err;
 	}
+quiet_out:
+	ret = size;
 out:
 	if (sb_page)
 		put_page(sb_page);
@@ -2351,7 +2356,6 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 err:
 	pr_info("error %s: %s", path, err);
-	ret = -EINVAL;
 	goto out;
 }
 
-- 
2.16.4

