Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05071C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 09:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D446420830
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 09:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDCJPl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:15:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfDCJPl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 05:15:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02456ADE7;
        Wed,  3 Apr 2019 09:15:39 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] block: bio: ensure newly added bio flags don't override BVEC_POOL_IDX
Date:   Wed,  3 Apr 2019 11:15:19 +0200
Message-Id: <20190403091519.13376-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the introduction of BIO_NO_PAGE_REF we've used up all available bits
in bio::bi_flags.

Convert the defines of the flags to an enum and add a BUILD_BUG_ON() call
to make sure no-one adds a new one and thus overrides the BVEC_POOL_IDX
causing crashes.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
This used to be part of my bio patchset but as it's a) not clear why we
end up calling bio_put() on the on-stack bio and b) the needed prep patch
for the fix introduces a regression, I've decided to sent this patch out
as it's valid on it's own.

I dropped Hannes' and Christoph's R-b though, as the context changed.
---
 block/bio.c               |  3 +++
 include/linux/blk_types.h | 29 ++++++++++++++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8d516d508ae3..c2592c5d70b9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2218,6 +2218,9 @@ static int __init init_bio(void)
 	bio_slab_nr = 0;
 	bio_slabs = kcalloc(bio_slab_max, sizeof(struct bio_slab),
 			    GFP_KERNEL);
+
+	BUILD_BUG_ON(BIO_FLAG_LAST > BVEC_POOL_OFFSET);
+
 	if (!bio_slabs)
 		panic("bio: can't allocate bios\n");
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 791fee35df88..be418275763c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -215,21 +215,24 @@ struct bio {
 /*
  * bio flags
  */
-#define BIO_NO_PAGE_REF	0	/* don't put release vec pages */
-#define BIO_SEG_VALID	1	/* bi_phys_segments valid */
-#define BIO_CLONED	2	/* doesn't own data */
-#define BIO_BOUNCED	3	/* bio is a bounce bio */
-#define BIO_USER_MAPPED 4	/* contains user pages */
-#define BIO_NULL_MAPPED 5	/* contains invalid user pages */
-#define BIO_QUIET	6	/* Make BIO Quiet */
-#define BIO_CHAIN	7	/* chained bio, ->bi_remaining in effect */
-#define BIO_REFFED	8	/* bio has elevated ->bi_cnt */
-#define BIO_THROTTLED	9	/* This bio has already been subjected to
+enum {
+	BIO_NO_PAGE_REF,	/* don't put release vec pages */
+	BIO_SEG_VALID,		/* bi_phys_segments valid */
+	BIO_CLONED,		/* doesn't own data */
+	BIO_BOUNCED,		/* bio is a bounce bio */
+	BIO_USER_MAPPED,	/* contains user pages */
+	BIO_NULL_MAPPED,	/* contains invalid user pages */
+	BIO_QUIET,		/* Make BIO Quiet */
+	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
+	BIO_REFFED,		/* bio has elevated ->bi_cnt */
+	BIO_THROTTLED,		/* This bio has already been subjected to
 				 * throttling rules. Don't do it again. */
-#define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
+	BIO_TRACE_COMPLETION,	/* bio_endio() should trace the final completion
 				 * of this bio. */
-#define BIO_QUEUE_ENTERED 11	/* can use blk_queue_enter_live() */
-#define BIO_TRACKED 12		/* set if bio goes through the rq_qos path */
+	BIO_QUEUE_ENTERED,	/* can use blk_queue_enter_live() */
+	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_FLAG_LAST
+};
 
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
-- 
2.16.4

