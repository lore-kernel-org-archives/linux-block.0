Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EDFC3A5A2
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 08:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C97120830
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 08:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap8pSX2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfIVIJT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 04:09:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45091 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIVIJT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 04:09:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so10638222wrm.12;
        Sun, 22 Sep 2019 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4sz3bMPtRNQeqEEXec0GVjBvdkbRYQeJBiuMJ2oejo=;
        b=Ap8pSX2pFZwrJu+JxUae9LrqgooB/VeL6ghPHBWBmMTOV7tjHQf/R0oB7irc8JudA/
         dlx9v6MvmRaenxI2ddxlbEK4Wt4yDHljolkbGAVZQlIu3m4b62aeYAfA2JnKISu6LvX3
         Ssi2fsS2QGiTpUYz9QVE8gsEOaCgjmqFD3ErR2olqavDMztNZ/8MJ3Fv5X8oteK6wl+2
         7Wlz4tk16AABmMK+jr2HWV29rgEybd07i4z99TR1GTDYeC+Vj89MTfIhUibL8b0isSRZ
         r8320wmUfqysYxbKIu8wH7DS+PZqiVpE7AkHgDlPRCWYsLv4bGU1U4/lyfO4yWhf5pKI
         GKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4sz3bMPtRNQeqEEXec0GVjBvdkbRYQeJBiuMJ2oejo=;
        b=euS6Y3xO0urPf82dvsgpvi2O8lcOdrPudPrU3c6e9xrHYeCtu4ybjvc/88/Nmgkh6p
         T37hqlmsTKZsopjkM8Pl6CZza6I6v8f4rhCzoiBG+woSfeMRZZeoISaAwHF+M3XHw2CE
         yB1IrJ7BLUWOd5S7vtugfvRkeHqrvat3EKitxYv1pug7c570f37TowMaUv4ORTWFutuq
         xa3pvZhLKHLVbyh2Qw+uSL1k2SaLjCkpvhRwsXB39glzx/5UeLWmuQ+m5RfBc6sl5BAT
         TMDGDOH+3BKQjO1441UjQ9EilVg7uJ+W00S5wPSnLVYGJX55D9xF8wL10LKuaqpmGKm5
         8iMw==
X-Gm-Message-State: APjAAAXqf+H4f4Xzky9JTwL74TvTMYg4FemoVgPGzXWzBN1z2aNMZQ6l
        hjbVbOQB5ILFUOtdcGJ4MRI=
X-Google-Smtp-Source: APXvYqz3sNreJH2M+K1VawHH1PfjiIFcBehFodSfWxtAzgXn1LerO90uDeJb+bayz9xXwsSp/2M2OQ==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr5763670wrs.151.1569139756053;
        Sun, 22 Sep 2019 01:09:16 -0700 (PDT)
Received: from localhost.localdomain ([109.126.147.119])
        by smtp.gmail.com with ESMTPSA id x5sm7726983wrt.75.2019.09.22.01.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 01:09:15 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 1/2] sched/wait: Add wait_threshold
Date:   Sun, 22 Sep 2019 11:08:50 +0300
Message-Id: <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569139018.git.asml.silence@gmail.com>
References: <cover.1569139018.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Add wait_threshold -- a custom wait_event derivative, that waits until
a value is equal to or greater than the specified threshold.

v2: rebase
1. use full condition instead of event number generator
2. add WQ_THRESHOLD_WAKE_ALWAYS constant

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/wait_threshold.h | 67 ++++++++++++++++++++++++++++++++++
 kernel/sched/Makefile          |  2 +-
 kernel/sched/wait_threshold.c  | 26 +++++++++++++
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/wait_threshold.h
 create mode 100644 kernel/sched/wait_threshold.c

diff --git a/include/linux/wait_threshold.h b/include/linux/wait_threshold.h
new file mode 100644
index 000000000000..d8b054504c26
--- /dev/null
+++ b/include/linux/wait_threshold.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_WAIT_THRESHOLD_H
+#define _LINUX_WAIT_THRESHOLD_H
+
+#include <linux/wait.h>
+
+#define WQ_THRESHOLD_WAKE_ALWAYS	(~0ui)
+
+struct wait_threshold_queue_entry {
+	struct wait_queue_entry wq_entry;
+	unsigned int threshold;
+};
+
+
+void init_wait_threshold_entry(struct wait_threshold_queue_entry *wtq_entry,
+				unsigned int threshold);
+
+static inline void wake_up_threshold(struct wait_queue_head *wq_head,
+					unsigned int val)
+{
+	void *arg = (void *)(unsigned long)val;
+
+	__wake_up(wq_head, TASK_NORMAL, 1, arg);
+}
+
+#define ___wait_threshold_event(q, thresh, condition, state,		\
+				exclusive, ret, cmd)			\
+({									\
+	__label__ __out;						\
+	struct wait_queue_head *__wq_head = &q;				\
+	struct wait_threshold_queue_entry __wtq_entry;			\
+	struct wait_queue_entry *__wq_entry = &__wtq_entry.wq_entry;	\
+	long __ret = ret; /* explicit shadow */				\
+									\
+	init_wait_threshold_entry(&__wtq_entry, thresh);		\
+	for (;;) {							\
+		long __int = prepare_to_wait_event(__wq_head,		\
+						   __wq_entry,		\
+						   state);		\
+		if (condition)						\
+			break;						\
+									\
+		if (___wait_is_interruptible(state) && __int) {		\
+			__ret = __int;					\
+			goto __out;					\
+		}							\
+									\
+		cmd;							\
+	}								\
+	finish_wait(__wq_head, __wq_entry);				\
+__out:	__ret;								\
+})
+
+#define __wait_threshold_interruptible(q, thresh, condition)		\
+	___wait_threshold_event(q, thresh, condition, TASK_INTERRUPTIBLE, 0, 0,\
+			  schedule())
+
+#define wait_threshold_interruptible(q, threshold, condition)	\
+({								\
+	int __ret = 0;						\
+	might_sleep();						\
+	if (!(condition))					\
+		__ret = __wait_threshold_interruptible(q,	\
+			threshold, condition);			\
+	__ret;							\
+})
+#endif /* _LINUX_WAIT_THRESHOLD_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5662b5..bb895a3184f9 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -18,7 +18,7 @@ endif
 
 obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
-obj-y += wait.o wait_bit.o swait.o completion.o
+obj-y += wait.o wait_bit.o wait_threshold.o swait.o completion.o
 
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
diff --git a/kernel/sched/wait_threshold.c b/kernel/sched/wait_threshold.c
new file mode 100644
index 000000000000..80a027c02ff3
--- /dev/null
+++ b/kernel/sched/wait_threshold.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "sched.h"
+#include <linux/wait_threshold.h>
+
+static int wake_threshold_function(struct wait_queue_entry *wq_entry,
+				   unsigned int mode, int sync, void *arg)
+{
+	unsigned int val = (unsigned int)(unsigned long)arg;
+	struct wait_threshold_queue_entry *wtq_entry =
+		container_of(wq_entry, struct wait_threshold_queue_entry,
+			wq_entry);
+
+	if (val < wtq_entry->threshold)
+		return 0;
+
+	return default_wake_function(wq_entry, mode, sync, arg);
+}
+
+void init_wait_threshold_entry(struct wait_threshold_queue_entry *wtq_entry,
+			       unsigned int threshold)
+{
+	init_wait_entry(&wtq_entry->wq_entry, 0);
+	wtq_entry->wq_entry.func = wake_threshold_function;
+	wtq_entry->threshold = threshold;
+}
+EXPORT_SYMBOL(init_wait_threshold_entry);
-- 
2.23.0

