Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79232352038;
	Mon,  1 Jun 2026 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294508; cv=none; b=iuxeUu8RIfT7m0CfukdauHuvplSg7DZjyue0546IoAVMhGv0EAKNR82K6T3mCWUDlpaw9I1oKMNYi9vJ/it570m9ux/S9lx4Cyslgcoctx8qsThP5uvMW/JjJZ94/IzWLVKrXbZC56zawrU/tv+tcApNJpuZI3aDGWj4KIjHHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294508; c=relaxed/simple;
	bh=E3aFpFNnCDGr2Jp8lUAFmNesLZn3mKTThVVZck/Kohk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3jruwnC0UgneuvgRYPiuJ/1vxBybd66/fli4KeMQt9nD0986MKAUvMgipplVnKc9jx+teevbqoRAST3BzsIg6QrHzlf6dUIQAfRiSO8XjQyF+aro7C0bcYycrrBQEc3K2oFU/Fa6kvAwR8x4pFlHdpauF5YriwyccW1XA5YAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572551F0089D;
	Mon,  1 Jun 2026 06:15:04 +0000 (UTC)
From: Yu Kuai <yukuai@fygo.io>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yukuai@fygo.io,
	linux-kernel@vger.kernel.org,
	jack@suse.cz
Subject: [PATCH] block, bfq: release cgroup stats with bfq_group
Date: Mon,  1 Jun 2026 14:15:02 +0800
Message-ID: <20260601061502.899552-1-yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BFQ cgroup stats contain percpu counters embedded in struct bfq_group,
but the old free path destroys them from bfq_pd_free(), which is tied
to blkg policy-data teardown.

That is not the same lifetime as struct bfq_group. BFQ pins bfq_group
while bfq_queue entities refer to it, so bfq_pd_free() can drop the
policy-data reference while other bfq_group references still exist. The
following blkcg change also defers policy-data release through RCU and
leaves BFQ to run the final bfqg_put() from an RCU callback. For that
conversion, stats teardown must belong to the last bfq_group put, not to
policy-data teardown.

Move stats teardown to bfqg_put() so the embedded counters are destroyed
exactly when the last bfq_group reference is released, before kfree(bfqg).

Without this preparatory change, the RCU-delayed policy-data free
conversion reproduced the following KASAN report:

  BUG: KASAN: slab-use-after-free in percpu_counter_destroy_many+0xf1/0x2e0
  Write of size 8 at addr ffff88811d9409e0 by task test_blkcg/535

  CPU: 0 UID: 0 PID: 535 Comm: test_blkcg Not tainted 7.1.0-rc2-g1e14adca0199 #1 PREEMPT  ea13f83d4b74a12510d20db4a7d9a0fe8275f05c
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x54/0x70
   print_address_description+0x77/0x200
   ? percpu_counter_destroy_many+0xf1/0x2e0
   print_report+0x64/0x70
   kasan_report+0x118/0x150
   ? percpu_counter_destroy_many+0xf1/0x2e0
   percpu_counter_destroy_many+0xf1/0x2e0
   __mmdrop+0x1d8/0x350
   finish_task_switch+0x3f5/0x570
   __schedule+0xe8e/0x18a0
   schedule+0xfe/0x1c0
   schedule_timeout+0x7f/0x1d0
   __wait_for_common+0x26c/0x3f0
   wait_for_completion_state+0x21/0x40
   call_usermodehelper_exec+0x271/0x2c0
   __request_module+0x296/0x410
   elv_iosched_store+0x1bc/0x2c0
   queue_attr_store+0x152/0x1c0
   kernfs_fop_write_iter+0x1d7/0x280
   vfs_write+0x580/0x630
   ksys_write+0xec/0x190
   do_syscall_64+0x156/0x490
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 535:
   kasan_save_track+0x3e/0x80
   __kasan_kmalloc+0x72/0x90
   bfq_pd_alloc+0x60/0x100 [bfq]
   blkg_create+0x3bb/0xbe0
   blkg_lookup_create+0x3a2/0x460
   blkg_conf_start+0x24a/0x2d0
   bfq_io_set_weight+0x17f/0x430 [bfq]
   cgroup_file_write+0x1c5/0x4b0
   kernfs_fop_write_iter+0x1d7/0x280
   vfs_write+0x580/0x630
   ksys_write+0xec/0x190
   do_syscall_64+0x156/0x490
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Freed by task 0:
   kasan_save_track+0x3e/0x80
   kasan_save_free_info+0x46/0x50
   __kasan_slab_free+0x3a/0x60
   kfree+0x14e/0x4f0
   rcu_core+0x6f3/0xcd0
   handle_softirqs+0x1a0/0x550
   __irq_exit_rcu+0x8c/0x150
   irq_exit_rcu+0xe/0x20
   sysvec_apic_timer_interrupt+0x6e/0x80
   asm_sysvec_apic_timer_interrupt+0x1a/0x20

  Last potentially related work creation:
   kasan_save_stack+0x3e/0x60
   kasan_record_aux_stack+0x99/0xb0
   call_rcu+0x55/0x5c0
   blkg_free_workfn+0x130/0x220
   process_scheduled_works+0x655/0xb60
   worker_thread+0x446/0x600
   kthread+0x1f4/0x230
   ret_from_fork+0x259/0x420
   ret_from_fork_asm+0x1a/0x30

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bfq-cgroup.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index ac83b0668764..37ab70930c8d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -300,6 +300,25 @@ static struct bfq_group *bfqg_parent(struct bfq_group *bfqg)
 	return pblkg ? blkg_to_bfqg(pblkg) : NULL;
 }
 
+static void bfqg_stats_exit(struct bfqg_stats *stats)
+{
+	blkg_rwstat_exit(&stats->bytes);
+	blkg_rwstat_exit(&stats->ios);
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
+	blkg_rwstat_exit(&stats->merged);
+	blkg_rwstat_exit(&stats->service_time);
+	blkg_rwstat_exit(&stats->wait_time);
+	blkg_rwstat_exit(&stats->queued);
+	bfq_stat_exit(&stats->time);
+	bfq_stat_exit(&stats->avg_queue_size_sum);
+	bfq_stat_exit(&stats->avg_queue_size_samples);
+	bfq_stat_exit(&stats->dequeue);
+	bfq_stat_exit(&stats->group_wait_time);
+	bfq_stat_exit(&stats->idle_time);
+	bfq_stat_exit(&stats->empty_time);
+#endif
+}
+
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *group_entity = bfqq->entity.parent;
@@ -321,8 +340,10 @@ static void bfqg_get(struct bfq_group *bfqg)
 
 static void bfqg_put(struct bfq_group *bfqg)
 {
-	if (refcount_dec_and_test(&bfqg->ref))
+	if (refcount_dec_and_test(&bfqg->ref)) {
+		bfqg_stats_exit(&bfqg->stats);
 		kfree(bfqg);
+	}
 }
 
 static void bfqg_and_blkg_get(struct bfq_group *bfqg)
@@ -433,25 +454,6 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
 	entity->sched_data = &bfqg->sched_data;
 }
 
-static void bfqg_stats_exit(struct bfqg_stats *stats)
-{
-	blkg_rwstat_exit(&stats->bytes);
-	blkg_rwstat_exit(&stats->ios);
-#ifdef CONFIG_BFQ_CGROUP_DEBUG
-	blkg_rwstat_exit(&stats->merged);
-	blkg_rwstat_exit(&stats->service_time);
-	blkg_rwstat_exit(&stats->wait_time);
-	blkg_rwstat_exit(&stats->queued);
-	bfq_stat_exit(&stats->time);
-	bfq_stat_exit(&stats->avg_queue_size_sum);
-	bfq_stat_exit(&stats->avg_queue_size_samples);
-	bfq_stat_exit(&stats->dequeue);
-	bfq_stat_exit(&stats->group_wait_time);
-	bfq_stat_exit(&stats->idle_time);
-	bfq_stat_exit(&stats->empty_time);
-#endif
-}
-
 static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
 {
 	if (blkg_rwstat_init(&stats->bytes, gfp) ||
@@ -552,7 +554,6 @@ static void bfq_pd_free(struct blkg_policy_data *pd)
 {
 	struct bfq_group *bfqg = pd_to_bfqg(pd);
 
-	bfqg_stats_exit(&bfqg->stats);
 	bfqg_put(bfqg);
 }
 
-- 
2.51.0

