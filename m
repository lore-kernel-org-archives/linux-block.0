Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13523C35242
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E098720726
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="go7cdEvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgBOA6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:58:04 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49846 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgBOA6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 19:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581728283; x=1613264283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5uMNY0PoMYTboC/4vcdS8zjDc0S+AwdbfN1pm64k2lM=;
  b=go7cdEvuKEbZnN69pdy4Oqzvo5tYlGDcqoEoGJT6toShggSXOdUKg6rm
   Nvz0GRhTd9v5RGS+E2ZSu3FqwNSi+b0+LREjSDlW1Jur5G8vQjBH2pr4H
   egqQpt41ktsJ/SKJDu/7t4VtTkVrt+K6kSRSQvSvkRWLBr5AAvWgWLS/L
   c4QeeW+6wtytB5h2kNQ4ErWPjDLP3yeoyIeGW94sS5P2CwQiB7oSG7yp1
   T+X+ncFJskZXsM70xJ4z+zxgl1UUEeNtzUUQjM22ToQIx1pm7hX6Bsd02
   7Q4ZVrc2FHgCZYQV8KS2jRLdf/TWjhMZqBafmHKgMRFCiMay6HIgpDDAW
   g==;
IronPort-SDR: 1OBd2KLZw/ZnuGbNScjqrLxeda3x0teZzt0eu9WqKBl4T0Zzw5QUm0HqfwMRaZ4QcEjwklIajm
 hCAPXNDtENKottpztM4QOog6JEa/QQttG1F/Pn6Uuy076qQgtz4HJRo7yQsdpsyzBGog1tNU5y
 lWH7BaZ1hK/UDpfAlNAjRbpHB/rA/32ANML8Ntk5FkOzQaBQCE9ou/rDe/etjAaQp0t944vd2n
 LOpKw0hJfj3RrWSlYl3GeBXDxPqQ56r6CJxrBIMLbg26yOJdxS7NS7C1bsuUBJjOYxegeNynlj
 Se8=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; 
   d="scan'208";a="129905400"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 08:58:03 +0800
IronPort-SDR: fc1SS6mS+EEffDArMvgRdOdnnQBdHF5fyYDjF4iA/KWQ4/9pkpbTQDB3rbNVZqCwhWI+qU0ytp
 tTbCUDQHnydPPjC98LqA9mzcwArQF41O8hv7kRKZsSxZp+UO8rdgOl7QEHyHV+SY3EyG6QSqcb
 okY4disH7UgAMgPpHru7XP1WUAuiWLfsMdkwqjTkJjaf05tlX7Qmz8uEjL+vWtbEAo30VNYAJu
 40MngzUpx0e1EWt5gxlVm395/1aJRmH6L8mM5E1erT1kMhVTygZt2OU0VyRsBoz1Fl1yXgZ30J
 qgYmG+LgYanrvNM8EiNrXh1u
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 16:50:48 -0800
IronPort-SDR: pdqWvhWUNy8rBYnv6yfMHHhoUiiap6gJuZR22ZZV8TmaSj+64v49rVHZ8sT/gkWYxPfT7ztbmT
 Ev4GyApijU8OLybp7f9syyKURvuLJKjl5vHRij8KoytsB5FxFGJ5dcIAh7KuMBW8VQv2N5ak/X
 PrMsH1cFwvyZ2Htz4iTwX/kIsbHQGjC70t0hluZOTmikcyez9Jq9VB/KPNQo6BRwkasyQE2lA4
 xNmehwKvibJgRgJDQhI2T33y8WaeYIJVPeE5KNpruVV98BK3ekMCSQYA61v0ch9OyzgFalncOy
 +DU=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 16:58:03 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, damien.lemoal@wdc.com
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/3] null_blk: add tracepoint helpers for zoned mode
Date:   Fri, 14 Feb 2020 16:57:57 -0800
Message-Id: <20200215005758.3212-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
References: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
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
 drivers/block/Makefile         |  3 ++
 drivers/block/null_blk_trace.c | 20 +++++++++
 drivers/block/null_blk_trace.h | 78 ++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/block/null_blk_trace.c
 create mode 100644 drivers/block/null_blk_trace.h

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a53cc1e3a2d3..b05aa413f7c0 100644
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
+null_blk-$(CONFIG_TRACING)	+= null_blk_trace.o
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

