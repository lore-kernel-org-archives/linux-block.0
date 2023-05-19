Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E51C77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjESGvs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjESGvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F5AE4E
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684479059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJv0cNUOpxhbVVgUDWO42Qrl+y4JMj4v5kzhGALu+SY=;
        b=Fy+SrxIdOWkbiHdB+UU7fwSaBgOMxF/CIBy3p2YqkIh96dPBvE7NaWpBZh1F16OpI9GciL
        dwTXqE70Cy+phGNEbVuwdp+sC7hKwTVYG2KdNp9bnNi6+KITkCr1NIo7rQA3E2w4EFIM3t
        sdDDKQcjMX0W5CksR7InLEUuOt3LMnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-vVB9o-DdOYC2lxNrCrXD2A-1; Fri, 19 May 2023 02:50:56 -0400
X-MC-Unique: vVB9o-DdOYC2lxNrCrXD2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8102586C60F;
        Fri, 19 May 2023 06:50:55 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE80B492C13;
        Fri, 19 May 2023 06:50:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/7] ublk: cleanup ublk_copy_user_pages
Date:   Fri, 19 May 2023 14:50:26 +0800
Message-Id: <20230519065030.351216-4-ming.lei@redhat.com>
In-Reply-To: <20230519065030.351216-1-ming.lei@redhat.com>
References: <20230519065030.351216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Clean up ublk_copy_user_pages() by using iov_iter_get_pages2, and code
gets simplified a lot and becomes much more readable than before.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 112 +++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 63 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c8651c5ba4c..afc07fa17040 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -412,49 +412,39 @@ static const struct block_device_operations ub_fops = {
 
 #define UBLK_MAX_PIN_PAGES	32
 
-struct ublk_map_data {
-	const struct request *rq;
-	unsigned long	ubuf;
-	unsigned int	len;
-};
-
 struct ublk_io_iter {
 	struct page *pages[UBLK_MAX_PIN_PAGES];
-	unsigned pg_off;	/* offset in the 1st page in pages */
-	int nr_pages;		/* how many page pointers in pages */
 	struct bio *bio;
 	struct bvec_iter iter;
 };
 
-static inline unsigned ublk_copy_io_pages(struct ublk_io_iter *data,
-		unsigned max_bytes, bool to_vm)
+/* return how many pages are copied */
+static void ublk_copy_io_pages(struct ublk_io_iter *data,
+		size_t total, size_t pg_off, int dir)
 {
-	const unsigned total = min_t(unsigned, max_bytes,
-			PAGE_SIZE - data->pg_off +
-			((data->nr_pages - 1) << PAGE_SHIFT));
 	unsigned done = 0;
 	unsigned pg_idx = 0;
 
 	while (done < total) {
 		struct bio_vec bv = bio_iter_iovec(data->bio, data->iter);
-		const unsigned int bytes = min3(bv.bv_len, total - done,
-				(unsigned)(PAGE_SIZE - data->pg_off));
+		unsigned int bytes = min3(bv.bv_len, (unsigned)total - done,
+				(unsigned)(PAGE_SIZE - pg_off));
 		void *bv_buf = bvec_kmap_local(&bv);
 		void *pg_buf = kmap_local_page(data->pages[pg_idx]);
 
-		if (to_vm)
-			memcpy(pg_buf + data->pg_off, bv_buf, bytes);
+		if (dir == ITER_DEST)
+			memcpy(pg_buf + pg_off, bv_buf, bytes);
 		else
-			memcpy(bv_buf, pg_buf + data->pg_off, bytes);
+			memcpy(bv_buf, pg_buf + pg_off, bytes);
 
 		kunmap_local(pg_buf);
 		kunmap_local(bv_buf);
 
 		/* advance page array */
-		data->pg_off += bytes;
-		if (data->pg_off == PAGE_SIZE) {
+		pg_off += bytes;
+		if (pg_off == PAGE_SIZE) {
 			pg_idx += 1;
-			data->pg_off = 0;
+			pg_off = 0;
 		}
 
 		done += bytes;
@@ -468,41 +458,40 @@ static inline unsigned ublk_copy_io_pages(struct ublk_io_iter *data,
 			data->iter = data->bio->bi_iter;
 		}
 	}
-
-	return done;
 }
 
-static int ublk_copy_user_pages(struct ublk_map_data *data, bool to_vm)
+/*
+ * Copy data between request pages and io_iter, and 'offset'
+ * is the start point of linear offset of request.
+ */
+static size_t ublk_copy_user_pages(const struct request *req,
+		struct iov_iter *uiter, int dir)
 {
-	const unsigned int gup_flags = to_vm ? FOLL_WRITE : 0;
-	const unsigned long start_vm = data->ubuf;
-	unsigned int done = 0;
 	struct ublk_io_iter iter = {
-		.pg_off	= start_vm & (PAGE_SIZE - 1),
-		.bio	= data->rq->bio,
-		.iter	= data->rq->bio->bi_iter,
+		.bio	= req->bio,
+		.iter	= req->bio->bi_iter,
 	};
-	const unsigned int nr_pages = round_up(data->len +
-			(start_vm & (PAGE_SIZE - 1)), PAGE_SIZE) >> PAGE_SHIFT;
-
-	while (done < nr_pages) {
-		const unsigned to_pin = min_t(unsigned, UBLK_MAX_PIN_PAGES,
-				nr_pages - done);
-		unsigned i, len;
-
-		iter.nr_pages = get_user_pages_fast(start_vm +
-				(done << PAGE_SHIFT), to_pin, gup_flags,
-				iter.pages);
-		if (iter.nr_pages <= 0)
-			return done == 0 ? iter.nr_pages : done;
-		len = ublk_copy_io_pages(&iter, data->len, to_vm);
-		for (i = 0; i < iter.nr_pages; i++) {
-			if (to_vm)
+	size_t done = 0;
+
+	while (iov_iter_count(uiter) && iter.bio) {
+		unsigned nr_pages;
+		size_t len, off;
+		int i;
+
+		len = iov_iter_get_pages2(uiter, iter.pages,
+				iov_iter_count(uiter),
+				UBLK_MAX_PIN_PAGES, &off);
+		if (len <= 0)
+			return done;
+
+		ublk_copy_io_pages(&iter, len, off, dir);
+		nr_pages = DIV_ROUND_UP(len + off, PAGE_SIZE);
+		for (i = 0; i < nr_pages; i++) {
+			if (dir == ITER_DEST)
 				set_page_dirty(iter.pages[i]);
 			put_page(iter.pages[i]);
 		}
-		data->len -= len;
-		done += iter.nr_pages;
+		done += len;
 	}
 
 	return done;
@@ -529,15 +518,14 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 	 * context is pretty fast, see ublk_pin_user_pages
 	 */
 	if (ublk_need_map_req(req)) {
-		struct ublk_map_data data = {
-			.rq	=	req,
-			.ubuf	=	io->addr,
-			.len	=	rq_bytes,
-		};
+		struct iov_iter iter;
+		struct iovec iov;
+		const int dir = ITER_DEST;
 
-		ublk_copy_user_pages(&data, true);
+		import_single_range(dir, u64_to_user_ptr(io->addr), rq_bytes,
+				&iov, &iter);
 
-		return rq_bytes - data.len;
+		return ublk_copy_user_pages(req, &iter, dir);
 	}
 	return rq_bytes;
 }
@@ -549,17 +537,15 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
 	if (ublk_need_unmap_req(req)) {
-		struct ublk_map_data data = {
-			.rq	=	req,
-			.ubuf	=	io->addr,
-			.len	=	io->res,
-		};
+		struct iov_iter iter;
+		struct iovec iov;
+		const int dir = ITER_SOURCE;
 
 		WARN_ON_ONCE(io->res > rq_bytes);
 
-		ublk_copy_user_pages(&data, false);
-
-		return io->res - data.len;
+		import_single_range(dir, u64_to_user_ptr(io->addr), io->res,
+				&iov, &iter);
+		return ublk_copy_user_pages(req, &iter, dir);
 	}
 	return rq_bytes;
 }
-- 
2.40.1

