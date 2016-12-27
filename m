Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36446 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755672AbcL0QB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:01:29 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v1 18/54] bvec_iter: introduce BVEC_ITER_ALL_INIT
Date: Tue, 27 Dec 2016 23:56:07 +0800
Message-Id: <1482854250-13481-19-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Introduce BVEC_ITER_ALL_INIT for iterating one bio
from start to end.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bvec.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f8a8b293cd32..5c51c58fe202 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -183,4 +183,13 @@ static inline void bvec_iter_advance_mp(const struct bio_vec *bv,
 		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
 	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
 
+/* for iterating one bio from start to end */
+#define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
+{									\
+	.bi_sector	= 0,						\
+	.bi_size	= UINT_MAX,					\
+	.bi_idx		= 0,						\
+	.bi_bvec_done	= 0,						\
+}
+
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.7.4

