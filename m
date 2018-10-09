Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46451 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbeJISbE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so655914plz.13
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:38 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 25/45] lightnvm: pblk: add tracing for chunk resets
Date: Tue,  9 Oct 2018 13:11:55 +0200
Message-Id: <20181009111215.7653-26-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Trace state of chunk resets.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
 drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk.h       |  6 ++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index c482ef7dd4b5..84f3b4912b92 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -90,9 +90,15 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 	atomic_dec(&line->left_seblks);
 
 	if (rqd->error) {
+		trace_pblk_chunk_reset(pblk_disk_name(pblk),
+				&rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
+
 		chunk->state = NVM_CHK_ST_OFFLINE;
 		pblk_mark_bb(pblk, line, rqd->ppa_addr);
 	} else {
+		trace_pblk_chunk_reset(pblk_disk_name(pblk),
+				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
+
 		chunk->state = NVM_CHK_ST_FREE;
 	}
 
@@ -923,6 +929,9 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 	struct nvm_rq rqd = {NULL};
 	int ret;
 
+	trace_pblk_chunk_reset(pblk_disk_name(pblk), &ppa,
+				PBLK_CHUNK_RESET_START);
+
 	pblk_setup_e_rq(pblk, &rqd, ppa);
 
 	/* The write thread schedules erases so that it minimizes disturbances
@@ -1736,6 +1745,9 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	rqd->end_io = pblk_end_io_erase;
 	rqd->private = pblk;
 
+	trace_pblk_chunk_reset(pblk_disk_name(pblk),
+				&ppa, PBLK_CHUNK_RESET_START);
+
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index c171d0450c07..679e5c458ca6 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -31,6 +31,37 @@ struct ppa_addr;
 	{ PBLK_STATE_RECOVERING,	"RECOVERING",	},	\
 	{ PBLK_STATE_STOPPED,		"STOPPED"	})
 
+#define show_chunk_erase_state(state) __print_symbolic(state,	\
+	{ PBLK_CHUNK_RESET_START,	"START",	},	\
+	{ PBLK_CHUNK_RESET_DONE,	"OK",		},	\
+	{ PBLK_CHUNK_RESET_FAILED,	"FAILED"	})
+
+
+TRACE_EVENT(pblk_chunk_reset,
+
+	TP_PROTO(const char *name, struct ppa_addr *ppa, int state),
+
+	TP_ARGS(name, ppa, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(u64, ppa)
+		__field(int, state);
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->ppa = ppa->ppa;
+		__entry->state = state;
+	),
+
+	TP_printk("dev=%s grp=%llu pu=%llu chk=%llu state=%s", __get_str(name),
+			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.grp),
+			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.pu),
+			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.chk),
+			show_chunk_erase_state((int)__entry->state))
+
+);
 
 TRACE_EVENT(pblk_chunk_state,
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index b2746099ca1d..7f4e46dfb0d7 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -79,6 +79,12 @@ enum {
 	PBLK_BLK_ST_CLOSED =	0x2,
 };
 
+enum {
+	PBLK_CHUNK_RESET_START,
+	PBLK_CHUNK_RESET_DONE,
+	PBLK_CHUNK_RESET_FAILED,
+};
+
 struct pblk_sec_meta {
 	u64 reserved;
 	__le64 lba;
-- 
2.17.1
