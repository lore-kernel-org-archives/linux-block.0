Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47448 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932248AbdJMMrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id t69so21256092wmt.2
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:53 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 48/58] lightnvm: pblk: start gc if needed during init
Date: Fri, 13 Oct 2017 14:46:37 +0200
Message-Id: <20171013124647.32668-49-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Start GC if needed, directly after init, as we might
need to garbage collect in order to make room for user writes.

Create a helper function that allows to kick GC without exposing the
internals of the GC/rate-limiter interaction.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-gc.c   | 5 +++++
 drivers/lightnvm/pblk-init.c | 4 ++++
 drivers/lightnvm/pblk-rl.c   | 2 +-
 drivers/lightnvm/pblk.h      | 2 ++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 374089f..4bac9e1 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -510,6 +510,11 @@ void pblk_gc_should_stop(struct pblk *pblk)
 		pblk_gc_stop(pblk, 0);
 }
 
+void pblk_gc_should_kick(struct pblk *pblk)
+{
+	pblk_rl_update_rates(&pblk->rl);
+}
+
 void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
 			      int *gc_active)
 {
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f08fa20..ad9f014 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1025,6 +1025,10 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 			pblk->rwb.nr_entries);
 
 	wake_up_process(pblk->writer_ts);
+
+	/* Check if we need to start GC */
+	pblk_gc_should_kick(pblk);
+
 	return pblk;
 
 fail_stop_writer:
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 0896439..739f855 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -96,7 +96,7 @@ unsigned long pblk_rl_nr_free_blks(struct pblk_rl *rl)
  *
  * Only the total number of free blocks is used to configure the rate limiter.
  */
-static void pblk_rl_update_rates(struct pblk_rl *rl)
+void pblk_rl_update_rates(struct pblk_rl *rl)
 {
 	struct pblk *pblk = container_of(rl, struct pblk, rl);
 	unsigned long free_blocks = pblk_rl_nr_free_blks(rl);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 21438d1..29ba7ec 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -830,6 +830,7 @@ int pblk_gc_init(struct pblk *pblk);
 void pblk_gc_exit(struct pblk *pblk);
 void pblk_gc_should_start(struct pblk *pblk);
 void pblk_gc_should_stop(struct pblk *pblk);
+void pblk_gc_should_kick(struct pblk *pblk);
 void pblk_gc_kick(struct pblk *pblk);
 void pblk_gc_free_full_lines(struct pblk *pblk);
 void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
@@ -841,6 +842,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int force);
  */
 void pblk_rl_init(struct pblk_rl *rl, int budget);
 void pblk_rl_free(struct pblk_rl *rl);
+void pblk_rl_update_rates(struct pblk_rl *rl);
 int pblk_rl_high_thrs(struct pblk_rl *rl);
 int pblk_rl_low_thrs(struct pblk_rl *rl);
 unsigned long pblk_rl_nr_free_blks(struct pblk_rl *rl);
-- 
2.9.3
