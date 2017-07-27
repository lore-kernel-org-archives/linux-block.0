Return-Path: <axboe@kernel.dk>
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux block <linux-block@vger.kernel.org>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
Date: Thu, 27 Jul 2017 08:02:51 -0600
MIME-Version: 1.0
In-Reply-To: <87a83qfosu.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/26/2017 11:10 PM, Michael Ellerman wrote:
> Hi Jens,
> 
> I'm seeing the lockdep warning below on shutdown on a Power8 machine
> using IPR.
> 
> If I'm reading it right it looks like the spin_lock() (non-irq) in
> blk_mq_sched_insert_request() is the immediate cause.

All the users of ctx->lock should be from process context.

> Looking at blk_mq_requeue_work() (the caller), it is doing
> spin_lock_irqsave(). So is switching blk_mq_sched_insert_request() to
> spin_lock_irqsave() the right fix?

That's because the requeue lock needs to be IRQ safe. However, the
context allows for just spin_lock_irq() for that lock there, so that
should be fixed up. Not your issue, of course, but we don't need to
save flags there.

> ipr 0001:08:00.0: shutdown
> 
> ================================
> WARNING: inconsistent lock state
> 4.13.0-rc2-gcc6x-gf74c89b #1 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> swapper/28/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
>  (&(&hctx->lock)->rlock){+.?...}, at: [<c0000000005b60f4>] blk_mq_sched_dispatch_requests+0xa4/0x2a0
> {SOFTIRQ-ON-W} state was registered at:
>   lock_acquire+0xec/0x2e0
>   _raw_spin_lock+0x44/0x70
>   blk_mq_sched_insert_request+0x88/0x1f0
>   blk_mq_requeue_work+0x108/0x180
>   process_one_work+0x310/0x800
>   worker_thread+0x88/0x520
>   kthread+0x164/0x1b0
>   ret_from_kernel_thread+0x5c/0x74
> irq event stamp: 3572314
> hardirqs last  enabled at (3572314): [<c000000000b71998>] _raw_spin_unlock_irqrestore+0x58/0xb0
> hardirqs last disabled at (3572313): [<c000000000b716ec>] _raw_spin_lock_irqsave+0x3c/0x90
> softirqs last  enabled at (3572302): [<c0000000000df17c>] irq_enter+0x9c/0xe0
> softirqs last disabled at (3572303): [<c0000000000df2c8>] irq_exit+0x108/0x150
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&(&hctx->lock)->rlock);
>   <Interrupt>
>     lock(&(&hctx->lock)->rlock);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by swapper/28/0:
>  #0:  ((&ipr_cmd->timer)){+.-...}, at: [<c0000000001936f0>] call_timer_fn+0x10/0x4b0
>  #1:  (rcu_read_lock){......}, at: [<c0000000005aca60>] __blk_mq_run_hw_queue+0xa0/0x2c0
> 
> stack backtrace:
> CPU: 28 PID: 0 Comm: swapper/28 Not tainted 4.13.0-rc2-gcc6x-gf74c89b #1
> Call Trace:
> [c000001fffe97550] [c000000000b50818] dump_stack+0xe8/0x160 (unreliable)
> [c000001fffe97590] [c0000000001586d0] print_usage_bug+0x2d0/0x390
> [c000001fffe97640] [c000000000158f34] mark_lock+0x7a4/0x8e0
> [c000001fffe976f0] [c00000000015a000] __lock_acquire+0x6a0/0x1a70
> [c000001fffe97860] [c00000000015befc] lock_acquire+0xec/0x2e0
> [c000001fffe97930] [c000000000b71514] _raw_spin_lock+0x44/0x70
> [c000001fffe97960] [c0000000005b60f4] blk_mq_sched_dispatch_requests+0xa4/0x2a0
> [c000001fffe979c0] [c0000000005acac0] __blk_mq_run_hw_queue+0x100/0x2c0
> [c000001fffe97a00] [c0000000005ad478] __blk_mq_delay_run_hw_queue+0x118/0x130
> [c000001fffe97a40] [c0000000005ad61c] blk_mq_start_hw_queues+0x6c/0xa0
> [c000001fffe97a80] [c000000000797aac] scsi_kick_queue+0x2c/0x60
> [c000001fffe97aa0] [c000000000797cf0] scsi_run_queue+0x210/0x360
> [c000001fffe97b10] [c00000000079b888] scsi_run_host_queues+0x48/0x80
> [c000001fffe97b40] [c0000000007b6090] ipr_ioa_bringdown_done+0x70/0x1e0
> [c000001fffe97bc0] [c0000000007bc860] ipr_reset_ioa_job+0x80/0xf0
> [c000001fffe97bf0] [c0000000007b4d50] ipr_reset_timer_done+0xd0/0x100
> [c000001fffe97c30] [c0000000001937bc] call_timer_fn+0xdc/0x4b0
> [c000001fffe97cf0] [c000000000193d08] expire_timers+0x178/0x330
> [c000001fffe97d60] [c0000000001940c8] run_timer_softirq+0xb8/0x120
> [c000001fffe97de0] [c000000000b726a8] __do_softirq+0x168/0x6d8
> [c000001fffe97ef0] [c0000000000df2c8] irq_exit+0x108/0x150
> [c000001fffe97f10] [c000000000017bf4] __do_irq+0x2a4/0x4a0
> [c000001fffe97f90] [c00000000002da50] call_do_irq+0x14/0x24
> [c0000007fad93aa0] [c000000000017e8c] do_IRQ+0x9c/0x140
> [c0000007fad93af0] [c000000000008b98] hardware_interrupt_common+0x138/0x140
> --- interrupt: 501 at .L1.42+0x0/0x4
>     LR = arch_local_irq_restore.part.4+0x84/0xb0
> [c0000007fad93de0] [c0000007ffc1f7d8] 0xc0000007ffc1f7d8 (unreliable)
> [c0000007fad93e00] [c000000000988d3c] cpuidle_enter_state+0x1bc/0x530
> [c0000007fad93e60] [c0000000001457cc] call_cpuidle+0x4c/0x90
> [c0000007fad93e80] [c000000000145b28] do_idle+0x208/0x2f0
> [c0000007fad93ef0] [c000000000145f8c] cpu_startup_entry+0x3c/0x50
> [c0000007fad93f20] [c000000000042bc0] start_secondary+0x3b0/0x4b0
> [c0000007fad93f90] [c00000000000ac6c] start_secondary_prolog+0x10/0x14

The bug looks like SCSI running the queue inline from IRQ
context, that's not a good idea. Can you confirm the below works for
you?


diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f6097b89d5d3..78740ebf966c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -497,7 +497,7 @@ static void scsi_run_queue(struct request_queue *q)
 		scsi_starved_list_run(sdev->host);
 
 	if (q->mq_ops)
-		blk_mq_run_hw_queues(q, false);
+		blk_mq_run_hw_queues(q, true);
 	else
 		blk_run_queue(q);
 }

-- 
Jens Axboe


-- 
Jens Axboe
