Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] block: don't disable interrupts during kmap_atomic()
Date: Fri,  4 May 2018 16:32:45 +0200
Message-Id: <20180504143247.5240-1-bigeasy@linutronix.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

bounce_copy_vec() disables interrupts around kmap_atomic(). This is a
leftover from the old kmap_atomic() implementation which relied on fixed
mapping slots, so the caller had to make sure that the same slot could not
be reused from an interrupting context.

kmap_atomic() was changed to dynamic slots long ago and commit 1ec9c5ddc17a
("include/linux/highmem.h: remove the second argument of k[un]map_atomic()")
removed the slot assignements, but the callers were not checked for now
redundant interrupt disabling.

Remove the conditional interrupt disable.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/bounce.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index dd0b93f2a871..fea9c8146d82 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -63,14 +63,11 @@ __initcall(init_emergency_pool);
  */
 static void bounce_copy_vec(struct bio_vec *to, unsigned char *vfrom)
 {
-	unsigned long flags;
 	unsigned char *vto;
=20
-	local_irq_save(flags);
 	vto =3D kmap_atomic(to->bv_page);
 	memcpy(vto + to->bv_offset, vfrom, to->bv_len);
 	kunmap_atomic(vto);
-	local_irq_restore(flags);
 }
=20
 #else /* CONFIG_HIGHMEM */
--=20
2.17.0
