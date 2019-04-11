Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF4C282CE
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7542184B
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDKVJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfDKVJI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 17:09:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C68FA31028C4;
        Thu, 11 Apr 2019 21:09:07 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 873725C21E;
        Thu, 11 Apr 2019 21:09:04 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v1 11/15] block: make sure bio_add_page*() knows page that are coming from GUP
Date:   Thu, 11 Apr 2019 17:08:30 -0400
Message-Id: <20190411210834.4105-12-jglisse@redhat.com>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 11 Apr 2019 21:09:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

When we get a page reference through get_user_page*() we want to keep
track of that so pass down that information to bio_add_page*().

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>
---
 block/bio.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 73227ede9a0a..197b70426aa6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -708,7 +708,10 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 	 * cannot add the page
 	 */
 	bvec = &bio->bi_io_vec[bio->bi_vcnt];
-	bvec_set_page(bvec, page);
+	if (is_gup)
+		bvec_set_gup_page(bvec, page);
+	else
+		bvec_set_page(bvec, page);
 	bvec->bv_len = len;
 	bvec->bv_offset = offset;
 	bio->bi_vcnt++;
@@ -793,6 +796,7 @@ EXPORT_SYMBOL_GPL(__bio_try_merge_page);
  * @page: page to add
  * @len: length of the data to add
  * @off: offset of the data in @page
+ * @is_gup: was the page referenced through GUP (get_user_page*)
  *
  * Add the data at @page + @off to @bio as a new bvec.  The caller must ensure
  * that @bio has space for another bvec.
@@ -805,7 +809,10 @@ void __bio_add_page(struct bio *bio, struct page *page,
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio));
 
-	bvec_set_page(bv, page);
+	if (is_gup)
+		bvec_set_gup_page(bv, page);
+	else
+		bvec_set_page(bv, page);
 	bv->bv_offset = off;
 	bv->bv_len = len;
 
@@ -820,6 +827,7 @@ EXPORT_SYMBOL_GPL(__bio_add_page);
  *	@page: page to add
  *	@len: vec entry length
  *	@offset: vec entry offset
+ *	@is_gup: was the page referenced through GUP (get_user_page*)
  *
  *	Attempt to add a page to the bio_vec maplist. This will only fail
  *	if either bio->bi_vcnt == bio->bi_max_vecs or it's a cloned bio.
@@ -830,7 +838,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (!__bio_try_merge_page(bio, page, len, offset, false)) {
 		if (bio_full(bio))
 			return 0;
-		__bio_add_page(bio, page, len, offset, false);
+		__bio_add_page(bio, page, len, offset, is_gup);
 	}
 	return len;
 }
@@ -885,6 +893,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
+	bool gup;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -894,6 +903,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
+	/* Is iov_iter_get_pages() using GUP ? */
+	gup = iov_iter_get_pages_use_gup(iter);
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
@@ -902,7 +913,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		struct page *page = pages[i];
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
-		if (WARN_ON_ONCE(bio_add_page(bio, page, len, offset, false) != len))
+		if (WARN_ON_ONCE(bio_add_page(bio, page, len,
+					      offset, gup) != len))
 			return -EINVAL;
 		offset = 0;
 	}
@@ -1372,6 +1384,10 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 		ssize_t bytes;
 		size_t offs, added = 0;
 		int npages;
+		bool gup;
+
+		/* Is iov_iter_get_pages() using GUP ? */
+		gup = iov_iter_get_pages_use_gup(iter);
 
 		bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
 		if (unlikely(bytes <= 0)) {
@@ -1393,7 +1409,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 				if (n > bytes)
 					n = bytes;
 
-				if (!bio_add_pc_page(q, bio, page, n, offs, false))
+				if (!bio_add_pc_page(q, bio, page, n, offs, gup))
 					break;
 
 				/*
@@ -1412,8 +1428,12 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 		/*
 		 * release the pages we didn't map into the bio, if any
 		 */
-		while (j < npages)
-			put_page(pages[j++]);
+		while (j < npages) {
+			if (gup)
+				put_user_page(pages[j++]);
+			else
+				put_page(pages[j++]);
+		}
 		kvfree(pages);
 		/* couldn't stuff something into bio? */
 		if (bytes)
-- 
2.20.1

