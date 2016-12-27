Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36259 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933143AbcL0QKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:10:05 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v1 29/54] block: introduce bvec_for_each_sp_bvec()
Date: Tue, 27 Dec 2016 23:56:18 +0800
Message-Id: <1482854250-13481-30-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This helper can be used to iterate each singlepage bvec
from one multipage bvec.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bvec.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 5c51c58fe202..baf379d56106 100644
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
+	     (iter).bi_size = (mp_bvec)->bv_len;			\
+	     (iter).bi_size &&						\
+		((sp_bvl = bvec_iter_bvec((mp_bvec), (iter))), 1);	\
+	     bvec_iter_advance((mp_bvec), &(iter), (sp_bvl).bv_len))
+
+#define bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter)			\
+	__bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter, BVEC_ITER_ALL_INIT)
+
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.7.4

