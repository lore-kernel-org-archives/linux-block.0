Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D754C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 08:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiBIIVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbiBIIVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 03:21:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137CC05CB82;
        Wed,  9 Feb 2022 00:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Sw3T8I6YXMWb2jiqB7QUc/okYU5X2+bEkOeoAGfg6Ak=; b=zvIdqvijwOa1CZXt0/IX+bv8Ck
        FepyGnk9TVxolqz848lYLqSdrWdjoH71qYc4Qrkcg++Hungn2BIXlP4IYQP3xpav/hRyNJlqmsOoH
        GYu4BK0BNBLyCKJN8Gr/ES9P2pF7lmlkacAStU2MaVHc61n7BzEi1Tz4Kn8SjR9jyJZArJ9cpcuVY
        g1zOyniqKaE9Aq3WY3MUdK4gWDdTwgJyU5eVVseBYufGL6eRRDV1H1fKp5M0pCWaneJS/+HAgSwLE
        /gPnJ1eJlPuaqhKAvZ0VYkv8rMYlNIQFXIjgEWqAt4q8KLT0I80W/5dm9nscbzMBUYDYSN+EXuokJ
        p4GQIpBQ==;
Received: from [2001:4bb8:188:3efc:ea2:7599:7eeb:4b5a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHiEB-00GbAb-72; Wed, 09 Feb 2022 08:21:27 +0000
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
Date:   Wed,  9 Feb 2022 09:21:16 +0100
Message-Id: <20220209082121.2628452-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209082121.2628452-1-hch@lst.de>
References: <20220209082121.2628452-1-hch@lst.de>
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

