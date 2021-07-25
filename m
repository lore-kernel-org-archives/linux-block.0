Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB863C4338F
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFF660F23
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhGYFQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jul 2021 01:16:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CBCC061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 22:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KikSCdbAQP9TqPLYjLBmPZSAZRosktGrZQsiXsIEqJg=; b=j5CDZYf9TarrcaL3IrkkC2mPn/
        uddzY4Qv6hMtb6eBzVP9Dhd60pZTH1c4hfZuW0h1PGNOo+DQCm/Zm1thrNrIAKZwUZr/ys8wuHNpf
        8t50HiacONY3ME3QLgGdxLKViDjmZ/o/VG8kCrLRBjDu8hY+eDnbSpQvw/sJTtRwUJsV5L/UcUKF3
        OlOwLk0Xd7iWcHmwtMwC91q4cNBmE+MlmzwslCB4VfpKNW4zzCVQ8GuCvkrOM0ceTFBclStBi85B0
        6wTgEjdlxEgVpQb199ojuMSrLxPAsJSjBznELk1qFyfGBmxf6TxQSHzvmlri6NPRVAQkhLK8wYQdg
        6sZ/Yr6A==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7X7b-00CpjX-QE; Sun, 25 Jul 2021 05:56:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 4/8] block: support delayed holder registration
Date:   Sun, 25 Jul 2021 07:54:54 +0200
Message-Id: <20210725055458.29008-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725055458.29008-1-hch@lst.de>
References: <20210725055458.29008-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

device mapper needs to register holders before it is ready to do I/O.
Currently it does so by registering the disk early, which has all kinds
of bad side effects.  Support registering holders on an initialized but
not registered disk instead by delaying the sysfs registration until the
disk is registered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 10 +++++++
 block/holder.c        | 68 ++++++++++++++++++++++++++++++++-----------
 include/linux/genhd.h |  5 ++++
 3 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e2708a4a7a47..e3d93b868ec5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -429,6 +429,16 @@ static void register_disk(struct device *parent, struct gendisk *disk,
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
index 26c8557e2714..dd95d53c75fa 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -321,6 +321,7 @@ long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
+int bd_register_pending_holders(struct gendisk *disk);
 #else
 static inline int bd_link_disk_holder(struct block_device *bdev,
 				      struct gendisk *disk)
@@ -331,6 +332,10 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
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

