Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36313C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E9F204FD
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 08:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5YwT2e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeLQIGJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:06:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33090 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeLQIGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 03:06:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so5760851plo.0;
        Mon, 17 Dec 2018 00:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=jShTnzlS1emlGTeRbAUJyEsWFtZYA869xm5bWNEG/zI=;
        b=M5YwT2e8ZoeIkzfR6MWaBkjzoDSvPszCuFCEVUkrKzEOpSVWP2Ur9g1E3BAH55d9gq
         VWv2Hg1Lx+hLDUspQy0MRIUI6AOUby5g40GSgzh5gTXpanwqwmnANSmUYhVCv7GMTZ7v
         AX7cZPLFrKCdA5p4zk5/ykmAMxsayvfslQa8mZmJe7yZt8vTJpiFbaTWEVQueee+9uMc
         K6caZk9hEFYPvrc++LAHUGlbz8fpnVf88aTCcgUWzhYtKXHWk0N1Lowt92tUTp5zH3Ax
         pPvdL6vMeXAW7N8lG78ATqLsmYEpGQ9+4lt2zLLAQrUmm/eudNtC4vcd2ZByJxoml+kr
         Spxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=jShTnzlS1emlGTeRbAUJyEsWFtZYA869xm5bWNEG/zI=;
        b=cz+GSF4FHP2RXEGbe0OKAJ8iF8m9gdzGJUZIHgFCv/TAqfA5Z1YkMOfUb8n5A5wbz6
         B2nLipKdxYKGRG7hVn2FuZOPcyQ0u7N1NXoJIgnVMCWT9Jp3yWB+A/69mmBUksHPZ5yF
         AXUWgGJC8iGh7NQMRJv7mccOCif931c6JumjEywB76KXp6R4EEse0Cye5qbbI30Vvlsq
         DoMmjhTa6sgpYiKBTfFmvKokWzCu8rgsM9vUfGPrDROc9K3ehyYTAATz/Xu4+6rz3OfG
         snItGCbnffs80XpbKV+z+Iw6b5/PQvvzRfu01lCBEOOdfueL2IUVqjroIJMPxWT2U/hZ
         AXgQ==
X-Gm-Message-State: AA+aEWY/EGXDkH1ZTgJyS/Fbg6ighXjh9dlNAOgOEgoqqWnorAp7LuYF
        qXYvILhtoQYO5/fldgouwVBOyt3qpgk=
X-Google-Smtp-Source: AFSGD/U//XXVKtrfk4t7VUEu4sv9F6Cg6UQy3rQmXNjzkGTAXgCZKHPosyVcUiCqBV6hf4YD0mjl3w==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr11516107pls.71.1545033968088;
        Mon, 17 Dec 2018 00:06:08 -0800 (PST)
Received: from localhost.localdomain ([2601:602:9602:6598:9540:1d4c:35c2:b8e8])
        by smtp.gmail.com with ESMTPSA id q1sm18517115pgs.14.2018.12.17.00.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 00:06:07 -0800 (PST)
From:   yupeng <yupeng0921@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH v3 2/2] trace nvme submit queue status
Date:   Mon, 17 Dec 2018 00:06:05 -0800
Message-Id: <20181217080605.16867-2-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217080605.16867-1-yupeng0921@gmail.com>
References: <20181217080605.16867-1-yupeng0921@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

export nvme disk name, queue id, sq_head, sq_tail to trace event
usage example:
go to the event directory:
cd /sys/kernel/debug/tracing/events/nvme/nvme_sq
filter by disk name:
echo 'disk=="nvme1n1"' > filter
enable the event:
echo 1 > enable
check results from trace_pipe:
cat /sys/kernel/debug/tracing/trace_pipe
In practice, this patch help me debug hardware related
performant issue.

Signed-off-by: yupeng <yupeng0921@gmail.com>
---
 drivers/nvme/host/pci.c       |  7 +++++
 drivers/nvme/host/trace_pci.h | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 drivers/nvme/host/trace_pci.h

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..974cb05b3592 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -32,6 +32,9 @@
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace_pci.h"
+
 #include "nvme.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -899,6 +902,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	trace_nvme_sq(req->rq_disk,
+		nvmeq->qid,
+		le16_to_cpu(cqe->sq_head),
+		nvmeq->sq_tail);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
diff --git a/drivers/nvme/host/trace_pci.h b/drivers/nvme/host/trace_pci.h
new file mode 100644
index 000000000000..70fa853397f6
--- /dev/null
+++ b/drivers/nvme/host/trace_pci.h
@@ -0,0 +1,57 @@
+/*
+ * NVM Express device driver tracepoints
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nvme
+
+#if !defined(_TRACE_NVME_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NVME_H
+
+#include <linux/nvme.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "nvme.h"
+
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
+#define __print_disk_name(name)				\
+	nvme_trace_disk_name(p, name)
+
+TRACE_EVENT(nvme_sq,
+	    TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
+	    TP_ARGS(rq_disk, qid, sq_head, sq_tail),
+	    TP_STRUCT__entry(
+		 __array(char, disk, DISK_NAME_LEN)
+		 __field(int, qid)
+		 __field(int, sq_head)
+		 __field(int, sq_tail)),
+	    TP_fast_assign(
+		__entry->qid = qid;
+		__entry->sq_head = sq_head;
+		__entry->sq_tail = sq_tail;
+		__assign_disk_name(__entry->disk, rq_disk);
+	    ),
+	    TP_printk("nvme: %s qid=%d head=%d tail=%d",
+		      __print_disk_name(__entry->disk),
+		      __entry->qid, __entry->sq_head, __entry->sq_tail)
+);
+
+#endif /* _TRACE_NVME_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace_pci
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

