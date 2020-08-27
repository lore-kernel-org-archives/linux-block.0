Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD94C433E3
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A512177B
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dp1GkeR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH0Phx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Phw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 11:37:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EC0C061264
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2020 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dg+Pw3ffK+CKK2YOFQs9gIaqFz7C/uY6fIG4tpdNGDo=; b=Dp1GkeR9exPA9oZ50ufzQ8xVq5
        QjqsFrBWgY1Fe2SnN7nR5kwbFi/o8Qm0PNHBv4CgZzOy6J6WJ1TVQPAEO0TGeLHbLsnslqz/0i89a
        Ssz2zTVNl+bHn3wH9MLcdmZUOF9HICd3P5r8WHCRd6G+G/ImlEUCaD96fUi4f7MEH3q6EFaO1PUZt
        fMVC4mA/AGCCprAiV4tf3oC+tIb9Cwxok/39J4TmlEGCoTyKL4VEEo+jkN4/Pa91bmhW35AC53921
        0YG/0Z4deqPWZBgh04UWbMJYe4gxFnSs2d12ZvrinctJzTTHDN5NiG9kt0KrleRGb0AUag8+N6uJJ
        e3VfTzsQ==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJyI-0006xT-Pk; Thu, 27 Aug 2020 15:37:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: remove the BIO_NULL_MAPPED flag
Date:   Thu, 27 Aug 2020 17:37:45 +0200
Message-Id: <20200827153748.378424-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153748.378424-1-hch@lst.de>
References: <20200827153748.378424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can simply use a boolean flag in the bio_map_data data structure
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c           | 9 +++++----
 include/linux/blk_types.h | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 6e804892d5ec6a..51e6195f878d3c 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -12,7 +12,8 @@
 #include "blk.h"
 
 struct bio_map_data {
-	int is_our_pages;
+	bool is_our_pages : 1;
+	bool is_null_mapped : 1;
 	struct iov_iter iter;
 	struct iovec iov[];
 };
@@ -108,7 +109,7 @@ static int bio_uncopy_user(struct bio *bio)
 	struct bio_map_data *bmd = bio->bi_private;
 	int ret = 0;
 
-	if (!bio_flagged(bio, BIO_NULL_MAPPED)) {
+	if (!bmd || !bmd->is_null_mapped) {
 		/*
 		 * if we're in a workqueue, the request is orphaned, so
 		 * don't copy into a random user address space, just free
@@ -158,7 +159,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 	 * The caller provided iov might point to an on-stack or otherwise
 	 * shortlived one.
 	 */
-	bmd->is_our_pages = map_data ? 0 : 1;
+	bmd->is_our_pages = !map_data;
 
 	nr_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
 	if (nr_pages > BIO_MAX_PAGES)
@@ -234,7 +235,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 
 	bio->bi_private = bmd;
 	if (map_data && map_data->null_mapped)
-		bio_set_flag(bio, BIO_NULL_MAPPED);
+		bmd->is_null_mapped = true;
 	return bio;
 cleanup:
 	if (!map_data)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4ecf4fed171f0d..3d1bd8dad69baf 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -256,7 +256,6 @@ enum {
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_USER_MAPPED,	/* contains user pages */
-	BIO_NULL_MAPPED,	/* contains invalid user pages */
 	BIO_WORKINGSET,		/* contains userspace workingset pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
-- 
2.28.0

