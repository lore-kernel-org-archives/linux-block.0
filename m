Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD3C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F0560E05
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJLQ3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQ3y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:29:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BDBC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MAaLmzdPkt92qPqFPQ4YkOTO22u6dy+N8vyCPXUtXvE=; b=W1QuWY2NsgjE8SjQNuDiRDwAQs
        uHgCUJErl7O14qBQgJaUgr6LPEwgYzd9xSigIbDIUFjRndIcL+mhLM6O4UedIIuUob5Eiyi/occsF
        xwGFF2mqyf1S3dnxiBuABVghsI1zNoaG1nG3ranEPHE5oxOzqclneAfV0L/UetwZaz+kRETGZBK3F
        13ZUVymtO/D5z2ZPqmV/q+evaV5NhvAkVWmEuS1MuurzBeNY1IUt7yj6N7G6kWvC5+FfQZRorrkOW
        2F76mZ3aXOoX1y+eDzFVGyQDI9OSixx34neyPZyLnAJ9wxV73sw9sA7I3dE1RYu8kmei2y7x9r+MB
        F7mEShIQ==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKcA-006eKn-J0; Tue, 12 Oct 2021 16:27:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 8/8] block: mark bio_truncate static
Date:   Tue, 12 Oct 2021 18:18:04 +0200
Message-Id: <20211012161804.991559-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_truncate is only used in bio.c, so mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 2 +-
 include/linux/bio.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c89e402356a59..d5120451c36a3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -546,7 +546,7 @@ EXPORT_SYMBOL(zero_fill_bio);
  *   REQ_OP_READ, zero the truncated part. This function should only
  *   be used for handling corner cases, such as bio eod.
  */
-void bio_truncate(struct bio *bio, unsigned new_size)
+static void bio_truncate(struct bio *bio, unsigned new_size)
 {
 	struct bio_vec bv;
 	struct bvec_iter iter;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4c5106f2ed57e..d8d27742a75f9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -405,7 +405,6 @@ extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			       struct bio *src, struct bvec_iter *src_iter);
 extern void bio_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
-void bio_truncate(struct bio *bio, unsigned new_size);
 void guard_bio_eod(struct bio *bio);
 void zero_fill_bio(struct bio *bio);
 
-- 
2.30.2

