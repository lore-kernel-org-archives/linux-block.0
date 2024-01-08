Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98A54F8E
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W6PM+NLH"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36095e0601bso162325ab.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704740478; x=1705345278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ka34RrDXFM+UadkNQeXrqVAJPO5xGXT/+QQlf2JX5E=;
        b=W6PM+NLH6QQV8iOWaJAKMBIUoJs7VnjB/IW4fQ9dDUlI90WnIKr9jMftGFW7aytrkL
         b6GjpcNORCu+T+GcnpRhUo4alclopgQIjGRPW9i0bXnHJ6MSaoC8fzwIq5zkBWUPwrji
         /ni0CYWE1DNiRlAkuLCQV2yEqJrbvIdgAM+U507m8D6lCyGuMQan/tcYG8NRRdtCxX+q
         Iuv9mBDVfQPW3A8c0U+/3QJhXji/+POhlX1qfK1jWmd/XfEDUQX49Q8N2EQYNM2rzdr7
         2ynYVGC8VsSCeoXvZYC4yQJtY8hwUUe5sJI4aYiOU00NZIZ6xUqscHbdDLn5hFIvzmcM
         S7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740478; x=1705345278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ka34RrDXFM+UadkNQeXrqVAJPO5xGXT/+QQlf2JX5E=;
        b=tBEpJfCPDS2jdfM88UgTkyxdwp1EuglkQzwlkVxMSmOc9YY+ncz4HfLNGoaOtT2Mcv
         TSPaZnScLQlJH5Gpy0umRi+3cJPhEiyyGdQr7gFwsZT7bakDsjUis+NAqXY1u26FxOuK
         jjUtgJDYL8Qnc5keqh544eHTaBgOe8+ngo2p0aRunMdWpF2+yRrmU/a7kwf3lVMbu6Ec
         x+inSpGY7lLayaaLtoglSnvYG9psFxJu929DZe96T09JUuH7+QPGf9CSFiXYUIMwWE9K
         70l/Sjnx0g7pSY0wPLaL2Xe8TXH7B0dzMKkJpbqo72gBKBIXV09MXvRooyK64cxsEbhV
         B1cg==
X-Gm-Message-State: AOJu0YxyqltU1MXXgtfv9H0nxM0XfjKD1fZyqZKno2Pmk+jEA9qDm0X/
	JwbJ0y99RXCyWBATxutqlyYtLs5SwlInwwra+ND+xjJqjbjccQ==
X-Google-Smtp-Source: AGHT+IGcZ3VAtxhh/n5Acp85+pXBeQlUUBws+ysM5uAiywNhis5hfrRk0NnsmP0BzCtvIMLqE49HjA==
X-Received: by 2002:a05:6602:2bc1:b0:7bb:e685:62e with SMTP id s1-20020a0566022bc100b007bbe685062emr6982717iov.2.1704740477758;
        Mon, 08 Jan 2024 11:01:17 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z12-20020a029f0c000000b0046dcb39c1d3sm128206jal.28.2024.01.08.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:01:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: move __get_task_ioprio() into header file
Date: Mon,  8 Jan 2024 11:59:55 -0700
Message-ID: <20240108190113.1264200-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108190113.1264200-1-axboe@kernel.dk>
References: <20240108190113.1264200-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We call this once per IO, which can be millions of times per second.
Since nobody really uses io priorities, or at least it isn't very
common, this is all wasted time and can amount to as much as 3% of
the total kernel time.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/ioprio.c         | 26 --------------------------
 include/linux/ioprio.h | 25 ++++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index b5a942519a79..73301a261429 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -139,32 +139,6 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 	return ret;
 }
 
-/*
- * If the task has set an I/O priority, use that. Otherwise, return
- * the default I/O priority.
- *
- * Expected to be called for current task or with task_lock() held to keep
- * io_context stable.
- */
-int __get_task_ioprio(struct task_struct *p)
-{
-	struct io_context *ioc = p->io_context;
-	int prio;
-
-	if (p != current)
-		lockdep_assert_held(&p->alloc_lock);
-	if (ioc)
-		prio = ioc->ioprio;
-	else
-		prio = IOPRIO_DEFAULT;
-
-	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
-		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
-					 task_nice_ioprio(p));
-	return prio;
-}
-EXPORT_SYMBOL_GPL(__get_task_ioprio);
-
 static int get_task_ioprio(struct task_struct *p)
 {
 	int ret;
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 7578d4f6a969..d6a9b5b7ed16 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -47,7 +47,30 @@ static inline int task_nice_ioclass(struct task_struct *task)
 }
 
 #ifdef CONFIG_BLOCK
-int __get_task_ioprio(struct task_struct *p);
+/*
+ * If the task has set an I/O priority, use that. Otherwise, return
+ * the default I/O priority.
+ *
+ * Expected to be called for current task or with task_lock() held to keep
+ * io_context stable.
+ */
+static inline int __get_task_ioprio(struct task_struct *p)
+{
+	struct io_context *ioc = p->io_context;
+	int prio;
+
+	if (p != current)
+		lockdep_assert_held(&p->alloc_lock);
+	if (ioc)
+		prio = ioc->ioprio;
+	else
+		prio = IOPRIO_DEFAULT;
+
+	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
+		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
+					 task_nice_ioprio(p));
+	return prio;
+}
 #else
 static inline int __get_task_ioprio(struct task_struct *p)
 {
-- 
2.43.0

