Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C738C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139542081B
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCIB5v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:57:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfCIB5u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 20:57:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83D2680F9A;
        Sat,  9 Mar 2019 01:57:50 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF5A9608CC;
        Sat,  9 Mar 2019 01:38:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] block: put the same page when adding it to bio
Date:   Sat,  9 Mar 2019 09:37:35 +0800
Message-Id: <20190309013737.27741-5-ming.lei@redhat.com>
In-Reply-To: <20190309013737.27741-1-ming.lei@redhat.com>
References: <20190309013737.27741-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sat, 09 Mar 2019 01:57:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the added page is merged to last same page in bio_add_pc_page(),
the user may need to put this page for avoiding page leak.

bio_map_user_iov() needs this kind of handling, and now it deals with
it by itself in hack style.

Moves the handling of put page into __bio_add_pc_page(), so
bio_map_user_iov() may be simplified a bit, and maybe more users
can benefit from this change.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c         | 23 ++++++++++-------------
 include/linux/bio.h | 12 ++++++++++--
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 62411877224c..95ec5e893265 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -666,12 +666,13 @@ page_is_mergeable(const struct bio_vec *bv, struct page *page,
 }
 
 /**
- *	bio_add_pc_page	-	attempt to add page to bio
+ *	__bio_add_pc_page	-	attempt to add page to bio
  *	@q: the target queue
  *	@bio: destination bio
  *	@page: page to add
  *	@len: vec entry length
  *	@offset: vec entry offset
+ *	@put_same_page: put the page if it is same with last added page
  *
  *	Attempt to add a page to the bio_vec maplist. This can fail for a
  *	number of reasons, such as the bio being full or target block device
@@ -680,8 +681,9 @@ page_is_mergeable(const struct bio_vec *bv, struct page *page,
  *
  *	This should only be used by REQ_PC bios.
  */
-int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
-		    *page, unsigned int len, unsigned int offset)
+int __bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
+		      *page, unsigned int len, unsigned int offset,
+		      bool put_same_page)
 {
 	int retried_segments = 0;
 	struct bio_vec *bvec;
@@ -705,6 +707,8 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 
 		if (page == prev->bv_page &&
 		    offset == prev->bv_offset + prev->bv_len) {
+			if (put_same_page)
+				put_page(page);
 			prev->bv_len += len;
 			bio->bi_iter.bi_size += len;
 			goto done;
@@ -763,7 +767,7 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 	blk_recount_segments(q, bio);
 	return 0;
 }
-EXPORT_SYMBOL(bio_add_pc_page);
+EXPORT_SYMBOL(__bio_add_pc_page);
 
 /**
  * __bio_try_merge_page - try appending data to an existing bvec.
@@ -1394,21 +1398,14 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 			for (j = 0; j < npages; j++) {
 				struct page *page = pages[j];
 				unsigned int n = PAGE_SIZE - offs;
-				unsigned short prev_bi_vcnt = bio->bi_vcnt;
 
 				if (n > bytes)
 					n = bytes;
 
-				if (!bio_add_pc_page(q, bio, page, n, offs))
+				if (!__bio_add_pc_page(q, bio, page, n, offs,
+							true))
 					break;
 
-				/*
-				 * check if vector was merged with previous
-				 * drop page reference if needed
-				 */
-				if (bio->bi_vcnt == prev_bi_vcnt)
-					put_page(page);
-
 				added += n;
 				bytes -= n;
 				offs = 0;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index bb6090aa165d..28b8c46de11c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -430,8 +430,16 @@ extern void bio_reset(struct bio *);
 void bio_chain(struct bio *, struct bio *);
 
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
-extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
-			   unsigned int, unsigned int);
+extern int __bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
+			   unsigned int, unsigned int, bool);
+
+static inline int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
+		    *page, unsigned int len, unsigned int offset)
+{
+	return __bio_add_pc_page(q, bio, page, len, offset, false);
+}
+
+
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
-- 
2.9.5

