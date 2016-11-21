Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45267 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbcKUPSX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2016 10:18:23 -0500
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: clear all of bi_opf in bio_set_op_attrs
Date: Mon, 21 Nov 2016 16:18:18 +0100
Message-Id: <1479741498-12592-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since commit 87374179 ("block: add a proper block layer data direction
encoding") we only or the new op and flags into bi_opf in bio_set_op_attrs
instead of clearing the old value.  I've not seen any breakage with the
new behavior, but it seems dangerous.

Also convert it to an inline function to make the argument passing
safer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4d0044d..f57458a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -207,8 +207,11 @@ enum req_flag_bits {
 	((req)->cmd_flags & REQ_OP_MASK)
 
 /* obsolete, don't use in new code */
-#define bio_set_op_attrs(bio, op, op_flags) \
-	((bio)->bi_opf |= (op | op_flags))
+static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
+		unsigned op_flags)
+{
+	bio->bi_opf = op | op_flags;
+}
 
 static inline bool op_is_write(unsigned int op)
 {
-- 
2.1.4

