Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F9CC6379D
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BACE22254
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z+66ktM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKTBzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6558 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKTBzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837347; x=1637373347;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0QxzYPCbjov24q7/AyNBXvdAWCcFZLDgQuujZDOvIEQ=;
  b=Z+66ktM0NYsy6CW6fwwMrxKKJn5iHqSUj/kpKXc2tEHyKFOR/fqFBSAR
   NIx/ObjYao1PNfwITS8ZcwwFArG3yJA3rIKnnNV1h5zoLD7GSrYG8TV/U
   oB7kOccGtg4viiUrwEuivZf7SZ1eUEm60aFIXSeUOiqHI9HLnK6hhePJ8
   wZBSXaB0O6wmyM3c35NnI237cSZ1P88Dimm0pb/9NXNKlDg/xYks3bpTD
   ULOEIiiFrN5XlRZ/mh1oyMr6dsXUhzjTB4aSdFNvRcn4LJsuq06kepmqs
   bbp6/FTkaSLByRXtk9Q/3R8m9Pq/RqK+V+7pk6KTxUZkA8rWfZtpRTO2o
   w==;
IronPort-SDR: AwyiCHQNVTgLi6+BxkLDqN3eKMDmfjxYPa0zYRUyfsPJuNtFE/c7kvQoUidsPPZxb/+d2Uf0dk
 s1yZtfB8wRxO7G6XpvwWQSV1Yf2TS7H3MpD5vBOzXoG14RlUrQOWg3WSzvOeaPeiSeoo5Plr8u
 8ZmgebW1DHkZtxLdO/EMa1DKaCs4Gb+4eUipS8UGZZr5pxzyBfZDPTYeBgBMwIAW2L3JnsKCct
 cVFqTz01c3lynlQxXTttgVuxdLIkpqh7JQZzCONba43MNCHHCs3aZecsEOx/GAqq3QrH6eo0KR
 NX0=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516416"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:47 +0800
IronPort-SDR: BbDDotb2+bbh7I7xhQWVird0TGDANVEOCxeQdRa+33LTTXkZg/NOV7wNFneRmh+7QNbs8lrzdV
 Cy/r6oSCfAsXbEuJ2E7eiZRtzNFkBDajOKuiUhDG0MFGBAIok2ObBAzGgnOvgU1MY/Dr0WrQeY
 Y/xE0rWlMJ53Vv5s0Xe/UVQK3WhhvypTBV0zV6x9YDfTgwW5kFsFH8RYkp8PJNbo91dciHLw+B
 +yX4ydrOlDC/HiLNkX+rg56QbKIjK5ZT9RFGX6BoK/xmU/t6apkXKQu7Hxat+XJrQV+jlal0RW
 DIXOejYodDyoItSHBrlSWE55
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:37 -0800
IronPort-SDR: npl0KWFeJX/JoBgoUeScL0K7EnAAN64uzoC2aE/Xf0GVqnrU5o/ArsNaScFlIh5LZ1QLi1hcgm
 jpVoyxJ2Dt7oAKJWA30uI/j7M/Jw28gVc4O18pxWhpwpm7HS0WL4fo7t9s1+3AVA/JD1tLhL4W
 RDRZCNENcQYO4+m7P9bqBQDSZApZo0l1lOKoy4VTS2oIOig3j01tsUHv2vkQ7nOFCcMtDlqbAK
 LKMlnzrxXtJIDVyPXOFOe3WC3EgVEKIjgexmGGpaMCisXbl4jHUaNLi9uEHENqGX1Kb+wSA/r/
 dF0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:47 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 9/9] null_blk: Move driver into its own directory
Date:   Fri, 20 Nov 2020 10:55:19 +0900
Message-Id: <20201120015519.276820-10-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move null_blk driver code into the new sub-directory
drivers/block/null_blk.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/Kconfig                                |  8 +-------
 drivers/block/Makefile                               |  7 +------
 drivers/block/null_blk/Kconfig                       | 12 ++++++++++++
 drivers/block/null_blk/Makefile                      | 11 +++++++++++
 drivers/block/{null_blk_main.c => null_blk/main.c}   |  0
 drivers/block/{ => null_blk}/null_blk.h              |  0
 drivers/block/{null_blk_trace.c => null_blk/trace.c} |  2 +-
 drivers/block/{null_blk_trace.h => null_blk/trace.h} |  2 +-
 drivers/block/{null_blk_zoned.c => null_blk/zoned.c} |  2 +-
 9 files changed, 28 insertions(+), 16 deletions(-)
 create mode 100644 drivers/block/null_blk/Kconfig
 create mode 100644 drivers/block/null_blk/Makefile
 rename drivers/block/{null_blk_main.c => null_blk/main.c} (100%)
 rename drivers/block/{ => null_blk}/null_blk.h (100%)
 rename drivers/block/{null_blk_trace.c => null_blk/trace.c} (93%)
 rename drivers/block/{null_blk_trace.h => null_blk/trace.h} (97%)
 rename drivers/block/{null_blk_zoned.c => null_blk/zoned.c} (99%)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ecceaaa1a66f..262326973ee0 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -16,13 +16,7 @@ menuconfig BLK_DEV
 
 if BLK_DEV
 
-config BLK_DEV_NULL_BLK
-	tristate "Null test block driver"
-	select CONFIGFS_FS
-
-config BLK_DEV_NULL_BLK_FAULT_INJECTION
-	bool "Support fault injection for Null test block driver"
-	depends on BLK_DEV_NULL_BLK && FAULT_INJECTION
+source "drivers/block/null_blk/Kconfig"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index e1f63117ee94..a3170859e01d 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -41,12 +41,7 @@ obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
-obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
-null_blk-objs	:= null_blk_main.o
-ifeq ($(CONFIG_BLK_DEV_ZONED), y)
-null_blk-$(CONFIG_TRACING) += null_blk_trace.o
-endif
-null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
+obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/null_blk/Kconfig b/drivers/block/null_blk/Kconfig
new file mode 100644
index 000000000000..6bf1f8ca20a2
--- /dev/null
+++ b/drivers/block/null_blk/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Null block device driver configuration
+#
+
+config BLK_DEV_NULL_BLK
+	tristate "Null test block driver"
+	select CONFIGFS_FS
+
+config BLK_DEV_NULL_BLK_FAULT_INJECTION
+	bool "Support fault injection for Null test block driver"
+	depends on BLK_DEV_NULL_BLK && FAULT_INJECTION
diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Makefile
new file mode 100644
index 000000000000..84c36e512ab8
--- /dev/null
+++ b/drivers/block/null_blk/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# needed for trace events
+ccflags-y			+= -I$(src)
+
+obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
+null_blk-objs			:= main.o
+ifeq ($(CONFIG_BLK_DEV_ZONED), y)
+null_blk-$(CONFIG_TRACING) 	+= trace.o
+endif
+null_blk-$(CONFIG_BLK_DEV_ZONED) += zoned.o
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk/main.c
similarity index 100%
rename from drivers/block/null_blk_main.c
rename to drivers/block/null_blk/main.c
diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk/null_blk.h
similarity index 100%
rename from drivers/block/null_blk.h
rename to drivers/block/null_blk/null_blk.h
diff --git a/drivers/block/null_blk_trace.c b/drivers/block/null_blk/trace.c
similarity index 93%
rename from drivers/block/null_blk_trace.c
rename to drivers/block/null_blk/trace.c
index f246e7bff698..3711cba16071 100644
--- a/drivers/block/null_blk_trace.c
+++ b/drivers/block/null_blk/trace.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2020 Western Digital Corporation or its affiliates.
  */
-#include "null_blk_trace.h"
+#include "trace.h"
 
 /*
  * Helper to use for all null_blk traces to extract disk name.
diff --git a/drivers/block/null_blk_trace.h b/drivers/block/null_blk/trace.h
similarity index 97%
rename from drivers/block/null_blk_trace.h
rename to drivers/block/null_blk/trace.h
index 4f83032eb544..ce3b430e88c5 100644
--- a/drivers/block/null_blk_trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -73,7 +73,7 @@ TRACE_EVENT(nullb_report_zones,
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_FILE null_blk_trace
+#define TRACE_INCLUDE_FILE trace
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk/zoned.c
similarity index 99%
rename from drivers/block/null_blk_zoned.c
rename to drivers/block/null_blk/zoned.c
index 65464f7559e0..148b871f263b 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -4,7 +4,7 @@
 #include "null_blk.h"
 
 #define CREATE_TRACE_POINTS
-#include "null_blk_trace.h"
+#include "trace.h"
 
 #define MB_TO_SECTS(mb) (((sector_t)mb * SZ_1M) >> SECTOR_SHIFT)
 
-- 
2.28.0

