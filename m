Return-Path: <keescook@chromium.org>
Return-Path: <keescook@chromium.org>
Date: Tue, 24 Oct 2017 08:30:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: Convert timers to use timer_setup()
Message-ID: <20171024153004.GA112705@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/lightnvm/pblk-core.c | 4 ++--
 drivers/lightnvm/pblk-gc.c   | 6 +++---
 drivers/lightnvm/pblk-init.c | 2 +-
 drivers/lightnvm/pblk-rl.c   | 6 +++---
 drivers/lightnvm/pblk.h      | 2 +-
 drivers/lightnvm/rrpc.c      | 6 +++---
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 81501644fb15..8841eb66c902 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -229,9 +229,9 @@ static void pblk_write_kick(struct pblk *pblk)
 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(1000));
 }
 
-void pblk_write_timer_fn(unsigned long data)
+void pblk_write_timer_fn(struct timer_list *t)
 {
-	struct pblk *pblk = (struct pblk *)data;
+	struct pblk *pblk = from_timer(pblk, t, wtimer);
 
 	/* kick the write thread every tick to flush outstanding data */
 	pblk_write_kick(pblk);
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 6090d28f7995..85ff64fe5ba2 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -428,9 +428,9 @@ void pblk_gc_kick(struct pblk *pblk)
 	mod_timer(&gc->gc_timer, jiffies + msecs_to_jiffies(GC_TIME_MSECS));
 }
 
-static void pblk_gc_timer(unsigned long data)
+static void pblk_gc_timer(struct timer_list *t)
 {
-	struct pblk *pblk = (struct pblk *)data;
+	struct pblk *pblk = from_timer(pblk, t, gc.gc_timer);
 
 	pblk_gc_kick(pblk);
 }
@@ -569,7 +569,7 @@ int pblk_gc_init(struct pblk *pblk)
 		goto fail_free_writer_kthread;
 	}
 
-	setup_timer(&gc->gc_timer, pblk_gc_timer, (unsigned long)pblk);
+	timer_setup(&gc->gc_timer, pblk_gc_timer, 0);
 	mod_timer(&gc->gc_timer, jiffies + msecs_to_jiffies(GC_TIME_MSECS));
 
 	gc->gc_active = 0;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 1b0f61233c21..c0ae85b514f5 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -833,7 +833,7 @@ static int pblk_lines_init(struct pblk *pblk)
 
 static int pblk_writer_init(struct pblk *pblk)
 {
-	setup_timer(&pblk->wtimer, pblk_write_timer_fn, (unsigned long)pblk);
+	timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
 
 	pblk->writer_ts = kthread_create(pblk_write_ts, pblk, "pblk-writer-t");
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 2e6a5361baf0..1210deeb6f43 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -178,9 +178,9 @@ int pblk_rl_sysfs_rate_show(struct pblk_rl *rl)
 	return rl->rb_user_max;
 }
 
-static void pblk_rl_u_timer(unsigned long data)
+static void pblk_rl_u_timer(struct timer_list *t)
 {
-	struct pblk_rl *rl = (struct pblk_rl *)data;
+	struct pblk_rl *rl = from_timer(rl, t, u_timer);
 
 	/* Release user I/O state. Protect from GC */
 	smp_store_release(&rl->rb_user_active, 0);
@@ -221,7 +221,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	atomic_set(&rl->rb_gc_cnt, 0);
 	atomic_set(&rl->rb_space, -1);
 
-	setup_timer(&rl->u_timer, pblk_rl_u_timer, (unsigned long)rl);
+	timer_setup(&rl->u_timer, pblk_rl_u_timer, 0);
 
 	rl->rb_user_active = 0;
 	rl->rb_gc_active = 0;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 67e623bd5c2d..e097dea4a1ea 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -789,7 +789,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
  * pblk write thread
  */
 int pblk_write_ts(void *data);
-void pblk_write_timer_fn(unsigned long data);
+void pblk_write_timer_fn(struct timer_list *t);
 void pblk_write_should_kick(struct pblk *pblk);
 
 /*
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 267f01ae87e4..0993c14be860 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -267,9 +267,9 @@ static void rrpc_gc_kick(struct rrpc *rrpc)
 /*
  * timed GC every interval.
  */
-static void rrpc_gc_timer(unsigned long data)
+static void rrpc_gc_timer(struct timer_list *t)
 {
-	struct rrpc *rrpc = (struct rrpc *)data;
+	struct rrpc *rrpc = from_timer(rrpc, t, gc_timer);
 
 	rrpc_gc_kick(rrpc);
 	mod_timer(&rrpc->gc_timer, jiffies + msecs_to_jiffies(10));
@@ -1063,7 +1063,7 @@ static int rrpc_gc_init(struct rrpc *rrpc)
 	if (!rrpc->kgc_wq)
 		return -ENOMEM;
 
-	setup_timer(&rrpc->gc_timer, rrpc_gc_timer, (unsigned long)rrpc);
+	timer_setup(&rrpc->gc_timer, rrpc_gc_timer, 0);
 
 	return 0;
 }
-- 
2.7.4


-- 
Kees Cook
Pixel Security
