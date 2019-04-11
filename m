Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBC5C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CEF2184B
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDKVKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:10:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDKVJD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 17:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFE38309E9A7;
        Thu, 11 Apr 2019 21:09:02 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4018C5C220;
        Thu, 11 Apr 2019 21:09:01 +0000 (UTC)
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
Subject: [PATCH v1 09/15] block: bvec_put_page_dirty* instead of set_page_dirty* and bvec_put_page
Date:   Thu, 11 Apr 2019 17:08:28 -0400
Message-Id: <20190411210834.4105-10-jglisse@redhat.com>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 11 Apr 2019 21:09:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Use bvec_put_page_dirty*() instead of set_page_dirty*() followed by a call
to bvec_put_page(). With this change we can use the proper put_user_page*()
helpers.

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
 block/bio.c    | 8 ++------
 fs/block_dev.c | 8 +++-----
 fs/ceph/file.c | 6 +-----
 fs/cifs/misc.c | 8 +++-----
 4 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b74b81085f3a..efd254c90974 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1448,12 +1448,8 @@ static void __bio_unmap_user(struct bio *bio)
 	/*
 	 * make sure we dirty pages we wrote to
 	 */
-	bio_for_each_segment_all(bvec, bio, i, iter_all) {
-		if (bio_data_dir(bio) == READ)
-			set_page_dirty_lock(bvec_page(bvec));
-
-		bvec_put_page(bvec);
-	}
+	bio_for_each_segment_all(bvec, bio, i, iter_all)
+		bvec_put_page_dirty_lock(bvec, bio_data_dir(bio) == READ);
 
 	bio_put(bio);
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9761f7943774..16a17fae6694 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -261,11 +261,9 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	__set_current_state(TASK_RUNNING);
 
-	bio_for_each_segment_all(bvec, &bio, i, iter_all) {
-		if (should_dirty && !PageCompound(bvec_page(bvec)))
-			set_page_dirty_lock(bvec_page(bvec));
-		bvec_put_page(bvec);
-	}
+	bio_for_each_segment_all(bvec, &bio, i, iter_all)
+		bvec_put_page_dirty_lock(bvec, should_dirty &&
+				!PageCompound(bvec_page(bvec)));
 
 	if (unlikely(bio.bi_status))
 		ret = blk_status_to_errno(bio.bi_status);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 6a39347f4956..d5561662b902 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -160,11 +160,7 @@ static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty)
 	int i;
 
 	for (i = 0; i < num_bvecs; i++) {
-		if (bvec_page(&bvecs[i])) {
-			if (should_dirty)
-				set_page_dirty_lock(bvec_page(&bvecs[i]));
-			bvec_put_page(&bvecs[i]);
-		}
+		bvec_put_page_dirty_lock(&bvecs[i], should_dirty);
 	}
 	kvfree(bvecs);
 }
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 86d78f297526..bc77a4a5f1af 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -800,11 +800,9 @@ cifs_aio_ctx_release(struct kref *refcount)
 	if (ctx->bv) {
 		unsigned i;
 
-		for (i = 0; i < ctx->npages; i++) {
-			if (ctx->should_dirty)
-				set_page_dirty(bvec_page(&ctx->bv[i]));
-			bvec_put_page(&ctx->bv[i]);
-		}
+		for (i = 0; i < ctx->npages; i++)
+			bvec_put_page_dirty_lock(&ctx->bv[i],
+					  ctx->should_dirty);
 		kvfree(ctx->bv);
 	}
 
-- 
2.20.1

