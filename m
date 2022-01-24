Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF4EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 24 Jan 2022 09:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiAXJjU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiAXJjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD9AC06173B
        for <linux-block@vger.kernel.org>; Mon, 24 Jan 2022 01:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=R1iDwNfXXUS0tQMXowiNEhvId5F54BU0hAaWyjmqdqo=; b=g13dumz+krrrnUyo2kZPbQtgmh
        5lXrl5SU6ZQ4A+oGS4d6li0356S6OkPqze5/7COfjk2XOsnO9hpyJDcntG//RGvz49m1fMVsSvtE2
        6nPyD51uw8Ucen1cuOg0qM+DtIvQ/OSG+pNh10tC4RBpsOmNujS06rBPx5bq/QWl8624oprAZw56r
        BMBlcVI8ZO0PK52T0mNWEVoaVWyPkkgtvIQwlfJwHsC6GBmEHSJGR4lHKynsG4FuGbvp3bahIt+Ak
        GHnFV2iV5zxA7PHwzqsQK7vmKiwiPgRt9s7sIq9i0CKY+fz9aZ1+kA7PJ30d6l1WQdTv1NSnizmnl
        Ao/25vPQ==;
Received: from [2001:4bb8:184:72a4:a337:a75f:a24e:7e39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvol-002pW4-NJ; Mon, 24 Jan 2022 09:39:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: move disk_{block,unblock,flush}_events to blk.h
Date:   Mon, 24 Jan 2022 10:39:11 +0100
Message-Id: <20220124093913.742411-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124093913.742411-1-hch@lst.de>
References: <20220124093913.742411-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to have these declarations in a public header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h           | 3 +++
 include/linux/genhd.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 8bd43b3ad33d5..2cba50d7e6cb1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -445,6 +445,9 @@ int disk_alloc_events(struct gendisk *disk);
 void disk_add_events(struct gendisk *disk);
 void disk_del_events(struct gendisk *disk);
 void disk_release_events(struct gendisk *disk);
+void disk_block_events(struct gendisk *disk);
+void disk_unblock_events(struct gendisk *disk);
+void disk_flush_events(struct gendisk *disk, unsigned int mask);
 extern struct device_attribute dev_attr_events;
 extern struct device_attribute dev_attr_events_async;
 extern struct device_attribute dev_attr_events_poll_msecs;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6906a45bc761a..504f9a6674ace 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -185,9 +185,6 @@ static inline int bdev_read_only(struct block_device *bdev)
 	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
 }
 
-extern void disk_block_events(struct gendisk *disk);
-extern void disk_unblock_events(struct gendisk *disk);
-extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
 bool disk_force_media_change(struct gendisk *disk, unsigned int events);
 
-- 
2.30.2

