Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7641BC77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbjELNjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjELNjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609D1387B
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PZg1TbIPC8qE49UMW1O5Ydy4Q/LUob5wE4DForL/9zU=; b=EnAW8fTvz1kovOeHjhsTC5ZZct
        +KoiEUkxJvWgckGqMzOS+FNeumdclLv7SGgxNfdxgae9WkZ2F59gIilljNjatQcZu2yHW6R+wDAom
        FUX+komwfvxl2uzF7fGH2U2Kke2wkAj9Kt2BQGcr25d5mWOTQMSP0kkEVurvAwGgWI8rBUClVDbXj
        eE0BSeaAMN+HBbQ9JWlusapM8anv4I6/M4fYLSw+aYnVumM1EdkpgRkaHCHsNTHjoMV6uMfg1R/U1
        a43xZmtgz3fh7yAdIZR5dHiQXLGgpV944b9YDLYOh3i5m5g3aMI6ccTRaYFsolFM15UPXoNr9XmQn
        I3WYuzUw==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzK-00C2iJ-2h;
        Fri, 12 May 2023 13:39:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 5/8] block: move the bi_size overflow check in __bio_try_merge_page
Date:   Fri, 12 May 2023 06:38:58 -0700
Message-Id: <20230512133901.1053543-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
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
---
 block/bio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5d2c95e05b1a52..93e6bca3c2239f 100644
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
@@ -1197,6 +1195,9 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
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

