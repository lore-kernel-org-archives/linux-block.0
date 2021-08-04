Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE0FC4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A41860F58
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhHDJpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhHDJpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 05:45:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFE0C0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FNjDu6YxZbFSYW2GYRBj5ZcH3kOMKWGqdNGAf4vr9Og=; b=NIAUOSbDw+xBXjfT4TDTdcSa9Q
        PQO3HpjNe4kgxaEUxX9dZpj4UEfVq03k6teHt1t4GJmEBfdIycHoMM+MY5Fd+L7pkw4pYoZz4ep9W
        2AeUvT5yZ52rvcx8pkV5JF6kYNDB5IMtquGBsxIxzlMsf0HT0nMpUCuF+U+sijI8xapkhiyEyuNUk
        5CZJWj00jbydrfisSWJFSVP/VpPoPveJfUdl0sepKMLJ7O9icIMMeSjw6GRvgoK8QyPjkv1IuwQh9
        FkOqszjQAVkvrwTATJS+4/rKxGmdIesRokcDTMRqWwmX1IiHhisqOlM8VNN/iF2cjkarvkU/A2ukb
        tJKcl7fw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBDRt-005e5C-5v; Wed, 04 Aug 2021 09:44:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 4/8] block: support delayed holder registration
Date:   Wed,  4 Aug 2021 11:41:43 +0200
Message-Id: <20210804094147.459763-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804094147.459763-1-hch@lst.de>
References: <20210804094147.459763-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

device mapper needs to register holders before it is ready to do I/O.
Currently it does so by registering the disk early, which can leave
the disk and queue in a weird half state where the queue is registered
with the disk, except for sysfs and the elevator.  And this state has
been a bit promlematic before, and will get more so when sorting out
the responsibilities between the queue and the disk.

Support registering holders on an initialized but not registered disk
instead by delaying the sysfs registration until the disk is registered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 block/genhd.c         | 10 +++++++
 block/holder.c        | 68 ++++++++++++++++++++++++++++++++-----------
 include/linux/genhd.h |  5 ++++
 3 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cd4eab744667..db916f779077 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -447,6 +447,16 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		kobject_create_and_add("holders", &ddev->kobj);
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 
+	/*
+	 * XXX: this is a mess, can't wait for real error handling in add_disk.
+	 * Make sure ->slave_dir is NULL if we failed some of the registration
+	 * so that the cleanup in bd_unlink_disk_holder works properly.
+	 */
+	if (bd_register_pending_holders(disk) < 0) {
+		kobject_put(disk->slave_dir);
+		disk->slave_dir = NULL;
+	}
+
 	if (disk->flags & GENHD_FL_HIDDEN)
 		return;
 
diff --git a/block/holder.c b/block/holder.c
index 11e65d99a9fb..4568cc4f6827 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -28,6 +28,19 @@ static void del_symlink(struct kobject *from, struct kobject *to)
 	sysfs_remove_link(from, kobject_name(to));
 }
 
+static int __link_disk_holder(struct block_device *bdev, struct gendisk *disk)
+{
+	int ret;
+
+	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
+	if (ret)
+		return ret;
+	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+	if (ret)
+		del_symlink(disk->slave_dir, bdev_kobj(bdev));
+	return ret;
+}
+
 /**
  * bd_link_disk_holder - create symlinks between holding disk and slave bdev
  * @bdev: the claimed slave bdev
@@ -66,7 +79,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	WARN_ON_ONCE(!bdev->bd_holder);
 
 	/* FIXME: remove the following once add_disk() handles errors */
-	if (WARN_ON(!disk->slave_dir || !bdev->bd_holder_dir))
+	if (WARN_ON(!bdev->bd_holder_dir))
 		goto out_unlock;
 
 	holder = bd_find_holder_disk(bdev, disk);
@@ -84,28 +97,28 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	INIT_LIST_HEAD(&holder->list);
 	holder->bdev = bdev;
 	holder->refcnt = 1;
-
-	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
-	if (ret)
-		goto out_free;
-
-	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-	if (ret)
-		goto out_del;
+	if (disk->slave_dir) {
+		ret = __link_disk_holder(bdev, disk);
+		if (ret) {
+			kfree(holder);
+			goto out_unlock;
+		}
+	}
 
 	list_add(&holder->list, &disk->slave_bdevs);
-	goto out_unlock;
-
-out_del:
-	del_symlink(disk->slave_dir, bdev_kobj(bdev));
-out_free:
-	kfree(holder);
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(bd_link_disk_holder);
 
+static void __unlink_disk_holder(struct block_device *bdev,
+		struct gendisk *disk)
+{
+	del_symlink(disk->slave_dir, bdev_kobj(bdev));
+	del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+}
+
 /**
  * bd_unlink_disk_holder - destroy symlinks created by bd_link_disk_holder()
  * @bdev: the calimed slave bdev
@@ -123,11 +136,32 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	mutex_lock(&disk->open_mutex);
 	holder = bd_find_holder_disk(bdev, disk);
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
-		del_symlink(disk->slave_dir, bdev_kobj(bdev));
-		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+		if (disk->slave_dir)
+			__unlink_disk_holder(bdev, disk);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
 	mutex_unlock(&disk->open_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
+
+int bd_register_pending_holders(struct gendisk *disk)
+{
+	struct bd_holder_disk *holder;
+	int ret;
+
+	mutex_lock(&disk->open_mutex);
+	list_for_each_entry(holder, &disk->slave_bdevs, list) {
+		ret = __link_disk_holder(holder->bdev, disk);
+		if (ret)
+			goto out_undo;
+	}
+	mutex_unlock(&disk->open_mutex);
+	return 0;
+
+out_undo:
+	list_for_each_entry_continue_reverse(holder, &disk->slave_bdevs, list)
+		__unlink_disk_holder(holder->bdev, disk);
+	mutex_unlock(&disk->open_mutex);
+	return ret;
+}
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 0721807d76ee..80952f038d79 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -323,6 +323,7 @@ long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
+int bd_register_pending_holders(struct gendisk *disk);
 #else
 static inline int bd_link_disk_holder(struct block_device *bdev,
 				      struct gendisk *disk)
@@ -333,6 +334,10 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 					 struct gendisk *disk)
 {
 }
+static inline int bd_register_pending_holders(struct gendisk *disk)
+{
+	return 0;
+}
 #endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
 
 dev_t part_devt(struct gendisk *disk, u8 partno);
-- 
2.30.2

