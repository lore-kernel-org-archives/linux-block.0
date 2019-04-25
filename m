Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC84C282E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7416A217D7
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+u05aZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbfDYHFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:05:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfDYHFK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 03:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xQ73h+2avdn47Cr/SP1ZrNFYanI/xoT9mgADZCKrD+o=; b=r+u05aZZ1qBNM63tI+fbyZTD4L
        AYYkmiG+EWHdvdgY5tW7H/z5CVE1i00f4Gni/q1VWygyFuxa/bNjkjzxXjUYTQHyy5WH0hc5iGp3Y
        B0KBhp6smr9nvtm6eeROZRDQs71WNvIP6EIJF5SWKk2Roiq1wO/H7FVMnMLUri8Bw7/aMPJz7qnoh
        TYYhYYWH2Cmzjt+sWh+fqMdZUqMD/+CKquojJOL/crbjjpANUE3jGvVDjrwdxl5gcsYS40t1/zHDs
        WwKYrZ6vLDIzhLY8+nL+zQbH2xBiO1X07zdoPdQTOq5rPend3dyKock0fEQ5GURAkm07wYMJheFeH
        4u2PqIVQ==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYRS-0007Wp-58; Thu, 25 Apr 2019 07:05:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: clean up __bio_add_pc_page a bit
Date:   Thu, 25 Apr 2019 09:04:35 +0200
Message-Id: <20190425070435.3478-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425070435.3478-1-hch@lst.de>
References: <20190425070435.3478-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Share the bi_size update by moving the done label up, and duplicate
the bv_len update in the two callers to get rid of the bvec_merge
label.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index de26dc18bceb..029afb121a48 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -731,9 +731,7 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		    offset == bvec->bv_offset + bvec->bv_len) {
 			if (put_same_page)
 				put_page(page);
- bvec_merge:
 			bvec->bv_len += len;
-			bio->bi_iter.bi_size += len;
 			goto done;
 		}
 
@@ -745,8 +743,10 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 			return 0;
 
 		if (page_is_mergeable(bvec, page, len, offset, false) &&
-				can_add_page_to_seg(q, bvec, page, len, offset))
-			goto bvec_merge;
+		    can_add_page_to_seg(q, bvec, page, len, offset)) {
+			bvec->bv_len += len;
+			goto done;
+		}
 	}
 
 	if (bio_full(bio))
@@ -760,9 +760,8 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	bvec->bv_len = len;
 	bvec->bv_offset = offset;
 	bio->bi_vcnt++;
-	bio->bi_iter.bi_size += len;
-
  done:
+	bio->bi_iter.bi_size += len;
 	bio->bi_phys_segments = bio->bi_vcnt;
 	bio_set_flag(bio, BIO_SEG_VALID);
 	return len;
-- 
2.20.1

