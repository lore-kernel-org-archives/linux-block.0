Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3972C47257
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A5C20746
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgEFNjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 09:39:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgEFNjk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 09:39:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D82B7AEA1;
        Wed,  6 May 2020 13:39:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ABB791E12F9; Wed,  6 May 2020 15:39:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] blkparse: Handle cgroup information
Date:   Wed,  6 May 2020 15:39:31 +0200
Message-Id: <20200506133933.4773-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200506133933.4773-1-jack@suse.cz>
References: <20200506133933.4773-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since Linux kernel commit 35fe6d763229 "block: use standard blktrace API
to output cgroup info for debug notes" the kernel can pass
__BLK_TA_CGROUP flag in the action field of generated events. blkparse
does not count with this and so it will get confused by such events and
either ignore them or misreport them. Teach blkparse how to properly
process events with __BLK_TA_CGROUP flag.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 blkparse.c       | 41 ++++++++++++++++++++++++++---------------
 blkparse_fmt.c   | 15 +++++++++++++++
 blktrace_api.h   | 10 ++++++++++
 doc/blkparse.1   |  4 ++++
 doc/blktrace.tex |  3 +++
 5 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 28bdf1543ddb..ae4cb4433944 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -597,7 +597,7 @@ static void handle_notify(struct blk_io_trace *bit)
 	void	*payload = (caddr_t) bit + sizeof(*bit);
 	__u32	two32[2];
 
-	switch (bit->action) {
+	switch (bit->action & ~__BLK_TN_CGROUP) {
 	case BLK_TN_PROCESS:
 		add_ppm_hash(bit->pid, payload);
 		break;
@@ -623,16 +623,27 @@ static void handle_notify(struct blk_io_trace *bit)
 	case BLK_TN_MESSAGE:
 		if (bit->pdu_len > 0) {
 			char msg[bit->pdu_len+1];
+			int len = bit->pdu_len;
+			char cgidstr[24];
 
-			memcpy(msg, (char *)payload, bit->pdu_len);
-			msg[bit->pdu_len] = '\0';
+			cgidstr[0] = 0;
+			if (bit->action & __BLK_TN_CGROUP) {
+				struct blk_io_cgroup_payload *cgid = payload;
+
+				sprintf(cgidstr, "%x,%x ", cgid->ino,
+					cgid->gen);
+				payload += sizeof(struct blk_io_cgroup_payload);
+				len -= sizeof(struct blk_io_cgroup_payload);
+			}
+			memcpy(msg, (char *)payload, len);
+			msg[len] = '\0';
 
 			fprintf(ofp,
-				"%3d,%-3d %2d %8s %5d.%09lu %5u %2s %3s %s\n",
+				"%3d,%-3d %2d %8s %5d.%09lu %5u %s%2s %3s %s\n",
 				MAJOR(bit->device), MINOR(bit->device),
-				bit->cpu, "0", (int) SECONDS(bit->time),
-				(unsigned long) NANO_SECONDS(bit->time),
-				0, "m", "N", msg);
+				bit->cpu, "0", (int)SECONDS(bit->time),
+				(unsigned long)NANO_SECONDS(bit->time),
+				0, cgidstr, "m", "N", msg);
 		}
 		break;
 
@@ -1511,7 +1522,7 @@ static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = t->action & 0xffff;
+	int act = (t->action & 0xffff) & ~__BLK_TA_CGROUP;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1560,7 +1571,7 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
-	int act = t->action & 0xffff;
+	int act = (t->action & 0xffff) & ~__BLK_TA_CGROUP;
 
 	switch (act) {
 		case __BLK_TA_QUEUE:
@@ -1643,7 +1654,7 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 		       struct per_dev_info *pdi)
 {
 	if (text_output) {
-		if (t->action == BLK_TN_MESSAGE)
+		if ((t->action & ~__BLK_TN_CGROUP) == BLK_TN_MESSAGE)
 			handle_notify(t);
 		else if (t->action & BLK_TC_ACT(BLK_TC_PC))
 			dump_trace_pc(t, pdi, pci);
@@ -1658,7 +1669,7 @@ static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
 
 	if (bin_output_msgs ||
 			    !(t->action & BLK_TC_ACT(BLK_TC_NOTIFY) &&
-			      t->action == BLK_TN_MESSAGE))
+			      (t->action & ~__BLK_TN_CGROUP) == BLK_TN_MESSAGE))
 		output_binary(t, sizeof(*t) + t->pdu_len);
 }
 
@@ -2234,7 +2245,7 @@ static void show_entries_rb(int force)
 			break;
 		}
 
-		if (!(bit->action == BLK_TN_MESSAGE) &&
+		if (!((bit->action & ~__BLK_TN_CGROUP) == BLK_TN_MESSAGE) &&
 		    check_sequence(pdi, t, force))
 			break;
 
@@ -2246,7 +2257,7 @@ static void show_entries_rb(int force)
 		if (!pci || pci->cpu != bit->cpu)
 			pci = get_cpu_info(pdi, bit->cpu);
 
-		if (!(bit->action == BLK_TN_MESSAGE))
+		if (!((bit->action & ~__BLK_TN_CGROUP) == BLK_TN_MESSAGE))
 			pci->last_sequence = bit->sequence;
 
 		pci->nelems++;
@@ -2380,7 +2391,7 @@ static int read_events(int fd, int always_block, int *fdblock)
 		/*
 		 * not a real trace, so grab and handle it here
 		 */
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
+		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			continue;
@@ -2529,7 +2540,7 @@ static int ms_prime(struct ms_stream *msp)
 			continue;
 		}
 
-		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && bit->action != BLK_TN_MESSAGE) {
+		if (bit->action & BLK_TC_ACT(BLK_TC_NOTIFY) && (bit->action & ~__BLK_TN_CGROUP) != BLK_TN_MESSAGE) {
 			handle_notify(bit);
 			output_binary(bit, sizeof(*bit) + bit->pdu_len);
 			bit_free(bit);
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index c42e6d7b7219..df2f6ce2148a 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -205,6 +205,21 @@ static void print_field(char *act, struct per_cpu_info *pci,
 	case 'e':
 		fprintf(ofp, strcat(format, "d"), t->error);
 		break;
+	case 'g': {
+		char cgidstr[24];
+		u32 ino = 0, gen = 0;
+
+		if (t->action & __BLK_TA_CGROUP) {
+			struct blk_io_cgroup_payload *cgid =
+				(struct blk_io_cgroup_payload *)pdu_buf;
+
+			ino = cgid->ino;
+			gen = cgid->gen;
+		}
+		sprintf(cgidstr, "%x,%x", ino, gen);
+		fprintf(ofp, strcat(format, "s"), cgidstr);
+		break;
+	}
 	case 'M':
 		fprintf(ofp, strcat(format, "d"), MAJOR(t->device));
 		break;
diff --git a/blktrace_api.h b/blktrace_api.h
index b22221828f41..8c760b8dd260 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -51,6 +51,7 @@ enum {
 	__BLK_TA_REMAP,			/* bio was remapped */
 	__BLK_TA_ABORT,			/* request aborted */
 	__BLK_TA_DRV_DATA,		/* binary driver data */
+	__BLK_TA_CGROUP = 1 << 8,
 };
 
 /*
@@ -60,6 +61,7 @@ enum blktrace_notify {
 	__BLK_TN_PROCESS = 0,		/* establish pid/name mapping */
 	__BLK_TN_TIMESTAMP,		/* include system clock */
 	__BLK_TN_MESSAGE,               /* Character string message */
+	__BLK_TN_CGROUP = __BLK_TA_CGROUP,
 };
 
 /*
@@ -116,6 +118,14 @@ struct blk_io_trace_remap {
 	__u64 sector_from;
 };
 
+/*
+ * Payload with originating cgroup info
+ */
+struct blk_io_cgroup_payload {
+	__u32 ino;
+	__u32 gen;
+};
+
 /*
  * User setup structure passed with BLKSTARTTRACE
  */
diff --git a/doc/blkparse.1 b/doc/blkparse.1
index e494b6eca223..4c26baffc56c 100644
--- a/doc/blkparse.1
+++ b/doc/blkparse.1
@@ -332,6 +332,10 @@ the event's device (separated by a comma).
 .IP \fBe\fR 4
 Error value
 
+.IP \fBg\fR 4
+Cgroup identifier of the cgroup that generated the IO. Note that this requires
+appropriate kernel support (kernel version at least 4.14).
+
 .IP \fBm\fR 4
 Minor number of event's device.
 
diff --git a/doc/blktrace.tex b/doc/blktrace.tex
index 3647c7502142..836ac4a35f86 100644
--- a/doc/blktrace.tex
+++ b/doc/blktrace.tex
@@ -601,6 +601,9 @@ Specifier & \\ \hline\hline
 the event's device \\
          & (separated by a comma). \\ \hline
 \emph{e} & Error value \\ \hline
+\emph{g} & Cgroup identifier of the cgroup that generated the IO. Note that this requires
+appropriate \\
+         & kernel support (kernel version at least 4.14). \\ \hline
 \emph{m} & Minor number of event's device. \\ \hline
 \emph{M} & Major number of event's device. \\ \hline
 \emph{n} & Number of blocks \\ \hline
-- 
2.16.4

