Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82588C04A94
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGXQyj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjGXQyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5980DB7
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=h8zEt1XgMZMmMv7pSGycCAsQPgI06zFL2S70tYLRonI=; b=cuZgzE+A90s6er4YKGdICwMPt9
        E6qe+5XLgr4mAKvWDTuacVuy9DidlF9hS6u4pSiZg7Jt7GZkieWI8ej+kOk7wIuUesSip6yxZPZr1
        XG+A0neKHWNwMOk99AOLefrft5Pc7npGHwLCVpnuMTF4VtqNntKpubDo8LauCF77dw090+4SfnwIt
        LZzYK6U6jEV5EXs/5UejkoOOyhLtONyp04rZXuF3oGiRNBxAsLlhHBxuz3JM/IhCit95eiRkgCvYZ
        g0SZG3pdFCxK77L/2cNAcU7iBaDX1q997RehOiLvl1AR3pY/ce5o73jib5RFltkWC06gaO7cmYQT+
        SI5TXNAw==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNypO-004vuS-1D;
        Mon, 24 Jul 2023 16:54:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/8] block: move the bi_size overflow check in __bio_try_merge_page
Date:   Mon, 24 Jul 2023 09:54:30 -0700
Message-Id: <20230724165433.117645-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724165433.117645-1-hch@lst.de>
References: <20230724165433.117645-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Checking for availability in bi_size in a function that attempts to
merge into an existing segment is a bit odd, as the limit also applies
when adding a new segment.  This code works fine as we always call
__bio_try_merge_page, but contributes to sub-optimal calling conventions
and doesn't lead to clear code.

Move it to two of the callers instead, the third one already has a more
strict check that includes max_hw_segments anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3dcbe98580dcef..17f57fd2cff2f1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -949,10 +949,6 @@ static bool __bio_try_merge_page(struct bio *bio, struct page *page,
 
 	if (!page_is_mergeable(bv, page, len, off, same_page))
 		return false;
-	if (bio->bi_iter.bi_size > UINT_MAX - len) {
-		*same_page = false;
-		return false;
-	}
 	bv->bv_len += len;
 	bio->bi_iter.bi_size += len;
 	return true;
@@ -1123,6 +1119,8 @@ int bio_add_page(struct bio *bio, struct page *page,
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
+	if (bio->bi_iter.bi_size > UINT_MAX - len)
+		return 0;
 
 	if (bio->bi_vcnt > 0 &&
 	    __bio_try_merge_page(bio, page, len, offset, &same_page))
@@ -1204,6 +1202,9 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 {
 	bool same_page = false;
 
+	if (WARN_ON_ONCE(bio->bi_iter.bi_size > UINT_MAX - len))
+		return -EIO;
+
 	if (bio->bi_vcnt > 0 &&
 	    __bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		if (same_page)
-- 
2.39.2

