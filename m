Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C444BC06511
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C715218A3
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lTTgLqpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfGCNAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:00:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfGCNAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 09:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PPBKSaDVsotEOWPk6bI1IwvRtVhG5tYAk8o3o2f7qDg=; b=lTTgLqpk72b4igQ3UzCARwo/HR
        x0FKfgC4Cjsc73x3Wc87Heu3soYPU4VHws0AZuEk69WY4//DXlaFpa/o+eMkMebC1XAaI4iPo8i+Y
        Qc7LmU9vyx1su54qFH/593ZLVoamloGQHRT060hnzuXDty6gHSx2nwwMW+8kjr5pxsBBMt0xX8r7j
        T/QTNuqnCcDisPp+eizk4aRX1tlA0e4WYBV/jIlYDAMsm5oEYRRKqK3RymYjML361dVzTbr2+qody
        a1JH3I1RAkYp5e9uIDGVdttolG4SmMnh2aLnxuJKor+kMW7Gk9H2SYy4mTKNkHVtUoxm63YkDGAVD
        Zw6wAeLg==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiesQ-0006ZI-0Y; Wed, 03 Jul 2019 13:00:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: move same page handling from __bio_add_pc_page to the callers
Date:   Wed,  3 Jul 2019 06:00:36 -0700
Message-Id: <20190703130036.4105-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703130036.4105-1-hch@lst.de>
References: <20190703130036.4105-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hiding page refcount manipulation inside a low-level bio helper is
somewhat awkward.  Instead return the same page information to the
callers, where it fits in much better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1db626f99bcb..631b590a479f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -668,7 +668,7 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
  *	@page: page to add
  *	@len: vec entry length
  *	@offset: vec entry offset
- *	@put_same_page: put the page if it is same with last added page
+ *	@same_page: return if the merge happen inside the same page
  *
  *	Attempt to add a page to the bio_vec maplist. This can fail for a
  *	number of reasons, such as the bio being full or target block device
@@ -679,10 +679,9 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
  */
 static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
-		bool put_same_page)
+		bool *same_page)
 {
 	struct bio_vec *bvec;
-	bool same_page = false;
 
 	/*
 	 * cloned bio must not modify vec list
@@ -694,12 +693,8 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_pc_page(q, bio, page, len, offset,
-				&same_page)) {
-			if (put_same_page && same_page)
-				put_page(page);
+		if (bio_try_merge_pc_page(q, bio, page, len, offset, same_page))
 			return len;
-		}
 
 		/*
 		 * If the queue doesn't support SG gaps and adding this segment
@@ -728,7 +723,8 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset)
 {
-	return __bio_add_pc_page(q, bio, page, len, offset, false);
+	bool same_page = false;
+	return __bio_add_pc_page(q, bio, page, len, offset, &same_page);
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
@@ -1369,13 +1365,17 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 			for (j = 0; j < npages; j++) {
 				struct page *page = pages[j];
 				unsigned int n = PAGE_SIZE - offs;
+				bool same_page = false;
 
 				if (n > bytes)
 					n = bytes;
 
 				if (!__bio_add_pc_page(q, bio, page, n, offs,
-							true))
+						&same_page)) {
+					if (same_page)
+						put_page(page);
 					break;
+				}
 
 				added += n;
 				bytes -= n;
-- 
2.20.1

