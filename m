Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 07/10] block: Add missing flush_dcache_page() call
Date: Tue,  8 May 2018 21:33:55 -0400
Message-Id: <20180509013358.16399-8-kent.overstreet@gmail.com>
In-Reply-To: <20180509013358.16399-1-kent.overstreet@gmail.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Since a bio can point to userspace pages (e.g. direct IO), this is
generally necessary.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c58544d4bc..ce8e259f9a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -994,6 +994,8 @@ void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 		kunmap_atomic(dst_p);
 		kunmap_atomic(src_p);
 
+		flush_dcache_page(dst_bv.bv_page);
+
 		bio_advance_iter(src, src_iter, bytes);
 		bio_advance_iter(dst, dst_iter, bytes);
 	}
-- 
2.17.0
