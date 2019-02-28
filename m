Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B0C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55869218B0
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 16:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+ANmWtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfB1QAi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:00:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfB1QAi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 11:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=96Hca5yLpoltlyMq41bcBv67QNu0z1eOrF1d8KYhsVk=; b=d+ANmWtEmjAxmZZdMIXPeTevC
        WBKEbdTupibo3cFi3j5bFLWOkUUfYUgonGJuWHggD0Bf+xSGrTl5Wk0iojQsF7zExKBr7AVmhI1Vh
        3c/EoHFlmYA7uXzfk6H/q5HaBb/RjDBW5DpGH2xZudcqo69+4P+TAg4Q+IDcBz8fZ/xX7UDW5tnDN
        bzSZaZGtULb7HWAwHgGEJkb2wZFI899t4gkf46dMsjSMS2e071D0Dp6WB4eGVwaAhl91fZbKH9vjj
        heqdiagXFy4IiqY3sky6Hbh4KKfyYFu40gQXznr3NX9Rk8s7OMISY3m20UkIPwTP616mrvrtYR2Ua
        bWo95ppYw==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzO6t-0003wn-Dj; Thu, 28 Feb 2019 16:00:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH] block: optimize bvec iteration in bvec_iter_advance
Date:   Thu, 28 Feb 2019 11:00:18 -0500
Message-Id: <20190228160018.3652-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to only iterate in chunks of PAGE_SIZE or less in
bvec_iter_advance, given that the callers pass in the chunk length that
they are operating on - either that already is less than PAGE_SIZE
because they do classic page-based iteration, or it is larger because
the caller operates on multi-page bvecs.

This should help optimizing shaving off a few cycles of the I/O hot
path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bvec.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 2c32e3e151a0..cf06c0647c4f 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -112,14 +112,15 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	}
 
 	while (bytes) {
-		unsigned iter_len = bvec_iter_len(bv, *iter);
-		unsigned len = min(bytes, iter_len);
+		const struct bio_vec *cur = bv + iter->bi_idx;
+		unsigned len = min3(bytes, iter->bi_size,
+				    cur->bv_len - iter->bi_bvec_done);
 
 		bytes -= len;
 		iter->bi_size -= len;
 		iter->bi_bvec_done += len;
 
-		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
+		if (iter->bi_bvec_done == cur->bv_len) {
 			iter->bi_bvec_done = 0;
 			iter->bi_idx++;
 		}
-- 
2.20.1

