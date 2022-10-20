Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ED7C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 16:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiJTQri (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJTQra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 12:47:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877521B4C6C
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hkIuj+BzWlKJS6tRI+AQCsNX1NAYb4W4vpT99lyeYE0=; b=RxxzB96/GeG9IaOvRCgi/Ek2Ee
        H5vh4eaiaN+qngH5rUvN6l/jxMZ66U124WWNcjMZ0t52Orkut3IctiQvz1fPqmPJ3fCUyGKz4Gs8J
        HnI0JPpQHPL1zYkFDFSmCyNW001EcvFIZRUNh9mG3GwWoD8Qmay2bGh1mlf5L7x7L2pxS10EetNg+
        geTD9LddNnMzyF4EaZrFKFohgaH1aKvzsyoNdaS06bLnX2jcmMZdRddiFHcCS4BZ4OeNmTCZ92i3H
        zDl+5TtO3EOVelVxyAkcj4xwpnAR88Ke7YBRXMdRzq/9b6Y19WO0jAEPfAIt7BNVBl5B6dxpFuSkV
        ssJNRd8A==;
Received: from [205.220.129.26] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYhT-000WrM-Gs; Thu, 20 Oct 2022 16:47:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 6/6] block: remove delayed holder registration
Date:   Thu, 20 Oct 2022 09:46:05 -0700
Message-Id: <20221020164605.1764830-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020164605.1764830-1-hch@lst.de>
References: <20221020164605.1764830-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that dm has been fixed to track of holder registrations before
add_disk, the somewhat buggy block layer code can be safely removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          |  4 ----
 block/holder.c         | 40 +++++++++++-----------------------------
 include/linux/blkdev.h |  5 -----
 3 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cd90df6c775c2..7c86b161fbd0f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -478,10 +478,6 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		goto out_put_holder_dir;
 	}
 
-	ret = bd_register_pending_holders(disk);
-	if (ret < 0)
-		goto out_put_slave_dir;
-
 	ret = blk_register_queue(disk);
 	if (ret)
 		goto out_put_slave_dir;
diff --git a/block/holder.c b/block/holder.c
index 4923a77ebecdc..c183553503b07 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -79,6 +79,9 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	struct bd_holder_disk *holder;
 	int ret = 0;
 
+	if (WARN_ON_ONCE(!disk->slave_dir))
+		return -EINVAL;
+
 	mutex_lock(&disk->open_mutex);
 
 	WARN_ON_ONCE(!bdev->bd_holder);
@@ -98,12 +101,10 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	INIT_LIST_HEAD(&holder->list);
 	holder->bdev = bdev;
 	holder->refcnt = 1;
-	if (disk->slave_dir) {
-		ret = __link_disk_holder(bdev, disk);
-		if (ret) {
-			kfree(holder);
-			goto out_unlock;
-		}
+	ret = __link_disk_holder(bdev, disk);
+	if (ret) {
+		kfree(holder);
+		goto out_unlock;
 	}
 
 	list_add(&holder->list, &disk->slave_bdevs);
@@ -140,11 +141,13 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 {
 	struct bd_holder_disk *holder;
 
+	if (WARN_ON_ONCE(!disk->slave_dir))
+		return;
+
 	mutex_lock(&disk->open_mutex);
 	holder = bd_find_holder_disk(bdev, disk);
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
-		if (disk->slave_dir)
-			__unlink_disk_holder(bdev, disk);
+		__unlink_disk_holder(bdev, disk);
 		kobject_put(bdev->bd_holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
@@ -152,24 +155,3 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	mutex_unlock(&disk->open_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
-
-int bd_register_pending_holders(struct gendisk *disk)
-{
-	struct bd_holder_disk *holder;
-	int ret;
-
-	mutex_lock(&disk->open_mutex);
-	list_for_each_entry(holder, &disk->slave_bdevs, list) {
-		ret = __link_disk_holder(holder->bdev, disk);
-		if (ret)
-			goto out_undo;
-	}
-	mutex_unlock(&disk->open_mutex);
-	return 0;
-
-out_undo:
-	list_for_each_entry_continue_reverse(holder, &disk->slave_bdevs, list)
-		__unlink_disk_holder(holder->bdev, disk);
-	mutex_unlock(&disk->open_mutex);
-	return ret;
-}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d986..5a208d6def879 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -839,7 +839,6 @@ void set_capacity(struct gendisk *disk, sector_t size);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
-int bd_register_pending_holders(struct gendisk *disk);
 #else
 static inline int bd_link_disk_holder(struct block_device *bdev,
 				      struct gendisk *disk)
@@ -850,10 +849,6 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 					 struct gendisk *disk)
 {
 }
-static inline int bd_register_pending_holders(struct gendisk *disk)
-{
-	return 0;
-}
 #endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
 
 dev_t part_devt(struct gendisk *disk, u8 partno);
-- 
2.30.2

