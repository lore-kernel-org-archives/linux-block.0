Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71367C77B7F
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 04:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjETEpJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 00:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjETEpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 00:45:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E5E42
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 21:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iiMw+Jox5TpZypH2S0c8fTWznXddFcUP10Wdmd1KB4w=; b=s6iOQUe7T0Xi4C8qy6O2QiL0nE
        f7aT5dJxPZakOHtm1Qv3kyyV4n1Qm5fLJyV8rKZLwDOX8YgidrCnslWY8Qf4qn8V+cnmi/iVDTR0Z
        FjuIf1cPTcTTmtI147XdoQ1A/vpyEjT0d1Sg6GOnfJt5K8qjVrSCOsqmnMI+2BUfiaVUHD17YOXpB
        C+2wgSJmrX1U1eKGuFJulwILzjdT3qFbwNVOamBGWtfuxifO9Bf43vpbVCtECT6VGL/98frrPdyIW
        +YPsf1FIHfIn8HtuJM4Kh7sjXQ83urKU5AkvIr5bk4L0c7FKSX5iPIZ5K9Xj5yEWAY3+tI1oL+9k5
        jYg9yy1w==;
Received: from [2001:4bb8:188:3dd5:beca:d951:fdcb:9952] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0ESo-000hzt-2Y;
        Sat, 20 May 2023 04:45:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: don't plug in blkdev_write_iter
Date:   Sat, 20 May 2023 06:45:03 +0200
Message-Id: <20230520044503.334444-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For direct I/O writes that issues more than a single bio, the pluggin is
already done in __blkdev_direct_IO.
For synchronous buffered writes the plugging is done deep down in
writeback_inodes_wb / wb_writeback.

For the other cases there is no point in plugging as as single bio or no
bio at all is submitted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c7d..102ee85fc6eedf 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -520,7 +520,6 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct block_device *bdev = iocb->ki_filp->private_data;
 	struct inode *bd_inode = bdev->bd_inode;
 	loff_t size = bdev_nr_bytes(bdev);
-	struct blk_plug plug;
 	size_t shorted = 0;
 	ssize_t ret;
 
@@ -545,12 +544,10 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iov_iter_truncate(from, size);
 	}
 
-	blk_start_plug(&plug);
 	ret = __generic_file_write_iter(iocb, from);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
-	blk_finish_plug(&plug);
 	return ret;
 }
 
-- 
2.39.2

