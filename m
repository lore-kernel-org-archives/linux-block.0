Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751806AbdFZMR6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:17:58 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 30/51] block: introduce bvec_get_last_page()
Date: Mon, 26 Jun 2017 20:10:13 +0800
Message-Id: <20170626121034.3051-31-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

BTRFS and guard_bio_eod() need to get the last page, so introduce
this helper to make them happy.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 7addceea9828..6673e3c0b7eb 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -206,4 +206,18 @@ static inline void bvec_iter_advance_mp(const struct bio_vec *bv,
 #define bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter)			\
 	__bvec_for_each_sp_bvec(sp_bvl, mp_bvec, iter, BVEC_ITER_ALL_INIT)
 
+/*
+ * get the last page from the multipage bvec and store it
+ * in @sp_bv
+ */
+static inline void bvec_get_last_page(struct bio_vec *mp_bv,
+				      struct bio_vec *sp_bv)
+{
+	struct bvec_iter iter;
+
+	*sp_bv = *mp_bv;
+	bvec_for_each_sp_bvec(*sp_bv, mp_bv, iter)
+		;
+}
+
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.9.4
