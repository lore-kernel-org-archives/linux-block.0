Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4184C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 05:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C293C60F6C
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 05:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhI1FaO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbhI1FaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 01:30:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06CC061575
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 22:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4WBm4eXmjObEW2+XSf9ryC+/P7AfIxwtLCkgYn+jKm0=; b=a1h17Nvs37/nM8bb781Xwg4ROk
        +pHTum1nnoWujf/dKgGHjjDQgH9sHLU9VwT8v0evywWBwcK/fZDFm5AbNw8CRPrWDg64KNN7Ep2un
        fc2YlCquyV5StvXvJO1e1SNSKvefdY1Y4I5TPK2Sku9SkjopzByzUd3l1aIf0SrNOS+yW/6bGiS84
        JJKzzs/fpJlySvSRF60txEFXhWz5DNkWan/f5Ssuw0juD98kcGBXwaN9wj5CKStERO+Q1iElI4Byw
        kLBcXCVtqWKRWIW3fA0GxDURXb5EHm6GReX9fjWzLE2Mt3GeJW/Ix9/7+3e0B63opRSiXwO1Ydrpy
        eb69r8lQ==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mV5em-00AWRi-Go; Tue, 28 Sep 2021 05:28:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: print the current process in handle_bad_sector
Date:   Tue, 28 Sep 2021 07:27:55 +0200
Message-Id: <20210928052755.113016-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the bad sector information a little more useful by printing
current->comm to identify the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5454db2fa263b..4c2a3db4bd336 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -636,8 +636,9 @@ static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
 	char b[BDEVNAME_SIZE];
 
-	pr_info_ratelimited("attempt to access beyond end of device\n"
+	pr_info_ratelimited("%s: attempt to access beyond end of device\n"
 			    "%s: rw=%d, want=%llu, limit=%llu\n",
+			    current->comm,
 			    bio_devname(bio, b), bio->bi_opf,
 			    bio_end_sector(bio), maxsector);
 }
-- 
2.30.2

