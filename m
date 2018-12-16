Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDEDC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 01:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B968206C2
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 01:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPydhI3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeLPBsw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Dec 2018 20:48:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38929 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLPBsw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Dec 2018 20:48:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so4438946pgl.6;
        Sat, 15 Dec 2018 17:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=HZQs3PQx2/bdtEO8VHnejHgNGOzdb07KmzpGf5Nbh/g=;
        b=OPydhI3AmN+VnP0cPlqTOI+cdbKFeCMv26SyGHE2rMW4Z1TVETZ4YEPajA6vF9HmhV
         jeJQxm9A3avkSNelIySZlAg7PuNMAbrD0MXnGr7lTBriT97cG1BvPdbrazIbd1w4foV4
         EJAy94BTHDnbvbbnqzsaJxrD6zaHwJ5jdTpcRmOekG7/xZ+HSBKWBs6yWkko70zMN6i6
         AEUzkS6qNE3AkYaG+518Kt566jVBv0uDT0pi95n1QAi5CipdMdz3undfyu6lWTalvF+h
         l2dTEkWStFQWuX+KS3/ENCzN2IwKV0/j87hy2S02RsgMyfhRCbnxxNmsdWsBVcM4bbAX
         Nu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=HZQs3PQx2/bdtEO8VHnejHgNGOzdb07KmzpGf5Nbh/g=;
        b=I5+iE4Ss3m2ROzM0R2s9kKR3sq12XVYto+3NQUqGjGsJyNvDzANLAi8hKY7+EIilOO
         qKmb99ABFT3MAfRIWUZPmN+rEAZfUH4JliFsu8udbFWZ1gtJMZ6DWlRkUJ3GEJj7LRqv
         7NbcgYlXe8B38T6vV7wNpgLbwCQ1Dn0DOAvmdRpBiUxFi1iWoDHDmYMPjrUto5R3wb/f
         gtQv+5uiL5lloOG8J6ADhEi+sut6K3DPF46vTqWAyK+SGUC9RawtfSrOli1gTtOQFu4h
         5EpLWMe5H7an4I5l+/pg1/lL5y3hr10UM8LPyvPQJI3VgMyY9THlohLDtySQ1MwvV+XS
         MBFA==
X-Gm-Message-State: AA+aEWb20xmngUcyl2Y15GaFmSJgERAz5CU+Y2I22uZna6xeVlQvZ/ZG
        xceA8oQbKNb0UXTwg7nND/EkMaxdZ2Q=
X-Google-Smtp-Source: AFSGD/VDI05SfkhKQPFPCzk5RR7S4rBXO+Iai1MJ0+m2OiAtam7nrFkyiLKhULHjJwVxuaK/gFShvQ==
X-Received: by 2002:a62:db41:: with SMTP id f62mr8378361pfg.123.1544924930789;
        Sat, 15 Dec 2018 17:48:50 -0800 (PST)
Received: from localhost.localdomain ([2601:602:9602:6598:9540:1d4c:35c2:b8e8])
        by smtp.gmail.com with ESMTPSA id z127sm14394990pfb.80.2018.12.15.17.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 17:48:50 -0800 (PST)
From:   yupeng <yupeng0921@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH v2 1/2] share nvme trace event helper functions with multiple nvme modules
Date:   Sat, 15 Dec 2018 17:48:48 -0800
Message-Id: <20181216014849.8584-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The trace.c could only be used by core.c, move it to a header file and
then other nvme modules could also use it. This commit creates a new
header file trace_common.h, which has all the functions of trace.c. It
changes all functions to static functions, so any other modules could
include it without conflict. This commit also moves some common
functions from trace.h to trace_common.h. Because the trace events in
trace.h are used by nvme-core only, this commit renames the trace.h to
trace_core.h.

Signed-off-by: yupeng <yupeng0921@gmail.com>
---
 drivers/nvme/host/Makefile                    |  1 -
 drivers/nvme/host/core.c                      |  2 +-
 drivers/nvme/host/{trace.c => trace_common.h} | 82 +++++++++++++++++--
 drivers/nvme/host/{trace.h => trace_core.h}   | 76 +----------------
 4 files changed, 80 insertions(+), 81 deletions(-)
 rename drivers/nvme/host/{trace.c => trace_common.h} (55%)
 rename drivers/nvme/host/{trace.h => trace_core.h} (56%)

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index aea459c65ae1..165c265f57f1 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 
 nvme-core-y				:= core.o
-nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 962012135b62..a1cf8df4c507 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -30,7 +30,7 @@
 #include <asm/unaligned.h>
 
 #define CREATE_TRACE_POINTS
-#include "trace.h"
+#include "trace_core.h"
 
 #include "nvme.h"
 #include "fabrics.h"
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace_common.h
similarity index 55%
rename from drivers/nvme/host/trace.c
rename to drivers/nvme/host/trace_common.h
index 25b0e310f4a8..b9b88da74f58 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace_common.h
@@ -12,9 +12,16 @@
  * more details.
  */
 
-#include <asm/unaligned.h>
-#include "trace.h"
+#ifndef TRACE_HEADER_MULTI_READ
+
+#include <linux/nvme.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "nvme.h"
 
+#ifdef CONFIG_TRACING
+#include <asm/unaligned.h>
 static const char *nvme_trace_create_sq(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -99,7 +106,7 @@ static const char *nvme_trace_common(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
-const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
+static const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 				       u8 opcode, u8 *cdw10)
 {
 	switch (opcode) {
@@ -114,7 +121,7 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 	}
 }
 
-const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
+static const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 				     u8 opcode, u8 *cdw10)
 {
 	switch (opcode) {
@@ -129,7 +136,7 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 	}
 }
 
-const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
+static const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
 
@@ -139,3 +146,68 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 
 	return ret;
 }
+
+#endif	/* CONFIG_TRACING */
+
+static inline void __assign_disk_name(char *name, struct gendisk *disk)
+{
+	if (disk)
+		memcpy(name, disk->disk_name, DISK_NAME_LEN);
+	else
+		memset(name, 0, DISK_NAME_LEN);
+}
+
+#define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
+#define show_admin_opcode_name(val)					\
+	__print_symbolic(val,						\
+		nvme_admin_opcode_name(nvme_admin_delete_sq),		\
+		nvme_admin_opcode_name(nvme_admin_create_sq),		\
+		nvme_admin_opcode_name(nvme_admin_get_log_page),	\
+		nvme_admin_opcode_name(nvme_admin_delete_cq),		\
+		nvme_admin_opcode_name(nvme_admin_create_cq),		\
+		nvme_admin_opcode_name(nvme_admin_identify),		\
+		nvme_admin_opcode_name(nvme_admin_abort_cmd),		\
+		nvme_admin_opcode_name(nvme_admin_set_features),	\
+		nvme_admin_opcode_name(nvme_admin_get_features),	\
+		nvme_admin_opcode_name(nvme_admin_async_event),		\
+		nvme_admin_opcode_name(nvme_admin_ns_mgmt),		\
+		nvme_admin_opcode_name(nvme_admin_activate_fw),		\
+		nvme_admin_opcode_name(nvme_admin_download_fw),		\
+		nvme_admin_opcode_name(nvme_admin_ns_attach),		\
+		nvme_admin_opcode_name(nvme_admin_keep_alive),		\
+		nvme_admin_opcode_name(nvme_admin_directive_send),	\
+		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
+		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
+		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
+		nvme_admin_opcode_name(nvme_admin_security_send),	\
+		nvme_admin_opcode_name(nvme_admin_security_recv),	\
+		nvme_admin_opcode_name(nvme_admin_sanitize_nvm))
+
+#define nvme_opcode_name(opcode)	{ opcode, #opcode }
+#define show_nvm_opcode_name(val)				\
+	__print_symbolic(val,					\
+		nvme_opcode_name(nvme_cmd_flush),		\
+		nvme_opcode_name(nvme_cmd_write),		\
+		nvme_opcode_name(nvme_cmd_read),		\
+		nvme_opcode_name(nvme_cmd_write_uncor),		\
+		nvme_opcode_name(nvme_cmd_compare),		\
+		nvme_opcode_name(nvme_cmd_write_zeroes),	\
+		nvme_opcode_name(nvme_cmd_dsm),			\
+		nvme_opcode_name(nvme_cmd_resv_register),	\
+		nvme_opcode_name(nvme_cmd_resv_report),		\
+		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_resv_release))
+
+#define show_opcode_name(qid, opcode)					\
+	(qid ? show_nvm_opcode_name(opcode) : show_admin_opcode_name(opcode))
+
+#define parse_nvme_cmd(qid, opcode, cdw10) 			\
+	(qid ?							\
+	 nvme_trace_parse_nvm_cmd(p, opcode, cdw10) : 		\
+	 nvme_trace_parse_admin_cmd(p, opcode, cdw10))
+
+#define __print_disk_name(name)				\
+	nvme_trace_disk_name(p, name)
+
+
+#endif	/* TRACE_HEADER_MULTI_READ */
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace_core.h
similarity index 56%
rename from drivers/nvme/host/trace.h
rename to drivers/nvme/host/trace_core.h
index 196d5bd56718..ed60ad6cf634 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace_core.h
@@ -18,79 +18,7 @@
 #if !defined(_TRACE_NVME_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_NVME_H
 
-#include <linux/nvme.h>
-#include <linux/tracepoint.h>
-#include <linux/trace_seq.h>
-
-#include "nvme.h"
-
-#define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
-#define show_admin_opcode_name(val)					\
-	__print_symbolic(val,						\
-		nvme_admin_opcode_name(nvme_admin_delete_sq),		\
-		nvme_admin_opcode_name(nvme_admin_create_sq),		\
-		nvme_admin_opcode_name(nvme_admin_get_log_page),	\
-		nvme_admin_opcode_name(nvme_admin_delete_cq),		\
-		nvme_admin_opcode_name(nvme_admin_create_cq),		\
-		nvme_admin_opcode_name(nvme_admin_identify),		\
-		nvme_admin_opcode_name(nvme_admin_abort_cmd),		\
-		nvme_admin_opcode_name(nvme_admin_set_features),	\
-		nvme_admin_opcode_name(nvme_admin_get_features),	\
-		nvme_admin_opcode_name(nvme_admin_async_event),		\
-		nvme_admin_opcode_name(nvme_admin_ns_mgmt),		\
-		nvme_admin_opcode_name(nvme_admin_activate_fw),		\
-		nvme_admin_opcode_name(nvme_admin_download_fw),		\
-		nvme_admin_opcode_name(nvme_admin_ns_attach),		\
-		nvme_admin_opcode_name(nvme_admin_keep_alive),		\
-		nvme_admin_opcode_name(nvme_admin_directive_send),	\
-		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
-		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
-		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
-		nvme_admin_opcode_name(nvme_admin_security_send),	\
-		nvme_admin_opcode_name(nvme_admin_security_recv),	\
-		nvme_admin_opcode_name(nvme_admin_sanitize_nvm))
-
-#define nvme_opcode_name(opcode)	{ opcode, #opcode }
-#define show_nvm_opcode_name(val)				\
-	__print_symbolic(val,					\
-		nvme_opcode_name(nvme_cmd_flush),		\
-		nvme_opcode_name(nvme_cmd_write),		\
-		nvme_opcode_name(nvme_cmd_read),		\
-		nvme_opcode_name(nvme_cmd_write_uncor),		\
-		nvme_opcode_name(nvme_cmd_compare),		\
-		nvme_opcode_name(nvme_cmd_write_zeroes),	\
-		nvme_opcode_name(nvme_cmd_dsm),			\
-		nvme_opcode_name(nvme_cmd_resv_register),	\
-		nvme_opcode_name(nvme_cmd_resv_report),		\
-		nvme_opcode_name(nvme_cmd_resv_acquire),	\
-		nvme_opcode_name(nvme_cmd_resv_release))
-
-#define show_opcode_name(qid, opcode)					\
-	(qid ? show_nvm_opcode_name(opcode) : show_admin_opcode_name(opcode))
-
-const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
-		u8 *cdw10);
-const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
-		u8 *cdw10);
-
-#define parse_nvme_cmd(qid, opcode, cdw10) 			\
-	(qid ?							\
-	 nvme_trace_parse_nvm_cmd(p, opcode, cdw10) : 		\
-	 nvme_trace_parse_admin_cmd(p, opcode, cdw10))
-
-const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
-#define __print_disk_name(name)				\
-	nvme_trace_disk_name(p, name)
-
-#ifndef TRACE_HEADER_MULTI_READ
-static inline void __assign_disk_name(char *name, struct gendisk *disk)
-{
-	if (disk)
-		memcpy(name, disk->disk_name, DISK_NAME_LEN);
-	else
-		memset(name, 0, DISK_NAME_LEN);
-}
-#endif
+#include "trace_common.h"
 
 TRACE_EVENT(nvme_setup_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
@@ -189,7 +117,7 @@ TRACE_EVENT(nvme_async_event,
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_FILE trace
+#define TRACE_INCLUDE_FILE trace_core
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
-- 
2.17.1

