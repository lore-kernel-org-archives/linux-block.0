Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 26/49] block: introduce bvec_for_each_sp_bvec()
Date: Tue,  8 Aug 2017 16:45:25 +0800
Message-Id: <20170808084548.18963-27-ming.lei@redhat.com>
In-Reply-To: <20170808084548.18963-1-ming.lei@redhat.com>
References: <20170808084548.18963-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

This helper can be used to iterate each singlepage bvec
from one multipage bvec.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index c1ec0945451a..23d3abdf057c 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -224,4 +224,18 @@ static inline bool bvec_iter_advance_mp(const struct bio_vec *bv,
 	.bi_bvec_done	= 0,						\
 }
 
+/*
+ * This helper iterates over the multipage bvec of @mp_bvec and
+ * returns each singlepage bvec via @sp_bvl.
+ */
+#define __bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter, start)		\
+	for (iter = start,						\
+	     (iter).bi_size = (mp_bvec)->bv_len  - (iter).bi_bvec_done;	\
+	     (iter).bi_size &&						\
+		((sp_bvl = bvec_iter_bvec((mp_bvec), (iter))), 1);	\
+	     bvec_iter_advance((mp_bvec), &(iter), (sp_bvl).bv_len))
+
+#define bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter)			\
+	__bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter, BVEC_ITER_ALL_INIT)
+
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.9.4
