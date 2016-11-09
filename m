Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36127 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbcKISiF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2016 13:38:05 -0500
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: clear all of bi_opf in bio_set_op_attrs
Date: Wed,  9 Nov 2016 10:38:04 -0800
Message-Id: <1478716684-5085-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since commit 87374179 ("block: add a proper block layer data direction
encoding") we only OR the new op and flags into bi_opf in bio_set_op_attrs
instead of clearing the old value.  I've not seen any breakage with the
new behavior, but it seems dangerous.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 562ac46..67434fd 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -208,7 +208,7 @@ enum req_flag_bits {
 
 /* obsolete, don't use in new code */
 #define bio_set_op_attrs(bio, op, op_flags) \
-	((bio)->bi_opf |= (op | op_flags))
+	((bio)->bi_opf = op | op_flags)
 
 static inline bool op_is_write(unsigned int op)
 {
-- 
2.1.4

