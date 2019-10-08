Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8109EC4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 12:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B1920640
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 12:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prN+G4P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfJHMw2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:52:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34037 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbfJHMwZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 08:52:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so13483192wrp.1
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2019 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CY2v7yIbUQO+kUdb+ns8XxSwsNG79RB1PtGsa0u/5rk=;
        b=prN+G4P3hgi5YODFv5NZFDI29CilqP4ENwL0w25Ei8wzkTOtWzj89ShELBr94Puqk1
         kSpd9RM0FCxuGN+phyvgBYRQLgiPMDCkkgXPp3MTdVJ+sEQQat2Z/WPBhotYAhj2XV+U
         Dy7tTfUToI4j6R0YTkB+gZ1mEsfVrzVkz3zYSZwHvQ0BqMMAjYt9eUFcT5eYWq2F9FJQ
         GeZ3B31kJIUsg1j2gXwLjZ57L2JSDh1tsqHVF2JTro+kJBDKiQyZPHe/yrCkZBnr2FE8
         MvXOigkMDjo6MdjzWDSIuBjGbSjsUIUZDm/18AkhiImsPXWFeslFRXYEMvJV78tuwy4A
         h10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CY2v7yIbUQO+kUdb+ns8XxSwsNG79RB1PtGsa0u/5rk=;
        b=h6yHNW6WtJ4bUYeUsqxmMf6DSdHkltq9VWhDuJ3s76U0JmqS3mfchWvXgnR6iL//MU
         kP7COoSF3fTctDGcXaItxc0+2cYfzdTdl+cryFxp9kNw+hsuMseTy2SVSnJ7hgSJIsfe
         2HEzkw3Goqxg0YU8kL9Oj3QRem9YOu3V9aZXmtBuutDXrOBQRVYc4pHqywH+SxMUchMo
         GaJxRNvzeZrCeBSQH78whhs3D3wPH4BFFoCEseootO7tOefbdQQnadt6H3s6LLYcG3G8
         8KRHwGvcd9MgLhrlQbiJmqcNlckm2EcUXB3SBzJJzxG/qq1T4nWXm4oSVyFNmBJKwqlv
         flmg==
X-Gm-Message-State: APjAAAUoR4g0Dy+qZz2FZ/54POl8Ekq0wMTw54/9pSZTf7Pk9mwHgkcC
        SCAq36VmSJYJcN1BjMpAyNTq/6/i
X-Google-Smtp-Source: APXvYqz3eI5jsBEfJYtMQV+LGG1lfKQ+I990SIPoEWaJJpfqJLPSLAu6/9n1vb6yRPyl2Qf+3SGbsw==
X-Received: by 2002:adf:fb48:: with SMTP id c8mr428052wrs.247.1570539144140;
        Tue, 08 Oct 2019 05:52:24 -0700 (PDT)
Received: from localhost.corp.ad.zalando.net ([185.85.220.201])
        by smtp.gmail.com with ESMTPSA id a14sm2525879wmm.44.2019.10.08.05.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:52:23 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC v1] io_uring: add io_uring_link trace event
Date:   Tue,  8 Oct 2019 14:53:57 +0200
Message-Id: <20191008125357.25265-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To trace io_uring activity one can get an information from workqueue and
io trace events, but looks like some parts could be hard to identify.
E.g. it's not easy to figure out that one work was started after another
due to a link between them.

For that purpose introduce io_uring_link trace event, that will be fired
when a request is added to a link_list.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 fs/io_uring.c                   |  4 ++++
 include/Kbuild                  |  1 +
 include/trace/events/io_uring.h | 42 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 include/trace/events/io_uring.h

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bfbb7ab3c4e..63e4b592d69 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -71,6 +71,9 @@
 #include <linux/sizes.h>
 #include <linux/hugetlb.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/io_uring.h>
+
 #include <uapi/linux/io_uring.h>
 
 #include "internal.h"
@@ -2488,6 +2491,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 
 		s->sqe = sqe_copy;
 		memcpy(&req->submit, s, sizeof(*s));
+		trace_io_uring_link(&req->work, &prev->work);
 		list_add_tail(&req->list, &prev->link_list);
 	} else if (s->sqe->flags & IOSQE_IO_LINK) {
 		req->flags |= REQ_F_LINK;
diff --git a/include/Kbuild b/include/Kbuild
index ffba79483cc..61b66725d25 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -1028,6 +1028,7 @@ header-test-			+= trace/events/fsi_master_gpio.h
 header-test-			+= trace/events/huge_memory.h
 header-test-			+= trace/events/ib_mad.h
 header-test-			+= trace/events/ib_umad.h
+header-test-			+= trace/events/io_uring.h
 header-test-			+= trace/events/iscsi.h
 header-test-			+= trace/events/jbd2.h
 header-test-			+= trace/events/kvm.h
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
new file mode 100644
index 00000000000..56245c31a1e
--- /dev/null
+++ b/include/trace/events/io_uring.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM io_uring
+
+#if !defined(_TRACE_IO_URING_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IO_URING_H
+
+#include <linux/tracepoint.h>
+
+/**
+ * io_uring_link - called immediately before the io_uring work added into
+ * 				   link_list of the another request.
+ * @work:			pointer to linked struct work_struct
+ * @target_work:	pointer to previous struct work_struct,
+ * 					that would contain @work
+ *
+ * Allows to track linked requests in io_uring.
+ */
+TRACE_EVENT(io_uring_link,
+
+	TP_PROTO(struct work_struct *work, struct work_struct *target_work),
+
+	TP_ARGS(work, target_work),
+
+	TP_STRUCT__entry (
+		__field(  void *,	work			)
+		__field(  void *,	target_work		)
+	),
+
+	TP_fast_assign(
+		__entry->work			= work;
+		__entry->target_work	= target_work;
+	),
+
+	TP_printk("io_uring work struct %p linked after %p",
+			  __entry->work, __entry->target_work)
+);
+
+#endif /* _TRACE_IO_URING_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.21.0

