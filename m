Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BACCEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 12:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjFUMtY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUMtX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 08:49:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E351717
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V7EkQLb3tvRshQ0uCTeetJGkxBr7GMMpB9MHaM7YD/g=; b=3rL0WQYZ0bKe3k4AKhpkXkOAkt
        RcjvsJYFhCbcZ7eRQdXPgf7xkEGSMzAmqD29ACz0c1bfSpiQKVA55jTufJWabPnOoAso1zQxEo8Er
        f7hikTKknkVzawqfclfl9xEmus/rcewkCluxkgg+W0YytNbKBwQK/Aim8AJVZFh7n2Gyqd3ES4PXr
        sXwqMC3Sau8XZL/CEivjxZFUIvmqVQtR8gCcnHVkFPmAawFirf/7JLDxUos0ynC0Y+QRudSI+ex/o
        Mfe94ZpBrUj+f4i8ZLpjGkgvfmCYle1XMNQnAs6ijquSRce7YJC6owMKdriVZZUzOdBnhFqDNtvkb
        U4zxtz8w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBxGw-00EbEA-0q;
        Wed, 21 Jun 2023 12:49:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] block: fix the exclusive open mask in disk_scan_partitions
Date:   Wed, 21 Jun 2023 14:49:14 +0200
Message-Id: <20230621124914.185992-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FMODE_EXEC has nothing to do with exclusive opens, and even is of
the wrong type.  We need to check for BLK_OPEN_EXCL here.

Fixes: 985958b8584c ("block: fix wrong mode for blkdev_get_by_dev() from disk_scan_partitions()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index a94952ae9e396a..3d287b32d50dfd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -366,7 +366,7 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXEC, NULL,
+	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
 				 NULL);
 	if (IS_ERR(bdev))
 		ret =  PTR_ERR(bdev);
-- 
2.39.2

