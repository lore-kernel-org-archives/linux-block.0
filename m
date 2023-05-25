Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A736DC7EE29
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjEYVsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 17:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjEYVso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 17:48:44 -0400
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [IPv6:2001:41d0:203:375::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF41A2
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 14:48:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685051320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KkRPMSjK8YKASg8ZAP2GYnCrc/m4pRzmXY3p1j1RS/g=;
        b=a5Ua3jPQQwy6N9lQr/+d3LtuAC8WhjKIbI5ddlzl49u+avjnUPNS4kpj/3yy2kyQZsVj0E
        aYAzQA+vmk12NIuVpAiLMs3h6CFrQTy2Dq1ggwjeiX4cwmKAn+e7lLhPwhJ5pNtRkw9K3N
        9d4WZoaUZGUoAYGTRU6FnY85rb5QA7w=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 3/7] block: Bring back zero_fill_bio_iter
Date:   Thu, 25 May 2023 17:48:18 -0400
Message-Id: <20230525214822.2725616-4-kent.overstreet@linux.dev>
In-Reply-To: <20230525214822.2725616-1-kent.overstreet@linux.dev>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This reverts the commit that deleted it; it's used by bcachefs.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/bio.c         | 6 +++---
 include/linux/bio.h | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e74a04ea14..70b5c987bc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -606,15 +606,15 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(bio_kmalloc);
 
-void zero_fill_bio(struct bio *bio)
+void zero_fill_bio_iter(struct bio *bio, struct bvec_iter start)
 {
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
-	bio_for_each_segment(bv, bio, iter)
+	__bio_for_each_segment(bv, bio, iter, start)
 		memzero_bvec(&bv);
 }
-EXPORT_SYMBOL(zero_fill_bio);
+EXPORT_SYMBOL(zero_fill_bio_iter);
 
 /**
  * bio_truncate - truncate the bio to small size of @new_size
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152..3536f28c05 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -484,7 +484,12 @@ extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 extern void bio_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
 void guard_bio_eod(struct bio *bio);
-void zero_fill_bio(struct bio *bio);
+void zero_fill_bio_iter(struct bio *bio, struct bvec_iter iter);
+
+static inline void zero_fill_bio(struct bio *bio)
+{
+	zero_fill_bio_iter(bio, bio->bi_iter);
+}
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-- 
2.40.1

