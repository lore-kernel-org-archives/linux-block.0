Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35653 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753366AbdIFKww (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:52 -0400
Received: by mail-wm0-f41.google.com with SMTP id f199so7945594wme.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:51 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 15/18] lightnvm: pblk: avoid deadlock on low LUN config
Date: Wed,  6 Sep 2017 12:51:08 +0200
Message-Id: <1504695071-25928-16-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On low LUN configurations, make sure not to send bios that are bigger
than the buffer size.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 drivers/lightnvm/pblk-rl.c   | 6 ++++++
 drivers/lightnvm/pblk.h      | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8459434edd89..12c05aebac16 100644
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
index 2e6a5361baf0..596bdec433c3 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -178,6 +178,11 @@ int pblk_rl_sysfs_rate_show(struct pblk_rl *rl)
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
@@ -214,6 +219,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	/* To start with, all buffer is available to user I/O writers */
 	rl->rb_budget = budget;
 	rl->rb_user_max = budget;
+	rl->rb_max_io = budget >> 1;
 	rl->rb_gc_max = 0;
 	rl->rb_state = PBLK_RL_HIGH;
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 2304a4891f20..2ae9d94e9852 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -273,6 +273,7 @@ struct pblk_rl {
 	int rb_gc_max;		/* Max buffer entries available for GC I/O */
 	int rb_gc_rsv;		/* Reserved buffer entries for GC I/O */
 	int rb_state;		/* Rate-limiter current state */
+	int rb_max_io;		/* Maximum size for an I/O giving the config */
 
 	atomic_t rb_user_cnt;	/* User I/O buffer counter */
 	atomic_t rb_gc_cnt;	/* GC I/O buffer counter */
@@ -846,6 +847,7 @@ int pblk_rl_gc_may_insert(struct pblk_rl *rl, int nr_entries);
 void pblk_rl_gc_in(struct pblk_rl *rl, int nr_entries);
 void pblk_rl_out(struct pblk_rl *rl, int nr_user, int nr_gc);
 int pblk_rl_sysfs_rate_show(struct pblk_rl *rl);
+int pblk_rl_max_io(struct pblk_rl *rl);
 void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line *line);
 void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line);
 void pblk_rl_set_space_limit(struct pblk_rl *rl, int entries_left);
-- 
2.7.4
