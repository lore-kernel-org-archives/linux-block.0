Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A1C54FCF
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8B220724
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J/vNDQdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCYDVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:21:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28768 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYDVr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 23:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585106508; x=1616642508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ayaeOSCp0h6IyoJ4r1GNbP9LA7FwtNIS474PFWS2FQ=;
  b=J/vNDQdDxolBmxUYxJPCnio5EeY7SXNssxrCahWkX72Q2jGJb2b0j5/y
   M1K+ZqE58LorT5o8ICK+j1US6JR6c34obD36T3FbPpgVfWRUfQGATCZA+
   XrAS5CUy1UtjDFsaJlyzHAJYXWFCcwRr1hxAL6+rbwIeIh78XvggAr5LT
   HDurg+d9EQqJISxnUNgD9e4IZTsdvrtXzgrlQoEQGfZijuxNg6Oc9D4cD
   bxoZ7vRgHdVHp8Sw2CYBblxgND5NNFADNBmZse72AU+IiKtxqphfahIGP
   oahrmJZZuJUphxAoMD/1tUF4HMwh35s7nKQOPi7Vy5sgpGSTObl+Ivn60
   w==;
IronPort-SDR: tv1yJQiHnm2j5rf0hJzWGrISZDShq1kVpQz4UFPl6TDhoTiFss6hHcGybJ8K759c7MlBlmVKMG
 gmd4as3VRUJSYz6HJniJ5X00IiLKP3uZCJC2b9j0DdxL22VdO63ttCK7q0rRoDopbJ749RdEjX
 84U9DLsuA+whuEKHFxL3I9L+Em5RoGJ1d9nXoKOowSKrHYE2w3+1sakyBnFJjFiRNUQDJpdFk1
 4hQT+g1pcD71zFiKT9vB29YzFWVr9nDv149j1xfP/C8PqiU0x/IKl5In6fUh2H2up8eT7iytJS
 IZE=
X-IronPort-AV: E=Sophos;i="5.72,302,1580745600"; 
   d="scan'208";a="133862165"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 11:21:47 +0800
IronPort-SDR: +cipwvK6sVDbLq/rYlOV3vwRQzwgQWrYqOjIUELIX8ovUefJp+FbXOBLxq4AMyIOgchDHrLtej
 B2S1mKC3Mqv9WT+xDtZgPLRt7W7qxTt3QbjVbLweypfEd9f6g9AHzJpbIr3/nwOG3xwQc5+xJQ
 yEP61DFvWbUG1XLR6MNGFIxq3Tm/yE5juBrH6+iC1jwN7/mvvl1M55IZRp7546xeJJBS/cpxpP
 8qbCUSpHEY+hqQAfI+9BGCrdScAoPm+wB/zDscjhsuQBfUplyX1avfMYNamEOQkHnGMEENtJAJ
 Yj9gsMmnVKu49/JfviEkYXHV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 20:13:25 -0700
IronPort-SDR: MvAwtnx8sYHEDAMT8HlPVk/IhsYyJcHHp7wUPIQA6eXl3cknBv8gQ3rbLB0FJBpN1bdw5m0ldu
 Fm1fHKDCCNsqjrxggxA7wVmo45/uxMZWTqi90oi69UdCTDPdDYA6fhORHpA2Cka20yxmSdbQ9J
 3/KYTm3GAnifdodUxVCSWBr4jVzhM4upXQDK1aMt8rlfTHrw/Q7RmOTVeps+CKiMcAQNirMQfY
 A5xguywRdAVb/5MdK2ogw8ZEPnW1GMaQSVBAC7tk2Mpn4i71/0oljDEVMMjdYBnZVJlivPiyz1
 0NA=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 20:21:46 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 2/3] null_blk: add tracepoint helpers for zoned mode
Date:   Tue, 24 Mar 2020 19:16:28 -0700
Message-Id: <20200325021629.15103-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds two new tracpoints for null_blk_zoned.c that allows us
to trace report-zones, zone-mgmt-op and zone-write operations which has
direct effect on the zone condition state machine.

Also, we update drivers/block/Makefile so that new null_blk related
tracefiles can be compiled.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/Makefile         |  6 +++
 drivers/block/null_blk_trace.c | 21 +++++++++
 drivers/block/null_blk_trace.h | 79 ++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/block/null_blk_trace.c
 create mode 100644 drivers/block/null_blk_trace.h

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a53cc1e3a2d3..795facd8cf19 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -6,6 +6,9 @@
 # Rewritten to use lists instead of if-statements.
 # 
 
+# needed for trace events
+ccflags-y				+= -I$(src)
+
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
@@ -39,6 +42,9 @@ obj-$(CONFIG_ZRAM) += zram/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs	:= null_blk_main.o
+ifeq ($(CONFIG_BLK_DEV_ZONED), y)
+null_blk-$(CONFIG_TRACING) += null_blk_trace.o
+endif
 null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
 
 skd-y		:= skd_main.o
diff --git a/drivers/block/null_blk_trace.c b/drivers/block/null_blk_trace.c
new file mode 100644
index 000000000000..f246e7bff698
--- /dev/null
+++ b/drivers/block/null_blk_trace.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * null_blk trace related helpers.
+ *
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+#include "null_blk_trace.h"
+
+/*
+ * Helper to use for all null_blk traces to extract disk name.
+ */
+const char *nullb_trace_disk_name(struct trace_seq *p, char *name)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (name && *name)
+		trace_seq_printf(p, "disk=%s, ", name);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
diff --git a/drivers/block/null_blk_trace.h b/drivers/block/null_blk_trace.h
new file mode 100644
index 000000000000..4f83032eb544
--- /dev/null
+++ b/drivers/block/null_blk_trace.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * null_blk device driver tracepoints.
+ *
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nullb
+
+#if !defined(_TRACE_NULLB_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NULLB_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "null_blk.h"
+
+const char *nullb_trace_disk_name(struct trace_seq *p, char *name);
+
+#define __print_disk_name(name) nullb_trace_disk_name(p, name)
+
+#ifndef TRACE_HEADER_MULTI_READ
+static inline void __assign_disk_name(char *name, struct gendisk *disk)
+{
+	if (disk)
+		memcpy(name, disk->disk_name, DISK_NAME_LEN);
+	else
+		memset(name, 0, DISK_NAME_LEN);
+}
+#endif
+
+TRACE_EVENT(nullb_zone_op,
+	    TP_PROTO(struct nullb_cmd *cmd, unsigned int zone_no,
+		     unsigned int zone_cond),
+	    TP_ARGS(cmd, zone_no, zone_cond),
+	    TP_STRUCT__entry(
+		__array(char, disk, DISK_NAME_LEN)
+		__field(enum req_opf, op)
+		__field(unsigned int, zone_no)
+		__field(unsigned int, zone_cond)
+	    ),
+	    TP_fast_assign(
+		__entry->op = req_op(cmd->rq);
+		__entry->zone_no = zone_no;
+		__entry->zone_cond = zone_cond;
+		__assign_disk_name(__entry->disk, cmd->rq->rq_disk);
+	    ),
+	    TP_printk("%s req=%-15s zone_no=%u zone_cond=%-10s",
+		      __print_disk_name(__entry->disk),
+		      blk_op_str(__entry->op),
+		      __entry->zone_no,
+		      blk_zone_cond_str(__entry->zone_cond))
+);
+
+TRACE_EVENT(nullb_report_zones,
+	    TP_PROTO(struct nullb *nullb, unsigned int nr_zones),
+	    TP_ARGS(nullb, nr_zones),
+	    TP_STRUCT__entry(
+		__array(char, disk, DISK_NAME_LEN)
+		__field(unsigned int, nr_zones)
+	    ),
+	    TP_fast_assign(
+		__entry->nr_zones = nr_zones;
+		__assign_disk_name(__entry->disk, nullb->disk);
+	    ),
+	    TP_printk("%s nr_zones=%u",
+		      __print_disk_name(__entry->disk), __entry->nr_zones)
+);
+
+#endif /* _TRACE_NULLB_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE null_blk_trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.22.0

