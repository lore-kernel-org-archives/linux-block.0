Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FF9C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FC660EBC
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhKDR0d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhKDRXT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 13:23:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A72C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NdoBYgU1QtwdxpL1hf/q8rvFsy+7PJrqcBFgXmrndYM=; b=pvIgQNpOm9IkfPLAXAIj9e28dg
        fqcgx0NeIurnh3T1f2bhspgLWsJ1x3slEr0S9UPr49lelQZSFGeNjCqtYaw62K+q/fV9xnaR2o4+M
        WqZyJbo9vxIaMk14bwwA58YlJwI6lokjxTTQfk3LPbUWzbKhM278kyYcC2x2ywOWWz0IYw/gcgSEu
        93yQFYH5h8ahXAQvwrLpjR5HR0y8QsCEBDP0rWJXuRyNk+teaG2y4Dc4c/QO6dceBQ6RYwPey0DfF
        oqyz4RzkTL0+KvHF2qd3wS6mlxRf7ivIhE9m4QJap9NA2n21vCXwF0mBGWKOqFrJ9rvIo5CjTra+B
        VKXMjbbw==;
Received: from [2001:4bb8:188:6569:974c:c58e:36a2:68c0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migPo-009eYH-B1; Thu, 04 Nov 2021 17:20:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: add a loff_t cast to bdev_nr_bytes
Date:   Thu,  4 Nov 2021 18:20:37 +0100
Message-Id: <20211104172037.531803-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not really needed as both loff_t and sector_t are always 64-bits wide,
but this documents the different types a bit better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/genhd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 59eabbc3a36b7..462634b4b48fb 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -250,7 +250,7 @@ static inline sector_t bdev_nr_sectors(struct block_device *bdev)
 
 static inline loff_t bdev_nr_bytes(struct block_device *bdev)
 {
-	return bdev_nr_sectors(bdev) << SECTOR_SHIFT;
+	return (loff_t)bdev_nr_sectors(bdev) << SECTOR_SHIFT;
 }
 
 static inline sector_t get_capacity(struct gendisk *disk)
-- 
2.30.2

