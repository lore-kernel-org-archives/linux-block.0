Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1410C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D172147C
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zIwVUnUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfCLJAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:00:18 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40711 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfCLJAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 05:00:18 -0400
Received: by mail-wr1-f54.google.com with SMTP id t5so565407wri.7
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btVK/jtdAfu6AHuJ6S+yT+D8LfZ0KK3FDm6jIOjAw+w=;
        b=zIwVUnUFW4N+3v68oh+lo2cLxoG34ZSW/qTtQiFK0iOgbGazb2FoAehAsJ5Oxg1NKE
         mldTdbxnmF526mUDFp5wcKTbFqtvE+RTglmjvlT5o7ZETSKIfA4/R9QmemlV8NU2VuLp
         atEqWEttirD5F0hB1KSXrFQYwVPqG6z0VsM0cw1Pbwdn2FF6SHEnxZfMcrOHV9OfCTiL
         WryEopGoTlXJSpWJ13hdT0Q+m/m1PFJWjcg9na/gzbFlwGsMCRjDr7NmRzND26729v/k
         FzNRZh5yxaKvjRHYlBedciyESQkGtTEOKFKIE44BAXriBKmhrLdswggsFZr+5PdZRt2O
         4Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btVK/jtdAfu6AHuJ6S+yT+D8LfZ0KK3FDm6jIOjAw+w=;
        b=Ag3bS1SKARZR41tqt8LIK7ya9OBtu3ZVxQBi58XrSg+7zwPevKBLUKxmaiUevLoDmI
         jcAhDgb/rfumuhtPU7a7hWrQ+g2fp8ao58ou0KRdosH9b92V3mCcMLiIfKbspeqOuIk+
         5xwkm2Je5QWAibEzaIOyC9MWfYPCp8uX/QrpC9lIEjTnEfCR9V+63wjXHf4MKZQMxHf7
         4eBixvy/eYqS6oY57n7+fS3TSAKrxaOPguIj6Jg9aENW5Xqvw5RtBqo5M6DLziW2UoSD
         QDP0OPaWAWWojQDciGbgiNMJX4C+0JNG4JJJaU6oVbsZvucAke8AcFbMZ8kXIbSp2Xa+
         hFeQ==
X-Gm-Message-State: APjAAAW2qxDEIe7oS91BnYxojH/9opObcruYspganpaE1+VFKhp0+0gB
        wBoMiPliG7TGJDVPdb6gKj0uOw==
X-Google-Smtp-Source: APXvYqy/T7GhDxhFR5W7lNSSa2QTDLlUBX2f92hCb+5Oy12jsPbbCSh6l5NEKHrv6ZG8o4E5aiOOug==
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr22255913wrw.317.1552381215773;
        Tue, 12 Mar 2019 02:00:15 -0700 (PDT)
Received: from localhost.localdomain ([84.33.65.66])
        by smtp.gmail.com with ESMTPSA id y20sm3953043wmi.34.2019.03.12.02.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:00:15 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, holger@applied-asynchrony.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 7/9] block, bfq: print SHARED instead of pid for shared queues in logs
Date:   Tue, 12 Mar 2019 09:59:33 +0100
Message-Id: <20190312085935.11340-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312085935.11340-1-paolo.valente@linaro.org>
References: <20190312085935.11340-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Francesco Pollicino <fra.fra.800@gmail.com>

The function "bfq_log_bfqq" prints the pid of the process
associated with the queue passed as input.

Unfortunately, if the queue is shared, then more than one process
is associated with the queue. The pid that gets printed in this
case is the pid of one of the associated processes.
Which process gets printed depends on the exact sequence of merge
events the queue underwent. So printing such a pid is rather
useless and above all is often rather confusing because it
reports a random pid between those of the associated processes.

This commit addresses this issue by printing SHARED instead of a pid
if the queue is shared.

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Francesco Pollicino <fra.fra.800@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 ++++++++++
 block/bfq-iosched.h | 23 +++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 500b04df9efa..7d95d9c01036 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2590,6 +2590,16 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	 *   assignment causes no harm).
 	 */
 	new_bfqq->bic = NULL;
+	/*
+	 * If the queue is shared, the pid is the pid of one of the associated
+	 * processes. Which pid depends on the exact sequence of merge events
+	 * the queue underwent. So printing such a pid is useless and confusing
+	 * because it reports a random pid between those of the associated
+	 * processes.
+	 * We mark such a queue with a pid -1, and then print SHARED instead of
+	 * a pid in logging messages.
+	 */
+	new_bfqq->pid = -1;
 	bfqq->bic = NULL;
 	/* release process reference to bfqq */
 	bfq_put_queue(bfqq);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 829730b96fb2..67e63c276c7a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -32,6 +32,8 @@
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
+#define MAX_PID_STR_LENGTH 12
+
 /*
  * Soft real-time applications are extremely more latency sensitive
  * than interactive ones. Over-raise the weight of the former to
@@ -1016,13 +1018,23 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 /* --------------- end of interface of B-WF2Q+ ---------------- */
 
 /* Logging facilities. */
+static inline void bfq_pid_to_str(int pid, char *str, int len)
+{
+	if (pid != -1)
+		snprintf(str, len, "%d", pid);
+	else
+		snprintf(str, len, "SHARED-");
+}
+
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
+	char pid_str[MAX_PID_STR_LENGTH];	\
+	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
 	blk_add_cgroup_trace_msg((bfqd)->queue,				\
 			bfqg_to_blkg(bfqq_group(bfqq))->blkcg,		\
-			"bfq%d%c " fmt, (bfqq)->pid,			\
+			"bfq%s%c " fmt, pid_str,			\
 			bfq_bfqq_sync((bfqq)) ? 'S' : 'A', ##args);	\
 } while (0)
 
@@ -1033,10 +1045,13 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
-#define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	\
-	blk_add_trace_msg((bfqd)->queue, "bfq%d%c " fmt, (bfqq)->pid,	\
+#define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
+	char pid_str[MAX_PID_STR_LENGTH];	\
+	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
+	blk_add_trace_msg((bfqd)->queue, "bfq%s%c " fmt, pid_str,	\
 			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
-				##args)
+				##args);	\
+} while (0)
 #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
 
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
-- 
2.20.1

