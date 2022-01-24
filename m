Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB77BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 24 Jan 2022 09:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiAXJjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiAXJjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26E0C06173B
        for <linux-block@vger.kernel.org>; Mon, 24 Jan 2022 01:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Soq76R5XvHVjOF8wmbfdCiRYPowns2s2ii3TYqMGGS0=; b=nWpfwNQ8P6Mhpm5vvQ/ghb8PtS
        tn1XAhYRB8DJOAK2JUGLQ8FjsatFMwn1YXSymIMnGjSg3djHvjAqztiyTTqUEaezLytIDCdlo1sxd
        gs7bviqOz+dvZyFjWmNDdqEjUnDwmlYp0uvvmtTiic32VcaBhvH2YLZWATYM1fdKFgRPQ06ao941C
        bzZwCWzAvG88lHz+zYzH6IyFjfvMebtmCFk8Z12HVLql4RRKU5W8YIrHfMOlMpx5823oZ7f5WEsYB
        E8Z52LV/tDrX99uTDGyXcbkunSt7Cnnme/DZwugtniiBR7saLeWk+nREaLvqioM4k/xuMlHIG+N5z
        vRjJ8shg==;
Received: from [2001:4bb8:184:72a4:a337:a75f:a24e:7e39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvoo-002pX1-Sl; Mon, 24 Jan 2022 09:39:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: move blk_drop_partitions to blk.h
Date:   Mon, 24 Jan 2022 10:39:12 +0100
Message-Id: <20220124093913.742411-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124093913.742411-1-hch@lst.de>
References: <20220124093913.742411-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to have this declaration in a public header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h           | 1 +
 include/linux/genhd.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 2cba50d7e6cb1..800c5ae387a0b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -426,6 +426,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 int bdev_del_partition(struct gendisk *disk, int partno);
 int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
+void blk_drop_partitions(struct gendisk *disk);
 
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 504f9a6674ace..aa4bd985dbe51 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -219,7 +219,6 @@ static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
 }
 
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
-void blk_drop_partitions(struct gendisk *disk);
 
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass);
-- 
2.30.2

