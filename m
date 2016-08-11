Return-Path: <linux-block-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51304 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbcHKIQC (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 11 Aug 2016 04:16:02 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] bvec: avoid variable shadowing warning
Date: Thu, 11 Aug 2016 10:15:56 +0200
Message-Id: <1470903356-22381-1-git-send-email-johannes@sipsolutions.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Due to the (indirect) nesting of min(..., min(...)), sparse will
show a variable shadowing warning whenever bvec.h is included.

Avoid that by assigning the inner min() to a temporary variable first.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/bvec.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 701b64a3b7c5..89b65b82d98f 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -74,7 +74,8 @@ static inline void bvec_iter_advance(const struct bio_vec *bv,
 		  "Attempted to advance past end of bvec iter\n");
 
 	while (bytes) {
-		unsigned len = min(bytes, bvec_iter_len(bv, *iter));
+		unsigned iter_len = bvec_iter_len(bv, *iter);
+		unsigned len = min(bytes, iter_len);
 
 		bytes -= len;
 		iter->bi_size -= len;
-- 
2.8.1

