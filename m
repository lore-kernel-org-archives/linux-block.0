Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E85C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E7420840
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1E4T6UH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfCGQ0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:26:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42463 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfCGQ0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 11:26:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so18146199wrg.9
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xlQD5/IUhsVAwG7WZ+Uc2ij3RLscMuoaMIxAkg1O+iU=;
        b=Q1E4T6UHR4NyVlm1gbaXS3LV4WXKIF/F0NLzALIOjQ/JI8bU/ftJotOWy8XUY8UJ0j
         d1e7gj4cZHb4l21rHhfjQFcTvhG+OuqT9BIhi6ORBNZ/PP3NLmZYw1FXyv5HJk4Sbyrl
         Hjsa4b56ODAD1QEAuleKB/+IOgGMLiEFEhVhLeRy68WCrq5MsTbojThwSnDC++kO7HI6
         YBQ6TAyLL+O4BHgIDct2NxkS96no/ITQ31rBbcoPwKjomcMgLlWY4mDnENBoBcRiFPca
         8a3tTQ4omdGB+GToHNIlWVfuyaMS9bmCYT/V+tS6eKNPwYlvXR5+PY3ypSoEyCzul+ui
         WQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xlQD5/IUhsVAwG7WZ+Uc2ij3RLscMuoaMIxAkg1O+iU=;
        b=l64ROLtS0hqA0G4ek1RJ5LHmlKrcyokY7oH/qQAWPmkMqQHb4Ze3SkV+15yFm5Qp3k
         7MXj5kPhAPAyUC0/ZJWu0Lqh8wfa1mUSHXnzIQAeqBBdfPAwLSqxlbU6aDxotR4klBhd
         /kFKNq6UNasiV7eDR7sgECmJLzz5SfXZpvfMRCUEl7SO43I3bqq1aCXMokL0cpwAdi95
         4pRc66/kSIGiZF5BZJ5OYAzTd2mPVc9Bed887Xlr2byOMFgdnzI6aLmjdrki3iEFH0rX
         ymnZx2xM9q3fN+O+vczEGNCH9hFlBvdL+y/e9lSu1uU/SY4Hm8J/VJSTgRWTWZ66b133
         K7bA==
X-Gm-Message-State: APjAAAUTqPGUj75zu060woTsntXrgiUZV0nK2B6pMLF02782YqONTUFz
        HP4Y+x9Ro1abxbHeDpjyseepXg==
X-Google-Smtp-Source: APXvYqzSct+LDFTHq5O4JBJRM6R7GprYMkIgXLU6AWuLJihhVpa5nIAnVoOnDALeDoYGeR9ZDKQ48w==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr7028459wrt.8.1551975980402;
        Thu, 07 Mar 2019 08:26:20 -0800 (PST)
Received: from localhost.localdomain (146-241-117-61.dyn.eolo.it. [146.241.117.61])
        by smtp.gmail.com with ESMTPSA id o127sm5801797wmo.20.2019.03.07.08.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:26:19 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 7/8] block, bfq: print SHARED instead of pid for shared queues in logs
Date:   Thu,  7 Mar 2019 17:25:53 +0100
Message-Id: <20190307162554.77205-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307162554.77205-1-paolo.valente@linaro.org>
References: <20190307162554.77205-1-paolo.valente@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Francesco Pollicino <fra.fra.800@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 ++++++++++
 block/bfq-iosched.h | 18 ++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

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
index 829730b96fb2..21ddb19cc322 100644
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
+void bfq_pid_to_str(int pid, char *str, int len)
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
 
@@ -1034,7 +1046,9 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	\
-	blk_add_trace_msg((bfqd)->queue, "bfq%d%c " fmt, (bfqq)->pid,	\
+	char pid_str[MAX_PID_STR_LENGTH];	\
+	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
+	blk_add_trace_msg((bfqd)->queue, "bfq%s%c " fmt, pid_str,	\
 			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
 				##args)
 #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
-- 
2.20.1

