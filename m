Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35500 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbcL0QFa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:05:30 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v1 32/54] block: introduce bvec_get_last_sp()
Date: Wed, 28 Dec 2016 00:04:41 +0800
Message-Id: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

BTRFS need to get the last singlepage bvec, so introduce
this helper to make it happy.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bvec.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index baf379d56106..e9a623067c52 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -206,4 +206,14 @@ static inline void bvec_iter_advance_mp(const struct bio_vec *bv,
 #define bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter)			\
 	__bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter, BVEC_ITER_ALL_INIT)
 
+/* get the last singlepage bvec from the multipage bvec  */
+static inline void bvec_get_last_sp(struct bio_vec *mp_bv,
+				    struct bio_vec *sp_bv)
+{
+	struct bvec_iter iter;
+
+	bvec_for_each_sp_bvec(*sp_bv, mp_bv, iter)
+		;
+}
+
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.7.4

