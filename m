Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00492C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F162133D
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfB0Mkt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:40:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfB0Mkt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 07:40:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F4E530BCE60;
        Wed, 27 Feb 2019 12:40:49 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 573EB60865;
        Wed, 27 Feb 2019 12:40:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] block: introduce mp_bvec_for_each_page() for iterating over page
Date:   Wed, 27 Feb 2019 20:40:13 +0800
Message-Id: <20190227124013.4828-5-ming.lei@redhat.com>
In-Reply-To: <20190227124013.4828-1-ming.lei@redhat.com>
References: <20190227124013.4828-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Feb 2019 12:40:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mp_bvec_for_each_segment() is a bit big for the iteration, so introduce
a light-weight helper for iterating over pages, then 32bytes stack
space can be saved.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c          | 7 +++----
 include/linux/bvec.h | 5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index eae8b754801d..7917535123df 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -849,8 +849,7 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 	size = bio_add_page(bio, bv->bv_page, len,
 				bv->bv_offset + iter->iov_offset);
 	if (size == len) {
-		struct bvec_iter_all iter_all;
-		struct bio_vec *tmp;
+		struct page *pg;
 		int i;
 
 		/*
@@ -862,8 +861,8 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 		 * get rid of the get here and the need to call
 		 * bio_release_pages() at IO completion time.
 		 */
-		mp_bvec_for_each_segment(tmp, bv, i, iter_all)
-			get_page(tmp->bv_page);
+		mp_bvec_for_each_page(pg, bv, i)
+			get_page(pg);
 		iov_iter_advance(iter, size);
 		return 0;
 	}
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 4376f683c08a..2c32e3e151a0 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -188,4 +188,9 @@ static inline void mp_bvec_last_segment(const struct bio_vec *bvec,
 	}
 }
 
+#define mp_bvec_for_each_page(pg, bv, i)				\
+	for (i = (bv)->bv_offset / PAGE_SIZE;				\
+		(i < (((bv)->bv_offset + (bv)->bv_len) / PAGE_SIZE)) && \
+		(pg = bvec_nth_page((bv)->bv_page, i)); i += 1)
+
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.9.5

