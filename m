Return-Path: <keescook@chromium.org>
Return-Path: <keescook@chromium.org>
Date: Thu, 5 Oct 2017 16:13:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>,
	linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] block/aoe: Convert timers to use timer_setup()
Message-ID: <20171005231354.GA109107@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>
Cc: linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: Rebased to linux-block.git/for-4.15/timer
---
 drivers/block/aoe/aoecmd.c | 6 +++---
 drivers/block/aoe/aoedev.c | 9 +++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index dc43254e05a4..55ab25f79a08 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -744,7 +744,7 @@ count_targets(struct aoedev *d, int *untainted)
 }
 
 static void
-rexmit_timer(ulong vp)
+rexmit_timer(struct timer_list *timer)
 {
 	struct aoedev *d;
 	struct aoetgt *t;
@@ -758,7 +758,7 @@ rexmit_timer(ulong vp)
 	int utgts;	/* number of aoetgt descriptors (not slots) */
 	int since;
 
-	d = (struct aoedev *) vp;
+	d = from_timer(d, timer, timer);
 
 	spin_lock_irqsave(&d->lock, flags);
 
@@ -1429,7 +1429,7 @@ aoecmd_ata_id(struct aoedev *d)
 
 	d->rttavg = RTTAVG_INIT;
 	d->rttdev = RTTDEV_INIT;
-	d->timer.function = rexmit_timer;
+	d->timer.function = (TIMER_FUNC_TYPE)rexmit_timer;
 
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (skb) {
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index b28fefb90391..697f735b07a4 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include "aoe.h"
 
-static void dummy_timer(ulong);
 static void freetgt(struct aoedev *d, struct aoetgt *t);
 static void skbpoolfree(struct aoedev *d);
 
@@ -146,11 +145,11 @@ aoedev_put(struct aoedev *d)
 }
 
 static void
-dummy_timer(ulong vp)
+dummy_timer(struct timer_list *t)
 {
 	struct aoedev *d;
 
-	d = (struct aoedev *)vp;
+	d = from_timer(d, t, timer);
 	if (d->flags & DEVFL_TKILL)
 		return;
 	d->timer.expires = jiffies + HZ;
@@ -466,9 +465,7 @@ aoedev_by_aoeaddr(ulong maj, int min, int do_alloc)
 	INIT_WORK(&d->work, aoecmd_sleepwork);
 	spin_lock_init(&d->lock);
 	skb_queue_head_init(&d->skbpool);
-	init_timer(&d->timer);
-	d->timer.data = (ulong) d;
-	d->timer.function = dummy_timer;
+	timer_setup(&d->timer, dummy_timer, 0);
 	d->timer.expires = jiffies + HZ;
 	add_timer(&d->timer);
 	d->bufpool = NULL;	/* defer to aoeblk_gdalloc */
-- 
2.7.4


-- 
Kees Cook
Pixel Security
