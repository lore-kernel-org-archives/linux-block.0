Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019BEC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 01:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41FD206C2
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 01:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5nBKrQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeLPBsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Dec 2018 20:48:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37053 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLPBsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Dec 2018 20:48:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so2935112pgb.4;
        Sat, 15 Dec 2018 17:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Lwk3FR8oIcmlTWkeJWf0gLeJDotRefKWMnRmeWivKG4=;
        b=e5nBKrQDyWVXcYx1NKW6R/TmihFrNkcS1JNVwB2Xrwlda800M4qVgvgDJXmSvelVku
         JKcyFmJeFWEcaSSpE8iHxSQ/MUFCuzjFmLry8ZvTW7WAwXRbWVdG6vMLuWJxudFyzRUp
         3dMI3RqcvJxEPjVctYRgdaXB9jOWTYUewov50XHU9N0lOpNJ7IAVamMKb/nxt+hoBY7A
         s4Y6lhn1skkZkYvA1kc4Tx9P9Uqvpqk+JjTP4CaVKwX9SFJUDhOYnXvWTm/4fbAUqW1M
         umlfmHgnluqJRhwtwS2XLSXBryfb94YXb3XHSyKiwW9b3HrGu+yVacWMnbQ/G0v/+IDW
         J2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Lwk3FR8oIcmlTWkeJWf0gLeJDotRefKWMnRmeWivKG4=;
        b=cyiD7acszCc37hmvO0Fy5Fqsn0Qub6vhKVHJsiP3kgc1614RZaYi2EMypEEEQN1TSU
         1OMuhTs08KLJ0bY6kNECWQt/x2yhE52vu43B12kveuXvjqu73DPinS+Ux8wrhld1NG2W
         zqG8Glj3UtI25Dp+OebbjPaqAHxPS98WrJBKj2IhpSEDoqS0u8Vx/hdu2IhWUXbJykv4
         KESjpeYoqTxlXPjnNsdSKMq+ab/yubRR2C+kyTAM9GtDyi5rwJiTAh4g/BoigvSMNU6G
         efnoc72N3tVL8iwdSEwoUh5JrjqXT44LVdHuZAzfs2of+meJ6WI8ZfRCjZlpe78TA4FA
         l9WA==
X-Gm-Message-State: AA+aEWYU37ueI2TbZKC8RQmxAfJFGe/WbtY+NwlsLbJI9IfAWZwpewGc
        ZSlx1hjVB8ZN7jYDMGr8SXm2qJxez1U=
X-Google-Smtp-Source: AFSGD/UDxbPfREPnyfUHOGYiP5SIxZSlQJ+M/e39tMoprJpV2I8HZg0TCp1Di9qivRpIWA5TZXKR8Q==
X-Received: by 2002:a62:8949:: with SMTP id v70mr8031341pfd.85.1544924931656;
        Sat, 15 Dec 2018 17:48:51 -0800 (PST)
Received: from localhost.localdomain ([2601:602:9602:6598:9540:1d4c:35c2:b8e8])
        by smtp.gmail.com with ESMTPSA id z127sm14394990pfb.80.2018.12.15.17.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 17:48:51 -0800 (PST)
From:   yupeng <yupeng0921@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH v2 2/2] trace nvme submit queue status
Date:   Sat, 15 Dec 2018 17:48:49 -0800
Message-Id: <20181216014849.8584-2-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181216014849.8584-1-yupeng0921@gmail.com>
References: <20181216014849.8584-1-yupeng0921@gmail.com>
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
 drivers/nvme/host/trace_pci.h | 49 +++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
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
index 000000000000..a48bdd4412e4
--- /dev/null
+++ b/drivers/nvme/host/trace_pci.h
@@ -0,0 +1,49 @@
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
+#include "trace_common.h"
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

