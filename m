Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986ABC282DA
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689402083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfDKVJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:09:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfDKVI6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 17:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0FA5DC8FB;
        Thu, 11 Apr 2019 21:08:57 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 397AA5C220;
        Thu, 11 Apr 2019 21:08:54 +0000 (UTC)
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
Subject: [PATCH v1 06/15] block: convert bio_vec.bv_page to bv_pfn to store pfn and not page
Date:   Thu, 11 Apr 2019 17:08:25 -0400
Message-Id: <20190411210834.4105-7-jglisse@redhat.com>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 11 Apr 2019 21:08:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

To be able to store flags with each bio_vec store the pfn value and
not the page this leave us with couple uppers bits we can latter use
for flags.

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
 Documentation/block/biodoc.txt |  7 +++++--
 include/linux/bvec.h           | 29 +++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index ac18b488cb5e..c673d4285781 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -410,7 +410,7 @@ mapped to bio structures.
 2.2 The bio struct
 
 The bio structure uses a vector representation pointing to an array of tuples
-of <page, offset, len> to describe the i/o buffer, and has various other
+of <pfn, offset, len> to describe the i/o buffer, and has various other
 fields describing i/o parameters and state that needs to be maintained for
 performing the i/o.
 
@@ -418,11 +418,14 @@ Notice that this representation means that a bio has no virtual address
 mapping at all (unlike buffer heads).
 
 struct bio_vec {
-       struct page     *bv_page;
+       unsigned long   *bv_pfn;
        unsigned short  bv_len;
        unsigned short  bv_offset;
 };
 
+You should not access the bv_pfn fields directly but use helpers to get the
+corresponding struct page as bv_pfn can encode more than page pfn value.
+
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers)
  */
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d701cd968f13..ac84ac66a333 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -29,7 +29,7 @@
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
  */
 struct bio_vec {
-	struct page	*bv_page;
+	unsigned long	bv_pfn;
 	unsigned int	bv_len;
 	unsigned int	bv_offset;
 };
@@ -51,14 +51,19 @@ struct bvec_iter_all {
 	unsigned	done;
 };
 
+static inline unsigned long page_to_bvec_pfn(struct page *page)
+{
+	return page ? page_to_pfn(page) : -1UL;
+}
+
 static inline struct page *bvec_page(const struct bio_vec *bvec)
 {
-	return bvec->bv_page;
+	return bvec->bv_pfn == -1UL ? NULL : pfn_to_page(bvec->bv_pfn);
 }
 
 static inline void bvec_set_page(struct bio_vec *bvec, struct page *page)
 {
-	bvec->bv_page = page;
+	bvec->bv_pfn = page_to_bvec_pfn(page);
 }
 
 static inline struct page *bvec_nth_page(struct page *page, int idx)
@@ -70,11 +75,15 @@ static inline struct page *bvec_nth_page(struct page *page, int idx)
  * various member access, note that bio_data should of course not be used
  * on highmem page vectors
  */
-#define BIO_VEC_INIT(p, l, o) {.bv_page = (p), .bv_len = (l), .bv_offset = (o)}
+#define BIO_VEC_INIT(p, l, o) {.bv_pfn = page_to_bvec_pfn(p), \
+				.bv_len = (l), .bv_offset = (o)}
 
 #define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
 
 /* multi-page (mp_bvec) helpers */
+#define mp_bvec_iter_pfn(bvec, iter)				\
+	((__bvec_iter_bvec((bvec), (iter)))->bv_pfn)
+
 #define mp_bvec_iter_page(bvec, iter)				\
 	(bvec_page(__bvec_iter_bvec((bvec), (iter))))
 
@@ -90,7 +99,7 @@ static inline struct page *bvec_nth_page(struct page *page, int idx)
 
 #define mp_bvec_iter_bvec(bvec, iter)				\
 ((struct bio_vec) {						\
-	.bv_page	= mp_bvec_iter_page((bvec), (iter)),	\
+	.bv_pfn		= mp_bvec_iter_pfn((bvec), (iter)),	\
 	.bv_len		= mp_bvec_iter_len((bvec), (iter)),	\
 	.bv_offset	= mp_bvec_iter_offset((bvec), (iter)),	\
 })
@@ -100,16 +109,20 @@ static inline struct page *bvec_nth_page(struct page *page, int idx)
 	(mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
 
 #define bvec_iter_len(bvec, iter)				\
-	min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),		\
+	min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),	\
 	      PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
 
 #define bvec_iter_page(bvec, iter)				\
-	bvec_nth_page(mp_bvec_iter_page((bvec), (iter)),		\
+	bvec_nth_page(mp_bvec_iter_page((bvec), (iter)),	\
 		      mp_bvec_iter_page_idx((bvec), (iter)))
 
+#define bvec_iter_pfn(bvec, iter)				\
+	(mp_bvec_iter_pfn((bvec), (iter)) +			\
+	 mp_bvec_iter_page_idx((bvec), (iter)))
+
 #define bvec_iter_bvec(bvec, iter)				\
 ((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
+	.bv_pfn		= bvec_iter_pfn((bvec), (iter)),	\
 	.bv_len		= bvec_iter_len((bvec), (iter)),	\
 	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
 })
-- 
2.20.1

