Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE3CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B153A60F23
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhJLKuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhJLKuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:50:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C60EC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LsAS9Ygj80w363bIN4XwCd/d3GT/58wGpTl7ChHvZ6g=; b=caSIrs8AN+UYNM3ClvNN3OUSvB
        wgqElAOp16UOY7mCQnVTxb77ouKubSKn6aKwWC33mYSkKyHS/kGuUFbaIR/YqH1DSiLRISDEGSP/G
        T+FgsmNjQ93z61NZ4nuxSCH5h5FOYz9Flv6STZoeaEw2BtWqqqeG4HxaneuTOVVfzyE5mqm+o8wYZ
        dfYXJsvstnW6d+Xd6nmnluNrvTJsHxi6hGNOKcv8lIH7lrnqeAR5oupqEVoWFoEgGeEWuNfNBVBsL
        9QQAN2ulMS8wpWglZtQLdoiuTLJ9fm1MGdrpc8VHUT4czwv0oykLTD2QiaSkvnmXnZ/hkr/3DYwJm
        8R+F8fRw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFJ4-006QZq-I6; Tue, 12 Oct 2021 10:47:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: move the *blkdev_ioctl declarations out of blkdev.h
Date:   Tue, 12 Oct 2021 12:44:49 +0200
Message-Id: <20211012104450.659013-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012104450.659013-1-hch@lst.de>
References: <20211012104450.659013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These are only used inside of block/.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h           | 4 ++++
 include/linux/genhd.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 38867b4c5c7ed..bca4ba1a1f8dd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -403,6 +403,10 @@ static inline void bio_clear_hipri(struct bio *bio)
 	bio->bi_opf &= ~REQ_HIPRI;
 }
 
+int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
+		unsigned long arg);
+long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
+
 extern const struct address_space_operations def_blk_aops;
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c1639c16b74c3..082a3e5fd8fa1 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -280,10 +280,6 @@ bool bdev_check_media_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
 void set_capacity(struct gendisk *disk, sector_t size);
 
-/* for drivers/char/raw.c: */
-int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
-long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
-
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
-- 
2.30.2

