Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD90C2D0E5
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DB22074D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 18:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gs0KpXdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYSzS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:55:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44174 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 14:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585162517; x=1616698517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTxvAClUXETgUf5DJpiFRfRGG9W8afOr5c6Vq+QrYaA=;
  b=Gs0KpXdbZ2LAnjyiuzT5K8DME/f8w7Gt8n5cM0nRi+7LTYCNeNJy5WRb
   yWsanL9a8OHGEG+VupnsPifJ8Ol7DD363o+BVyBXDPsFOeLo/Peku4x+w
   FXzctLegP2zuMnnY7sbawZoNUJi+WZeMtX88uLaNpeVrQWJrYxdskta09
   Y0wJY2SyqK3yQLhDd/+/k4edx3pl+i/1MTKN4Lnt44/+clVs76oIbMxPw
   panMX3L9Q+jbJ5fhMAd44Ru2izQwM20IdTJSW+1RBUuOJOYFGz8ftpKsR
   EKRy9/5JkXBm8cAQ+LfRaWS86faBOzU/naVbbTJk+gfac+t6qcMH+OM1p
   Q==;
IronPort-SDR: A+rjrvf5fFkiQNk5utj46Nj+mO2jQiuhYzJiilBvXAYYj4tacYd23llIPBvaZE2b0GJi//gZ8q
 9WPUyvT1g/p7VZ23YzE0KaQUCa98lZsIEUx6PThhxyVBgKLHGz3ab/PcQeQOh3LDlmJYrhYGUm
 kWWwLiUfq+CwSShxTVfBBrBmpoy4EePD4idQ3aIxywYGQFdbWQwIhMum29CO9RSa/J/SEOu9UN
 BUnmhMcjF0NyoKWCEjNZLPumbZ0ZhvCYhZZQkQT7MGUb+a525+9WoDuztD3GwWQxVEh//gGnEo
 gAc=
X-IronPort-AV: E=Sophos;i="5.72,305,1580745600"; 
   d="scan'208";a="133494478"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2020 02:55:16 +0800
IronPort-SDR: 3cCq5ll4yUJYIOsm+CQdcG1U7hQHYzXP2yQ8kZ35Rrd/9Mgg+N98A8xjxI1/bx9dCWqvVMXoi9
 m9fa3pgNeyauRbQ2oUlLamEczMM+BECqz38Wgr5iiMUlc9631Vnj8ip90aInLBlQ9oYHjU48x6
 w/hwiWIUZe3C1AjM54xJfrjMCJVkKeM7hYU9GL62Jo/XNyD4y3Z3pylEuMseyXIRhPHh1iguAG
 uODRbxfYZfLicuYDzYcGaMtGvlsDcE/QtbY9v9wDK+M2F3LNPd0KjnxcnF7SmUiHWXfkU1s/lq
 SGTVtCg+UGo5Ai/8XCDDWqKv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 11:46:27 -0700
IronPort-SDR: ET50n/6soBimuGgfKxbVRYMSfuQlt3VbiQT43zbvzfSiPowk2wULDdJLOryhfuHWC/mCU5XP/t
 x/XgnOF+3DD4096SVhzSrIfkr97qf+YaM6N/NFDAci57eQPR/Khn5i5lBbr95sL/OsBHbw7aFP
 1pUTxYjtap76NJLrqnM+zNYESZVDncw8/+MYA7mvWL/x1w+xrzuH9MsNJqPqioARMZjui3BJxr
 kWbI6OOXbsaMuivUZCq+dvkhKfxjCOgnj+0FErd8CLBPkG0PKV+psQX7IKjo8Qp3P+ElQfpHOJ
 oGQ=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Mar 2020 11:55:17 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 2/3] null_blk: add tracepoint helpers for zoned mode
Date:   Wed, 25 Mar 2020 10:49:55 -0700
Message-Id: <20200325174956.16719-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325174956.16719-1-chaitanya.kulkarni@wdc.com>
References: <20200325174956.16719-1-chaitanya.kulkarni@wdc.com>
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
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
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

