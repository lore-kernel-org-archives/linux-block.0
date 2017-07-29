Return-Path: <oleksandr@natalenko.name>
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: blk-mq breaks suspend even with runtime PM patch
Date: Sat, 29 Jul 2017 17:27:41 +0200
Message-ID: <5912148.iRCpNe8Dyb@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Hello Jens, Christoph.

Unfortunately, even with "block: disable runtime-pm for blk-mq" patch applied 
blk-mq breaks suspend to RAM for me. It is reproducible on my laptop as well 
as in a VM.

I use complex disk layout involving MD, LUKS and LVM, and managed to get these 
warnings from VM via serial console when suspend fails:

===
[  245.516573] INFO: task kworker/0:1:49 blocked for more than 120 seconds.
[  245.520025]       Not tainted 4.12.0-pf4 #1
[  245.521836] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  245.525612] kworker/0:1     D    0    49      2 0x00000000
[  245.527515] Workqueue: events vmstat_shepherd
[  245.528685] Call Trace:
[  245.529296]  __schedule+0x459/0xe40
[  245.530115]  ? kvm_clock_read+0x25/0x40
[  245.531003]  ? ktime_get+0x40/0xa0
[  245.531819]  schedule+0x3d/0xb0
[  245.532542]  ? schedule+0x3d/0xb0
[  245.533299]  schedule_preempt_disabled+0x15/0x20
[  245.534367]  __mutex_lock.isra.5+0x295/0x530
[  245.535351]  __mutex_lock_slowpath+0x13/0x20
[  245.536362]  ? __mutex_lock_slowpath+0x13/0x20
[  245.537334]  mutex_lock+0x25/0x30
[  245.538118]  get_online_cpus.part.14+0x15/0x30
[  245.539588]  get_online_cpus+0x20/0x30
[  245.540560]  vmstat_shepherd+0x21/0xc0
[  245.541538]  process_one_work+0x1de/0x430
[  245.542364]  worker_thread+0x47/0x3f0
[  245.543042]  kthread+0x125/0x140
[  245.543649]  ? process_one_work+0x430/0x430
[  245.544417]  ? kthread_create_on_node+0x70/0x70
[  245.545737]  ret_from_fork+0x25/0x30
[  245.546490] INFO: task md0_raid10:459 blocked for more than 120 seconds.
[  245.547668]       Not tainted 4.12.0-pf4 #1
[  245.548769] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  245.550133] md0_raid10      D    0   459      2 0x00000000
[  245.551092] Call Trace:
[  245.551539]  __schedule+0x459/0xe40
[  245.552163]  schedule+0x3d/0xb0
[  245.552728]  ? schedule+0x3d/0xb0
[  245.553344]  md_super_wait+0x6e/0xa0 [md_mod]
[  245.554118]  ? wake_bit_function+0x60/0x60
[  245.554854]  md_update_sb.part.60+0x3df/0x840 [md_mod]
[  245.555771]  md_check_recovery+0x215/0x4b0 [md_mod]
[  245.556732]  raid10d+0x62/0x13c0 [raid10]
[  245.557456]  ? schedule+0x3d/0xb0
[  245.558169]  ? schedule+0x3d/0xb0
[  245.558803]  ? schedule_timeout+0x21f/0x330
[  245.559593]  md_thread+0x120/0x160 [md_mod]
[  245.560380]  ? md_thread+0x120/0x160 [md_mod]
[  245.561202]  ? wake_bit_function+0x60/0x60
[  245.561975]  kthread+0x125/0x140
[  245.562601]  ? find_pers+0x70/0x70 [md_mod]
[  245.563394]  ? kthread_create_on_node+0x70/0x70
[  245.564516]  ret_from_fork+0x25/0x30
[  245.565669] INFO: task dmcrypt_write:487 blocked for more than 120 seconds.
[  245.567151]       Not tainted 4.12.0-pf4 #1
[  245.567946] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  245.569390] dmcrypt_write   D    0   487      2 0x00000000
[  245.570352] Call Trace:
[  245.570801]  __schedule+0x459/0xe40
[  245.571601]  ? preempt_schedule_common+0x1f/0x30
[  245.572421]  ? ___preempt_schedule+0x16/0x18
[  245.573168]  schedule+0x3d/0xb0
[  245.573733]  ? schedule+0x3d/0xb0
[  245.574378]  md_write_start+0xe3/0x270 [md_mod]
[  245.575180]  ? wake_bit_function+0x60/0x60
[  245.575915]  raid10_make_request+0x3f/0x140 [raid10]
[  245.576827]  md_make_request+0xa9/0x2a0 [md_mod]
[  245.577659]  generic_make_request+0x11e/0x2f0
[  245.578464]  dmcrypt_write+0x22d/0x250 [dm_crypt]
[  245.579288]  ? dmcrypt_write+0x22d/0x250 [dm_crypt]
[  245.580183]  ? wake_up_process+0x20/0x20
[  245.580875]  kthread+0x125/0x140
[  245.581455]  ? kthread+0x125/0x140
[  245.582064]  ? crypt_iv_essiv_dtr+0x70/0x70 [dm_crypt]
[  245.582971]  ? kthread_create_on_node+0x70/0x70
[  245.583772]  ret_from_fork+0x25/0x30
[  245.584424] INFO: task btrfs-transacti:553 blocked for more than 120 
seconds.
[  245.585830]       Not tainted 4.12.0-pf4 #1
[  245.586596] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  245.587947] btrfs-transacti D    0   553      2 0x00000000
[  245.588922] Call Trace:
[  245.589377]  __schedule+0x459/0xe40
[  245.590062]  ? btrfs_submit_bio_hook+0x8c/0x180 [btrfs]
[  245.590976]  schedule+0x3d/0xb0
[  245.591538]  ? schedule+0x3d/0xb0
[  245.592175]  io_schedule+0x16/0x40
[  245.592794]  wait_on_page_bit_common+0xe3/0x180
[  245.593589]  ? page_cache_tree_insert+0xc0/0xc0
[  245.594387]  __filemap_fdatawait_range+0x12a/0x1a0
[  245.595229]  filemap_fdatawait_range+0x14/0x30
[  245.596033]  btrfs_wait_ordered_range+0x6b/0x110 [btrfs]
[  245.596998]  ? _raw_spin_unlock+0x10/0x30
[  245.597735]  __btrfs_wait_cache_io+0x45/0x1c0 [btrfs]
[  245.599091]  btrfs_wait_cache_io+0x2c/0x30 [btrfs]
[  245.600789]  btrfs_write_dirty_block_groups+0x206/0x390 [btrfs]
[  245.602068]  commit_cowonly_roots+0x221/0x2c0 [btrfs]
[  245.602981]  btrfs_commit_transaction+0x3c4/0x900 [btrfs]
[  245.603940]  transaction_kthread+0x190/0x1c0 [btrfs]
[  245.604806]  kthread+0x125/0x140
[  245.605398]  ? btrfs_cleanup_transaction+0x500/0x500 [btrfs]
[  245.606414]  ? kthread_create_on_node+0x70/0x70
[  245.607213]  ret_from_fork+0x25/0x30
[  245.607846] INFO: task systemd-sleep:677 blocked for more than 120 seconds.
[  245.609061]       Not tainted 4.12.0-pf4 #1
[  245.609858] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  245.611202] systemd-sleep   D    0   677      1 0x00000000
[  245.612160] Call Trace:
[  245.612604]  __schedule+0x459/0xe40
[  245.613231]  ? blk_mq_queue_reinit_work+0x100/0x100
[  245.614080]  schedule+0x3d/0xb0
[  245.614637]  ? schedule+0x3d/0xb0
[  245.615222]  blk_mq_freeze_queue_wait+0x46/0xb0
[  245.616015]  ? wake_bit_function+0x60/0x60
[  245.616778]  blk_mq_queue_reinit_work+0x6e/0x100
[  245.617592]  blk_mq_queue_reinit_dead+0x3d/0x50
[  245.618420]  ? __flow_cache_shrink+0x170/0x170
[  245.619199]  cpuhp_invoke_callback+0x84/0x430
[  245.619965]  ? cpuhp_invoke_callback+0x84/0x430
[  245.620754]  ? __flow_cache_shrink+0x170/0x170
[  245.621530]  cpuhp_down_callbacks+0x42/0x80
[  245.622267]  _cpu_down+0xc5/0x100
[  245.622856]  freeze_secondary_cpus+0x9e/0x230
[  245.623629]  suspend_devices_and_enter+0x2e6/0x800
[  245.624471]  pm_suspend+0x349/0x3c0
[  245.625090]  state_store+0x49/0xa0
[  245.625699]  kobj_attr_store+0xf/0x20
[  245.626379]  sysfs_kf_write+0x37/0x40
[  245.627038]  kernfs_fop_write+0x11c/0x1a0
[  245.627800]  __vfs_write+0x37/0x140
[  245.628448]  ? handle_mm_fault+0xde/0x220
[  245.629155]  vfs_write+0xb1/0x1a0
[  245.629745]  SyS_write+0x55/0xc0
[  245.630337]  ? trace_do_page_fault+0x37/0xf0
[  245.631088]  entry_SYSCALL_64_fastpath+0x1a/0xa5
[  245.632109] RIP: 0033:0x7f810459dbf0
[  245.632821] RSP: 002b:00007ffec9ba2e58 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[  245.634127] RAX: ffffffffffffffda RBX: 00000000000000c6 RCX: 
00007f810459dbf0
[  245.635353] RDX: 0000000000000004 RSI: 000000b716c73390 RDI: 
0000000000000004
[  245.636778] RBP: 000000000000270f R08: 000000b716c73240 R09: 
00007f8104a718c0
[  245.638254] R10: 00007f810485ead8 R11: 0000000000000246 R12: 
00007f810485ead8
[  245.639500] R13: 0000000000001010 R14: 000000b716c73380 R15: 
00007f810485ea80
===

With blk-mq disabled everything works okay.

How can I help you in solving this issue?
