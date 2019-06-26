Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A183C48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298A42085A
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qCOXDLdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfFZNtt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:49:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfFZNtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K8KdzYaUH4xJkJVWKuaqSBkccKjfHhxegJmbc8y5v5o=; b=qCOXDLdm6+fKY4+DTUYLG4ChZ4
        Q/OW6znGzBeihNo5KG8RDGcYL4rVb3IauPPfAUaLSg/g1Zlqu7TOQL3hGQx7XExgyCNZMx+8Tv4Ct
        FYu28drFDUs6f6wffjHQXBdEtPqxXshCKMg04vnfOHanfJ/vBHZsEeLXazE4Rh5z///2p/rMBZVkC
        ptWpU+ZTa8R7zO593podznDyF+MHQFpRDptDmTKy6ecCxhAf16yJe6xegwPR1xwX2ndbM6oM+Iqu5
        kGXfCegqYIC5D9/fs1LGvOcNrzx6ReBme1waLjeYG+kCRYJeKngJ2xToNleLMLDN6lQ6MHwQWAcX/
        myWmsJdA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8J3-0003EM-1j; Wed, 26 Jun 2019 13:49:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 8/9] direct-io: use bio_release_pages in dio_bio_complete
Date:   Wed, 26 Jun 2019 15:49:27 +0200
Message-Id: <20190626134928.7988-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626134928.7988-1-hch@lst.de>
References: <20190626134928.7988-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bio_release_pages instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/direct-io.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index ac7fb19b6ade..ae196784f487 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -538,8 +538,8 @@ static struct bio *dio_await_one(struct dio *dio)
  */
 static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 {
-	struct bio_vec *bvec;
 	blk_status_t err = bio->bi_status;
+	bool should_dirty = dio->op == REQ_OP_READ && dio->should_dirty;
 
 	if (err) {
 		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
@@ -548,19 +548,10 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 			dio->io_error = -EIO;
 	}
 
-	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
+	if (dio->is_async && should_dirty) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
 	} else {
-		struct bvec_iter_all iter_all;
-
-		bio_for_each_segment_all(bvec, bio, iter_all) {
-			struct page *page = bvec->bv_page;
-
-			if (dio->op == REQ_OP_READ && !PageCompound(page) &&
-					dio->should_dirty)
-				set_page_dirty_lock(page);
-			put_page(page);
-		}
+		bio_release_pages(bio, should_dirty);
 		bio_put(bio);
 	}
 	return err;
-- 
2.20.1

