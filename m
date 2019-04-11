Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE8EC282DA
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486F20850
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDKVJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:09:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfDKVJA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 17:09:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80026A1F6F;
        Thu, 11 Apr 2019 21:08:59 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E0C05C221;
        Thu, 11 Apr 2019 21:08:57 +0000 (UTC)
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
Subject: [PATCH v1 07/15] block: add bvec_put_page_dirty*() to replace put_page(bvec_page())
Date:   Thu, 11 Apr 2019 17:08:26 -0400
Message-Id: <20190411210834.4105-8-jglisse@redhat.com>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 11 Apr 2019 21:08:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

For bio_vec.page we need to use the appropriate put_page ie put_user_page
if the page reference was taken through GUP (any of the get_user_page*)
or the regular put_page otherwise.

To distinguish between the two we store a flag as the top if of the pfn
values on all archectitecture we have at least one bit available there.

We also take care of dirtnyness ie calling set_page_dirty*().

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
 include/linux/bvec.h | 52 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ac84ac66a333..a1e464c708fb 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -20,6 +20,7 @@
 #ifndef __LINUX_BVEC_ITER_H
 #define __LINUX_BVEC_ITER_H
 
+#include <asm/bitsperlong.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
@@ -34,6 +35,9 @@ struct bio_vec {
 	unsigned int	bv_offset;
 };
 
+#define BVEC_PFN_GUP (1UL << (BITS_PER_LONG - 1))
+#define BVEC_PFN_MASK (~BVEC_PFN_GUP)
+
 struct bvec_iter {
 	sector_t		bi_sector;	/* device address in 512 byte
 						   sectors */
@@ -58,7 +62,13 @@ static inline unsigned long page_to_bvec_pfn(struct page *page)
 
 static inline struct page *bvec_page(const struct bio_vec *bvec)
 {
-	return bvec->bv_pfn == -1UL ? NULL : pfn_to_page(bvec->bv_pfn);
+	return bvec->bv_pfn == -1UL ? NULL :
+		pfn_to_page(bvec->bv_pfn & BVEC_PFN_MASK);
+}
+
+static inline void bvec_set_gup_page(struct bio_vec *bvec, struct page *page)
+{
+	bvec->bv_pfn = page_to_bvec_pfn(page) | BVEC_PFN_GUP;
 }
 
 static inline void bvec_set_page(struct bio_vec *bvec, struct page *page)
@@ -71,6 +81,46 @@ static inline struct page *bvec_nth_page(struct page *page, int idx)
 	return idx == 0 ? page : nth_page(page, idx);
 }
 
+static inline void bvec_put_page(const struct bio_vec *bvec)
+{
+	struct page *page = bvec_page(bvec);
+
+	if (page == NULL)
+		return;
+
+	if (bvec->bv_pfn & BVEC_PFN_GUP)
+		put_user_page(page);
+	else
+		put_page(page);
+}
+
+static inline void bvec_put_page_dirty(const struct bio_vec *bvec, bool dirty)
+{
+	struct page *page = bvec_page(bvec);
+
+	if (page == NULL)
+		return;
+
+	if (dirty)
+		set_page_dirty(page);
+
+	bvec_put_page(bvec);
+}
+
+static inline void bvec_put_page_dirty_lock(const struct bio_vec *bvec,
+					    bool dirty)
+{
+	struct page *page = bvec_page(bvec);
+
+	if (page == NULL)
+		return;
+
+	if (dirty)
+		set_page_dirty_lock(page);
+
+	bvec_put_page(bvec);
+}
+
 /*
  * various member access, note that bio_data should of course not be used
  * on highmem page vectors
-- 
2.20.1

