Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C51C433E0
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC83420738
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 17:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qhAsF6If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGRpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jul 2020 13:45:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53DAC061755
        for <linux-block@vger.kernel.org>; Tue,  7 Jul 2020 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gECaeIlagpow9M0HqX79L7dXqps6WX9nssgPAvLViJc=; b=qhAsF6If8Vgc5B+0gczkG5vDgG
        7uiplQO7FdBZpAY3ZdRvdsW5VBHQyZkpRF3pSLJ87vPrpQ32W7kJFKHd7P/efd/O8Ws3zgIwTaiXd
        1yhhchVONmH3dJqzH0xzeuyLfg+KziJJXJrNZLeUEEDuRLCfY9scDC/xxUhSdrzKNGbzD/iTdAzON
        xu9PAJhkkBTmre/TyZnWjaJwdWzDIDUjQ2+evFeKeBpg1AojEybZdH1M1uR0hzhEFL/qWczSOtLoX
        ncYVaHjrnvT8x3T0gpTA1WxQqKDldQhuvV8IXj4K69EuKpQ3lmryWSNnClkej7Ld9aRnSibGm4KX8
        uUx2yq/A==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsreU-0003AO-18; Tue, 07 Jul 2020 17:45:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] block: remove a bogus warning in __submit_bio_noacct_mq
Date:   Tue,  7 Jul 2020 19:45:03 +0200
Message-Id: <20200707174503.4162535-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If blk_mq_submit_bio flushes the plug list, bios for other disks can
show up on current->bio_list.  As that doesn't involve any stacking of
block device it is entirely harmless and we should not warn about
this case.

Fixes: ff93ea0ce763 ("block: shortcut __submit_bio_noacct for blk-mq drivers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9f1bf8658b611a..93104c7470e8ac 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1154,14 +1154,13 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 
 static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 {
-	struct gendisk *disk = bio->bi_disk;
 	struct bio_list bio_list[2] = { };
 	blk_qc_t ret = BLK_QC_T_NONE;
 
 	current->bio_list = bio_list;
 
 	do {
-		WARN_ON_ONCE(bio->bi_disk != disk);
+		struct gendisk *disk = bio->bi_disk;
 
 		if (unlikely(bio_queue_enter(bio) != 0))
 			continue;
-- 
2.26.2

