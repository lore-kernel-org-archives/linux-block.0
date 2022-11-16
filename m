Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18397C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 13:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKPNUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 08:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiKPNUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 08:20:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DC21835
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3SkdOXoD+Z8WZfqez6fUxNI0Xp8dH9JIZoaNq8gjzg8=; b=TbyWdfkIjHYWQJ6DQofcrfeRR2
        z7MwSx6fRpxcIoS11b/rqPH7VdrHsm8a+9m9VGkSvZPDf7zC+z9UFuUknUR5yISq0bzDaszwLPrp6
        DzY5gJKslMxzi35RrrCF6wFsSbYWBL8O+5mXTMI7MHPW3JA5RjJX3BfHg7TZR9dLtEW2YwgG7zKCs
        iE8cuMORbRKTNSYn4W53a+sOZGvq9h74jEz1nrcd0VlZQWrDc+B4cK64ep2kmuwHsDopWx0/xCf3L
        PtE98WNP4VdJubyZF5FHy+6LBCXJJt0jGqvoL9MoEz/6vszUTKHM8NLKmfgAIyG4TqPQVssfsjaTF
        SXLRR0yw==;
Received: from [2001:4bb8:191:2606:427:bb47:a3d:e0b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovILF-003pMq-UB; Wed, 16 Nov 2022 13:20:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove blkdev_writepages
Date:   Wed, 16 Nov 2022 14:20:35 +0100
Message-Id: <20221116132035.2192924-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While the block device code should switch to implementing
->writepages instead of ->writepage eventually, the current
implementation is entirely pointless as it does the same looping over
->writepage as the generic code if no ->writepages is present.

Remove blkdev_writepages so that we can eventually unexport
generic_writepages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b90742595317e..50d245e8c913a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -405,12 +405,6 @@ static int blkdev_write_end(struct file *file, struct address_space *mapping,
 	return ret;
 }
 
-static int blkdev_writepages(struct address_space *mapping,
-			     struct writeback_control *wbc)
-{
-	return generic_writepages(mapping, wbc);
-}
-
 const struct address_space_operations def_blk_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
@@ -419,7 +413,6 @@ const struct address_space_operations def_blk_aops = {
 	.writepage	= blkdev_writepage,
 	.write_begin	= blkdev_write_begin,
 	.write_end	= blkdev_write_end,
-	.writepages	= blkdev_writepages,
 	.direct_IO	= blkdev_direct_IO,
 	.migrate_folio	= buffer_migrate_folio_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
-- 
2.30.2

