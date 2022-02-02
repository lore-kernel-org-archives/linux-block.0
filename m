Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DBCC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 15:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiBBP5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiBBP5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 10:57:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF8EC061714;
        Wed,  2 Feb 2022 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Sw3T8I6YXMWb2jiqB7QUc/okYU5X2+bEkOeoAGfg6Ak=; b=BMexVoq5xuoiPG2lI6P0lGhyYj
        zTa3iwiJpJwjT/yz0eaxXfNumeqM9ruwkrzLm053Jr8vTaU3+8KQ8rLygAjplLm224EVEUMA7onq7
        L1Hvz8CHLUsPXIX16p+wnUPJ+EaA6AY2lxWtazI+fM+KGm4vEzO29DPi2LjGh1NBMJxtjxMohV19n
        SFFW0ZtunsA8WPYQ3Dw7PutON+S4ep9n35bFj3+mURkKPf3UQGhkjSUDPtvOlbfDAxlFX2kjppcqD
        7CaNLH/6ZufjOOaHcrOOgT+bqjhTajMPQTAZtXwyk0a6x7/pgtAYQ9f1bWhFLjutiL/mEYa7zL8DW
        FaXwRgsQ==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI0H-00G6Ww-7q; Wed, 02 Feb 2022 15:57:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/5] block: add a ->free_disk method
Date:   Wed,  2 Feb 2022 16:56:55 +0100
Message-Id: <20220202155659.107895-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202155659.107895-1-hch@lst.de>
References: <20220202155659.107895-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a method to notify the driver that the gendisk is about to be freed.
This allows drivers to tie the lifetime of their private data to that of
the gendisk and thus deal with device removal races without expensive
synchronization and boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          | 4 ++++
 include/linux/blkdev.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 9589d1d59afab..1a650c55d7626 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1119,6 +1119,10 @@ static void disk_release(struct device *dev)
 	xa_destroy(&disk->part_tbl);
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
+
+	if (disk->fops->free_disk)
+		disk->fops->free_disk(disk);
+
 	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3bfc75a2a4509..a8f8aa4671037 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1464,6 +1464,7 @@ struct block_device_operations {
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
 	int (*set_read_only)(struct block_device *bdev, bool ro);
+	void (*free_disk)(struct gendisk *disk);
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
-- 
2.30.2

