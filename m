Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55877 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758096AbdJMMrS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id u138so21641950wmu.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:17 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 11/58] lightnvm: pblk: reuse pblk_gc_should_kick
Date: Fri, 13 Oct 2017 14:46:00 +0200
Message-Id: <20171013124647.32668-12-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

This is a trivial change which reuses pblk_gc_should_kick instead of
repeating it again in pblk_rl_free_lines_inc.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Made it apply to the common case.
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c |  2 --
 drivers/lightnvm/pblk-rl.c   | 33 +++++++++------------------------
 drivers/lightnvm/pblk.h      |  1 -
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 8536d38..a68c6ae 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1591,8 +1591,6 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 
 	spin_unlock(&line->lock);
 	spin_unlock(&l_mg->gc_lock);
-
-	pblk_gc_should_kick(pblk);
 }
 
 void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 2e6a536..9565c3b 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -96,9 +96,11 @@ unsigned long pblk_rl_nr_free_blks(struct pblk_rl *rl)
  *
  * Only the total number of free blocks is used to configure the rate limiter.
  */
-static int pblk_rl_update_rates(struct pblk_rl *rl, unsigned long max)
+static void pblk_rl_update_rates(struct pblk_rl *rl)
 {
+	struct pblk *pblk = container_of(rl, struct pblk, rl);
 	unsigned long free_blocks = pblk_rl_nr_free_blks(rl);
+	int max = rl->rb_budget;
 
 	if (free_blocks >= rl->high) {
 		rl->rb_user_max = max;
@@ -124,23 +126,18 @@ static int pblk_rl_update_rates(struct pblk_rl *rl, unsigned long max)
 		rl->rb_state = PBLK_RL_LOW;
 	}
 
-	return rl->rb_state;
+	if (rl->rb_state == (PBLK_RL_MID | PBLK_RL_LOW))
+		pblk_gc_should_start(pblk);
+	else
+		pblk_gc_should_stop(pblk);
 }
 
 void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line *line)
 {
-	struct pblk *pblk = container_of(rl, struct pblk, rl);
 	int blk_in_line = atomic_read(&line->blk_in_line);
-	int ret;
 
 	atomic_add(blk_in_line, &rl->free_blocks);
-	/* Rates will not change that often - no need to lock update */
-	ret = pblk_rl_update_rates(rl, rl->rb_budget);
-
-	if (ret == (PBLK_RL_MID | PBLK_RL_LOW))
-		pblk_gc_should_start(pblk);
-	else
-		pblk_gc_should_stop(pblk);
+	pblk_rl_update_rates(rl);
 }
 
 void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line)
@@ -148,19 +145,7 @@ void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line)
 	int blk_in_line = atomic_read(&line->blk_in_line);
 
 	atomic_sub(blk_in_line, &rl->free_blocks);
-}
-
-void pblk_gc_should_kick(struct pblk *pblk)
-{
-	struct pblk_rl *rl = &pblk->rl;
-	int ret;
-
-	/* Rates will not change that often - no need to lock update */
-	ret = pblk_rl_update_rates(rl, rl->rb_budget);
-	if (ret == (PBLK_RL_MID | PBLK_RL_LOW))
-		pblk_gc_should_start(pblk);
-	else
-		pblk_gc_should_stop(pblk);
+	pblk_rl_update_rates(rl);
 }
 
 int pblk_rl_high_thrs(struct pblk_rl *rl)
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 9ece409..3a07c5b 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -824,7 +824,6 @@ int pblk_gc_init(struct pblk *pblk);
 void pblk_gc_exit(struct pblk *pblk);
 void pblk_gc_should_start(struct pblk *pblk);
 void pblk_gc_should_stop(struct pblk *pblk);
-void pblk_gc_should_kick(struct pblk *pblk);
 void pblk_gc_kick(struct pblk *pblk);
 void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
 			      int *gc_active);
-- 
2.9.3
