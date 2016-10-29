Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 35/60] bvec_iter: introduce BVEC_ITER_ALL_INIT
Date: Sat, 29 Oct 2016 16:08:34 +0800
Message-Id: <1477728600-12938-36-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Introduce BVEC_ITER_ALL_INIT for iterating one bio
from start to end.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bvec.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 9df9e582bd3f..e12ce6bd63d7 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -183,4 +183,12 @@ static inline void bvec_iter_advance_mp(const struct bio_vec *bv,
 		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
 	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
 
+#define BVEC_ITER_ALL_INIT (struct bvec_iter)			\
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

