Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076CBC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 07:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJRHif (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 03:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJRHic (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 03:38:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5575140CE
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=T/rKt87NVeQm/0GZSQUQVhGIW8gFZYmQPoOzvwOeOTY=; b=uCpNwCfGmS1qqPRv3hq2Jr6OvG
        k/9hJKHljIMZXZ+mXR0R6k3vB+Xk4QTOSwYEWu0Q2y6PFuU1ZlErBkij41q3ryU3o5xraQZsKbZWL
        FlmLvPGx+ve0oQhd3jdpLXUkkJNujKc3xfCoBbggK8vkEua1B/I9hFvWAHtEjsATAXIxIegXXbTfp
        EZuBzKkgqXa4ZdXLn0PZuU5JEwqZgQaw9LHpF2JyKFCPkA4i2H8mBYozCRb3SxMae7bO+m3S7xKML
        H4NybfH4Iw6xjQsM5t192vZeLzA4dDPpz322/bMPSeOlPxwQO42LF0zPTj7uZ7SrKcL0o4Xehlcc0
        I+T2TmUw==;
Received: from [2001:4bb8:199:ad84:bc07:8d59:28dc:d7d9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okhBE-003sZa-Jw; Tue, 18 Oct 2022 07:38:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH 1/2] block: unregister holder kobject on late add_disk failure
Date:   Tue, 18 Oct 2022 09:38:21 +0200
Message-Id: <20221018073822.646207-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When device_add_disk fails after the registering the delayed holders,
the kobjects for them are leaked.  Fix this by unregistering them for
these failure cases.

Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          |  4 +++-
 block/holder.c         | 10 ++++++++++
 include/linux/blkdev.h |  4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423df..6123005154b2a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -484,7 +484,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 
 	ret = blk_register_queue(disk);
 	if (ret)
-		goto out_put_slave_dir;
+		goto out_unregister_holders;
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		ret = bdi_register(disk->bdi, "%u:%u",
@@ -526,6 +526,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		bdi_unregister(disk->bdi);
 out_unregister_queue:
 	blk_unregister_queue(disk);
+out_unregister_holders:
+	bd_unregister_all_holders(disk);
 out_put_slave_dir:
 	kobject_put(disk->slave_dir);
 out_put_holder_dir:
diff --git a/block/holder.c b/block/holder.c
index 4923a77ebecdc..b60fca775b055 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -173,3 +173,13 @@ int bd_register_pending_holders(struct gendisk *disk)
 	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
+
+void bd_unregister_all_holders(struct gendisk *disk)
+{
+	struct bd_holder_disk *holder;
+
+	mutex_lock(&disk->open_mutex);
+	list_for_each_entry(holder, &disk->slave_bdevs, list)
+		__unlink_disk_holder(holder->bdev, disk);
+	mutex_unlock(&disk->open_mutex);
+}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d986..ccab9a2dae4bd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -840,6 +840,7 @@ void set_capacity(struct gendisk *disk, sector_t size);
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
 int bd_register_pending_holders(struct gendisk *disk);
+void bd_unregister_all_holders(struct gendisk *disk);
 #else
 static inline int bd_link_disk_holder(struct block_device *bdev,
 				      struct gendisk *disk)
@@ -854,6 +855,9 @@ static inline int bd_register_pending_holders(struct gendisk *disk)
 {
 	return 0;
 }
+static inline void bd_unregister_all_holders(struct gendisk *disk)
+{
+}
 #endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
 
 dev_t part_devt(struct gendisk *disk, u8 partno);
-- 
2.30.2

