Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF05FC10F14
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968C820850
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 21:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDKVKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:10:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfDKVJC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 17:09:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20C2A3086210;
        Thu, 11 Apr 2019 21:09:01 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0C35C223;
        Thu, 11 Apr 2019 21:08:59 +0000 (UTC)
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
Subject: [PATCH v1 08/15] block: use bvec_put_page() instead of put_page(bvec_page())
Date:   Thu, 11 Apr 2019 17:08:27 -0400
Message-Id: <20190411210834.4105-9-jglisse@redhat.com>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 11 Apr 2019 21:09:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Replace all put_page(bvec_page()) with bvec_put_page() so that we can
use proper put_page (ie either put_page() or put_user_page()).

This is done using a coccinelle patch and running it with:

spatch --sp-file spfile --in-place --dir .

with spfile:
%<---------------------------------------------------------------------
@exists@
expression E1;
@@
-put_page(bvec_page(E1));
+bvec_put_page(E1);
--------------------------------------------------------------------->%

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
 block/bio.c    | 6 +++---
 fs/afs/rxrpc.c | 2 +-
 fs/block_dev.c | 4 ++--
 fs/ceph/file.c | 2 +-
 fs/cifs/misc.c | 2 +-
 fs/io_uring.c  | 2 +-
 fs/iomap.c     | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c73ac2120ca0..b74b81085f3a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1433,7 +1433,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 
  out_unmap:
 	bio_for_each_segment_all(bvec, bio, j, iter_all) {
-		put_page(bvec_page(bvec));
+		bvec_put_page(bvec);
 	}
 	bio_put(bio);
 	return ERR_PTR(ret);
@@ -1452,7 +1452,7 @@ static void __bio_unmap_user(struct bio *bio)
 		if (bio_data_dir(bio) == READ)
 			set_page_dirty_lock(bvec_page(bvec));
 
-		put_page(bvec_page(bvec));
+		bvec_put_page(bvec);
 	}
 
 	bio_put(bio);
@@ -1666,7 +1666,7 @@ static void bio_release_pages(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, i, iter_all)
-		put_page(bvec_page(bvec));
+		bvec_put_page(bvec);
 }
 
 /*
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 85caafeb9131..08386ddf7185 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -349,7 +349,7 @@ static int afs_send_pages(struct afs_call *call, struct msghdr *msg)
 		ret = rxrpc_kernel_send_data(call->net->socket, call->rxcall, msg,
 					     bytes, afs_notify_end_request_tx);
 		for (loop = 0; loop < nr; loop++)
-			put_page(bvec_page(&bv[loop]));
+			bvec_put_page(&bv[loop]);
 		if (ret < 0)
 			break;
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7304fc309326..9761f7943774 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -264,7 +264,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio_for_each_segment_all(bvec, &bio, i, iter_all) {
 		if (should_dirty && !PageCompound(bvec_page(bvec)))
 			set_page_dirty_lock(bvec_page(bvec));
-		put_page(bvec_page(bvec));
+		bvec_put_page(bvec);
 	}
 
 	if (unlikely(bio.bi_status))
@@ -342,7 +342,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 			int i;
 
 			bio_for_each_segment_all(bvec, bio, i, iter_all)
-				put_page(bvec_page(bvec));
+				bvec_put_page(bvec);
 		}
 		bio_put(bio);
 	}
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5183f545b90a..6a39347f4956 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -163,7 +163,7 @@ static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty)
 		if (bvec_page(&bvecs[i])) {
 			if (should_dirty)
 				set_page_dirty_lock(bvec_page(&bvecs[i]));
-			put_page(bvec_page(&bvecs[i]));
+			bvec_put_page(&bvecs[i]);
 		}
 	}
 	kvfree(bvecs);
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 4b6a6317f125..86d78f297526 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -803,7 +803,7 @@ cifs_aio_ctx_release(struct kref *refcount)
 		for (i = 0; i < ctx->npages; i++) {
 			if (ctx->should_dirty)
 				set_page_dirty(bvec_page(&ctx->bv[i]));
-			put_page(bvec_page(&ctx->bv[i]));
+			bvec_put_page(&ctx->bv[i]);
 		}
 		kvfree(ctx->bv);
 	}
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 32f4b4ddd20b..349f0e58ee5c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2346,7 +2346,7 @@ static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
 		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
 
 		for (j = 0; j < imu->nr_bvecs; j++)
-			put_page(bvec_page(&imu->bvec[j]));
+			bvec_put_page(&imu->bvec[j]);
 
 		if (ctx->account_mem)
 			io_unaccount_mem(ctx->user, imu->nr_bvecs);
diff --git a/fs/iomap.c b/fs/iomap.c
index ed5f249cf0d4..ab578054ebe9 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1595,7 +1595,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 			int i;
 
 			bio_for_each_segment_all(bvec, bio, i, iter_all)
-				put_page(bvec_page(bvec));
+				bvec_put_page(bvec);
 		}
 		bio_put(bio);
 	}
-- 
2.20.1

