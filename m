Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C5EC433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 16:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJTQrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJTQrD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 12:47:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D31D93ED
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZpEF09OV4bJdcqGzSGDpR6VVYwKGQHKuXIL3dXVFBWA=; b=A87X8kHH8NxfhHul0SVi6l+rUP
        NXFzqsgvrl2g9AdT2QQqRrJGRC5VrKMXupG40do+W+ppghtVwNv+6GLHxHjVv40+cgbvkZYZEHvmF
        1PDaclPjp7GzW5o2d9aAnphq1ceRcsNjLpOtGjIDad0KOwVasRkKV31LST2ZDJOuok0t3UqWcKcGP
        /5xM84CidKf09ycSZSActBUfVL2hgcdk2b+wwauqV8Y7TT9peT+BXxy/rRqJVv+DGQBmnIr69pBWE
        Xc3AUTyZvU0XsWLzftEhspuTXkYylPTrg2Id7CUZyQH9XwQ/GO5mZG/WmoKPitZ/UqVYy4JDJp8tz
        vtOJgfDQ==;
Received: from [205.220.129.26] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYgu-000WUB-Dr; Thu, 20 Oct 2022 16:46:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 3/6] dm: cleanup open_table_device
Date:   Thu, 20 Oct 2022 09:46:02 -0700
Message-Id: <20221020164605.1764830-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020164605.1764830-1-hch@lst.de>
References: <20221020164605.1764830-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move all the logic for allocation the table_device and linking it into
the list into the open_table_device.  This keeps the code tidy and
ensures that the table_devices only exist in fully initialized state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 56 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 36189a32329aa..f60d9e8fc3abf 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -732,28 +732,41 @@ static char *_dm_claim_ptr = "I belong to device-mapper";
 /*
  * Open a table device so we can use it as a map destination.
  */
-static int open_table_device(struct table_device *td, dev_t dev,
-			     struct mapped_device *md)
+static struct table_device *open_table_device(struct mapped_device *md,
+		dev_t dev, fmode_t mode)
 {
+	struct table_device *td;
 	struct block_device *bdev;
 	u64 part_off;
 	int r;
 
-	BUG_ON(td->dm_dev.bdev);
+	td = kmalloc_node(sizeof(*td), GFP_KERNEL, md->numa_node_id);
+	if (!td)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&td->count, 1);
 
-	bdev = blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim_ptr);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	bdev = blkdev_get_by_dev(dev, mode | FMODE_EXCL, _dm_claim_ptr);
+	if (IS_ERR(bdev)) {
+		r = PTR_ERR(bdev);
+		goto out_free_td;
+	}
 
 	r = bd_link_disk_holder(bdev, dm_disk(md));
-	if (r) {
-		blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);
-		return r;
-	}
+	if (r)
+		goto out_blkdev_put;
 
+	td->dm_dev.mode = mode;
 	td->dm_dev.bdev = bdev;
 	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off, NULL, NULL);
-	return 0;
+	format_dev_t(td->dm_dev.name, dev);
+	list_add(&td->list, &md->table_devices);
+	return td;
+
+out_blkdev_put:
+	blkdev_put(bdev, mode | FMODE_EXCL);
+out_free_td:
+	kfree(td);
+	return ERR_PTR(r);
 }
 
 /*
@@ -786,31 +799,16 @@ static struct table_device *find_table_device(struct list_head *l, dev_t dev,
 int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
 			struct dm_dev **result)
 {
-	int r;
 	struct table_device *td;
 
 	mutex_lock(&md->table_devices_lock);
 	td = find_table_device(&md->table_devices, dev, mode);
 	if (!td) {
-		td = kmalloc_node(sizeof(*td), GFP_KERNEL, md->numa_node_id);
-		if (!td) {
-			mutex_unlock(&md->table_devices_lock);
-			return -ENOMEM;
-		}
-
-		td->dm_dev.mode = mode;
-		td->dm_dev.bdev = NULL;
-
-		if ((r = open_table_device(td, dev, md))) {
+		td = open_table_device(md, dev, mode);
+		if (IS_ERR(td)) {
 			mutex_unlock(&md->table_devices_lock);
-			kfree(td);
-			return r;
+			return PTR_ERR(td);
 		}
-
-		format_dev_t(td->dm_dev.name, dev);
-
-		refcount_set(&td->count, 1);
-		list_add(&td->list, &md->table_devices);
 	} else {
 		refcount_inc(&td->count);
 	}
-- 
2.30.2

