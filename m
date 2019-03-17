Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090AFC43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69BC2085A
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfCQKB4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfCQKB4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 06:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 140D830832D4;
        Sun, 17 Mar 2019 10:01:56 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9364B60165;
        Sun, 17 Mar 2019 10:01:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 06/10] block: put the same page when adding it to bio
Date:   Sun, 17 Mar 2019 18:01:08 +0800
Message-Id: <20190317100112.8106-7-ming.lei@redhat.com>
In-Reply-To: <20190317100112.8106-1-ming.lei@redhat.com>
References: <20190317100112.8106-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 17 Mar 2019 10:01:56 +0000 (UTC)
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
 block/bio.c         | 28 ++++++++++++++++------------
 include/linux/bio.h |  3 +++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5ac8692e3986..4b37f5173c66 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -666,12 +666,13 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 }
 
 /**
- *	bio_add_pc_page	-	attempt to add page to passthrough bio
+ *	__bio_add_pc_page	- attempt to add page to passthrough bio
  *	@q: the target queue
  *	@bio: destination bio
  *	@page: page to add
  *	@len: vec entry length
  *	@offset: vec entry offset
+ *	@put_same_page: put the page if it is same with last added page
  *
  *	Attempt to add a page to the bio_vec maplist. This can fail for a
  *	number of reasons, such as the bio being full or target block device
@@ -680,8 +681,9 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
  *
  *	This should only be used by passthrough bios.
  */
-int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
-		    *page, unsigned int len, unsigned int offset)
+int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		bool put_same_page)
 {
 	int retried_segments = 0;
 	struct bio_vec *bvec;
@@ -705,6 +707,8 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 
 		if (page == bvec->bv_page &&
 		    offset == bvec->bv_offset + bvec->bv_len) {
+			if (put_same_page)
+				put_page(page);
 			bvec->bv_len += len;
 			bio->bi_iter.bi_size += len;
 			goto done;
@@ -763,6 +767,13 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 	blk_recount_segments(q, bio);
 	return 0;
 }
+EXPORT_SYMBOL(__bio_add_pc_page);
+
+int bio_add_pc_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset)
+{
+	return __bio_add_pc_page(q, bio, page, len, offset, false);
+}
 EXPORT_SYMBOL(bio_add_pc_page);
 
 /**
@@ -1394,21 +1405,14 @@ struct bio *bio_map_user_iov(struct request_queue *q,
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
index bb6090aa165d..bb915591557b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -432,6 +432,9 @@ void bio_chain(struct bio *, struct bio *);
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
+extern int __bio_add_pc_page(struct request_queue *, struct bio *,
+			     struct page *, unsigned int, unsigned int,
+			     bool);
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
-- 
2.9.5

