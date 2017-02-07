Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] bfq-mq: cause deadlock by executing exit_icq body immediately
Date: Tue,  7 Feb 2017 18:33:46 +0100
Message-Id: <20170207173346.4789-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
this patch is meant to show that, if the  body of the hook exit_icq is executed
from inside that hook, and not as deferred work, then a circular deadlock
occurs.

It happens if, on a CPU
- the body of icq_exit takes the scheduler lock,
- it does so from inside the exit_icq hook, which is invoked with the queue
  lock held

while, on another CPU
- bfq_bio_merge, after taking the scheduler lock, invokes bfq_bic_lookup,
  which, in its turn, takes the queue lock. bfq_bic_lookup needs to take such a
  lock, because it invokes ioc_lookup_icq.

For more details, here is a lockdep report, right before the deadlock did occur.

[   44.059877] ======================================================
[   44.124922] [ INFO: possible circular locking dependency detected ]
[   44.125795] 4.10.0-rc5-bfq-mq+ #38 Not tainted
[   44.126414] -------------------------------------------------------
[   44.127291] sync/2043 is trying to acquire lock:
[   44.128918]  (&(&bfqd->lock)->rlock){-.-...}, at: [<ffffffff90484195>] bfq_exit_icq_bfqq+0x55/0x140
[   44.134052]
[   44.134052] but task is already holding lock:
[   44.134868]  (&(&q->__queue_lock)->rlock){-.....}, at: [<ffffffff9044738e>] put_io_context_active+0x6e/0xc0
[   44.136292]
[   44.136292] which lock already depends on the new lock.
[   44.136292]
[   44.137411]
[   44.137411] the existing dependency chain (in reverse order) is:
[   44.139936]
[   44.139936] -> #1 (&(&q->__queue_lock)->rlock){-.....}:
[   44.141512]
[   44.141517] [<ffffffff900ee6bb>] lock_acquire+0x11b/0x220
[   44.142569]
[   44.142578] [<ffffffff90943e66>] _raw_spin_lock_irqsave+0x56/0x90
[   44.146365]
[   44.146371] [<ffffffff904822f5>] bfq_bic_lookup.isra.112+0x25/0x60
[   44.147523]
[   44.147525] [<ffffffff9048245d>] bfq_request_merge+0x3d/0xe0
[   44.149738]
[   44.149742] [<ffffffff90439aef>] elv_merge+0xcf/0xe0
[   44.150726]
[   44.150728] [<ffffffff90453c46>] blk_mq_sched_try_merge+0x36/0x150
[   44.151878]
[   44.151881] [<ffffffff9047fb6a>] bfq_bio_merge+0x5a/0xa0
[   44.153913]
[   44.153916] [<ffffffff90454500>] __blk_mq_sched_bio_merge+0x60/0x70
[   44.155089]
[   44.155091] [<ffffffff9044e6c7>] blk_sq_make_request+0x277/0xa90
[   44.157455]
[   44.157458] [<ffffffff90440846>] generic_make_request+0xf6/0x2b0
[   44.158597]
[   44.158599] [<ffffffff90440a73>] submit_bio+0x73/0x150
[   44.160537]
[   44.160541] [<ffffffff90366e0b>] ext4_mpage_readpages+0x48b/0x950
[   44.162961]
[   44.162971] [<ffffffff90313236>] ext4_readpages+0x36/0x40
[   44.164037]
[   44.164040] [<ffffffff901eca4e>] __do_page_cache_readahead+0x2ae/0x3a0
[   44.165224]
[   44.165227] [<ffffffff901ecc4e>] ondemand_readahead+0x10e/0x4b0
[   44.166334]
[   44.166336] [<ffffffff901ed1a1>] page_cache_sync_readahead+0x31/0x50
[   44.167502]
[   44.167503] [<ffffffff901dcaed>] generic_file_read_iter+0x68d/0x8d0
[   44.168661]
[   44.168663] [<ffffffff9030e6c7>] ext4_file_read_iter+0x37/0xc0
[   44.169760]
[   44.169764] [<ffffffff9026e7c3>] __vfs_read+0xe3/0x150
[   44.171987]
[   44.171990] [<ffffffff9026ee58>] vfs_read+0xa8/0x170
[   44.178999]
[   44.179005] [<ffffffff902761e8>] prepare_binprm+0x118/0x200
[   44.180080]
[   44.180083] [<ffffffff90277bcb>] do_execveat_common.isra.39+0x56b/0xa00
[   44.184409]
[   44.184414] [<ffffffff902782fa>] SyS_execve+0x3a/0x50
[   44.185398]
[   44.185401] [<ffffffff90003e49>] do_syscall_64+0x69/0x160
[   44.187349]
[   44.187353] [<ffffffff9094408d>] return_from_SYSCALL_64+0x0/0x7a
[   44.188475]
[   44.188475] -> #0 (&(&bfqd->lock)->rlock){-.-...}:
[   44.199960]
[   44.199966] [<ffffffff900edd24>] __lock_acquire+0x15e4/0x1890
[   44.201056]
[   44.201058] [<ffffffff900ee6bb>] lock_acquire+0x11b/0x220
[   44.202099]
[   44.202101] [<ffffffff909434da>] _raw_spin_lock_irq+0x4a/0x80
[   44.203197]
[   44.203200] [<ffffffff90484195>] bfq_exit_icq_bfqq+0x55/0x140
[   44.204848]
[   44.204851] [<ffffffff9048429c>] bfq_exit_icq+0x1c/0x30
[   44.205863]
[   44.205866] [<ffffffff90446e68>] ioc_exit_icq+0x38/0x50
[   44.206881]
[   44.206883] [<ffffffff9044739a>] put_io_context_active+0x7a/0xc0
[   44.215156] sh (2042): drop_caches: 3
[   44.216738]
[   44.216742] [<ffffffff90447428>] exit_io_context+0x48/0x50
[   44.217497]
[   44.217500] [<ffffffff90095727>] do_exit+0x787/0xc50
[   44.218207]
[   44.218209] [<ffffffff90095c80>] do_group_exit+0x50/0xd0
[   44.218969]
[   44.218970] [<ffffffff90095d14>] SyS_exit_group+0x14/0x20
[   44.219716]
[   44.219718] [<ffffffff90943fc5>] entry_SYSCALL_64_fastpath+0x23/0xc6
[   44.220550]
[   44.220550] other info that might help us debug this:
[   44.220550]
[   44.223477]  Possible unsafe locking scenario:
[   44.223477]
[   44.224281]        CPU0                    CPU1
[   44.224903]        ----                    ----
[   44.225523]   lock(&(&q->__queue_lock)->rlock);
[   44.226144]                                lock(&(&bfqd->lock)->rlock);
[   44.227051]                                lock(&(&q->__queue_lock)->rlock);
[   44.228019]   lock(&(&bfqd->lock)->rlock);
[   44.228643]
[   44.228643]  *** DEADLOCK ***
[   44.228643]
[   44.230136] 2 locks held by sync/2043:
[   44.230591]  #0:  (&(&ioc->lock)->rlock/1){......}, at: [<ffffffff90447358>] put_io_context_active+0x38/0xc0
[   44.231553]  #1:  (&(&q->__queue_lock)->rlock){-.....}, at: [<ffffffff9044738e>] put_io_context_active+0x6e/0xc0
[   44.232542]
[   44.232542] stack backtrace:
[   44.232974] CPU: 1 PID: 2043 Comm: sync Not tainted 4.10.0-rc5-bfq-mq+ #38
[   44.238224] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[   44.239364] Call Trace:
[   44.239717]  dump_stack+0x85/0xc2
[   44.240186]  print_circular_bug+0x1e3/0x250
[   44.240773]  __lock_acquire+0x15e4/0x1890
[   44.241350]  lock_acquire+0x11b/0x220
[   44.241867]  ? bfq_exit_icq_bfqq+0x55/0x140
[   44.242455]  _raw_spin_lock_irq+0x4a/0x80
[   44.243018]  ? bfq_exit_icq_bfqq+0x55/0x140
[   44.243629]  bfq_exit_icq_bfqq+0x55/0x140
[   44.244192]  bfq_exit_icq+0x1c/0x30
[   44.244713]  ioc_exit_icq+0x38/0x50
[   44.246518]  put_io_context_active+0x7a/0xc0
[   44.247116]  exit_io_context+0x48/0x50
[   44.247647]  do_exit+0x787/0xc50
[   44.248103]  do_group_exit+0x50/0xd0
[   44.249055]  SyS_exit_group+0x14/0x20
[   44.249568]  entry_SYSCALL_64_fastpath+0x23/0xc6
[   44.250208] RIP: 0033:0x7fd70b22ab98
[   44.250704] RSP: 002b:00007ffc9cc43878 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   44.251745] RAX: ffffffffffffffda RBX: 00007fd70b523620 RCX: 00007fd70b22ab98
[   44.252730] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   44.253713] RBP: 00007fd70b523620 R08: 00000000000000e7 R09: ffffffffffffff98
[   44.254690] R10: 00007ffc9cc437c8 R11: 0000000000000246 R12: 0000000000000000
[   44.255674] R13: 00007fd70b523c40 R14: 0000000000000000 R15: 0000000000000000

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-mq-iosched.c | 34 +++-------------------------------
 block/bfq-mq.h         |  3 ---
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
index 05a12b6..6e79bb8 100644
--- a/block/bfq-mq-iosched.c
+++ b/block/bfq-mq-iosched.c
@@ -4001,28 +4001,13 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
 	}
 }
 
-static void bfq_exit_icq_body(struct work_struct *work)
-{
-	struct bfq_io_cq *bic =
-		container_of(work, struct bfq_io_cq, exit_icq_work);
-
-	bfq_exit_icq_bfqq(bic, true);
-	bfq_exit_icq_bfqq(bic, false);
-}
-
-static void bfq_init_icq(struct io_cq *icq)
-{
-	struct bfq_io_cq *bic = icq_to_bic(icq);
-
-	INIT_WORK(&bic->exit_icq_work, bfq_exit_icq_body);
-}
-
 static void bfq_exit_icq(struct io_cq *icq)
 {
 	struct bfq_io_cq *bic = icq_to_bic(icq);
 
 	BUG_ON(!bic);
-	kblockd_schedule_work(&bic->exit_icq_work);
+	bfq_exit_icq_bfqq(bic, true);
+	bfq_exit_icq_bfqq(bic, false);
 }
 
 /*
@@ -4934,21 +4919,9 @@ static void bfq_exit_queue(struct elevator_queue *e)
 	BUG_ON(bfqd->in_service_queue);
 	BUG_ON(!list_empty(&bfqd->active_list));
 
-	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list) {
-		if (bfqq->bic) /* bfqqs without bic are handled below */
-			cancel_work_sync(&bfqq->bic->exit_icq_work);
-	}
-
 	spin_lock_irq(&bfqd->lock);
-	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list) {
+	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
-		/*
-		 * Make sure that deferred exit_icq_work completes
-		 * without errors for bfq_queues without bic
-		 */
-		if (!bfqq->bic)
-			bfqq->bfqd = NULL;
-	}
 	spin_unlock_irq(&bfqd->lock);
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
@@ -5384,7 +5357,6 @@ static struct elevator_type iosched_bfq_mq = {
 	.ops.mq = {
 		.get_rq_priv		= bfq_get_rq_private,
 		.put_rq_priv		= bfq_put_rq_private,
-		.init_icq		= bfq_init_icq,
 		.exit_icq		= bfq_exit_icq,
 		.insert_requests	= bfq_insert_requests,
 		.dispatch_request	= bfq_dispatch_request,
diff --git a/block/bfq-mq.h b/block/bfq-mq.h
index 6e1c0d8..41b9d33 100644
--- a/block/bfq-mq.h
+++ b/block/bfq-mq.h
@@ -345,9 +345,6 @@ struct bfq_io_cq {
 	uint64_t blkcg_serial_nr; /* the current blkcg serial */
 #endif
 
-	/* delayed work to exec the body of the the exit_icq handler */
-	struct work_struct exit_icq_work;
-
 	/*
 	 * Snapshot of the idle window before merging; taken to
 	 * remember this value while the queue is merged, so as to be
-- 
2.10.0
