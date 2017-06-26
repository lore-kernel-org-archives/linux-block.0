Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51049 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbdFZMRm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:17:42 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 28/51] block: introduce bvec_for_each_sp_bvec()
Date: Mon, 26 Jun 2017 20:10:11 +0800
Message-Id: <20170626121034.3051-29-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This helper can be used to iterate each singlepage bvec
from one multipage bvec.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 5c51c58fe202..7addceea9828 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -192,4 +192,18 @@ static inline void bvec_iter_advance_mp(const struct bio_vec *bv,
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
