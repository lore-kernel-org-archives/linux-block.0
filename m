Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33312 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943136AbcJ2IPW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:15:22 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 44/60] block: introduce bvec_for_each_sp_bvec()
Date: Sat, 29 Oct 2016 16:08:43 +0800
Message-Id: <1477728600-12938-45-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This helper can be used to iterate each singlepage bvec
from one multipage bvec.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bvec.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index e12ce6bd63d7..510d1d2d79f1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -191,4 +191,14 @@ static inline void bvec_iter_advance_mp(const struct bio_vec *bv,
 	.bi_bvec_done	= 0,						\
 }
 
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

