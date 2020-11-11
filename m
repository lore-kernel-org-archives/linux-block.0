Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD4EC55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60542074B
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eNwMyid6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKKNBB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:01:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32534 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgKKNBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099660; x=1636635660;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=o+1lVTW/q7+3AX2JW2198Em9/z+xjLCGpSgs/dHrLYg=;
  b=eNwMyid67oboWqK+w4Qs8OHPJMCHr3qxoTz5SJLx9Ih1t44IcyQ8p8AR
   NEi8joJuVaoK/8oWSvdWcsNQhBCCHQsP5P6no49V/cP3EfZsvwyVs/qvJ
   EptMzCrTQfAi/cEskgOO7f6g6RybWkb7Zte9yHFdb/3x9e9TQbIm+8mfg
   GxAwkRX43R+vGgaVYsMdqjfS7ZaYfhn9xfHMCFC3/VDkQPmKR2ObvXkFS
   Z7UwwaKL+xAJ1bz2KZddQbgy5YYfuJI3fhoGnvk5IGD+xF9lCBMsyOGq/
   wGpJnP0u9LPJDZJJxJf4D0kOTGLA+uEZXcc4vcTv5aMspFzAq6TLH6mmC
   Q==;
IronPort-SDR: Vx+6RvZMU4Vli5BQszjbRUG3spbIfP66UF7rewtZ0cC0TTxRCSR5alisjriX3gQvhEVZtsLZ4D
 BCKlXzHq7AswaaCm3FVIHTsqVcBxpjDLVR0vVnz3Jvx8fNloVp4neBkM9Q5oJifUs1CGzUtw8U
 IhMD+DcEwyjdwbdhzJ9jESGk5fV0IiBQkUo63OC/72jE6rH+BN3dk70g0NvAAasJPMy4D4nLqi
 n42RO2w2o1/PVfjbxjAPkbY59Q0FuBthgBYxoDW9PXN+iWOHQB3ds651Rqh4V2tdwDgO1gRbU9
 cUA=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283554"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:59 +0800
IronPort-SDR: TrgsLCeiwBALmVSRs30QoQKyw6AQm7X2BvlPk1INPxTjoAwu76nCiAYbivWpZ9I9QRj3PuXzzo
 JhWDsB66Gv/nPBPr/bANycOSU2mksfZLa5qrwH6FJS7TiDwxySj6bfwMxOpG73uEov3pq4/bh3
 8/e676zLgAkaIceUvYZM/25N6W7pXqJ0/UgjlSiMa0vXE8878AG0VPFBQym/NuIo12bRucIEUo
 BoouVUWlc4raAO4msE6hQbFf9Bs2m+3Ji1ZrLjkuOE4JxmyKJGWZ/IL97/wFhO5DTi/L26ZxRV
 52ZRn+5XSReq3Uk9zpZ4lhTy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:41 -0800
IronPort-SDR: m1NBzDfYd7RUbpCRne6tPWqrAHfpKuAUvJFz2FgfvJ3+k8HNB0CevCZUxNj3EVBSGyuY+9j822
 9OD3vStqDnFu2SwJ939bsyM/IP2Beoim2PmpMZYFg14OQ9JsOjXMUSaHmy1kJ941e63XYbJPlK
 /zQFQemfb0lTtTOt1ftfCaXLEu4mYhzJXlq7qEA02gHYywMrg7ohgsmYrlwdWdz7NVCiEH0M71
 xmloV4RM82bSevAqYsDEj4sr5WRBc34Y8el8q//8QQLi+qLfy8esCZiQv8OXzlXExVbgvXK/cO
 7Wk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:59 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 9/9] null_blk: Move driver into its own directory
Date:   Wed, 11 Nov 2020 22:00:49 +0900
Message-Id: <20201111130049.967902-10-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
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
index 2fd8c825d70b..375ef63adcd3 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -4,7 +4,7 @@
 #include "null_blk.h"
 
 #define CREATE_TRACE_POINTS
-#include "null_blk_trace.h"
+#include "trace.h"
 
 #define MB_TO_SECTS(mb) (((sector_t)mb * SZ_1M) >> SECTOR_SHIFT)
 
-- 
2.26.2

