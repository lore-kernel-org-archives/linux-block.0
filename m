Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36467 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934024AbdC3Ntz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 09:49:55 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 1/8] Guard bvec iteration logic
Date: Thu, 30 Mar 2017 17:49:29 +0400
Message-Id: <1490881776-28735-2-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1490881776-28735-1-git-send-email-dmonakhov@openvz.org>
References: <1490881776-28735-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If some one try to attempt advance bvec beyond it's size we simply
dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
This simply means that we endup dereferencing/corrupting random memory
region.

Code was added long time ago here 4550dd6c, luckily no one hit it
in real life :)

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 include/linux/bvec.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 89b65b8..86b914f 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -70,8 +70,7 @@ static inline void bvec_iter_advance(const struct bio_vec *bv,
 				     struct bvec_iter *iter,
 				     unsigned bytes)
 {
-	WARN_ONCE(bytes > iter->bi_size,
-		  "Attempted to advance past end of bvec iter\n");
+	BUG_ON(bytes > iter->bi_size);
 
 	while (bytes) {
 		unsigned iter_len = bvec_iter_len(bv, *iter);
-- 
2.9.3
