Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:61807 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbdIULZm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:25:42 -0400
Date: Thu, 21 Sep 2017 14:25:40 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 1/6] lightnvm: pblk: reuse pblk_gc_should_kick
Message-ID: <20170921112539.GA28510@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a trivial change which reuses pblk_gc_should_kick instead of
repeating it again in pblk_rl_free_lines_inc.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-core.c | 1 +
 drivers/lightnvm/pblk-rl.c   | 9 ---------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 64a6a25..a230125 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1478,6 +1478,7 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 	spin_unlock(&l_mg->free_lock);
 
 	pblk_rl_free_lines_inc(&pblk->rl, line);
+	pblk_gc_should_kick(pblk);
 }
 
 static void pblk_line_put_ws(struct work_struct *work)
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 596bdec..e7c162a 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -129,18 +129,9 @@ static int pblk_rl_update_rates(struct pblk_rl *rl, unsigned long max)
 
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
 }
 
 void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line)
-- 
2.5.0
