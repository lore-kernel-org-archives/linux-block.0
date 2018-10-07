Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Hard lockup in blk_mq_free_request() / wbt_done() / wake_up_all()
To: Chris Boot <bootc@boo.tc>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Josef Bacik <jbacik@fb.com>
References: <9788e0e6-a448-bf85-1f41-88f42dc0071d@boo.tc>
 <ac2c7156-f405-4047-564d-816159d5968b@kernel.dk>
 <7080a91c-8d9a-6305-2b67-dc27a374327a@boo.tc>
 <d8ba8949-259a-c0c0-d476-710bcf69c266@kernel.dk>
 <9c444ab8-2e50-c42a-dae1-86954358218e@boo.tc>
 <7dbe184d-5660-7b64-8027-bf4f82625ff2@I-love.SAKURA.ne.jp>
 <296ff5ef-6d50-d895-2ba2-5c824e96c44b@boo.tc>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7f79b5b8-fb3e-46d6-69a8-8e137139d24b@i-love.sakura.ne.jp>
Date: Sun, 7 Oct 2018 09:03:17 +0900
MIME-Version: 1.0
In-Reply-To: <296ff5ef-6d50-d895-2ba2-5c824e96c44b@boo.tc>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Adding Josef.

On 2018/10/06 2:05, Chris Boot wrote:
> I upgraded the kernel on my affected system to a 4.18.6 kernel (Debian's
> 4.18.6-1~bpo9+1 in stretch-backports) and ran my test suite again. I'm
> sorry to report that the issue occurred once more.
> 
> Logs below, it's all I managed to get out of it before my session locked up.
> 
> [Oct 5 17:56] INFO: rcu_sched self-detected stall on CPU
> [  +0.003914] INFO: rcu_sched detected stalls on CPUs/tasks:
> [  +0.001271] 	82-....: (1 GPs behind) idle=47a/0/3 softirq=60148/60149
> fqs=2234
> [  +0.012840] 	
> [  +0.000007] 	82-....: (1 GPs behind) idle=47a/0/3 softirq=60148/60149
> fqs=2235
> [  +0.000002]  (t=5255 jiffies g=82048 c=82047 q=35803)
> [  +0.008936] 	
> [  +0.000003] NMI backtrace for cpu 82
> [  +0.000005] (detected by 87, t=5257 jiffies, g=82048, c=82047, q=35803)
> [  +0.001598] CPU: 82 PID: 0 Comm: swapper/82 Not tainted
> 4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
> [  +0.000001] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
> 3.0a 05/30/2017
> [  +0.000001] Call Trace:
> [  +0.000004]  <IRQ>
> [  +0.000011]  dump_stack+0x5c/0x7b
> [  +0.000005]  nmi_cpu_backtrace+0x89/0x90
> [  +0.000007]  ? lapic_can_unplug_cpu+0xa0/0xa0
> [  +0.000002]  nmi_trigger_cpumask_backtrace+0xf5/0x130
> [  +0.000007]  rcu_dump_cpu_stacks+0x9b/0xcb
> [  +0.000003]  rcu_check_callbacks+0x79a/0x8e0
> [  +0.000007]  ? sched_clock_cpu+0xc/0xa0
> [  +0.000005]  ? tick_sched_do_timer+0x60/0x60
> [  +0.000005]  update_process_times+0x28/0x50
> [  +0.000003]  tick_sched_handle+0x22/0x60
> [  +0.000002]  tick_sched_timer+0x37/0x70
> [  +0.000002]  __hrtimer_run_queues+0xfc/0x270
> [  +0.000003]  hrtimer_interrupt+0x101/0x240
> [  +0.000004]  smp_apic_timer_interrupt+0x6a/0x130
> [  +0.000002]  apic_timer_interrupt+0xf/0x20
> [  +0.000006] RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
> [  +0.000001] Code: 8b 00 a8 08 74 0b 65 81 25 d8 6b 11 48 ff ff ff 7f
> 44 89 e0 5b 5d 41 5c c3 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 48 89 f7 57
> 9d <0f> 1f 44 00 00 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 c6 07
> [  +0.000030] RSP: 0000:ffff8bfdffc83de8 EFLAGS: 00000202 ORIG_RAX:
> ffffffffffffff13
> [  +0.000002] RAX: 00000000ff72b790 RBX: ffff8bedf5807768 RCX:
> dead000000000200
> [  +0.000001] RDX: ffffa8cc4fa87410 RSI: 0000000000000202 RDI:
> 0000000000000202
> [  +0.000001] RBP: 00000000ff72b790 R08: ffff8bedf5807770 R09:
> 000003fffff00000
> [  +0.000001] R10: 0000000000000052 R11: 0000000000000001 R12:
> 0000000000000202
> [  +0.000001] R13: 0000000000000003 R14: 0000000000000000 R15:
> 0000000000000000
> [  +0.000001]  ? apic_timer_interrupt+0xa/0x20
> [  +0.000006]  __wake_up_common_lock+0x89/0xc0
> [  +0.000007]  rwb_wake_all+0x30/0x40
> [  +0.000003]  scale_up.part.25+0x24/0x40
> [  +0.000002]  wb_timer_fn+0x295/0x430
> [  +0.000007]  ? blk_mq_tag_update_depth+0x110/0x110
> [  +0.000001]  call_timer_fn+0x2b/0x120
> [  +0.000003]  run_timer_softirq+0x1d3/0x410
> [  +0.000002]  ? enqueue_hrtimer+0x3a/0x90
> [  +0.000002]  ? __hrtimer_run_queues+0x12c/0x270
> [  +0.000002]  __do_softirq+0x10d/0x2a6
> [  +0.000006]  irq_exit+0xb6/0xc0
> [  +0.000003]  smp_apic_timer_interrupt+0x74/0x130
> [  +0.000001]  apic_timer_interrupt+0xf/0x20
> [  +0.000001]  </IRQ>
> [  +0.000008] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
> [  +0.000001] Code: c8 28 48 e8 bb b9 b2 ff 48 89 04 24 0f 1f 44 00 00
> 31 ff e8 4b c4 b2 ff 80 7c 24 0f 00 0f 85 b6 01 00 00 fb 66 0f 1f 44 00
> 00 <48> 8b 0c 24 48 ba cf f7 53 e3 a5 9b c4 20 4c 29 f9 48 89 c8 48 c1
> [  +0.000028] RSP: 0000:ffffa8cc4c7cbe78 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffff13
> [  +0.000002] RAX: ffff8bfdffca1b80 RBX: 0000000000000001 RCX:
> 000000000000001f
> [  +0.000001] RDX: 00000237c552d9f0 RSI: 0000000040000219 RDI:
> 0000000000000000
> [  +0.000000] RBP: ffff8bfdffcaaf78 R08: 00000000ffffffff R09:
> 0000000000000008
> [  +0.000001] R10: 00000000000000a9 R11: 00000000000000c2 R12:
> ffffffffb88b3a78
> [  +0.000001] R13: 0000000000000001 R14: 0000000000000001 R15:
> 00000237c55130a6
> [  +0.000004]  ? cpuidle_enter_state+0x95/0x2b0
> [  +0.000004]  do_idle+0x204/0x270
> [  +0.000003]  cpu_startup_entry+0x6f/0x80
> [  +0.000002]  start_secondary+0x1a4/0x1f0
> [  +0.000005]  secondary_startup_64+0xa5/0xb0

This trace contains rwb_wake_all() from scale_up(), which was removed by
commit a79050434b45959f ("blk-rq-qos: refactor out common elements of blk-wbt").

Josef, what is the reason you removed rwb_wake_all() from scale_up() (and
you added rwb_wake_all() to scale_down()) ?
