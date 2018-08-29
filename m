Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38769 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeH2Q2P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:28:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so3795262edb.5
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:31:33 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 3/4] lightnvm: pblk: add trace events for pblk state changes
Date: Wed, 29 Aug 2018 14:31:16 +0200
Message-Id: <1535545877-770-4-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Add trace events for tracking pblk state changes.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  |  3 +++
 drivers/lightnvm/pblk-init.c  |  1 +
 drivers/lightnvm/pblk-trace.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 05775a279b20..566a5d3165ee 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1503,6 +1503,7 @@ static void pblk_stop_writes(struct pblk *pblk, struct pblk_line *line)
 
 	pblk_set_space_limit(pblk);
 	pblk->state = PBLK_STATE_STOPPING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 }
 
 static void pblk_line_close_meta_sync(struct pblk *pblk)
@@ -1552,6 +1553,7 @@ void __pblk_pipeline_flush(struct pblk *pblk)
 		return;
 	}
 	pblk->state = PBLK_STATE_RECOVERING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	spin_unlock(&l_mg->free_lock);
 
 	pblk_flush_writer(pblk);
@@ -1573,6 +1575,7 @@ void __pblk_pipeline_stop(struct pblk *pblk)
 
 	spin_lock(&l_mg->free_lock);
 	pblk->state = PBLK_STATE_STOPPED;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	l_mg->data_line = NULL;
 	l_mg->data_next = NULL;
 	spin_unlock(&l_mg->free_lock);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ddbd91d80119..d0546213c64f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1093,6 +1093,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->dev = dev;
 	pblk->disk = tdisk;
 	pblk->state = PBLK_STATE_RUNNING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	pblk->gc.gc_enabled = 0;
 
 	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index f9aa9e25e428..c171d0450c07 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -25,6 +25,13 @@ struct ppa_addr;
 	{ PBLK_LINESTATE_CORRUPT,	"CORRUPT"	})
 
 
+#define show_pblk_state(state) __print_symbolic(state,		\
+	{ PBLK_STATE_RUNNING,		"RUNNING",	},	\
+	{ PBLK_STATE_STOPPING,		"STOPPING",	},	\
+	{ PBLK_STATE_RECOVERING,	"RECOVERING",	},	\
+	{ PBLK_STATE_STOPPED,		"STOPPED"	})
+
+
 TRACE_EVENT(pblk_chunk_state,
 
 	TP_PROTO(const char *name, struct ppa_addr *ppa, int state),
@@ -75,6 +82,27 @@ TRACE_EVENT(pblk_line_state,
 
 );
 
+TRACE_EVENT(pblk_state,
+
+	TP_PROTO(const char *name, int state),
+
+	TP_ARGS(name, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, state);
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->state = state;
+	),
+
+	TP_printk("dev=%s state=%s", __get_str(name),
+			show_pblk_state((int)__entry->state))
+
+);
+
 #endif /* !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */
-- 
2.7.4
