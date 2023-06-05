Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D5C7EE23
	for <linux-block@archiver.kernel.org>; Mon,  5 Jun 2023 21:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjFEV1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjFEV1h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 17:27:37 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0BD109
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 14:27:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686000452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/W2KTV3ULawkr9BtdK4REvFFcYHPIv4u0Yiv/rOYuY=;
        b=tjmpCz2EinHgsmvuXii8BrI6Xyb3kVTA5dfu1dGW48GnnlR9bF5r/ar6aQtTDrHJdKlVZ+
        smA0XvgGjirfWIzaRrmGJeUG4Wsj1gj3yN6px1v51k/rdliYnASvFPNkrBNVQH2fBG4p1K
        nZi7M2e7o1e/Rn/rVMwMgEdUd166Y5c=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 5/5] block: CONFIG_BLK_DEBUG
Date:   Mon,  5 Jun 2023 17:27:17 -0400
Message-Id: <20230605212717.2570570-5-kent.overstreet@linux.dev>
In-Reply-To: <20230605212717.2570570-1-kent.overstreet@linux.dev>
References: <20230605212717.2570570-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds a new kconfig option to enable some extra debug mode
assertions. Currently this is just used for some bio iterator
assertions, but hopefully more will be added in the future.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 block/Kconfig        | 7 +++++++
 include/linux/bio.h  | 5 +++++
 include/linux/bvec.h | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 86122e459f..611dddb59c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -165,6 +165,13 @@ config BLK_CGROUP_IOPRIO
 	scheduler and block devices process requests. Only some I/O schedulers
 	and some block devices support I/O priorities.
 
+config BLK_DEBUG
+	bool "Extra block layer assertions"
+	depends on DEBUG_KERNEL
+	help
+	Enable extra assertions in the block layer. Currently this is just the
+	bio iterator code, but may be expanded.
+
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f599bcf15e..cece57c54d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -81,6 +81,8 @@ static inline void *bio_data(struct bio *bio)
 static inline struct bio_vec bio_iter_all_peek(const struct bio *bio,
 					       struct bvec_iter_all *iter)
 {
+	BLK_BUG_ON(iter->idx >= bio->bi_vcnt);
+
 	return bvec_iter_all_peek(bio->bi_io_vec, iter);
 }
 
@@ -89,6 +91,9 @@ static inline void bio_iter_all_advance(const struct bio *bio,
 					unsigned bytes)
 {
 	bvec_iter_all_advance(bio->bi_io_vec, iter, bytes);
+
+	BLK_BUG_ON(iter->idx > bio->bi_vcnt ||
+		   (iter->idx == bio->bi_vcnt && iter->done));
 }
 
 #define bio_for_each_segment_all_continue(bvl, bio, iter)		\
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ee5965fedf..2467245da2 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -16,6 +16,12 @@
 
 struct page;
 
+#ifdef CONFIG_BLK_DEBUG
+#define BLK_BUG_ON(cond) BUG_ON(cond)
+#else
+#define BLK_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
+#endif
+
 /**
  * struct bio_vec - a contiguous range of physical memory addresses
  * @bv_page:   First page associated with the address range.
@@ -210,6 +216,8 @@ static inline struct bio_vec __bvec_iter_all_peek(const struct bio_vec *bvec,
 {
 	struct bio_vec bv = bvec[iter->idx];
 
+	BLK_BUG_ON(iter->done >= bv.bv_len);
+
 	bv.bv_offset	+= iter->done;
 	bv.bv_len	-= iter->done;
 
-- 
2.40.1

