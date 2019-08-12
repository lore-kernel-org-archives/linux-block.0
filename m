Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761A5C433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B18E2085A
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 15:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NRxCKeNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHLPkL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:40:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHLPkL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 11:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YTDBTjPd7ekLBRE5sGfdUi2mYhUHaZiKi+iIg/dveWc=; b=NRxCKeNWox69+UlTVzjzD3jVoi
        71TKYXM2XLzdbZMtouKys7FuuHsa+vgM8P8gdNUkup636f6zgsZS2k8PStHsYdtSf0vhxH5C1zrJo
        8/aMvuSJio3ipVofTRW+blLXSbKxPw7T7XR6hj7iW2+OyrJ10e2oz62U5QMPvULzKns33fbIQgR10
        MsWSW6cA6CGaESuGqYU35onzPmTkrBfnqiHCMPUwh81A0iamCuMFOa62pvyErSAIQb33nkGcWjaFt
        riiAjv6XIrLaxES1Wb9hJJxHsn3M/eOMNfb7DNYHn5wpoj0uSrwW95t4A1oL4LgJIcq//Wz4IZoYU
        VKEvqtBQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxCQb-0003YC-VW; Mon, 12 Aug 2019 15:40:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: move same page handling from __bio_add_pc_page to the callers
Date:   Mon, 12 Aug 2019 17:39:58 +0200
Message-Id: <20190812153958.29560-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812153958.29560-1-hch@lst.de>
References: <20190812153958.29560-1-hch@lst.de>
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
index 6ea4b9257667..11aa6738ed62 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -669,7 +669,7 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
  *	@page: page to add
  *	@len: vec entry length
  *	@offset: vec entry offset
- *	@put_same_page: put the page if it is same with last added page
+ *	@same_page: return if the merge happen inside the same page
  *
  *	Attempt to add a page to the bio_vec maplist. This can fail for a
  *	number of reasons, such as the bio being full or target block device
@@ -680,10 +680,9 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
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
@@ -695,12 +694,8 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
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
@@ -729,7 +724,8 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset)
 {
-	return __bio_add_pc_page(q, bio, page, len, offset, false);
+	bool same_page = false;
+	return __bio_add_pc_page(q, bio, page, len, offset, &same_page);
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
@@ -1370,13 +1366,17 @@ struct bio *bio_map_user_iov(struct request_queue *q,
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

