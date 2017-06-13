Return-Path: <zwisler@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170531214350.31157-2-bart.vanassche@sandisk.com>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com> <20170531214350.31157-2-bart.vanassche@sandisk.com>
From: Ross Zwisler <zwisler@gmail.com>
Date: Tue, 13 Jun 2017 11:54:13 -0600
Message-ID: <CAOxpaSVwuO6kRQN4aNELVTzfWbJORUNZh=E5xBRgvuC0wajptA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] block: Avoid that blk_exit_rl() triggers a use-after-free
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 3:43 PM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> Since the introduction of .init_rq_fn() and .exit_rq_fn() it is
> essential that the memory allocated for struct request_queue
> stays around until all blk_exit_rl() calls have finished. Hence
> make blk_init_rl() take a reference on struct request_queue.
>
> This patch fixes the following crash:
>
> general protection fault: 0000 [#2] SMP
> CPU: 3 PID: 28 Comm: ksoftirqd/3 Tainted: G      D         4.12.0-rc2-dbg+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> task: ffff88013a108040 task.stack: ffffc9000071c000
> RIP: 0010:free_request_size+0x1a/0x30
> RSP: 0018:ffffc9000071fd38 EFLAGS: 00010202
> RAX: 6b6b6b6b6b6b6b6b RBX: ffff880067362a88 RCX: 0000000000000003
> RDX: ffff880067464178 RSI: ffff880067362a88 RDI: ffff880135ea4418
> RBP: ffffc9000071fd40 R08: 0000000000000000 R09: 0000000100180009
> R10: ffffc9000071fd38 R11: ffffffff81110800 R12: ffff88006752d3d8
> R13: ffff88006752d3d8 R14: ffff88013a108040 R15: 000000000000000a
> FS:  0000000000000000(0000) GS:ffff88013fd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa8ec1edb00 CR3: 0000000138ee8000 CR4: 00000000001406e0
> Call Trace:
>  mempool_destroy.part.10+0x21/0x40
>  mempool_destroy+0xe/0x10
>  blk_exit_rl+0x12/0x20
>  blkg_free+0x4d/0xa0
>  __blkg_release_rcu+0x59/0x170
>  rcu_process_callbacks+0x260/0x4e0
>  __do_softirq+0x116/0x250
>  smpboot_thread_fn+0x123/0x1e0
>  kthread+0x109/0x140
>  ret_from_fork+0x31/0x40
>
> Fixes: commit e9c787e65c0c ("scsi: allocate scsi_cmnd structures as part of struct request")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <stable@vger.kernel.org> # v4.11+
> ---
>  block/blk-cgroup.c |  2 +-
>  block/blk-core.c   | 10 ++++++++--
>  block/blk-sysfs.c  |  2 +-
>  block/blk.h        |  2 +-
>  4 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 7c2947128f58..0480892e97e5 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -74,7 +74,7 @@ static void blkg_free(struct blkcg_gq *blkg)
>                         blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>
>         if (blkg->blkcg != &blkcg_root)
> -               blk_exit_rl(&blkg->rl);
> +               blk_exit_rl(blkg->q, &blkg->rl);
>
>         blkg_rwstat_exit(&blkg->stat_ios);
>         blkg_rwstat_exit(&blkg->stat_bytes);
> diff --git a/block/blk-core.c b/block/blk-core.c
> index c7068520794b..a7421b772d0e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -648,13 +648,19 @@ int blk_init_rl(struct request_list *rl, struct request_queue *q,
>         if (!rl->rq_pool)
>                 return -ENOMEM;
>
> +       if (rl != &q->root_rl)
> +               WARN_ON_ONCE(!blk_get_queue(q));
> +
>         return 0;
>  }
>
> -void blk_exit_rl(struct request_list *rl)
> +void blk_exit_rl(struct request_queue *q, struct request_list *rl)
>  {
> -       if (rl->rq_pool)
> +       if (rl->rq_pool) {
>                 mempool_destroy(rl->rq_pool);
> +               if (rl != &q->root_rl)
> +                       blk_put_queue(q);
> +       }
>  }

This commit is causing the following kernel BUG for me when I shut
down my systems:

  BUG: sleeping function called from invalid context at kernel/workqueue.c:2790
  in_atomic(): 1, irqs_disabled(): 0, pid: 41, name: rcuop/3
  1 lock held by rcuop/3/41:
   #0:  (rcu_callback){......}, at: [<ffffffff8111f9a2>]
rcu_nocb_kthread+0x282/0x500
  Preemption disabled at:
  [<ffffffff8111f9b3>] rcu_nocb_kthread+0x293/0x500
  CPU: 2 PID: 41 Comm: rcuop/3 Not tainted 4.12.0-rc5 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.9.3-1.fc25 04/01/2014
  Call Trace:
   dump_stack+0x86/0xcf
   ___might_sleep+0x174/0x260
   __might_sleep+0x4a/0x80
   flush_work+0x7e/0x2e0
   ? blk_throtl_update_limit_valid.isra.14+0x192/0x240
   ? blkg_destroy_all+0x63/0xc0
   ? __cancel_work_timer+0x123/0x1c0
   __cancel_work_timer+0x143/0x1c0
   ? blkcg_exit_queue+0x2d/0x40
   ? _raw_spin_unlock_irq+0x2c/0x60
   cancel_work_sync+0x10/0x20
   blk_throtl_exit+0x25/0x60
   blkcg_exit_queue+0x35/0x40
   blk_release_queue+0x42/0x130
   kobject_put+0xa9/0x190
  kauditd_printk_skb: 60 callbacks suppressed
  audit: type=1131 audit(1497375715.762:263): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
msg='unit=auditd comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success'
  audit: type=1131 audit(1497375715.765:264): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
msg='unit=systemd-tmpfiles-setup comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
  audit: type=1131 audit(1497375715.767:265): pid=1 uid=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
msg='unit=fedora-import-state comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
   blk_exit_rl+0x35/0x40
   blkg_free+0x56/0xb0
   __blkg_release_rcu+0x5e/0x190
   ? blkcg_css_offline+0xa0/0xa0
   rcu_nocb_kthread+0x33d/0x500
   kthread+0x117/0x150
   ? rcu_all_qs+0xe0/0xe0
   ? kthread_create_on_node+0x70/0x70
   ret_from_fork+0x2a/0x40
  BUG: scheduling while atomic: rcuop/3/41/0x00000201
  1 lock held by rcuop/3/41:
   #0:  (rcu_callback){......}, at: [<ffffffff8111f9a2>]
rcu_nocb_kthread+0x282/0x500
  Modules linked in: nd_pmem nd_btt dax_pmem device_dax nfit libnvdimm
  Preemption disabled at:
  [<ffffffff8111f9b3>] rcu_nocb_kthread+0x293/0x500
  CPU: 2 PID: 41 Comm: rcuop/3 Tainted: G        W       4.12.0-rc5 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.9.3-1.fc25 04/01/2014
  Call Trace:
   dump_stack+0x86/0xcf
   ? rcu_nocb_kthread+0x293/0x500
   __schedule_bug+0x88/0xe0
   __schedule+0x77a/0xb10
   ? wait_for_completion+0x10b/0x1a0
   schedule+0x40/0x90
   schedule_timeout+0x2ac/0x510
   ? wait_for_completion+0x122/0x1a0
   ? wait_for_completion+0x122/0x1a0
   ? _raw_spin_unlock_irq+0x2c/0x60
   ? wait_for_completion+0x10b/0x1a0
   ? wait_for_completion+0x10b/0x1a0
   wait_for_completion+0x12a/0x1a0
   ? wait_for_completion+0x12a/0x1a0
   ? wake_up_q+0x80/0x80
   __wait_rcu_gp+0xca/0x100
   synchronize_rcu.part.67+0x41/0x60
   ? rcu_barrier+0x20/0x20
   ? trace_raw_output_rcu_utilization+0x50/0x50
   ? wait_for_completion+0x47/0x1a0
   synchronize_rcu+0x2c/0xa0
   blk_queue_bypass_start+0x7f/0xa0
   blkcg_deactivate_policy+0x110/0x120
   blk_throtl_exit+0x34/0x60
   blkcg_exit_queue+0x35/0x40
   blk_release_queue+0x42/0x130
   kobject_put+0xa9/0x190
   blk_exit_rl+0x35/0x40
   blkg_free+0x56/0xb0
   __blkg_release_rcu+0x5e/0x190
   ? blkcg_css_offline+0xa0/0xa0
   rcu_nocb_kthread+0x33d/0x500
   kthread+0x117/0x150
   ? rcu_all_qs+0xe0/0xe0
   ? kthread_create_on_node+0x70/0x70
   ret_from_fork+0x2a/0x40
  NOHZ: local_softirq_pending 202
  DEBUG_LOCKS_WARN_ON(val > preempt_count())
  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 41 at kernel/sched/core.c:3202
preempt_count_sub+0x5f/0xa0
  Modules linked in: nd_pmem nd_btt dax_pmem device_dax nfit libnvdimm
  CPU: 2 PID: 41 Comm: rcuop/3 Tainted: G        W       4.12.0-rc5 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.9.3-1.fc25 04/01/2014
  task: ffff880210790000 task.stack: ffffc90000dbc000
  RIP: 0010:preempt_count_sub+0x5f/0xa0
  RSP: 0000:ffffc90000dbfe58 EFLAGS: 00010082
  RAX: 000000000000002a RBX: 0000000000000200 RCX: 0000000000000001
  RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8110dad7
  RBP: ffffc90000dbfe58 R08: 0000000000000000 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8111fa08
  R13: 0000000000000026 R14: ffff880210790000 R15: ffff88020880c4c0
  FS:  0000000000000000(0000) GS:ffff880211400000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000055c7110f4148 CR3: 000000020c1bc000 CR4: 00000000000006e0
  Call Trace:
   __local_bh_enable_ip+0x52/0xb0
   rcu_nocb_kthread+0x2fe/0x500
   kthread+0x117/0x150
   ? rcu_all_qs+0xe0/0xe0
   ? kthread_create_on_node+0x70/0x70
   ret_from_fork+0x2a/0x40
  Code: 37 f4 7e 5d c3 e8 52 d2 56 00 85 c0 74 f5 8b 15 b8 2b 51 02 85
d2 75 eb 48 c7 c6 9a f9 ef 81 48 c7 c7 c2 87 ee 81 e8 e8 34 12 00 <0f>
ff 5d c3 84 d2 75 c7 e8 24 d2 56 00 85 c0 74 c7 8b 05 8a 2b
  ---[ end trace f7877221a24ce5d5 ]---

I think essentially the problem is that blk_exit_rl() is called from
atomic context, and the work done by the newly added blk_put_queue()
call can sleep.

This is reproducible 100% of the time by running a single xfstest
(generic/085 is what I've been using) against a pair simulated of PMEM
block devices (without DAX), and by shutting down or rebooting the
system.

Sometimes it is relatively harmless, and you just get a splat during shutdown.
Sometimes the shutdown stops making forward progress and the machine
fails to reboot.

I am able to reproduce this consistently with v4.12-rc5, and reverting
this one commit removes the behavior.

- Ross
