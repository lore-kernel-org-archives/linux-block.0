Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6956CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 04:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiKNE0v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Nov 2022 23:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiKNE0u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Nov 2022 23:26:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F735CE11
        for <linux-block@vger.kernel.org>; Sun, 13 Nov 2022 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PZPhHg+vYOWwk2HJPfw4QTMMVnk65Bm1h8rs7eub//o=; b=H/jDy0inG53HcE6sIlNNmeJa5/
        VSCRw/UEyXDwctA+IpZ2R03rRMIdGgqPa6QPwBrTeERDsV16D4o0+HLV0+1w18aJF0WI5VRMgXNhe
        ZLpS52+WncvTt4K4NeT1KBRNuD006wcsq8/B3QNPk4oUnqNfqpnTukYLbbf2YZ2HSvhS/61qXIk0X
        cNs/sS8cIqnpG4aBthwrLBsl/4ak1qELL3J8BISrKarGg9E+0NdsKzC4DAFwcC0Db0lJbgupPvcfH
        o3gXi3HgRJSrsGbEFpdtSyXcPkCGEdyaYGcQnbuQBsRUuxcV3zP6VNJY2xuTBaVntEmDXmpTLrAOL
        g3zDRjLg==;
Received: from [2001:4bb8:191:2606:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouR3X-00Fv6y-VE; Mon, 14 Nov 2022 04:26:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 3/5] block: fix error unwinding in blk_register_queue
Date:   Mon, 14 Nov 2022 05:26:35 +0100
Message-Id: <20221114042637.1009333-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114042637.1009333-1-hch@lst.de>
References: <20221114042637.1009333-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_register_queue fails to handle errors from blk_mq_sysfs_register,
leaks various resources on errors and accidentally sets queue refs percpu
refcount to percpu mode on kobject_add failure.  Fix all that by
properly unwinding on errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 197646d479b4a..abd1784ff05e3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -823,13 +823,15 @@ int blk_register_queue(struct gendisk *disk)
 	int ret;
 
 	mutex_lock(&q->sysfs_dir_lock);
-
 	ret = kobject_add(&q->kobj, &disk_to_dev(disk)->kobj, "queue");
 	if (ret < 0)
-		goto unlock;
+		goto out_unlock_dir;
 
-	if (queue_is_mq(q))
-		blk_mq_sysfs_register(disk);
+	if (queue_is_mq(q)) {
+		ret = blk_mq_sysfs_register(disk);
+		if (ret)
+			goto out_del_queue_kobj;
+	}
 	mutex_lock(&q->sysfs_lock);
 
 	mutex_lock(&q->debugfs_mutex);
@@ -841,17 +843,17 @@ int blk_register_queue(struct gendisk *disk)
 
 	ret = disk_register_independent_access_ranges(disk);
 	if (ret)
-		goto put_dev;
+		goto out_debugfs_remove;
 
 	if (q->elevator) {
 		ret = elv_register_queue(q, false);
 		if (ret)
-			goto put_dev;
+			goto out_unregister_ia_ranges;
 	}
 
 	ret = blk_crypto_sysfs_register(disk);
 	if (ret)
-		goto put_dev;
+		goto out_elv_unregister;
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	wbt_enable_default(q);
@@ -862,8 +864,6 @@ int blk_register_queue(struct gendisk *disk)
 	if (q->elevator)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
-
-unlock:
 	mutex_unlock(&q->sysfs_dir_lock);
 
 	/*
@@ -882,13 +882,17 @@ int blk_register_queue(struct gendisk *disk)
 
 	return ret;
 
-put_dev:
+out_elv_unregister:
 	elv_unregister_queue(q);
+out_unregister_ia_ranges:
 	disk_unregister_independent_access_ranges(disk);
+out_debugfs_remove:
+	blk_debugfs_remove(disk);
 	mutex_unlock(&q->sysfs_lock);
-	mutex_unlock(&q->sysfs_dir_lock);
+out_del_queue_kobj:
 	kobject_del(&q->kobj);
-
+out_unlock_dir:
+	mutex_unlock(&q->sysfs_dir_lock);
 	return ret;
 }
 
-- 
2.30.2

