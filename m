Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF75EC38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 15:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ3PcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJ3PcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 11:32:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83707B1D8
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QEkMe4yA7BRgDyHIScWawW3DXudnaQ0F4P9Wl9dPXa0=; b=xN7NWFnxxU9dHiwUnai+//9w/5
        P+71cotmzpZdmKkTmhIV/4Id+mRA0iD8kjaOITLM/zl0qGrFMorYopMQtvY9Av4KJi6jkwWErrdl0
        uUxR5FSti1zW8elflnuQ1KqOCSsz44gW0nobPzWeUqJjKjfTMOjnwQNgHAUrViyepntGf4kCifPxy
        UDJR8818574N8F3dXoae8vAz47QUSWHd6yImLYnSwhF9IUlt31xKp9ZjwTMqF6xMBlrGPosXx0oes
        IaHLn0rPnFq3Hf0+Knqu9hME86OVjx5yT6oZy32Z29te1YgcZozZgDC6uIPWBqxkxqpRU8ENXz22L
        OjwiSPnw==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opAHw-00HW0v-8r; Sun, 30 Oct 2022 15:31:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 6/7] block: remove delayed holder registration
Date:   Sun, 30 Oct 2022 16:31:18 +0100
Message-Id: <20221030153120.1045101-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030153120.1045101-1-hch@lst.de>
References: <20221030153120.1045101-1-hch@lst.de>
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
 block/genhd.c          |  4 ---
 block/holder.c         | 72 ++++++++++++------------------------------
 include/linux/blkdev.h |  5 ---
 3 files changed, 21 insertions(+), 60 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index aa0e2f5684543..97d2243f07827 100644
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
index 5283bc804cc14..dd9327b43ce05 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -29,19 +29,6 @@ static void del_symlink(struct kobject *from, struct kobject *to)
 	sysfs_remove_link(from, kobject_name(to));
 }
 
-static int __link_disk_holder(struct block_device *bdev, struct gendisk *disk)
-{
-	int ret;
-
-	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
-	if (ret)
-		return ret;
-	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-	if (ret)
-		del_symlink(disk->slave_dir, bdev_kobj(bdev));
-	return ret;
-}
-
 /**
  * bd_link_disk_holder - create symlinks between holding disk and slave bdev
  * @bdev: the claimed slave bdev
@@ -75,6 +62,9 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	struct bd_holder_disk *holder;
 	int ret = 0;
 
+	if (WARN_ON_ONCE(!disk->slave_dir))
+		return -EINVAL;
+
 	mutex_lock(&disk->open_mutex);
 
 	WARN_ON_ONCE(!bdev->bd_holder);
@@ -94,34 +84,32 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	INIT_LIST_HEAD(&holder->list);
 	holder->bdev = bdev;
 	holder->refcnt = 1;
-	if (disk->slave_dir) {
-		ret = __link_disk_holder(bdev, disk);
-		if (ret) {
-			kfree(holder);
-			goto out_unlock;
-		}
-	}
-
+	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
+	if (ret)
+		goto out_free_holder;
+	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+	if (ret)
+		goto out_del_symlink;
 	list_add(&holder->list, &disk->slave_bdevs);
+
 	/*
 	 * del_gendisk drops the initial reference to bd_holder_dir, so we need
 	 * to keep our own here to allow for cleanup past that point.
 	 */
 	kobject_get(bdev->bd_holder_dir);
+	mutex_unlock(&disk->open_mutex);
+	return 0;
 
+out_del_symlink:
+	del_symlink(disk->slave_dir, bdev_kobj(bdev));
+out_free_holder:
+	kfree(holder);
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(bd_link_disk_holder);
 
-static void __unlink_disk_holder(struct block_device *bdev,
-		struct gendisk *disk)
-{
-	del_symlink(disk->slave_dir, bdev_kobj(bdev));
-	del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-}
-
 /**
  * bd_unlink_disk_holder - destroy symlinks created by bd_link_disk_holder()
  * @bdev: the calimed slave bdev
@@ -136,11 +124,14 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
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
+		del_symlink(disk->slave_dir, bdev_kobj(bdev));
+		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
 		kobject_put(bdev->bd_holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
@@ -148,24 +139,3 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
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
index 57ed49f20d2eb..df45037815527 100644
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

