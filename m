Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D420C433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAC3610C8
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhJFRd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:33:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbhJFRdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:33:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 090621FEF3;
        Wed,  6 Oct 2021 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633541518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wk6tCskQ9yIfiKGjM5o2XAB1G+7SzmoK7GhWE/e1TY=;
        b=NkKmRO0Dk1sh2DWAUK7bXabDkXDp9S1Q4hdQ9g1SOCStcyocl6+EDZHCohcuK/6liBpUQJ
        kLq0IMvm/wp6rJD6ALoROfu4TF8zH8mTVJUpItMGUHfO+o6OlMYoFXNSxJpPKZVtTxUXmI
        M6biBLADwm0qduC8agoQf+/Y1nVNV3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633541518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wk6tCskQ9yIfiKGjM5o2XAB1G+7SzmoK7GhWE/e1TY=;
        b=fAXG8LSsn8b9Yv4xIlmjA6lnlyRG76kUw0LC/ZfjMpGyLQHWQGePvJQ7F4a1DfWv0kczfz
        +tdO1Dnr6AD4IKAA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id E7D7DA3B8E;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 716431F2CA3; Wed,  6 Oct 2021 19:31:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 6/8] bfq: Provide helper to generate bfqq name
Date:   Wed,  6 Oct 2021 19:31:45 +0200
Message-Id: <20211006173157.6906-6-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211006164110.10817-1-jack@suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2855; h=from:subject; bh=RkAzfQOxfcGjo5Yxwc+JRb2ioBSMxMmjz16n6Ifdwe0=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGBJj7zbo/TTVadDXFmKfEnR8u4VLmNKb2u45NgnJFmVrD3dU /AjrZDRmYWDkYJAVU2RZHXlR+9o8o66toRoyMINYmUCmMHBxCsCNbuVgWGI0+6pbegnPBCnzKSsfdB nLlLN4rqzn7mmRmbhB4khMf/IriYuWSntXBei9Z3aUzN93bPL9TYbvvrIZpc217D8qfXyHJpvvD+Pu lJcsy1csPyu4syda49WxIm+bHweEMs6YRFTL3Zma9yvC/vnTHakPNkhYuritkVJZ9kTpmeC8G2seb+ 2zstfKE/W0l1SZMm9a4Q7eJIltfe8jSyOyfBSZ4sR3VG9t8zLId74XqlrWetbGvVzuv8vHV9rZL7pX LZvlHfy6sOZfD6+yd6PU3Z5vjtEN18JsnpjsfSH0c/u8+5pnHHlZZM51reI/f0Vt2z7vOtY5tzW26/ pO8e0VMg/jOLzB5LXbe9YpcU8B
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of having helper formating bfqq pid, provide a helper to
generate full bfqq name as used in the traces. It saves some code
duplication and will save more in the coming tracepoints.

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

