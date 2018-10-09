Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35828 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeJISbB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8-v6so680932plb.2
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:34 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 24/45] lightnvm: pblk: add trace events for pblk state changes
Date: Tue,  9 Oct 2018 13:11:54 +0200
Message-Id: <20181009111215.7653-25-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Add trace events for tracking pblk state changes.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  |  3 +++
 drivers/lightnvm/pblk-init.c  |  1 +
 drivers/lightnvm/pblk-trace.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ef52c1647f88..c482ef7dd4b5 100644
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
index fca37da16266..9aebdee8e4c9 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1109,6 +1109,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
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
2.17.1
