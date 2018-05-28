Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50973 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165489AbeE1NnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 May 2018 09:43:16 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B61431E04A3
        for <linux-block@vger.kernel.org>; Mon, 28 May 2018 15:43:14 +0200 (CEST)
To: "Jens Axboe <axboe@kernel.dk>; Hannes Reinecke <hare@suse.com>; Johannes
        Thumshirn <jthumshirn@suse.de>; Omar Sandoval <osandov@fb.com>; Mike
        Snitzer <snitzer@redhat.com>; Shaohua Li <shli@fb.com>; Bart Van Assche
        <bart.vanassche@wdc.com> ; Keith Busch <keith.busch@intel.com>; Ming Lei"
        <ming.lei@redhat.com>
Subject: [PATCH] block: Add block level changes for inline encryption
CC: <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org; Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Message-ID: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
Date: Mon, 28 May 2018 14:43:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


This patch introduces new variable under bio structure to
facilitate inline encryption. This variable is used to
associate I/O requests to crypto information.

Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
---
 block/Kconfig             | 13 +++++++++++++
 block/bio.c               |  6 ++++++
 include/linux/blk_types.h |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 28ec557..a48ecec 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -128,6 +128,19 @@ config BLK_DEV_THROTTLING_LOW
 
 	Note, this is an experimental interface and could be changed someday.
 
+config BLK_DEV_INLINE_ENCRYPTION
+	bool "Enable support for block device inline encryption"
+	default n
+	help
+	Enable block devices for Inline Encryption support.
+
+	This option is required to support the inline encryption capability
+	of the block device driver, including UFS Host Controller driver.
+	When the Inline Encryption feature is enabled in the block device
+	drivers, this option will be automatically enabled.
+
+	If unsure, say N.
+
 config BLK_CMDLINE_PARSER
 	bool "Block device command line partition parser"
 	default n
diff --git a/block/bio.c b/block/bio.c
index 0a4df92..91aecf5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -606,6 +606,9 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
+#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
+	bio->bi_ie_private = bio_src->bi_ie_private;
+#endif
 
 	bio_clone_blkcg_association(bio, bio_src);
 }
@@ -690,6 +693,9 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
+#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
+	bio->bi_ie_private      = bio_src->bi_ie_private;
+#endif
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4cb970c..11df096 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -183,6 +183,9 @@ struct bio {
 	void			*bi_cg_private;
 	struct bio_issue	bi_issue;
 #endif
+#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
+	void                    *bi_ie_private;
+#endif
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-- 
2.7.4
