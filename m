Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B5C77B7F
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 09:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjETJAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 05:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETJAR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 05:00:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BBF198
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OnnuWTsW6S5BH7dQF2gaqtb2Pqa+GBOl8tgcyocHma0=; b=xZYpPTaLqPJoPWd9UP8dGRT2a+
        PsjZTJO+1eIHuEvscn3P5rt4qREsQZmH0YkvNSUIyD2Aebk1+W1ZxJzvSTqeQtH12mTshoRlIKwsQ
        8rpiLp6GjNAhPHRJvB7XPyW1FaXkMk3xPdfLWhOaKEgssY1m5B1fNGWPap++mnWJDOa7SPujRA/Ve
        kbjCNKUUmCTnZqwIICAqveuDckvP8UCDtqSLqbJh0aKYuQMqxWAFJ0kJkRxWsvj4DhYGpwq9zAQY2
        Pt/qqft7kr5FnlUt33liUgNUhRc2GtoM2Q5puOBj9e8ZEhOM9aoZdwnKE08+4Dn0w+r/GVpLOkLMJ
        xT7fAjeQ==;
Received: from [2001:4bb8:188:3dd5:beca:d951:fdcb:9952] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0IRi-00148m-0k;
        Sat, 20 May 2023 09:00:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove NFL4_UFLG_MASK
Date:   Sat, 20 May 2023 11:00:10 +0200
Message-Id: <20230520090010.527046-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The NFL4_UFLG_MASK define slipped in in commit 9208d4149758
("block: add a ->get_unique_id method") and should never have been
added, as NFSD as the only user of it already has it's copy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 361341aea82ce5..96897d10b81327 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1379,8 +1379,6 @@ enum blk_unique_id {
 	BLK_UID_NAA	= 3,
 };
 
-#define NFL4_UFLG_MASK			0x0000003F
-
 struct block_device_operations {
 	void (*submit_bio)(struct bio *bio);
 	int (*poll_bio)(struct bio *bio, struct io_comp_batch *iob,
-- 
2.39.2

