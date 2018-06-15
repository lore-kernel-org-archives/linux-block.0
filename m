Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33494 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965635AbeFOLQO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 07:16:14 -0400
Received: by mail-wr0-f180.google.com with SMTP id k16-v6so9561967wro.0
        for <linux-block@vger.kernel.org>; Fri, 15 Jun 2018 04:16:14 -0700 (PDT)
From: Gioh Kim <gi-oh.kim@profitbricks.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Gioh Kim <gi-oh.kim@profitbricks.com>
Subject: [RFC] replace comments for bvl_vec with bio_vec
Date: Fri, 15 Jun 2018 13:15:54 +0200
Message-Id: <20180615111554.14005-1-gi-oh.kim@profitbricks.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I think bvl_vec means bio_vec_list that was replaced with bio_vec
long time ago. If I am correct, I think some comments for blk_vec
need to be replaced with bio_vec.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 include/linux/blk_types.h | 2 +-
 include/linux/bvec.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3c4f390aea4b..a39dc0a665b9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -196,7 +196,7 @@ struct bio {
 	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
 	 */
 
-	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
+	unsigned short		bi_max_vecs;	/* max bio_vecs we can hold */
 
 	atomic_t		__bi_cnt;	/* pin count */
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index fe7a22dd133b..6023dc9e6f79 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -38,7 +38,7 @@ struct bvec_iter {
 						   sectors */
 	unsigned int		bi_size;	/* residual I/O count */
 
-	unsigned int		bi_idx;		/* current index into bvl_vec */
+	unsigned int		bi_idx;		/* current index into bio_vec */
 
 	unsigned int            bi_done;	/* number of bytes completed */
 
-- 
2.14.1
