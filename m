Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:57255 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758164AbdJMMrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id l68so21509846wmd.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:22 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 16/58] lightnvm: pblk: avoid deadlock on low LUN config
Date: Fri, 13 Oct 2017 14:46:05 +0200
Message-Id: <20171013124647.32668-17-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

On low LUN configurations, make sure not to send bios that are bigger
than the buffer size.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 drivers/lightnvm/pblk-rl.c   | 6 ++++++
 drivers/lightnvm/pblk.h      | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8344511..eee4eeb 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -46,7 +46,7 @@ static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
 	 * user I/Os. Unless stalled, the rate limiter leaves at least 256KB
 	 * available for user I/O.
 	 */
-	if (unlikely(pblk_get_secs(bio) >= pblk_rl_sysfs_rate_show(&pblk->rl)))
+	if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
 		blk_queue_split(q, &bio);
 
 	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 9565c3b..0896439 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -163,6 +163,11 @@ int pblk_rl_sysfs_rate_show(struct pblk_rl *rl)
 	return rl->rb_user_max;
 }
 
+int pblk_rl_max_io(struct pblk_rl *rl)
+{
+	return rl->rb_max_io;
+}
+
 static void pblk_rl_u_timer(unsigned long data)
 {
 	struct pblk_rl *rl = (struct pblk_rl *)data;
@@ -199,6 +204,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	/* To start with, all buffer is available to user I/O writers */
 	rl->rb_budget = budget;
 	rl->rb_user_max = budget;
+	rl->rb_max_io = budget >> 1;
 	rl->rb_gc_max = 0;
 	rl->rb_state = PBLK_RL_HIGH;
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 3a07c5b..b592e51 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -267,6 +267,7 @@ struct pblk_rl {
 	int rb_gc_max;		/* Max buffer entries available for GC I/O */
 	int rb_gc_rsv;		/* Reserved buffer entries for GC I/O */
 	int rb_state;		/* Rate-limiter current state */
+	int rb_max_io;		/* Maximum size for an I/O giving the config */
 
 	atomic_t rb_user_cnt;	/* User I/O buffer counter */
 	atomic_t rb_gc_cnt;	/* GC I/O buffer counter */
@@ -844,6 +845,7 @@ int pblk_rl_gc_may_insert(struct pblk_rl *rl, int nr_entries);
 void pblk_rl_gc_in(struct pblk_rl *rl, int nr_entries);
 void pblk_rl_out(struct pblk_rl *rl, int nr_user, int nr_gc);
 int pblk_rl_sysfs_rate_show(struct pblk_rl *rl);
+int pblk_rl_max_io(struct pblk_rl *rl);
 void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line *line);
 void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line);
 void pblk_rl_set_space_limit(struct pblk_rl *rl, int entries_left);
-- 
2.9.3
