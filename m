Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DABDC7EE29
	for <linux-block@archiver.kernel.org>; Thu,  1 Jun 2023 07:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjFAH2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjFAH2u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 03:28:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10381A5
        for <linux-block@vger.kernel.org>; Thu,  1 Jun 2023 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aiSJvj7qkOthyKc8VPfMGgr8suMGfwyntm919KAyySE=; b=IbYYe8olMwunIlxOx7rH8cwngZ
        K53xIFGTLR0rsi2dM9OBFLC5joMmXNAUFVi+moiKi3yYaTVlElyJbjAnD1HPXuWOIdOrrn2X0JJrB
        uy4i2HceYP1ZTbzzMZzv+oah2zy+42RO22wv0pd8koewgg6jlLMCuWTdN3fRo2AU1DolnFLjyYWSR
        AvW9twabMlWi1S8RPzxiJlPBFShXqgONJf+i0hg/jqwY27EptSNwAJDklMZ7XvpvYskCTztLZKrYl
        b3H1v+ftz/Nhg0kKGj8s8mxtVXIG3IWpz34JMUDXRBG3a28e/FPHVOue1ya4Mjei1DkRcta8HZikp
        vjggvT2g==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4cjg-002MLn-2W;
        Thu, 01 Jun 2023 07:28:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: simplify the check for flushes in bio_check_ro
Date:   Thu,  1 Jun 2023 09:28:28 +0200
Message-Id: <20230601072829.1258286-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601072829.1258286-1-hch@lst.de>
References: <20230601072829.1258286-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only writes without no sectors are pure flush requests, so drop
the extra op_is_flush check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2ae22bebeb3ee1..4ba243968e41eb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -494,9 +494,8 @@ late_initcall(fail_make_request_debugfs);
 
 static inline void bio_check_ro(struct bio *bio)
 {
-	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
-		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
-			return;
+	if (op_is_write(bio_op(bio)) && bio_sectors(bio) &&
+	    bdev_read_only(bio->bi_bdev)) {
 		pr_warn("Trying to write to read-only block-device %pg\n",
 			bio->bi_bdev);
 		/* Older lvm-tools actually trigger this */
-- 
2.39.2

