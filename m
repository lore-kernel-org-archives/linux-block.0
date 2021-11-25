Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47392C4167D
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 13:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355125AbhKYNmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:42:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41388 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355187AbhKYNkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:02 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48E9B1FD3E;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637847409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tp7/8R1LmG938qy5axq4MAM3rTPHcg6t4envA+5B7xo=;
        b=3T7Onr75W/3Pb5XE1BtgINaZS2yM2qRJCNtA9Xw0IyP8h7EaDNW348AQ9R6/XHDhCVMH0E
        d09SUKc0aj5K2zlTnUGX9z+o5Wojf+u44dN7YAaLIrneh2JJYiHJ2DMj0EzMJIH6sXD0og
        gy9NBCD9gLjLtAvCpomGY+JWruZdYWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637847409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tp7/8R1LmG938qy5axq4MAM3rTPHcg6t4envA+5B7xo=;
        b=vJ1ZZt7i0Tyvjtjdpr6ZhcXxxEs3NpBuR8Dvo+CoqZSUO5e1Tg8Z4+0rbrJ8YfJABMHAs2
        6fKXJOiWRXHChMBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3D59BA3B92;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 041EE1F2CE6; Thu, 25 Nov 2021 14:36:46 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 6/8] bfq: Provide helper to generate bfqq name
Date:   Thu, 25 Nov 2021 14:36:39 +0100
Message-Id: <20211125133645.27483-6-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125133131.14018-1-jack@suse.cz>
References: <20211125133131.14018-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; h=from:subject; bh=lIW8uaLgOKwWPQwZ8mubQz8UhMz485reSQkalNeN/dQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhn5FnyHX8wjbtONKgxP8uQ+RM1kSJK6/bTo5GIH08 iqxLYvSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZ+RZwAKCRCcnaoHP2RA2cjACA C/96X+C8pdJZSPVH+wCrW6B4Elu6Uv7Refvr508sMEDjN7CyXhexjTq1UHG8CDGEHb7y75ubI0KviP mjrqLGHyamP26Yxt0vV5Oj4p+YKTDc2xiUWiWgzbLxSK6D5zYI8DGZveDs98bdqGKSeGm3iw/FelKa F+0IfrOl/e7Ca8nxm7UEhlh6DYuxocmYrZxVQBUvyQGlWyPugTCqSKcR5y1Ys35NkYLdqFHMjSrkbZ LbvA/8RGieh8Vjk4Tso3Vd72FC+0bRXRLX4qgnQA9ankX4nQ6XhzJDC32xGj2eK+mzKLSHfw3LX3xI I38Q6vt9OAzC63PKMKKciVq5hP5agY
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of having helper formating bfqq pid, provide a helper to
generate full bfqq name as used in the traces. It saves some code
duplication and will save more in the coming tracepoints.

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index bb8180c52a31..07288b9da389 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -25,7 +25,7 @@
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
-#define MAX_PID_STR_LENGTH 12
+#define MAX_BFQQ_NAME_LENGTH 16
 
 /*
  * Soft real-time applications are extremely more latency sensitive
@@ -1083,26 +1083,27 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 /* --------------- end of interface of B-WF2Q+ ---------------- */
 
 /* Logging facilities. */
-static inline void bfq_pid_to_str(int pid, char *str, int len)
+static inline void bfq_bfqq_name(struct bfq_queue *bfqq, char *str, int len)
 {
-	if (pid != -1)
-		snprintf(str, len, "%d", pid);
+	char type = bfq_bfqq_sync(bfqq) ? 'S' : 'A';
+
+	if (bfqq->pid != -1)
+		snprintf(str, len, "bfq%d%c", bfqq->pid, type);
 	else
-		snprintf(str, len, "SHARED-");
+		snprintf(str, len, "bfqSHARED-%c", type);
 }
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
-	char pid_str[MAX_PID_STR_LENGTH];	\
+	char pid_str[MAX_BFQQ_NAME_LENGTH];				\
 	if (likely(!blk_trace_note_message_enabled((bfqd)->queue)))	\
 		break;							\
-	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
+	bfq_bfqq_name((bfqq), pid_str, MAX_BFQQ_NAME_LENGTH);		\
 	blk_add_cgroup_trace_msg((bfqd)->queue,				\
 			bfqg_to_blkg(bfqq_group(bfqq))->blkcg,		\
-			"bfq%s%c " fmt, pid_str,			\
-			bfq_bfqq_sync((bfqq)) ? 'S' : 'A', ##args);	\
+			"%s " fmt, pid_str, ##args);			\
 } while (0)
 
 #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)	do {			\
@@ -1113,13 +1114,11 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
-	char pid_str[MAX_PID_STR_LENGTH];	\
+	char pid_str[MAX_BFQQ_NAME_LENGTH];				\
 	if (likely(!blk_trace_note_message_enabled((bfqd)->queue)))	\
 		break;							\
-	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
-	blk_add_trace_msg((bfqd)->queue, "bfq%s%c " fmt, pid_str,	\
-			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
-				##args);	\
+	bfq_bfqq_name((bfqq), pid_str, MAX_BFQQ_NAME_LENGTH);		\
+	blk_add_trace_msg((bfqd)->queue, "%s " fmt, pid_str, ##args);	\
 } while (0)
 #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
 
-- 
2.26.2

