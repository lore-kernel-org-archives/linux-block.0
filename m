Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46FC38A2A
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA419206D5
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEFNjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 09:39:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbgEFNjk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 09:39:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9715AEB8;
        Wed,  6 May 2020 13:39:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B24741E12FF; Wed,  6 May 2020 15:39:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] iowatcher: Handle cgroup information
Date:   Wed,  6 May 2020 15:39:33 +0200
Message-Id: <20200506133933.4773-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200506133933.4773-1-jack@suse.cz>
References: <20200506133933.4773-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since Linux kernel commit 35fe6d763229 "block: use standard blktrace API
to output cgroup info for debug notes" the kernel can pass
__BLK_TA_CGROUP flag in the action field of generated events. Teach
iowatcher to ignore this information.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 iowatcher/blkparse.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 982de9459826..6203854bd49c 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -51,7 +51,7 @@ extern int plot_io_action;
 extern int io_per_process;
 
 #define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
-#define BLK_TA_MASK ((1 << BLK_TC_SHIFT) - 1)
+#define BLK_TA_MASK (((1 << BLK_TC_SHIFT) - 1) & ~__BLK_TA_CGROUP)
 
 struct pending_io {
 	/* sector offset of this IO */
@@ -260,18 +260,23 @@ static void handle_notify(struct trace *trace)
 {
 	struct blk_io_trace *io = trace->io;
 	void *payload = (char *)io + sizeof(*io);
+	int pdu_len = io->pdu_len;
 	u32 two32[2];
 
-	if (io->action == BLK_TN_PROCESS) {
+	if (io->action & __BLK_TN_CGROUP) {
+		payload += sizeof(struct blk_io_cgroup_payload);
+		pdu_len -= sizeof(struct blk_io_cgroup_payload);
+	}
+	if ((io->action & ~__BLK_TN_CGROUP) == BLK_TN_PROCESS) {
 		if (io_per_process)
 			process_hash_insert(io->pid, payload);
 		return;
 	}
 
-	if (io->action != BLK_TN_TIMESTAMP)
+	if ((io->action & ~__BLK_TN_CGROUP) != BLK_TN_TIMESTAMP)
 		return;
 
-	if (io->pdu_len != sizeof(two32))
+	if (pdu_len != sizeof(two32))
 		return;
 
 	memcpy(two32, payload, sizeof(two32));
@@ -309,11 +314,16 @@ static int is_io_event(struct blk_io_trace *test)
 	char *message;
 	if (!(test->action & BLK_TC_ACT(BLK_TC_NOTIFY)))
 		return 1;
-	if (test->action == BLK_TN_MESSAGE) {
+	if ((test->action & ~__BLK_TN_CGROUP) == BLK_TN_MESSAGE) {
 		int len = test->pdu_len;
+
+		message = (char *)(test + 1);
+		if (test->action & __BLK_TN_CGROUP) {
+			len -= sizeof(struct blk_io_cgroup_payload);
+			message += sizeof(struct blk_io_cgroup_payload);
+		}
 		if (len < 3)
 			return 0;
-		message = (char *)(test + 1);
 		if (strncmp(message, "fio ", 4) == 0) {
 			return 1;
 		}
@@ -372,13 +382,17 @@ static int parse_fio_bank_message(struct trace *trace, u64 *bank_ret, u64 *offse
 
 	if (!(test->action & BLK_TC_ACT(BLK_TC_NOTIFY)))
 		return -1;
-	if (test->action != BLK_TN_MESSAGE)
+	if ((test->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE)
 		return -1;
 
+	message = (char *)(test + 1);
+	if (test->action & __BLK_TN_CGROUP) {
+		len -= sizeof(struct blk_io_cgroup_payload);
+		message += sizeof(struct blk_io_cgroup_payload);
+	}
 	/* the message is fio rw bank offset num_banks */
 	if (len < 3)
 		return -1;
-	message = (char *)(test + 1);
 	if (strncmp(message, "fio r ", 6) != 0)
 		return -1;
 
-- 
2.16.4

