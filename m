Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D6C04A6A
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 17:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjHHR4T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjHHRzs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC1298AE
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B7F961D9E
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 13:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C17FC433C8;
        Tue,  8 Aug 2023 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691503027;
        bh=ptKGcj+Hv+g5fxFGLRoGbRY5wCMXFJQrJ7vGDW5yqdU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bHKUoO4QK+Q/CDLxaofvtOGTg8zC5zWfq4nmRarquIz0r4KbQsaSYQcM/G6fMzE3S
         WM067B6cntOLpQNKtoe2MuqQiX31IQhQTOjPofeTfJarfEIdWAUI2sobYBt41hoLOm
         Tv4e4QbSyW4t4TBREfXCfrD18KSlp/4/3kN9Ht/3TM5DbyaZsgxEbLPJ/YiacS0Uba
         m2a4qoPxKqPFhH3x61AxhcfkIMJ0tWVTmJ4JAzG9me99Mi6POgHfWhlFgSiJ2Pr8/Q
         wGVlsNMB2FI5b6dspnpOIwjaHNcd0l66kgE+VCOa4OZJnUZdqLVpWlTZ5ijk7NcH2p
         cNzkTOB02IaPw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 5/5] block: switch ldm partition code to use pr_xxx() functions
Date:   Tue,  8 Aug 2023 22:57:02 +0900
Message-ID: <20230808135702.628588-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808135702.628588-1-dlemoal@kernel.org>
References: <20230808135702.628588-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Modify the ldm partition code to use the regular pr_info(), pr_err() etc
functions instead of using printk(). With this change, the function
_ldm_printk() is not necessary and removed. The special LDM_DEBUG
configuration option is also removed as regular dynamic debug control
can be used to turn on or off the debug messages. References to this
configuration option is removed from the documentation and from the m68k
defconfig.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/admin-guide/ldm.rst |  7 +++----
 arch/m68k/configs/virt_defconfig  |  1 -
 block/partitions/Kconfig          | 10 ---------
 block/partitions/ldm.c            | 35 +++++++------------------------
 4 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/Documentation/admin-guide/ldm.rst b/Documentation/admin-guide/ldm.rst
index 12c571368e73..e7b69a03e938 100644
--- a/Documentation/admin-guide/ldm.rst
+++ b/Documentation/admin-guide/ldm.rst
@@ -80,10 +80,9 @@ To enable LDM, choose the following two options:
   - "Advanced partition selection" CONFIG_PARTITION_ADVANCED
   - "Windows Logical Disk Manager (Dynamic Disk) support" CONFIG_LDM_PARTITION
 
-If you believe the driver isn't working as it should, you can enable the extra
-debugging code.  This will produce a LOT of output.  The option is:
-
-  - "Windows LDM extra logging" CONFIG_LDM_DEBUG
+If you believe the driver isn't working as it should, you can enable extra
+debugging messages using dynamic debug.  This will produce a LOT of output.
+See Documentation/admin-guide/dynamic-debug-howto.rst for details.
 
 N.B. The partition code cannot be compiled as a module.
 
diff --git a/arch/m68k/configs/virt_defconfig b/arch/m68k/configs/virt_defconfig
index 311b57e73316..94dd334da74f 100644
--- a/arch/m68k/configs/virt_defconfig
+++ b/arch/m68k/configs/virt_defconfig
@@ -19,7 +19,6 @@ CONFIG_MINIX_SUBPARTITION=y
 CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_LDM_PARTITION=y
-CONFIG_LDM_DEBUG=y
 CONFIG_SUN_PARTITION=y
 CONFIG_SYSV68_PARTITION=y
 CONFIG_NET=y
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 7aff4eb81c60..71e4461fc35d 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -200,16 +200,6 @@ config LDM_PARTITION
 
 	  If unsure, say N.
 
-config LDM_DEBUG
-	bool "Windows LDM extra logging"
-	depends on LDM_PARTITION
-	help
-	  Say Y here if you would like LDM to log verbosely.  This could be
-	  helpful if the driver doesn't work as expected and you'd like to
-	  report a bug.
-
-	  If unsure, say N.
-
 config SGI_PARTITION
 	bool "SGI partition support" if PARTITION_ADVANCED
 	default y if DEFAULT_SGI_PARTITION
diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 38e58960ae03..691908c8c8f3 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -19,39 +19,18 @@
 #include "ldm.h"
 #include "check.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "partition: ldm: " fmt
+
 /*
  * ldm_debug/info/error/crit - Output an error message
  * @f:    A printf format string containing the message
  * @...:  Variables to substitute into @f
- *
- * ldm_debug() writes a DEBUG level message to the syslog but only if the
- * driver was compiled with debug enabled. Otherwise, the call turns into a NOP.
  */
-#ifndef CONFIG_LDM_DEBUG
-#define ldm_debug(...)	do {} while (0)
-#else
-#define ldm_debug(f, a...) _ldm_printk (KERN_DEBUG, __func__, f, ##a)
-#endif
-
-#define ldm_crit(f, a...)  _ldm_printk (KERN_CRIT,  __func__, f, ##a)
-#define ldm_error(f, a...) _ldm_printk (KERN_ERR,   __func__, f, ##a)
-#define ldm_info(f, a...)  _ldm_printk (KERN_INFO,  __func__, f, ##a)
-
-static __printf(3, 4)
-void _ldm_printk(const char *level, const char *function, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start (args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	printk("%s%s(): %pV\n", level, function, &vaf);
-
-	va_end(args);
-}
+#define ldm_debug(f, a...) pr_debug("%s(): " f, __func__, ##a)
+#define ldm_crit(f, a...)  pr_crit("%s(): " f, __func__, ##a)
+#define ldm_error(f, a...) pr_err("%s(): " f, __func__, ##a)
+#define ldm_info(f, a...)  pr_info("%s(): " f, __func__, ##a)
 
 /**
  * ldm_parse_privhead - Read the LDM Database PRIVHEAD structure
-- 
2.41.0

