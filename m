Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D36BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B9F61056
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 12:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhJOMTr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238711AbhJOMTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 08:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634300260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/5naXCj8dyZR4hMz7Beu981gCXuUblZmUpVNi0AjG8=;
        b=LKlqACt12T3Nplcwoh/PbO87CmEMLYw7B6ezB/gYlbE969LWYK8KL1ekcSeUYhxYDAqH0x
        k6AXKCoe08fE6irQoodD1sspzGc8AYASlE4CKCRQ+WlgKJSpDJZyNRvZ0W2l0T0bdTN8yi
        hZyseI+uA6oIDBrABu1gwddi30ckOQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Q3qmJEDiNtCghuI5Iu7hDw-1; Fri, 15 Oct 2021 08:17:37 -0400
X-MC-Unique: Q3qmJEDiNtCghuI5Iu7hDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F064100CCC4;
        Fri, 15 Oct 2021 12:17:36 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B49A19EF9;
        Fri, 15 Oct 2021 12:17:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] zram: simplify handling reset_store/remove vs. open
Date:   Fri, 15 Oct 2021 20:16:51 +0800
Message-Id: <20211015121652.2024287-3-ming.lei@redhat.com>
In-Reply-To: <20211015121652.2024287-1-ming.lei@redhat.com>
References: <20211015121652.2024287-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before resetting and removing one zram disk, disk->open_mutex is acquired,
and ->claim is set to prevent new open and zram_remove from being done,
then disk->open_mutex is released, and flush dirty pages and reset the zram
disk.

Turns out it needn't to be so complicated, we can simply flush dirty
pages and reset the zram disk with holding disk->open_mutex. Meantime
we can't fail to remove zram in case that it is running from module
exit, otherwise we will leak the zram device.

bdev_disk_changed() already runs sync_blockdev() with holding
disk->open_mutex, so this way is safe. Also it is safe to call
zram_reset_device() with ->open_mutex too, just we need to deal with
lockdep false warning since backing_dev_store() holds init lock before
acquiring backing device's open_mutex.

More importantly, we can avoid to fail removing zram when unloading module,
then zram device won't be leaked and the warning of 'Error: Removing state
63 which has instances left.' can be fixed.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 53 +++++++++++++----------------------
 drivers/block/zram/zram_drv.h |  4 ---
 2 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6f6f6a3fee0e..d374c0f46681 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -55,6 +55,8 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 static const struct block_device_operations zram_wb_devops;
 
+static struct lock_class_key zram_open_lock_key;
+
 static void zram_free_page(struct zram *zram, size_t index);
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 				u32 index, int offset, struct bio *bio);
@@ -1782,44 +1784,21 @@ static ssize_t reset_store(struct device *dev,
 	bdev = zram->disk->part0;
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
-	/* Do not reset an active device or claimed device */
-	if (bdev->bd_openers || zram->claim) {
+	/* Do not reset an active device */
+	if (bdev->bd_openers) {
 		mutex_unlock(&bdev->bd_disk->open_mutex);
 		return -EBUSY;
 	}
 
-	/* From now on, anyone can't open /dev/zram[0-9] */
-	zram->claim = true;
-	mutex_unlock(&bdev->bd_disk->open_mutex);
-
 	/* Make sure all the pending I/O are finished */
 	sync_blockdev(bdev);
 	zram_reset_device(zram);
-
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	zram->claim = false;
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
 	return len;
 }
 
-static int zram_open(struct block_device *bdev, fmode_t mode)
-{
-	int ret = 0;
-	struct zram *zram;
-
-	WARN_ON(!mutex_is_locked(&bdev->bd_disk->open_mutex));
-
-	zram = bdev->bd_disk->private_data;
-	/* zram was claimed to reset so open request fails */
-	if (zram->claim)
-		ret = -EBUSY;
-
-	return ret;
-}
-
 static const struct block_device_operations zram_devops = {
-	.open = zram_open,
 	.submit_bio = zram_submit_bio,
 	.swap_slot_free_notify = zram_slot_free_notify,
 	.rw_page = zram_rw_page,
@@ -1827,7 +1806,6 @@ static const struct block_device_operations zram_devops = {
 };
 
 static const struct block_device_operations zram_wb_devops = {
-	.open = zram_open,
 	.submit_bio = zram_submit_bio,
 	.swap_slot_free_notify = zram_slot_free_notify,
 	.owner = THIS_MODULE
@@ -1922,6 +1900,13 @@ static int zram_add(void)
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
 
+	/*
+	 * avoid false warning on disk->open_mutex because we hold
+	 * init_lock before acquiring backing disk's open_mutex, see
+	 * backing_dev_store()
+	 */
+	lockdep_set_class(&zram->disk->open_mutex, &zram_open_lock_key);
+
 	/* Actual capacity set using syfs (/sys/block/zram<id>/disksize */
 	set_capacity(zram->disk, 0);
 	/* zram devices sort of resembles non-rotational disks */
@@ -1973,19 +1958,17 @@ static int zram_remove(struct zram *zram)
 	struct block_device *bdev = zram->disk->part0;
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
-	if (bdev->bd_openers || zram->claim) {
+	if (bdev->bd_openers) {
 		mutex_unlock(&bdev->bd_disk->open_mutex);
 		return -EBUSY;
 	}
 
-	zram->claim = true;
-	mutex_unlock(&bdev->bd_disk->open_mutex);
-
-	zram_debugfs_unregister(zram);
-
 	/* Make sure all the pending I/O are finished */
 	sync_blockdev(bdev);
 	zram_reset_device(zram);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+
+	zram_debugfs_unregister(zram);
 
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
 
@@ -2066,7 +2049,11 @@ static struct class zram_control_class = {
 
 static int zram_remove_cb(int id, void *ptr, void *data)
 {
-	zram_remove(ptr);
+	/*
+	 * No one should own the device during module_exit, otherwise zram
+	 * module refcount has to be handled wrong by block layer.
+	 */
+	WARN_ON_ONCE(zram_remove(ptr));
 	return 0;
 }
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 80c3b43b4828..ad8564c8a52a 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -109,10 +109,6 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	char compressor[CRYPTO_MAX_ALG_NAME];
-	/*
-	 * zram is claimed so open request will be failed
-	 */
-	bool claim; /* Protected by disk->open_mutex */
 #ifdef CONFIG_ZRAM_WRITEBACK
 	struct file *backing_dev;
 	spinlock_t wb_limit_lock;
-- 
2.31.1

