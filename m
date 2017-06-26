Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbdFZMPt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:15:49 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 17/51] bvec_iter: introduce BVEC_ITER_ALL_INIT
Date: Mon, 26 Jun 2017 20:10:00 +0800
Message-Id: <20170626121034.3051-18-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Introduce BVEC_ITER_ALL_INIT for iterating one bio
from start to end.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 89b65b82d98f..162ca7caf510 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -94,4 +94,13 @@ static inline void bvec_iter_advance(const struct bio_vec *bv,
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
2.9.4
