Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1541C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 12:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0616218D8
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 12:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfCUMay (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:30:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727874AbfCUMax (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 08:30:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5199AF27;
        Thu, 21 Mar 2019 12:30:51 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/2] bio: introduce BIO_ALLOCED flag and check it in bio_free
Date:   Thu, 21 Mar 2019 13:30:45 +0100
Message-Id: <20190321123045.32396-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190321123045.32396-1-jthumshirn@suse.de>
References: <20190321123045.32396-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we're submitting a bio from stack and this ends up being split, we
call bio_put(). bio_put() will eventually call bio_free() if the reference
count drops to 0. But freeing the bio is wrong, as it was never allocated
out of the bio's mempool.

Flag each normally allocated bio as 'BIO_ALLOCATED' and skip freeing if the
flag isn't set.

Fixes: 189ce2b9dcc3 ("block: fast-path for small and simple direct I/O requests")
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bio.c               | 4 ++++
 include/linux/blk_types.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 8c689aed46a0..3282479d511d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -255,6 +255,9 @@ static void bio_free(struct bio *bio)
 
 	bio_uninit(bio);
 
+	if (!bio_flagged(bio, BIO_ALLOCED))
+		return;
+
 	if (bs) {
 		bvec_free(&bs->bvec_pool, bio->bi_io_vec, BVEC_POOL_IDX(bio));
 
@@ -521,6 +524,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 		bvl = bio->bi_inline_vecs;
 	}
 
+	bio_set_flag(bio, BIO_ALLOCED);
 	bio->bi_pool = bs;
 	bio->bi_max_vecs = nr_iovecs;
 	bio->bi_io_vec = bvl;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0273bad71a96..d0c9d6fd6e71 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -216,6 +216,7 @@ struct bio {
  * bio flags
  */
 enum {
+	BIO_ALLOCED = 0,		/* bio allocated by bio_alloc_bioset */
 	BIO_SEG_VALID =	1,		/* bi_phys_segments valid */
 	BIO_CLONED = 2,			/* doesn't own data */
 	BIO_BOUNCED = 3,		/* bio is a bounce bio */
-- 
2.16.4

