Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C244C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1817B206A3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfDXQtu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730534AbfDXQtu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34289AF6A;
        Wed, 24 Apr 2019 16:49:49 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 13/18] bcache: Add comments for blkdev_put() in registration code path
Date:   Thu, 25 Apr 2019 00:48:38 +0800
Message-Id: <20190424164843.29535-14-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add comments to explain why in register_bcache() blkdev_put() won't
be called in two location. Add comments to explain why blkdev_put()
must be called in register_cache() when cache_alloc() failed.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/md/bcache/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index fde334939545..fa856b2ca7af 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2189,6 +2189,12 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
 
 	ret = cache_alloc(ca);
 	if (ret != 0) {
+		/*
+		 * If we failed here, it means ca->kobj is not initialized yet,
+		 * kobject_put() won't be called and there is no chance to
+		 * call blkdev_put() to bdev in bch_cache_release(). So we
+		 * explicitly call blkdev_put() here.
+		 */
 		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 		if (ret == -ENOMEM)
 			err = "cache_alloc(): -ENOMEM";
@@ -2329,6 +2335,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		mutex_lock(&bch_register_lock);
 		ret = register_bdev(sb, sb_page, bdev, dc);
 		mutex_unlock(&bch_register_lock);
+		/* blkdev_put() will be called in cached_dev_free() */
 		if (ret < 0)
 			goto err;
 	} else {
@@ -2337,6 +2344,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		if (!ca)
 			goto err_close;
 
+		/* blkdev_put() will be called in bch_cache_release() */
 		if (register_cache(sb, sb_page, bdev, ca) != 0)
 			goto err;
 	}
-- 
2.16.4

