Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92813C34047
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C87A2464E
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HtPrxKTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBRR25 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:57 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49048 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRR25 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582046937; x=1613582937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HslBlIkDzsUYjHSLvAZ72qysCx+cr80B5VVH6xglZU4=;
  b=HtPrxKTaMOn0V2H+ZNwlZVXFkSGPXUirsuXBKpXJK+8q/bkLiVDlOqmt
   kzt1X41FG6zCw1umEJPwpjnOTbCBK6IOiE0DtrOM2ZQEmPICpC+2PjYLT
   7uYJvbIKQOfG3qEY8Kmtzx+1zIgQ8H8Gi5orR5KtR+hAl+G1YJv8V2RnC
   0vMs3MhVNIxOOY3aMUX2zvu1U2AXVGANZMVw/JIRTEbh8Lxk8nDRjEsmz
   rvCwS1+ytq5/kmBmt1JoH9QTKWJb3QPjDiORWOLfYu4Ks1gPSKrF2uh8K
   PsWe8nVZWraCCSz2r8RuY2cFujcJR+C6SmY+4vitXy2dWaguBB46S27z2
   w==;
IronPort-SDR: WYL0fQGgLyzizypQRJO+ZK5c9zgjifGBFDGmncW49ncOtitd9OB3Gqis+KShmH9B0k+vE/V5UA
 GFYiB3+qw14MvPcrUiPNYBcPVT126/5rrL3B25QPECd29Ftu3/L+6L26oI8s2RI85Y0BR44omf
 XOauLbc5J2Y7VNV0UCRM2/qbs/twv2nyJ2ylyhvF2Eu2QUvorhQgllA6GFgQxTUiuPPJc6NPka
 lsljTIbsxONXUg/u7/35zhc2WngmIq971opWwaHhRHYuZON39LjO8/++Z3eCPkP1u5520fuU+o
 PsE=
X-IronPort-AV: E=Sophos;i="5.70,456,1574092800"; 
   d="scan'208";a="134466591"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 01:28:57 +0800
IronPort-SDR: QWRklh+FGtMLRH+mPJhpaW87Rfy/6w0wEuY2ty0HIQs2D4wKbxo6Ba46u/cFUWFgVBHB2ql0/m
 u3OeFaDJslJCW8neD3gL2uNS5QsgwGaP3/zBf3IpjcxiTMtdjoD/yuVPH543gApIcKO850Y+ac
 2fLVBTLZO6JVcWvofU9Qgfpzx8g3qi1TnryGGnN9kFmc48ue1Vn94VTnoAINs6DaUTkr6I+W5u
 nNZ5ZzpDPgYiQ4yat8Z2Ey7zoCdD1JsmH3CBuxEMOBImuxF4MmE6J2OSGFC5xWYdrgSFEY6AN7
 JI1/rW9V4VQovC/mrVTe4VR1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 09:21:35 -0800
IronPort-SDR: S8xO3uFFLRD1TqyKFU8pL6ma5/8B8kwet+yOqr+L3CqCN7yUtxC37O7Lf/aO9h2/qETJDbBicc
 D7xlWY23U6qTbAIqoJ2ECwN+KIRUmzyer/UqodkAVAH32aYt2sf5E90wvvXj+mTUcqdGXo7O1G
 elwz685GdBI+xSzP2lCTyOQdaI9vFlZLDq494oPIcOHjQmoLNPwe1CUBRZ+RH/tUP1SByMYUzo
 kHOSMOvOJiez4+Pqdj7kQaAuvTR8sdeK1rKwNQ7hUXlENF3tsN/vRwbFEOvTQ0skAvnMZ5P49i
 blk=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2020 09:28:56 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     damien.lemoal@wdc.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/3] null_blk: add tracepoint helpers for zoned mode
Date:   Tue, 18 Feb 2020 09:28:39 -0800
Message-Id: <20200218172840.4097-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
References: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
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
Changes from V1:-

1. Use CONFIG_BLK_DEV_ZONE for null_blk_trace.o.
--
 drivers/block/Makefile         |  3 ++
 drivers/block/null_blk_trace.c | 20 +++++++++
 drivers/block/null_blk_trace.h | 78 ++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/block/null_blk_trace.c
 create mode 100644 drivers/block/null_blk_trace.h

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a53cc1e3a2d3..675eadbb8a91 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -6,6 +6,8 @@
 # Rewritten to use lists instead of if-statements.
 # 
 
+ccflags-y				+= -I$(src)
+
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
@@ -39,6 +41,7 @@ obj-$(CONFIG_ZRAM) += zram/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs	:= null_blk_main.o
+null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_trace.o
 null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
 
 skd-y		:= skd_main.o
diff --git a/drivers/block/null_blk_trace.c b/drivers/block/null_blk_trace.c
new file mode 100644
index 000000000000..bd066130ff39
--- /dev/null
+++ b/drivers/block/null_blk_trace.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * All trace related helpers for null_blk goes here.
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
index 000000000000..8171bc26f6d1
--- /dev/null
+++ b/drivers/block/null_blk_trace.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * null_blk device driver tracepoints.
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
+#define __print_disk_name(name)				\
+	nullb_trace_disk_name(p, name)
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
2.22.1

