Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580D0C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C55660F4F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhJYC5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 22:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232263AbhJYC5T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 22:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635130497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfPolJNm7P7L/JGB1152ao6XDhnZRZSDuWq/Pii30qo=;
        b=NBtQdbsaoUUgQtUlCKBYGdJ0cj8pgoZML5H41vg1hzQOaAIbY/XVsdImbdRsl7LKOkf5ef
        khtopJqos8MRmKM/t3qIezATrDl4DXWGBGu8RvgroUIq1wAzRYS1SzIE/nSXq8vHrpHmQe
        TkrkkpXZq9xDtoKLrf7N5RDKOAExTa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-CFq_rGAsMemUjQabbYQLvw-1; Sun, 24 Oct 2021 22:54:54 -0400
X-MC-Unique: CFq_rGAsMemUjQabbYQLvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D57C5362F8;
        Mon, 25 Oct 2021 02:54:52 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 148C85D9D5;
        Mon, 25 Oct 2021 02:54:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/4] zram: don't fail to remove zram during unloading module
Date:   Mon, 25 Oct 2021 10:54:24 +0800
Message-Id: <20211025025426.2815424-3-ming.lei@redhat.com>
In-Reply-To: <20211025025426.2815424-1-ming.lei@redhat.com>
References: <20211025025426.2815424-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the zram module is being unloaded, no one should be using the
zram disks. However even while being unloaded the zram module's
sysfs attributes might be poked at to re-configure zram devices.
This is expected, and kernfs ensures that these operations complete
before device_del() completes.

But reset_store() may set ->claim which will fail zram_remove(), when
this happens, zram_reset_device() is bypassed, and zram->comp can't
be destroyed, so the warning of 'Error: Removing state 63 which has
instances left.' is triggered during unloading module, together with
memory leak and sort of thing.

Fixes the issue by not failing zram_remove() if ->claim is set, and
we actually need to do nothing in case that zram_reset() is running
since del_gendisk() will wait until zram_reset() is done.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 25d781dc5fef..8883de7aa3d7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1968,25 +1968,40 @@ static int zram_add(void)
 static int zram_remove(struct zram *zram)
 {
 	struct block_device *bdev = zram->disk->part0;
+	bool claimed;
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
-	if (bdev->bd_openers || zram->claim) {
+	if (bdev->bd_openers) {
 		mutex_unlock(&bdev->bd_disk->open_mutex);
 		return -EBUSY;
 	}
 
-	zram->claim = true;
+	claimed = zram->claim;
+	if (!claimed)
+		zram->claim = true;
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
 	zram_debugfs_unregister(zram);
 
-	/* Make sure all the pending I/O are finished */
-	fsync_bdev(bdev);
-	zram_reset_device(zram);
+	if (claimed) {
+		/*
+		 * If we were claimed by reset_store(), del_gendisk() will
+		 * wait until reset_store() is done, so nothing need to do.
+		 */
+		;
+	} else {
+		/* Make sure all the pending I/O are finished */
+		fsync_bdev(bdev);
+		zram_reset_device(zram);
+	}
 
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
 
 	del_gendisk(zram->disk);
+
+	/* del_gendisk drains pending reset_store */
+	WARN_ON_ONCE(claimed && zram->claim);
+
 	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;
@@ -2063,7 +2078,7 @@ static struct class zram_control_class = {
 
 static int zram_remove_cb(int id, void *ptr, void *data)
 {
-	zram_remove(ptr);
+	WARN_ON_ONCE(zram_remove(ptr));
 	return 0;
 }
 
-- 
2.31.1

