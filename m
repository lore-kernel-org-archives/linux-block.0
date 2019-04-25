Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611BC10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D4F217D7
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oLHlAvqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfDYHFF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:05:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfDYHFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 03:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2TwHWgFVVH75HO3UajTc6bZCO6+yc3fIfCxTvkcUst0=; b=oLHlAvqZGL3g3AtLZOr83KZNko
        Q3XZzdW+G1N7fBoHtqG4Czs8hOzwDk3BJNXBTWjhB89cjhwMVBnufvwJEr+EkPNDutM/nSCcgOQdl
        W+AfiYVGA39BsKpyUBgQdjt706c4TwnKhe9M8wmRcUv1kEXQaGGZP2oNEn82ccLNhAU1WdSAvrCFU
        /aNNlHNE/Nq4s9diAEeC/wtDWKu9syg8Wn0519MOSSMnMvw+GUNRzZczYiUm+fIBmxrcyHBLFVc6k
        Vh4hGPalS9kKH5buPWCLB0w9LdsyZ7TLrImNbgfnCXAXZhaVmqCVuZTcSx0FyFqecCqw6xRLDJJgn
        3PDO5LmA==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYRM-0006Td-QP; Thu, 25 Apr 2019 07:05:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: remove the __bio_add_pc_page export
Date:   Thu, 25 Apr 2019 09:04:33 +0200
Message-Id: <20190425070435.3478-2-hch@lst.de>
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

The same page optimization is a rather odd corner case, which is not
used outside bio.c and which really should not be used outside of bio.c
either - we have better highlevel helpers like the rq/bio mapping
helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 3 +--
 include/linux/bio.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9ad0d00cdc9b..e717b303e1fb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -709,7 +709,7 @@ static bool can_add_page_to_seg(struct request_queue *q,
  *
  *	This should only be used by passthrough bios.
  */
-int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		bool put_same_page)
 {
@@ -776,7 +776,6 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	bio_set_flag(bio, BIO_SEG_VALID);
 	return len;
 }
-EXPORT_SYMBOL(__bio_add_pc_page);
 
 int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 186b2723c61b..077cecdf9437 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -435,9 +435,6 @@ void bio_chain(struct bio *, struct bio *);
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
-extern int __bio_add_pc_page(struct request_queue *, struct bio *,
-			     struct page *, unsigned int, unsigned int,
-			     bool);
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
-- 
2.20.1

