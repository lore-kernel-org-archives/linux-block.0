Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39851 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeDPQqv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 12:46:51 -0400
Received: by mail-lf0-f68.google.com with SMTP id p142-v6so23087111lfd.6
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 09:46:50 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: pblk: kick writer on new flush points
Date: Mon, 16 Apr 2018 18:46:16 +0200
Message-Id: <1523897176-6241-3-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1523897176-6241-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1523897176-6241-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Unless we kick the writer directly when setting a new flush point, the
user risks having to wait for up to one second (the default timeout for
the write thread to be kicked) for the IO to complete.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-cache.c | 10 ++++++----
 drivers/lightnvm/pblk-core.c  |  2 +-
 drivers/lightnvm/pblk-rb.c    |  4 ++--
 drivers/lightnvm/pblk.h       |  1 +
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index 29a2311..b1c6d7e 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -44,13 +44,15 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
 		goto out;
 	}
 
-	if (unlikely(!bio_has_data(bio)))
-		goto out;
-
 	pblk_ppa_set_empty(&w_ctx.ppa);
 	w_ctx.flags = flags;
-	if (bio->bi_opf & REQ_PREFLUSH)
+	if (bio->bi_opf & REQ_PREFLUSH) {
 		w_ctx.flags |= PBLK_FLUSH_ENTRY;
+		pblk_write_kick(pblk);
+	}
+
+	if (unlikely(!bio_has_data(bio)))
+		goto out;
 
 	for (i = 0; i < nr_entries; i++) {
 		void *data = bio_data(bio);
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 94d5d97..ceacd10 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -320,7 +320,7 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 	return -1;
 }
 
-static void pblk_write_kick(struct pblk *pblk)
+void pblk_write_kick(struct pblk *pblk)
 {
 	wake_up_process(pblk->writer_ts);
 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(1000));
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 52fdd85..7a63291 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -350,7 +350,7 @@ void pblk_rb_write_entry_gc(struct pblk_rb *rb, void *data,
 }
 
 static int pblk_rb_flush_point_set(struct pblk_rb *rb, struct bio *bio,
-				  unsigned int pos)
+				   unsigned int pos)
 {
 	struct pblk_rb_entry *entry;
 	unsigned int sync, flush_point;
@@ -420,7 +420,7 @@ void pblk_rb_flush(struct pblk_rb *rb)
 	if (pblk_rb_flush_point_set(rb, NULL, mem))
 		return;
 
-	pblk_write_should_kick(pblk);
+	pblk_write_kick(pblk);
 }
 
 static int pblk_rb_may_write_flush(struct pblk_rb *rb, unsigned int nr_entries,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 9c682ac..856ac41 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -837,6 +837,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 int pblk_write_ts(void *data);
 void pblk_write_timer_fn(struct timer_list *t);
 void pblk_write_should_kick(struct pblk *pblk);
+void pblk_write_kick(struct pblk *pblk);
 
 /*
  * pblk read path
-- 
2.7.4
