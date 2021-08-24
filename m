Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB824C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 07:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C484C6127B
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 07:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhHXHzf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhHXHzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 03:55:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4AAC061575
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZGNk7KL79bpbAs4G6/25iJbseUx2haZFDjHnv5KbN/k=; b=moHn7QSutaVt7cJv9lOutcSz0B
        06SptrnniMePCCsPiYMX3TYhnIiBHLN5cwiaI94kJHqPyKJMV/difaQnTaUiFStRwN3WzffJgzc3C
        TdGASg6fF/nC8qNqGVziadnYJbZYqvF4h2AlrC1ifOgMdXtrZ+sXr2DBgRSX2ulDc7gaM8bxAzTbJ
        EfudRLjiytzBKMkUioM1BBSaQqZK09rv+dkhxoxVTDlfPMYb2c6EImZ074GeveovS4QEAujKOTg8s
        aUpNX2/7IkXGSDi04O4scKV37cHwm1L8F640cPgB5cf4l8JE0PHThvjHPe5NWos62GFwxJHoIPK/D
        IMPPbh2w==;
Received: from [2001:4bb8:193:fd10:f8c0:1a4c:b688:f5a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIRG9-00AkYI-JJ; Tue, 24 Aug 2021 07:54:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: remove CONFIG_DEBUG_BLOCK_EXT_DEVT
Date:   Tue, 24 Aug 2021 09:52:16 +0200
Message-Id: <20210824075216.1179406-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824075216.1179406-1-hch@lst.de>
References: <20210824075216.1179406-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This might have been a neat debug aid when the extended dev_t was
added, but that time is long gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/configs/defconfig      |  1 -
 arch/riscv/configs/rv32_defconfig |  1 -
 block/genhd.c                     | 43 +++----------------------------
 init/do_mounts.c                  |  4 ---
 lib/Kconfig.debug                 | 27 -------------------
 5 files changed, 4 insertions(+), 72 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 1f2be234b11c..bc68231a8fb7 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -132,7 +132,6 @@ CONFIG_DEBUG_PLIST=y
 CONFIG_DEBUG_SG=y
 # CONFIG_RCU_TRACE is not set
 CONFIG_RCU_EQS_DEBUG=y
-CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 8dd02b842fef..434ef5b64599 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -127,7 +127,6 @@ CONFIG_DEBUG_PLIST=y
 CONFIG_DEBUG_SG=y
 # CONFIG_RCU_TRACE is not set
 CONFIG_RCU_EQS_DEBUG=y
-CONFIG_DEBUG_BLOCK_EXT_DEVT=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
diff --git a/block/genhd.c b/block/genhd.c
index 3ee031c97f22..716c5b04e5b1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -312,54 +312,19 @@ void unregister_blkdev(unsigned int major, const char *name)
 
 EXPORT_SYMBOL(unregister_blkdev);
 
-/**
- * blk_mangle_minor - scatter minor numbers apart
- * @minor: minor number to mangle
- *
- * Scatter consecutively allocated @minor number apart if MANGLE_DEVT
- * is enabled.  Mangling twice gives the original value.
- *
- * RETURNS:
- * Mangled value.
- *
- * CONTEXT:
- * Don't care.
- */
-static int blk_mangle_minor(int minor)
-{
-#ifdef CONFIG_DEBUG_BLOCK_EXT_DEVT
-	int i;
-
-	for (i = 0; i < MINORBITS / 2; i++) {
-		int low = minor & (1 << i);
-		int high = minor & (1 << (MINORBITS - 1 - i));
-		int distance = MINORBITS - 1 - 2 * i;
-
-		minor ^= low | high;	/* clear both bits */
-		low <<= distance;	/* swap the positions */
-		high >>= distance;
-		minor |= low | high;	/* and set */
-	}
-#endif
-	return minor;
-}
-
 int blk_alloc_ext_minor(void)
 {
 	int idx;
 
 	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT, GFP_KERNEL);
-	if (idx < 0) {
-		if (idx == -ENOSPC)
-			return -EBUSY;
-		return idx;
-	}
-	return blk_mangle_minor(idx);
+	if (idx == -ENOSPC)
+		return -EBUSY;
+	return idx;
 }
 
 void blk_free_ext_minor(unsigned int minor)
 {
-	ida_free(&ext_devt_ida, blk_mangle_minor(minor));
+	ida_free(&ext_devt_ida, minor);
 }
 
 static char *bdevt_str(dev_t devt, char *buf)
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 74aede860de7..b691d6891e51 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -432,10 +432,6 @@ void __init mount_block_root(char *name, int flags)
 		printk("Please append a correct \"root=\" boot option; here are the available partitions:\n");
 
 		printk_all_partitions();
-#ifdef CONFIG_DEBUG_BLOCK_EXT_DEVT
-		printk("DEBUG_BLOCK_EXT_DEVT is enabled, you need to specify "
-		       "explicit textual name for \"root=\" boot option.\n");
-#endif
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
 	if (!(flags & SB_RDONLY)) {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ddd575159fb..22a4aa51bd58 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1679,33 +1679,6 @@ config DEBUG_WQ_FORCE_RR_CPU
 	  feature by default.  When enabled, memory and cache locality will
 	  be impacted.
 
-config DEBUG_BLOCK_EXT_DEVT
-	bool "Force extended block device numbers and spread them"
-	depends on DEBUG_KERNEL
-	depends on BLOCK
-	default n
-	help
-	  BIG FAT WARNING: ENABLING THIS OPTION MIGHT BREAK BOOTING ON
-	  SOME DISTRIBUTIONS.  DO NOT ENABLE THIS UNLESS YOU KNOW WHAT
-	  YOU ARE DOING.  Distros, please enable this and fix whatever
-	  is broken.
-
-	  Conventionally, block device numbers are allocated from
-	  predetermined contiguous area.  However, extended block area
-	  may introduce non-contiguous block device numbers.  This
-	  option forces most block device numbers to be allocated from
-	  the extended space and spreads them to discover kernel or
-	  userland code paths which assume predetermined contiguous
-	  device number allocation.
-
-	  Note that turning on this debug option shuffles all the
-	  device numbers for all IDE and SCSI devices including libata
-	  ones, so root partition specified using device number
-	  directly (via rdev or root=MAJ:MIN) won't work anymore.
-	  Textual device names (root=/dev/sdXn) will continue to work.
-
-	  Say N if you are unsure.
-
 config CPU_HOTPLUG_STATE_CONTROL
 	bool "Enable CPU hotplug state control"
 	depends on DEBUG_KERNEL
-- 
2.30.2

