Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39163 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeH2Q2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:28:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so3795471edi.6
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:31:31 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 1/4] lightnvm: pblk: add trace events for chunk states
Date: Wed, 29 Aug 2018 14:31:14 +0200
Message-Id: <1535545877-770-2-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Introduce trace points for tracking chunk states in pblk - this is
useful for inspection of the entire state of the drive, and real handy
for both fw and pblk debugging.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 35 +++++++++++++++++++++++++++-
 drivers/lightnvm/pblk-init.c  |  4 ++++
 drivers/lightnvm/pblk-trace.h | 53 +++++++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-write.c | 10 ++++++--
 drivers/lightnvm/pblk.h       |  8 +++++++
 5 files changed, 107 insertions(+), 3 deletions(-)
 create mode 100644 drivers/lightnvm/pblk-trace.h

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index f7bff3ae52ac..4da37e29bb06 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -16,7 +16,10 @@
  *
  */
 
+#define CREATE_TRACE_POINTS
+
 #include "pblk.h"
+#include "pblk-trace.h"
 
 static void pblk_line_mark_bb(struct work_struct *work)
 {
@@ -93,6 +96,9 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 		chunk->state = NVM_CHK_ST_FREE;
 	}
 
+	trace_pblk_chunk_state(pblk_disk_name(pblk), &rqd->ppa_addr,
+				chunk->state);
+
 	atomic_dec(&pblk->inflight_io);
 }
 
@@ -477,9 +483,30 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 	return nvm_submit_io(dev, rqd);
 }
 
+void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
+
+	int i;
+
+	for (i = 0; i < rqd->nr_ppas; i++) {
+		struct ppa_addr *ppa = &ppa_list[i];
+		struct nvm_chk_meta *chunk = pblk_dev_ppa_to_chunk(pblk, *ppa);
+		u64 caddr = pblk_dev_ppa_to_chunk_addr(pblk, *ppa);
+
+		if (caddr == 0)
+			trace_pblk_chunk_state(pblk_disk_name(pblk),
+							ppa, NVM_CHK_ST_OPEN);
+		else if (caddr == chunk->cnlb)
+			trace_pblk_chunk_state(pblk_disk_name(pblk),
+							ppa, NVM_CHK_ST_CLOSED);
+	}
+}
+
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	int ret;
 
 	atomic_inc(&pblk->inflight_io);
 
@@ -488,7 +515,13 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 		return NVM_IO_ERR;
 #endif
 
-	return nvm_submit_io_sync(dev, rqd);
+	ret = nvm_submit_io_sync(dev, rqd);
+
+	if (trace_pblk_chunk_state_enabled() && !ret &&
+	    rqd->opcode == NVM_OP_PWRITE)
+		pblk_check_chunk_state_update(pblk, rqd);
+
+	return ret;
 }
 
 static void pblk_bio_map_addr_endio(struct bio *bio)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 0be64220b5d8..3f8bae9be852 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -19,6 +19,7 @@
  */
 
 #include "pblk.h"
+#include "pblk-trace.h"
 
 static unsigned int write_buffer_size;
 
@@ -650,6 +651,9 @@ static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
 		chunk->cnlb = chunk_meta->cnlb;
 		chunk->wp = chunk_meta->wp;
 
+		trace_pblk_chunk_state(pblk_disk_name(pblk), &ppa,
+					chunk->state);
+
 		if (chunk->type & NVM_CHK_TP_SZ_SPEC) {
 			WARN_ONCE(1, "pblk: custom-sized chunks unsupported\n");
 			continue;
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
new file mode 100644
index 000000000000..d985b729428f
--- /dev/null
+++ b/drivers/lightnvm/pblk-trace.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pblk
+
+#if !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PBLK_H
+
+#include <linux/tracepoint.h>
+
+struct ppa_addr;
+
+#define show_chunk_flags(state) __print_flags(state, "",	\
+	{ NVM_CHK_ST_FREE,		"FREE",		},	\
+	{ NVM_CHK_ST_CLOSED,		"CLOSED",	},	\
+	{ NVM_CHK_ST_OPEN,		"OPEN",		},	\
+	{ NVM_CHK_ST_OFFLINE,		"OFFLINE",	})
+
+TRACE_EVENT(pblk_chunk_state,
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
+			show_chunk_flags((int)__entry->state))
+
+);
+
+
+#endif /* !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../../drivers/lightnvm
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE pblk-trace
+#include <trace/define_trace.h>
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 8aa4b9ee5092..bb656cbd5d3e 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -16,6 +16,7 @@
  */
 
 #include "pblk.h"
+#include "pblk-trace.h"
 
 static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 				    struct pblk_c_ctx *c_ctx)
@@ -278,11 +279,13 @@ static void pblk_end_io_write(struct nvm_rq *rqd)
 	if (rqd->error) {
 		pblk_end_w_fail(pblk, rqd);
 		return;
-	}
+	} else {
+		if (trace_pblk_chunk_state_enabled())
+			pblk_check_chunk_state_update(pblk, rqd);
 #ifdef CONFIG_NVM_PBLK_DEBUG
-	else
 		WARN_ONCE(rqd->bio->bi_status, "pblk: corrupted write error\n");
 #endif
+	}
 
 	pblk_complete_write(pblk, rqd, c_ctx);
 	atomic_dec(&pblk->inflight_io);
@@ -303,6 +306,9 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 		pblk_log_write_err(pblk, rqd);
 		pblk_err(pblk, "metadata I/O failed. Line %d\n", line->id);
 		line->w_err_gc->has_write_err = 1;
+	} else {
+		if (trace_pblk_chunk_state_enabled())
+			pblk_check_chunk_state_update(pblk, rqd);
 	}
 
 	sync = atomic_add_return(rqd->nr_ppas, &emeta->sync);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 1bdac22e7897..ed17db2cae2c 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -785,6 +785,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
+void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
 			      int alloc_type, gfp_t gfp_mask);
@@ -1440,4 +1441,11 @@ static inline void pblk_setup_uuid(struct pblk *pblk)
 	uuid_le_gen(&uuid);
 	memcpy(pblk->instance_uuid, uuid.b, 16);
 }
+
+static inline char *pblk_disk_name(struct pblk *pblk)
+{
+	struct gendisk *disk = pblk->disk;
+
+	return disk->disk_name;
+}
 #endif /* PBLK_H_ */
-- 
2.7.4
