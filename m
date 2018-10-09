Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37229 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJISa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so679384pfi.4
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:31 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 23/45] lightnvm: pblk: add trace events for line state changes
Date: Tue,  9 Oct 2018 13:11:53 +0200
Message-Id: <20181009111215.7653-24-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Add trace events for logging for line state changes.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     | 19 +++++++++++++++++-
 drivers/lightnvm/pblk-gc.c       |  8 ++++++++
 drivers/lightnvm/pblk-init.c     |  3 +++
 drivers/lightnvm/pblk-recovery.c |  6 ++++++
 drivers/lightnvm/pblk-trace.h    | 33 ++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 8a5158607467..ef52c1647f88 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -413,6 +413,9 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
 		}
 	} else {
 		line->state = PBLK_LINESTATE_CORRUPT;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
+
 		line->gc_group = PBLK_LINEGC_NONE;
 		move_list =  &l_mg->corrupt_list;
 		pblk_err(pblk, "corrupted vsc for line %d, vsc:%d (%d/%d/%d)\n",
@@ -1019,6 +1022,8 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 		spin_lock(&l_mg->free_lock);
 		spin_lock(&line->lock);
 		line->state = PBLK_LINESTATE_BAD;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_add_tail(&line->list, &l_mg->bad_list);
@@ -1166,6 +1171,8 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 		bitmap_weight(line->invalid_bitmap, lm->sec_per_line)) {
 		spin_lock(&line->lock);
 		line->state = PBLK_LINESTATE_BAD;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_add_tail(&line->list, &l_mg->bad_list);
@@ -1218,6 +1225,8 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	if (line->state == PBLK_LINESTATE_NEW) {
 		blk_to_erase = pblk_prepare_new_line(pblk, line);
 		line->state = PBLK_LINESTATE_FREE;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 	} else {
 		blk_to_erase = blk_in_line;
 	}
@@ -1235,6 +1244,8 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	}
 
 	line->state = PBLK_LINESTATE_OPEN;
+	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+				line->state);
 
 	atomic_set(&line->left_eblks, blk_to_erase);
 	atomic_set(&line->left_seblks, blk_to_erase);
@@ -1331,6 +1342,8 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
 	if (unlikely(bit >= lm->blk_per_line)) {
 		spin_lock(&line->lock);
 		line->state = PBLK_LINESTATE_BAD;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_add_tail(&line->list, &l_mg->bad_list);
@@ -1650,6 +1663,8 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_FREE;
+	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 	line->gc_group = PBLK_LINEGC_NONE;
 	pblk_line_free(line);
 
@@ -1779,7 +1794,6 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 	WARN_ON(line->state != PBLK_LINESTATE_OPEN);
 	line->state = PBLK_LINESTATE_CLOSED;
 	move_list = pblk_line_gc_list(pblk, line);
-
 	list_add_tail(&line->list, move_list);
 
 	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
@@ -1798,6 +1812,9 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 
 	spin_unlock(&line->lock);
 	spin_unlock(&l_mg->gc_lock);
+
+	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 }
 
 void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 157c2567c9e8..b841d84c4342 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -16,8 +16,10 @@
  */
 
 #include "pblk.h"
+#include "pblk-trace.h"
 #include <linux/delay.h>
 
+
 static void pblk_gc_free_gc_rq(struct pblk_gc_rq *gc_rq)
 {
 	if (gc_rq->data)
@@ -64,6 +66,8 @@ static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_CLOSED;
+	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 	move_list = pblk_line_gc_list(pblk, line);
 	spin_unlock(&line->lock);
 
@@ -405,6 +409,8 @@ void pblk_gc_free_full_lines(struct pblk *pblk)
 		spin_lock(&line->lock);
 		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
 		line->state = PBLK_LINESTATE_GC;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_del(&line->list);
@@ -451,6 +457,8 @@ static void pblk_gc_run(struct pblk *pblk)
 		spin_lock(&line->lock);
 		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
 		line->state = PBLK_LINESTATE_GC;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_del(&line->list);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 4f2d9b502028..fca37da16266 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -985,6 +985,9 @@ static int pblk_lines_init(struct pblk *pblk)
 			goto fail_free_lines;
 
 		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
+
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+								line->state);
 	}
 
 	if (!nr_free_chks) {
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index cbcc0828517e..0322ab915ddc 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -15,6 +15,7 @@
  */
 
 #include "pblk.h"
+#include "pblk-trace.h"
 
 int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta_buf)
 {
@@ -932,6 +933,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 			spin_lock(&line->lock);
 			line->state = PBLK_LINESTATE_CLOSED;
+			trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 			move_list = pblk_line_gc_list(pblk, line);
 			spin_unlock(&line->lock);
 
@@ -947,6 +950,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			if (open_lines > 1)
 				pblk_err(pblk, "failed to recover L2P\n");
 
+			trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
+
 			open_lines++;
 			line->meta_line = meta_line;
 			data_line = line;
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index d985b729428f..f9aa9e25e428 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -15,6 +15,16 @@ struct ppa_addr;
 	{ NVM_CHK_ST_OPEN,		"OPEN",		},	\
 	{ NVM_CHK_ST_OFFLINE,		"OFFLINE",	})
 
+#define show_line_state(state) __print_symbolic(state,		\
+	{ PBLK_LINESTATE_NEW,		"NEW",		},	\
+	{ PBLK_LINESTATE_FREE,		"FREE",		},	\
+	{ PBLK_LINESTATE_OPEN,		"OPEN",		},	\
+	{ PBLK_LINESTATE_CLOSED,	"CLOSED",	},	\
+	{ PBLK_LINESTATE_GC,		"GC",		},	\
+	{ PBLK_LINESTATE_BAD,		"BAD",		},	\
+	{ PBLK_LINESTATE_CORRUPT,	"CORRUPT"	})
+
+
 TRACE_EVENT(pblk_chunk_state,
 
 	TP_PROTO(const char *name, struct ppa_addr *ppa, int state),
@@ -41,6 +51,29 @@ TRACE_EVENT(pblk_chunk_state,
 
 );
 
+TRACE_EVENT(pblk_line_state,
+
+	TP_PROTO(const char *name, int line, int state),
+
+	TP_ARGS(name, line, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, line)
+		__field(int, state);
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->line = line;
+		__entry->state = state;
+	),
+
+	TP_printk("dev=%s line=%d state=%s", __get_str(name),
+			(int)__entry->line,
+			show_line_state((int)__entry->state))
+
+);
 
 #endif /* !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.17.1
