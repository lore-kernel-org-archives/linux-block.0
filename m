Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC32C433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 07:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349747AbiBDHTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 02:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349571AbiBDHTj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 02:19:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A94C061714
        for <linux-block@vger.kernel.org>; Thu,  3 Feb 2022 23:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+CI8akbbXrM0eE8V3CgwPyg73A+lLlW1mr47bCOO2JE=; b=KWVTqXCKQ5f7+6pUDB2yU0uYZc
        5r2P/ntcuJ4OxAmAAu2PnnshCQDgti68jsREimUYZCesGDWPU+NwT7TmskNFkTFBhTZJfAwLvH4Y8
        cNffJSW795gIG/WHcRlxa5Xc1S1HQ0vj/QnP3Qs8O96BD+l+ZWmqhc8eoJuIyAkr3QNWDSaVRX5Zt
        FaOaj7EMNRLJeDD9bf34Vssqu+G+Xp7LXMTNUFCvvuq/P693ye0QSHk32vVewZ4u3EMLPRPAM59JP
        clG2oEO0+74v2+hGbqaR+6iB1MxlmCzBLO5tYBRQ61g/ZvVnpb9w2fs+AMOZJaZ6TWs7nn59TA4aP
        xlDMaVAw==;
Received: from [2001:4bb8:199:3f6d:ff3:60cd:85f:6199] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFssb-003dFJ-77; Fri, 04 Feb 2022 07:19:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com
Subject: [PATCH] block: call bio_associate_blkg from bio_reset
Date:   Fri,  4 Feb 2022 08:19:34 +0100
Message-Id: <20220204071934.168469-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Call bio_associate_blkg just like bio_set_dev did in the callers before
the conversion to set the block device in bio_reset.

Fixes: a7c50c940477 ("block: pass a block_device and opf to bio_reset")
Reported-by: syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com
Tested-by: syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 2e19ca600fcdb..d2f3c10350364 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -310,6 +310,8 @@ void bio_reset(struct bio *bio, struct block_device *bdev, unsigned int opf)
 	memset(bio, 0, BIO_RESET_BYTES);
 	atomic_set(&bio->__bi_remaining, 1);
 	bio->bi_bdev = bdev;
+	if (bio->bi_bdev)
+		bio_associate_blkg(bio);
 	bio->bi_opf = opf;
 }
 EXPORT_SYMBOL(bio_reset);
-- 
2.30.2

