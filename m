Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbeC3Jcd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Mar 2018 05:32:33 -0400
Date: Fri, 30 Mar 2018 05:32:33 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Message-ID: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
In-Reply-To: <1912441239.17517737.1522396297270.JavaMail.zimbra@redhat.com>
Subject: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello
I got this kernel BUG on 4.16.0-rc7, here is the reproducer and log, let me know if you need more info, thanks.

Reproducer:
1. setup target
#nvmetcli restore /etc/rdma.json
2. connect target on host
#nvme connect-all -t rdma -a $IP -s 4420during my NVMeoF RDMA testing
3. do fio background on host
#fio -filename=/dev/nvme0n1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -bs_unaligned -runtime=180 -size=-group_reporting -name=mytest -numjobs=60 &
4. offline cpu on host
#echo 0 > /sys/devices/system/cpu/cpu1/online
#echo 0 > /sys/devices/system/cpu/cpu2/online
#echo 0 > /sys/devices/system/cpu/cpu3/online
5. clear target
#nvmetcli clear
6. restore target
#nvmetcli restore /etc/rdma.json
7. check console log on host


[  167.054583] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.0.90:4420
[  167.108410] nvme nvme0: creating 40 I/O queues.
[  167.421694] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.90:4420
[  256.496376] smpboot: CPU 1 is now offline
[  256.525102] IRQ 37: no longer affine to CPU2
[  256.529872] IRQ 54: no longer affine to CPU2
[  256.534637] IRQ 70: no longer affine to CPU2
[  256.539405] IRQ 98: no longer affine to CPU2
[  256.544175] IRQ 140: no longer affine to CPU2
[  256.549036] IRQ 141: no longer affine to CPU2
[  256.553905] IRQ 166: no longer affine to CPU2
[  256.561042] smpboot: CPU 2 is now offline
[  256.796920] smpboot: CPU 3 is now offline
[  258.649993] print_req_error: operation not supported error, dev nvme0n1, sector 60151856
[  258.650031] print_req_error: operation not supported error, dev nvme0n1, sector 512220944
[  258.650040] print_req_error: operation not supported error, dev nvme0n1, sector 221050984
[  258.650047] print_req_error: operation not supported error, dev nvme0n1, sector 160854616
[  258.650058] print_req_error: operation not supported error, dev nvme0n1, sector 471080288
[  258.650083] print_req_error: operation not supported error, dev nvme0n1, sector 242366208
[  258.650093] print_req_error: operation not supported error, dev nvme0n1, sector 363042304
[  258.650100] print_req_error: operation not supported error, dev nvme0n1, sector 55054168
[  258.650106] print_req_error: operation not supported error, dev nvme0n1, sector 261203184
[  258.650110] print_req_error: operation not supported error, dev nvme0n1, sector 318931552
[  259.401504] nvme nvme0: Reconnecting in 10 seconds...
[  259.401508] Buffer I/O error on dev nvme0n1, logical block 218, lost async page write
[  259.415933] Buffer I/O error on dev nvme0n1, logical block 219, lost async page write
[  259.424709] Buffer I/O error on dev nvme0n1, logical block 267, lost async page write
[  259.433479] Buffer I/O error on dev nvme0n1, logical block 268, lost async page write
[  259.442248] Buffer I/O error on dev nvme0n1, logical block 269, lost async page write
[  259.451017] Buffer I/O error on dev nvme0n1, logical block 270, lost async page write
[  259.459784] Buffer I/O error on dev nvme0n1, logical block 271, lost async page write
[  259.468550] Buffer I/O error on dev nvme0n1, logical block 272, lost async page write
[  259.477319] Buffer I/O error on dev nvme0n1, logical block 273, lost async page write
[  259.486095] Buffer I/O error on dev nvme0n1, logical block 341, lost async page write
[  264.003845] nvme nvme0: Identify namespace failed
[  264.009222] print_req_error: 391720 callbacks suppressed
[  264.009223] print_req_error: I/O error, dev nvme0n1, sector 0
[  264.021610] print_req_error: I/O error, dev nvme0n1, sector 0
[  264.028048] print_req_error: I/O error, dev nvme0n1, sector 0
[  264.034486] print_req_error: I/O error, dev nvme0n1, sector 0
[  264.040922] print_req_error: I/O error, dev nvme0n1, sector 0
[  264.047359] print_req_error: I/O error, dev nvme0n1, sector 0
[  264.053794] Dev nvme0n1: unable to read RDB block 0
[  264.059261] print_req_error: I/O error, dev nvme0n1, sector 0
[  264.065699] print_req_error: I/O error, dev nvme0n1, sector 0
[  264.072134]  nvme0n1: unable to read partition table
[  264.082672] print_req_error: I/O error, dev nvme0n1, sector 524287872
[  264.090339] print_req_error: I/O error, dev nvme0n1, sector 524287872
[  269.481193] nvme nvme0: creating 37 I/O queues.
[  269.787024] BUG: unable to handle kernel paging request at 0000473023d3b6c8
[  269.795246] IP: blk_mq_get_request+0x23e/0x390
[  269.800599] PGD 0 P4D 0 
[  269.803810] Oops: 0002 [#1] SMP PTI
[  269.808089] Modules linked in: nvme_rdma nvme_fabrics nvme_core sch_mqprio ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge 8021q garp mrp stp llc ib_isert iscsir
[  269.890870]  syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm mlx4_core ahci libahci tg3 libata crc32c_intel i2c_core devlink dm_mirror dm_region_hash dm_log dm_mod
[  269.908864] CPU: 36 PID: 680 Comm: kworker/u369:8 Not tainted 4.16.0-rc7 #3
[  269.917207] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.6.2 01/08/2016
[  269.926155] Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
[  269.934239] RIP: 0010:blk_mq_get_request+0x23e/0x390
[  269.940392] RSP: 0018:ffffb237087cbca8 EFLAGS: 00010246
[  269.946841] RAX: 0000473023d3b680 RBX: ffff8b06546e0000 RCX: 000000000000001f
[  269.955443] RDX: 0000000000000000 RSI: ffffffdbc0ce8100 RDI: ffff8b0653431000
[  269.964053] RBP: ffffb237087cbce8 R08: ffffffffffffffff R09: 0000000000000002
[  269.972674] R10: ffff8af67eaa7160 R11: ffffd62c40186c00 R12: 0000000000000023
[  269.981285] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  269.989891] FS:  0000000000000000(0000) GS:ffff8af67ea80000(0000) knlGS:0000000000000000
[  269.999577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  270.006654] CR2: 0000473023d3b6c8 CR3: 00000015ed40a001 CR4: 00000000001606e0
[  270.015300] Call Trace:
[  270.018716]  blk_mq_alloc_request_hctx+0xf2/0x140
[  270.024668]  nvme_alloc_request+0x36/0x60 [nvme_core]
[  270.031016]  __nvme_submit_sync_cmd+0x2b/0xd0 [nvme_core]
[  270.037762]  nvmf_connect_io_queue+0x10e/0x170 [nvme_fabrics]
[  270.044898]  nvme_rdma_start_queue+0x21/0x80 [nvme_rdma]
[  270.051566]  nvme_rdma_configure_io_queues+0x196/0x280 [nvme_rdma]
[  270.059199]  nvme_rdma_reconnect_ctrl_work+0x39/0xd0 [nvme_rdma]
[  270.066637]  process_one_work+0x158/0x360
[  270.071846]  worker_thread+0x47/0x3e0
[  270.076672]  kthread+0xf8/0x130
[  270.080918]  ? max_active_store+0x80/0x80
[  270.086142]  ? kthread_bind+0x10/0x10
[  270.090987]  ret_from_fork+0x35/0x40
[  270.095739] Code: 89 83 40 01 00 00 45 84 e4 48 c7 83 48 01 00 00 00 00 00 00 ba 01 00 00 00 48 8b 45 10 74 0c 31 d2 41 f7 c4 00 08 06 00 0f 95 c2 <48> 83 44 d0 48 01 41 81 e4 00 00 06  
[  270.118418] RIP: blk_mq_get_request+0x23e/0x390 RSP: ffffb237087cbca8
[  270.126422] CR2: 0000473023d3b6c8
[  270.130994] ---[ end trace 222e693b7ee07afa ]---
[  270.141098] Kernel panic - not syncing: Fatal exception
[  270.147812] Kernel Offset: 0x22800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  270.164696] ---[ end Kernel panic - not syncing: Fatal exception
[  270.172257] WARNING: CPU: 36 PID: 680 at kernel/sched/core.c:1189 set_task_cpu+0x18c/0x1a0
[  270.182333] Modules linked in: nvme_rdma nvme_fabrics nvme_core sch_mqprio ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge 8021q garp mrp stp llc ib_isert iscsir
[  270.268075]  syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm mlx4_core ahci libahci tg3 libata crc32c_intel i2c_core devlink dm_mirror dm_region_hash dm_log dm_mod
[  270.286750] CPU: 36 PID: 680 Comm: kworker/u369:8 Tainted: G      D          4.16.0-rc7 #3
[  270.296862] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.6.2 01/08/2016
[  270.306088] Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
[  270.314436] RIP: 0010:set_task_cpu+0x18c/0x1a0
[  270.320253] RSP: 0018:ffff8af67ea83ce0 EFLAGS: 00010046
[  270.326938] RAX: 0000000000000200 RBX: ffff8af65d9445c0 RCX: 0000005555555501
[  270.335764] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8af65d9445c0
[  270.344591] RBP: 0000000000022380 R08: 0000000000000000 R09: 0000000000000010
[  270.353409] R10: 000000005abdf5ea R11: 0000000016684c67 R12: 0000000000000000
[  270.362223] R13: 0000000000000000 R14: 0000000000000046 R15: 0000000000000000
[  270.371030] FS:  0000000000000000(0000) GS:ffff8af67ea80000(0000) knlGS:0000000000000000
[  270.380913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  270.388166] CR2: 0000473023d3b6c8 CR3: 00000015ed40a001 CR4: 00000000001606e0
[  270.396985] Call Trace:
[  270.400557]  <IRQ>
[  270.403621]  try_to_wake_up+0x167/0x460
[  270.408730]  ? enqueue_task_fair+0x67/0xa00
[  270.414224]  __wake_up_common+0x8f/0x160
[  270.419417]  ep_poll_callback+0xc4/0x2f0
[  270.424609]  __wake_up_common+0x8f/0x160
[  270.429796]  __wake_up_common_lock+0x7a/0xc0
[  270.435368]  irq_work_run_list+0x4c/0x70
[  270.440547]  ? tick_sched_do_timer+0x60/0x60
[  270.446115]  update_process_times+0x3b/0x50
[  270.451579]  tick_sched_handle+0x26/0x60
[  270.456752]  tick_sched_timer+0x34/0x70
[  270.461826]  __hrtimer_run_queues+0xfb/0x270
[  270.467388]  hrtimer_interrupt+0x122/0x270
[  270.472756]  smp_apic_timer_interrupt+0x62/0x130
[  270.478712]  apic_timer_interrupt+0xf/0x20
[  270.484066]  </IRQ>
[  270.487167] RIP: 0010:panic+0x206/0x25c
[  270.492195] RSP: 0018:ffffb237087cba60 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff12
[  270.501406] RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000006
[  270.510136] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff8af67ea968b0
[  270.518863] RBP: ffffb237087cbad0 R08: 0000000000000000 R09: 0000000000000886
[  270.527578] R10: 00000000000003ff R11: 0000000000aaaaaa R12: ffffffffa4654b1a
[  270.536278] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[  270.544970]  oops_end+0xb0/0xc0
[  270.549179]  no_context+0x1b3/0x430
[  270.553753]  ? account_entity_dequeue+0xa3/0xd0
[  270.559473]  __do_page_fault+0x97/0x4c0
[  270.564396]  do_page_fault+0x32/0x140
[  270.569103]  page_fault+0x25/0x50
[  270.573398] RIP: 0010:blk_mq_get_request+0x23e/0x390
[  270.579516] RSP: 0018:ffffb237087cbca8 EFLAGS: 00010246
[  270.585906] RAX: 0000473023d3b680 RBX: ffff8b06546e0000 RCX: 000000000000001f
[  270.594422] RDX: 0000000000000000 RSI: ffffffdbc0ce8100 RDI: ffff8b0653431000
[  270.602929] RBP: ffffb237087cbce8 R08: ffffffffffffffff R09: 0000000000000002
[  270.611432] R10: ffff8af67eaa7160 R11: ffffd62c40186c00 R12: 0000000000000023
[  270.619927] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  270.628409]  ? blk_mq_get_request+0x212/0x390
[  270.633795]  blk_mq_alloc_request_hctx+0xf2/0x140
[  270.639565]  nvme_alloc_request+0x36/0x60 [nvme_core]
[  270.645721]  __nvme_submit_sync_cmd+0x2b/0xd0 [nvme_core]
[  270.652269]  nvmf_connect_io_queue+0x10e/0x170 [nvme_fabrics]
[  270.659209]  nvme_rdma_start_queue+0x21/0x80 [nvme_rdma]
[  270.665668]  nvme_rdma_configure_io_queues+0x196/0x280 [nvme_rdma]
[  270.673087]  nvme_rdma_reconnect_ctrl_work+0x39/0xd0 [nvme_rdma]
[  270.680314]  process_one_work+0x158/0x360
[  270.685302]  worker_thread+0x47/0x3e0
[  270.689897]  kthread+0xf8/0x130
[  270.693906]  ? max_active_store+0x80/0x80
[  270.698880]  ? kthread_bind+0x10/0x10
[  270.703473]  ret_from_fork+0x35/0x40
[  270.707967] Code: 8b 9c 08 00 00 04 e9 28 ff ff ff 0f 0b 66 90 e9 bf fe ff ff f7 83 88 00 00 00 fd ff ff ff 0f 84 c9 fe ff ff 0f 0b e9 c2 fe ff ff <0f> 0b e9 d1 fe ff ff 0f 1f 00 66 2e  
[  270.730149] ---[ end trace 222e693b7ee07afb ]---

Best Regards,
  Yi Zhang
