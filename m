Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7E273D6D;
	Mon,  1 Jun 2026 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294397; cv=none; b=P4Au4vRrrVWqyoKShzkkExwUAJuClTF1XEfEI5hag7cOpP0MzLFjMH73dx27FAzOQYEKcvaHzc36IK8KmKt32ks9UU8qgjKoyJy8E1T7Ts3ltmh5eYAdQDSmmaaLliSZye/AxQebN/aFDncGqcTM4+tPSK0F0ha/oKuYEwEGIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294397; c=relaxed/simple;
	bh=LKFx1duQIEQE9J6Tv0ZU9+lgwwPqRkDYeHdTDLwgO2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgUiOQGC7QrkePRyeBfGm607wlBHuhvt7WrfKnIKsgJufpyOkmOmc3HKqb5IuHt//6syMeqUq4llQYA3ldTMaPC60HFkxEywjKKDbfmSrw9zEmdNz5irTwNCNo4bdwU+RhKcxM2ekB0rbQBJvykTlGmZFD9mofhu1Joc2oXFvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6A71F00893;
	Mon,  1 Jun 2026 06:13:14 +0000 (UTC)
From: Yu Kuai <yukuai@fygo.io>
To: tj@kernel.org,
	josef@toxicpanda.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blk-iocost: use irq-safe locking in cgroup handlers
Date: Mon,  1 Jun 2026 14:13:12 +0800
Message-ID: <20260601061312.896801-1-yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioc_timer_fn() acquires ioc->lock from timer softirq context. The
io.weight, io.cost.qos and io.cost.model cgroup handlers can take the
same lock from process context, and the direct handler paths must not do
so with interrupts enabled.

A blkcg policy configuration reproducer with lockdep reproduced the
following report:

  WARNING: inconsistent lock state
  7.1.0-rc2-g1e14adca0199 #1 Not tainted
  --------------------------------
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
  swapper/2/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
  ffff88810f95d0f8 (&ioc->lock){+.?.}-{3:3}, at: ioc_timer_fn+0x3ff/0x3af0
  {SOFTIRQ-ON-W} state was registered at:
    lock_acquire+0xd4/0x290
    _raw_spin_lock+0x3a/0x70
    ioc_weight_write+0x35a/0x420
    cgroup_file_write+0x1c5/0x4b0
    kernfs_fop_write_iter+0x1d7/0x280
    vfs_write+0x580/0x630
    ksys_write+0xec/0x190
    do_syscall_64+0x156/0x490
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Possible unsafe locking scenario:

        CPU0
        ----
    lock(&ioc->lock);
    <Interrupt>
      lock(&ioc->lock);

     *** DEADLOCK ***

  1 lock held by swapper/2/0:
   #0: ffffc90000230d20 ((&ioc->timer)){+.-.}-{0:0}, at:
       call_timer_fn+0xba/0x3a0
  stack backtrace:
  CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 7.1.0-rc2-g1e14adca0199 #1 PREEMPT  ea13f83d4b74a12510d20db4a7d9a0fe8275f05c
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x54/0x70
   print_usage_bug+0x26d/0x280
   mark_lock_irq+0x3ef/0x400
   mark_lock+0x117/0x190
   __lock_acquire+0x592/0x2850
   lock_acquire+0xd4/0x290
   _raw_spin_lock_irq+0x49/0x80
   ioc_timer_fn+0x3ff/0x3af0
   call_timer_fn+0x120/0x3a0
   __run_timer_base+0x3ad/0x490
   run_timer_softirq+0x31/0x60
   handle_softirqs+0x1a0/0x550
   __irq_exit_rcu+0x8c/0x150
   irq_exit_rcu+0xe/0x20
   sysvec_apic_timer_interrupt+0x6e/0x80
   </IRQ>

Use spin_lock_irq() in the affected process-context handlers. The default
io.weight update already holds blkcg->lock with spin_lock_irq(), so the
nested ioc->lock acquisition there is already IRQ-safe and is left as a
plain spin_lock().

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-iocost.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 0cca88a366dc..493cba5523a8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3155,11 +3155,11 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 			goto einval;
 	}
 
-	spin_lock(&iocg->ioc->lock);
+	spin_lock_irq(&iocg->ioc->lock);
 	iocg->cfg_weight = v * WEIGHT_ONE;
 	ioc_now(iocg->ioc, &now);
 	weight_updated(iocg, &now);
-	spin_unlock(&iocg->ioc->lock);
+	spin_unlock_irq(&iocg->ioc->lock);
 
 	blkg_conf_exit(&ctx);
 	return nbytes;
@@ -3180,7 +3180,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (!dname)
 		return 0;
 
-	spin_lock(&ioc->lock);
+	spin_lock_irq(&ioc->lock);
 	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
 		   dname, ioc->enabled, ioc->user_qos_params ? "user" : "auto",
 		   ioc->params.qos[QOS_RPPM] / 10000,
@@ -3193,7 +3193,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 		   ioc->params.qos[QOS_MIN] % 10000 / 100,
 		   ioc->params.qos[QOS_MAX] / 10000,
 		   ioc->params.qos[QOS_MAX] % 10000 / 100);
-	spin_unlock(&ioc->lock);
+	spin_unlock_irq(&ioc->lock);
 	return 0;
 }
 
@@ -3378,14 +3378,14 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
 	if (!dname)
 		return 0;
 
-	spin_lock(&ioc->lock);
+	spin_lock_irq(&ioc->lock);
 	seq_printf(sf, "%s ctrl=%s model=linear "
 		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
 		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
 		   dname, ioc->user_cost_model ? "user" : "auto",
 		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
 		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
-	spin_unlock(&ioc->lock);
+	spin_unlock_irq(&ioc->lock);
 	return 0;
 }
 
-- 
2.51.0

