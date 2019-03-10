Return-Path: <SRS0=4SCO=RN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C18C43381
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261FC206DF
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QippPLGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfCJSMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:12:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33623 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfCJSM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Mar 2019 14:12:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id i8so2668724wrm.0
        for <linux-block@vger.kernel.org>; Sun, 10 Mar 2019 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rzi6we5rwF3Y64l19PsLoFd2B5RuM9WGk0GjrjaWejk=;
        b=QippPLGlc/JE4mt1hPQnApMT6VQ2+P2ihx/NcxK9/f1FpFPKP6s5TLVUVYacaKqkkC
         6ebcAHsbiy82QhweTPwXTB/zkESgxYcXWN553XYhhc6OOAQzfid12lBW6S3VvuwB7C0W
         ZFRop+pnOxeU3G3u7OIoMC4COenmsodLBR0srU32+t6oZ+GBBVIVoFE1phTqrZhzjKPR
         qVkIo2nkL6qfuXTYFUxwUZX85iDscB7A6ivF062zY3zDhCjRxJOs/W6teMBfpT/msHii
         cSnGfOX4CNw45oQ5vfZd+0sD2U5CP8dRhrTgLGrw+dqn1pe8U/Jor5QQeGdGHKH8s4L+
         0g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rzi6we5rwF3Y64l19PsLoFd2B5RuM9WGk0GjrjaWejk=;
        b=Ur+4zoM5AyBbeYLhzw/wTIwabiWWSHmMWE9P0+rwbMXqD5lwAaA98PAH0nQxXGe+i8
         TeflkC7hHJsz5NM5t45WT25yyM3BgjdQKpAXOmm3Lj8zl/8Oyi8MezkxHWwOEerx6Uq7
         Ta5HIhvAmKuuUmJ2ZXhAOsJ0Ug+VcXUGf39dgCs2kVtB0nTuaoIxA/fj3ImgAaxMkzgf
         gF4cstDY+TwQf+kx/i2Ibj0OF/qu5ED6I9PW+3vP0E12nJc2ywyQo5XDgFG5ajEY1sqz
         CNCoNFDT3BQ2kNAG6jTIfpddUrc/7/wLsy77zeLqJnmmqHq69MKMaCfGpPAjoY4tQ0SA
         EQ0A==
X-Gm-Message-State: APjAAAUb01HEwOzqkXIJiCUnElI8o+982FZw7QybgNe3gLPtzcBxN416
        u8BpH+p3i1vIRWpX254+vH7EDg==
X-Google-Smtp-Source: APXvYqzt69rIVwa0wx69Dl5HZ6knOrjTSUsruLoYIkTns+WZm68RyXA+tLG2Kx/FWWuRFU6LvPKAVQ==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr18411906wrn.184.1552241544158;
        Sun, 10 Mar 2019 11:12:24 -0700 (PDT)
Received: from localhost.localdomain (146-241-67-113.dyn.eolo.it. [146.241.67.113])
        by smtp.gmail.com with ESMTPSA id d206sm24906368wmc.11.2019.03.10.11.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:12:23 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 7/9] block, bfq: print SHARED instead of pid for shared queues in logs
Date:   Sun, 10 Mar 2019 19:11:35 +0100
Message-Id: <20190310181137.2604-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310181137.2604-1-paolo.valente@linaro.org>
References: <20190310181137.2604-1-paolo.valente@linaro.org>
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
index 829730b96fb2..6410cc9a064d 100644
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
+static void bfq_pid_to_str(int pid, char *str, int len)
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
+				##args)		\
+} while (0)
 #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
 
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
-- 
2.20.1

