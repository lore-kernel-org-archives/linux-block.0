Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6EC282E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CEE217D7
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DalVC5TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfDYHDb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:03:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYHDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 03:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LYAkLO2zbJj2lcqmOaVAhBMg2HIzqejXB0LqGnsq8G8=; b=DalVC5TRzmx6YQlHebBJAldIVM
        8h4rj27enr6eItK0s/1OLV0xVdygzToROOyviketi0ITO3O479mQnZE2r35Z2MozUCC54mIXwc/D/
        rMkZmEwrHtvMLmlqZJTJ02lmhMUMj5SbvrPLdfuscQ64AC8AGnr0MqaOs/ZUG/mLqXAZCFaqtqkEr
        w76KgG7By8rR7wwIOeAlfI+ZGoOYnUNeihJtMI95iaYfeGz+RVV0GjyeS9hMJ2SmH2NBkBNOKTHlT
        Fe9/Z8fWDWts5k3RjMyzBvBxFNSEqyEwNtbrD3f3pmn3fHelnEcmqgy1nAb2TKzajPTUKGmuJskrY
        6FkzPChg==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYPq-0006Ch-3Y; Thu, 25 Apr 2019 07:03:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: [PATCH 1/2] bcache: clean up do_btree_node_write a bit
Date:   Thu, 25 Apr 2019 09:02:59 +0200
Message-Id: <20190425070300.3388-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425070300.3388-1-hch@lst.de>
References: <20190425070300.3388-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a variable containing the buffer address instead of the to be
removed integer iterator from bio_for_each_segment_all.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/btree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index b139858b0802..3a9f8ed437de 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -431,12 +431,13 @@ static void do_btree_node_write(struct btree *b)
 	if (!bch_bio_alloc_pages(b->bio, __GFP_NOWARN|GFP_NOWAIT)) {
 		int j;
 		struct bio_vec *bv;
-		void *base = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
+		void *addr = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
 		struct bvec_iter_all iter_all;
 
-		bio_for_each_segment_all(bv, b->bio, j, iter_all)
-			memcpy(page_address(bv->bv_page),
-			       base + j * PAGE_SIZE, PAGE_SIZE);
+		bio_for_each_segment_all(bv, b->bio, j, iter_all) {
+			memcpy(page_address(bv->bv_page), addr, PAGE_SIZE);
+			addr += PAGE_SIZE;
+		}
 
 		bch_submit_bbio(b->bio, b->c, &k.key, 0);
 
-- 
2.20.1

