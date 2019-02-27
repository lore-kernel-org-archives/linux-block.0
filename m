Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A0EC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FF820C01
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 15:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfB0Pll (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:41:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0Plk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 10:41:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9ACA90B1A;
        Wed, 27 Feb 2019 15:41:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BDD1619A4;
        Wed, 27 Feb 2019 15:41:34 +0000 (UTC)
Date:   Wed, 27 Feb 2019 23:41:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 0/4] block: optimize for single-page bvec workloads
Message-ID: <20190227154129.GA10141@ming.t460p>
References: <20190227124013.4828-1-ming.lei@redhat.com>
 <922211dc-2a0d-d030-b072-7bd3e7f6fdcf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <922211dc-2a0d-d030-b072-7bd3e7f6fdcf@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 27 Feb 2019 15:41:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 27, 2019 at 06:25:30AM -0700, Jens Axboe wrote:
> On 2/27/19 5:40 AM, Ming Lei wrote:
> > Hi,
> > 
> > The 1st patch introduce bvec_nth_page(), so that nth_page() can
> > be avoided if the bvec is single-page.
> > 
> > The 2nd and 3rd patch adds fast path for single-page bvec case.
> > 
> > The last patch introduces a light-weight helper for iterating over
> > pages, which may improve __bio_iov_bvec_add_pages(). This patch
> > is for io_uring.
> 
> This reclaims another 2%, we're now at 1585K for the test case.
> Definite improvement!

BTW, could you test the following patch against the 4 patches?
--

From e763e623a54a73858c1949b3ea957f9d97006150 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 27 Feb 2019 16:51:25 +0800
Subject: [PATCH] block: apply bio_for_each_page_all()

If the users just need to retrieve each page, use bio_for_each_page_all()
which is much more efficient than bio_for_each_segment_all().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c         | 29 +++++++++++++----------------
 fs/block_dev.c      | 24 ++++++++++++------------
 fs/direct-io.c      |  9 +++------
 include/linux/bio.h |  5 +++++
 4 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7917535123df..c416b99abef8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1643,24 +1643,22 @@ struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
  */
 void bio_set_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	int i;
-	struct bvec_iter_all iter_all;
+	struct page *pg;
+	unsigned i, j;
 
-	bio_for_each_segment_all(bvec, bio, i, iter_all) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+	bio_for_each_page_all(pg, bio, i, j) {
+		if (!PageCompound(pg))
+			set_page_dirty_lock(pg);
 	}
 }
 
 static void bio_release_pages(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	int i;
-	struct bvec_iter_all iter_all;
+	struct page *pg;
+	unsigned i, j;
 
-	bio_for_each_segment_all(bvec, bio, i, iter_all)
-		put_page(bvec->bv_page);
+	bio_for_each_page_all(pg, bio, i, j)
+		put_page(pg);
 }
 
 /*
@@ -1703,13 +1701,12 @@ static void bio_dirty_fn(struct work_struct *work)
 
 void bio_check_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
 	unsigned long flags;
-	int i;
-	struct bvec_iter_all iter_all;
+	unsigned i, j;
+	struct page *pg;
 
-	bio_for_each_segment_all(bvec, bio, i, iter_all) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+	bio_for_each_page_all(pg, bio, i, j) {
+		if (!PageDirty(pg) && !PageCompound(pg))
 			goto defer;
 	}
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index e9faa52bb489..c6f90198c305 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -204,14 +204,15 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs, *bvec;
+	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
 	ssize_t ret;
 	blk_qc_t qc;
-	int i;
-	struct bvec_iter_all iter_all;
+	struct page *pg;
+	unsigned i, j;
+
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -261,10 +262,10 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	__set_current_state(TASK_RUNNING);
 
-	bio_for_each_segment_all(bvec, &bio, i, iter_all) {
-		if (should_dirty && !PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+	bio_for_each_page_all(pg, &bio, i, j) {
+		if (should_dirty && !PageCompound(pg))
+			set_page_dirty_lock(pg);
+		put_page(pg);
 	}
 
 	if (unlikely(bio.bi_status))
@@ -336,12 +337,11 @@ static void blkdev_bio_end_io(struct bio *bio)
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-		struct bio_vec *bvec;
-		int i;
-		struct bvec_iter_all iter_all;
+		struct page *pg;
+		unsigned i, j;
 
-		bio_for_each_segment_all(bvec, bio, i, iter_all)
-			put_page(bvec->bv_page);
+		bio_for_each_page_all(pg, bio, i, j)
+			put_page(pg);
 		bio_put(bio);
 	}
 }
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 9bb015bc4a83..94f56e6ca573 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -537,8 +537,6 @@ static struct bio *dio_await_one(struct dio *dio)
  */
 static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 {
-	struct bio_vec *bvec;
-	unsigned i;
 	blk_status_t err = bio->bi_status;
 
 	if (err) {
@@ -551,11 +549,10 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
 	} else {
-		struct bvec_iter_all iter_all;
-
-		bio_for_each_segment_all(bvec, bio, i, iter_all) {
-			struct page *page = bvec->bv_page;
+		struct page *page;
+		unsigned i, j;
 
+		bio_for_each_page_all(page, bio, i, j) {
 			if (dio->op == REQ_OP_READ && !PageCompound(page) &&
 					dio->should_dirty)
 				set_page_dirty_lock(page);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index bb6090aa165d..d7ba07c5252d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -134,6 +134,11 @@ static inline bool bio_full(struct bio *bio)
 	for (i = 0, iter_all.idx = 0; iter_all.idx < (bio)->bi_vcnt; iter_all.idx++)	\
 		mp_bvec_for_each_segment(bvl, &((bio)->bi_io_vec[iter_all.idx]), i, iter_all)
 
+/* iterate over each single page in this bio */
+#define bio_for_each_page_all(pg, bio, i, j)		\
+	for (i = 0; i < (bio)->bi_vcnt; i++)		\
+		mp_bvec_for_each_page(pg, &((bio)->bi_io_vec[i]), j)
+
 static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 				    unsigned bytes)
 {
-- 
2.9.5


-- 
Ming
