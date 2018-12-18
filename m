Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF82C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD078217D8
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o38O87s2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeLREvm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:51:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38040 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeLREvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 23:51:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so7236543plb.5;
        Mon, 17 Dec 2018 20:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=LNjZOu9ti/CUDcrkv4geNqby8F0/i8MG9p2fY1WFuZ4=;
        b=o38O87s2nTdZWz0DcU/hO0OYs5kgvygwn/D3tK7NDJy1e2vebQ14afy6tSY9wkXVxu
         OUb9Kh+lrVr9pBw8TRgXBoPOdLeXMXa0DPtRFcYHKilks1wWPA5XGQAjNAEQPrXjMFhL
         g/ZtZ4O4tLg28gQkrRxtLJqLVlA3+hItmqovvq3uGzCtbLwI9lVBm/pm2iCM3nDFvw4C
         cbnGOPZUcgWX5ot0ulalNmHb+ZwyOAlAwtqVcFibpcJBno+OUIYwzVkEEvyRhbKlTiVv
         adEdYEKyHWMu9FvyKIWFFMOSKu4dZoI48ul385uf/DBbrQBKuI/8S5ukJelkz9A8VQ8N
         A1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=LNjZOu9ti/CUDcrkv4geNqby8F0/i8MG9p2fY1WFuZ4=;
        b=t10W8anrkBUNI5wmHYU2XoJ3nopvb0JpMWv/jLixURHYhy8dBMqG9XZDTzQ2YeoXIP
         HGPLK0Ok69S6GTd1YhsBnmP6uHAx4rY5fALVClP2ifJMgyjWzxzMl1sd30KfbVpQ5y5T
         v1DikpmbKC3Fl4Vu+ZsMse/KZZb8BSlLZMxvPrbEtS/A1yWP1kbTchfRXAHrDqcgEVlP
         SO65fcdWpru49PYYGLS70gwzJZfTwK2CZkOqPi6JxBNPYo+ryzNPgD4b7Zlg/l4w9GcE
         SNuudeRmqJaKiIO7C2g5MueVWl3VpfFG12xOSX1K+JFpAHgYmkqaOGjfysd1+D5toO9p
         Adjg==
X-Gm-Message-State: AA+aEWaz/h/TeCXLLFaW0FnIVi656heYQhJMO/Hg0a3NNxUbv7qKH5QM
        J0tbEXR9KYqD98vUgBUa8vzRHyTs6N4=
X-Google-Smtp-Source: AFSGD/VXyvdab3SEHK9Yz4r21Xx/jFw8mFcOLerZSE+Ov8W/cXKEG3624w23vEUpKR79S7eZHJHeeA==
X-Received: by 2002:a17:902:e085:: with SMTP id cb5mr14991076plb.24.1545108701367;
        Mon, 17 Dec 2018 20:51:41 -0800 (PST)
Received: from localhost.localdomain ([2601:602:9602:6598:1820:defd:529e:3b95])
        by smtp.gmail.com with ESMTPSA id e9sm18164152pff.5.2018.12.17.20.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 20:51:40 -0800 (PST)
From:   yupeng <yupeng0921@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me, jthumshirn@suse.de
Subject: [PATCH v4 2/2] trace nvme submit queue status
Date:   Mon, 17 Dec 2018 20:51:38 -0800
Message-Id: <20181218045138.4282-2-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218045138.4282-1-yupeng0921@gmail.com>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
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
 drivers/nvme/host/pci.c   |  5 +++++
 drivers/nvme/host/trace.c |  2 ++
 drivers/nvme/host/trace.h | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..52df2f7fef37 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -32,6 +32,7 @@
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
+#include "trace.h"
 #include "nvme.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -899,6 +900,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	trace_nvme_sq(req->rq_disk,
+		nvmeq->qid,
+		le16_to_cpu(cqe->sq_head),
+		nvmeq->sq_tail);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 8ca7079ed2bc..7bfaace23e1e 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -142,3 +142,5 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
+
+EXPORT_TRACEPOINT_SYMBOL(nvme_sq);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 196d5bd56718..3606cd7000f4 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -184,6 +184,27 @@ TRACE_EVENT(nvme_async_event,
 
 #undef aer_name
 
+TRACE_EVENT(nvme_sq,
+	TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
+	TP_ARGS(rq_disk, qid, sq_head, sq_tail),
+	TP_STRUCT__entry(
+		__array(char, disk, DISK_NAME_LEN)
+		__field(int, qid)
+		__field(int, sq_head)
+		__field(int, sq_tail)
+	),
+	TP_fast_assign(
+		__assign_disk_name(__entry->disk, rq_disk);
+		__entry->qid = qid;
+		__entry->sq_head = sq_head;
+		__entry->sq_tail = sq_tail;
+	),
+	TP_printk("nvme: %s qid=%d head=%d tail=%d",
+		__print_disk_name(__entry->disk),
+		__entry->qid, __entry->sq_head, __entry->sq_tail
+	)
+);
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.1

