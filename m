Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4426BC8300F
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 02:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7D32223C
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 02:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgLCCbd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 21:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727102AbgLCCbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 21:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606962605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6M4s7rQZUCvh5e7iGoqQ3FFtHQw8xu0+o1SsbcRVFMY=;
        b=TtdurTKqom5ce/J0lfo5mYvpzkdb2lwHO7DBPBZXhgFE7CKCAxLzOVD0QYhyMy4dH4WdBa
        R8xn57k4IvKwLdxBVoUCjAOrkHans3gCusC2yiiqnSp6lMIGfcAjIhj6WZ33ATc8qFp1xM
        6I6gKRi8aQz8f75I1jgMZ5mLDGAluNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-TRVZb9JNPvCbf20rxfetGg-1; Wed, 02 Dec 2020 21:30:01 -0500
X-MC-Unique: TRVZb9JNPvCbf20rxfetGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E285A185E48B;
        Thu,  3 Dec 2020 02:29:59 +0000 (UTC)
Received: from localhost (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDD4E189A5;
        Thu,  3 Dec 2020 02:29:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 1/2] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Date:   Thu,  3 Dec 2020 10:29:39 +0800
Message-Id: <20201203022940.616610-2-ming.lei@redhat.com>
In-Reply-To: <20201203022940.616610-1-ming.lei@redhat.com>
References: <20201203022940.616610-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pavel reported that iov_iter_npages is a bit heavy in case of bvec
iter.

Turns out it isn't necessary to iterate every page in the bvec iter,
and we call iov_iter_npages() just for figuring out how many bio
vecs need to be allocated. And we can simply map each vector in bvec iter
to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
bvec iter.

This patch is based on Mathew's post:

https://lore.kernel.org/linux-block/20201120123931.GN29991@casper.infradead.org/

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c       |  4 ++--
 fs/iomap/direct-io.c |  4 ++--
 include/linux/bio.h  | 10 ++++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e56ee1f2652..fbcc900229af 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -417,7 +417,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
-		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
+		nr_pages = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
 			bool polled = false;
 
@@ -482,7 +482,7 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	int nr_pages;
 
-	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
+	nr_pages = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES + 1);
 	if (!nr_pages)
 		return 0;
 	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..0635469e811a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -250,7 +250,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	orig_count = iov_iter_count(dio->submit.iter);
 	iov_iter_truncate(dio->submit.iter, length);
 
-	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+	nr_pages = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
 	if (nr_pages <= 0) {
 		ret = nr_pages;
 		goto out;
@@ -308,7 +308,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		dio->size += n;
 		copied += n;
 
-		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+		nr_pages = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..8a7f44006f65 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -10,6 +10,7 @@
 #include <linux/ioprio.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
+#include <linux/uio.h>
 
 #define BIO_DEBUG
 
@@ -820,4 +821,13 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+static inline int bio_iov_iter_nvecs(const struct iov_iter *i, int maxvecs)
+{
+	if (!iov_iter_count(i))
+		return 0;
+	if (iov_iter_is_bvec(i))
+		return min_t(int, maxvecs, i->nr_segs);
+	return iov_iter_npages(i, maxvecs);
+}
+
 #endif /* __LINUX_BIO_H */
-- 
2.28.0

