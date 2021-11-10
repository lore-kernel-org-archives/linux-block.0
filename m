Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F53DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 09:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574B8611F2
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 09:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhKJJ7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:59:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJJ7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 04:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636538218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7mD/gMeFasrqBd75QCYdV3SBahZEqnqh6dt0KHDOo8Q=;
        b=IOmP7yzn8ftgOeyM2dYvUw9xQ+4V1sK3WHR+I0iAnfEEXslf4hBjpzR65lX3kiEtpmZcpW
        dE6vX7u1kcIDp9k/zPNgHjvp1JduRkv/mJOEqIEwYQRVMubgKgMPsUlGZXBjurZJrQSZ5T
        R3hJqGRICeBUTV/HoHyjoJu5qpTcGLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-DU4gV1YlMpa_tjuCVsJgJA-1; Wed, 10 Nov 2021 04:56:53 -0500
X-MC-Unique: DU4gV1YlMpa_tjuCVsJgJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 758671030C20;
        Wed, 10 Nov 2021 09:56:52 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9767156A86;
        Wed, 10 Nov 2021 09:56:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        czhong@redhat.com
Subject: [PATCH] block: avoid to touch unloaded module instance when opening bdev
Date:   Wed, 10 Nov 2021 17:55:11 +0800
Message-Id: <20211110095511.294645-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk->fops->owner is grabbed in blkdev_get_no_open() after the disk
kobject refcount is increased. This way can't make sure that
disk->fops->owner is still alive since del_gendisk() still can move
on if the kobject refcount of disk is grabbed by open() and ->open()
isn't called yet.

Fixes the issue by moving try_module_get() into blkdev_get_by_dev()
with ->open_mutex() held, then we can drain the in-progress open()
in del_gendisk(). Meantime new open() won't succeed because disk
becomes not alive.

This way is reasonable because blkdev_get_no_open() doesn't need
to grab disk->fops->owner which is required only if callback in
disk->fops is needed.

Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Cc: czhong@redhat.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bdev.c  | 12 +++++++-----
 block/genhd.c |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b4dab2fb6a74..b1d087e5e205 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -753,8 +753,7 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 
 	if (!bdev)
 		return NULL;
-	if ((bdev->bd_disk->flags & GENHD_FL_HIDDEN) ||
-	    !try_module_get(bdev->bd_disk->fops->owner)) {
+	if ((bdev->bd_disk->flags & GENHD_FL_HIDDEN)) {
 		put_device(&bdev->bd_device);
 		return NULL;
 	}
@@ -764,7 +763,6 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 
 void blkdev_put_no_open(struct block_device *bdev)
 {
-	module_put(bdev->bd_disk->fops->owner);
 	put_device(&bdev->bd_device);
 }
 
@@ -820,12 +818,14 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	ret = -ENXIO;
 	if (!disk_live(disk))
 		goto abort_claiming;
+	if (!try_module_get(disk->fops->owner))
+		goto abort_claiming;
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
 	else
 		ret = blkdev_get_whole(bdev, mode);
 	if (ret)
-		goto abort_claiming;
+		goto put_module;
 	if (mode & FMODE_EXCL) {
 		bd_finish_claiming(bdev, holder);
 
@@ -847,7 +847,8 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	if (unblock_events)
 		disk_unblock_events(disk);
 	return bdev;
-
+put_module:
+	module_put(disk->fops->owner);
 abort_claiming:
 	if (mode & FMODE_EXCL)
 		bd_abort_claiming(bdev, holder);
@@ -956,6 +957,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 		blkdev_put_whole(bdev, mode);
 	mutex_unlock(&disk->open_mutex);
 
+	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
 }
 EXPORT_SYMBOL(blkdev_put);
diff --git a/block/genhd.c b/block/genhd.c
index a4e9e8ebd941..5f427fdc9e23 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -576,6 +576,12 @@ void del_gendisk(struct gendisk *disk)
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
+	/*
+	 * New open() will be failed since disk becomes not alive, and old
+	 * open() has either grabbed the module refcnt or been failed in
+	 * case of deleting from module_exit(), so disk->fops->owner won't
+	 * be unloaded if the disk is opened.
+	 */
 	mutex_lock(&disk->open_mutex);
 	remove_inode_hash(disk->part0->bd_inode);
 	blk_drop_partitions(disk);
-- 
2.31.1

