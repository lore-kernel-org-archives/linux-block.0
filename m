Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36985 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeGVARS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jul 2018 20:17:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so14419604wrd.4
        for <linux-block@vger.kernel.org>; Sat, 21 Jul 2018 16:22:47 -0700 (PDT)
MIME-Version: 1.0
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 22 Jul 2018 07:22:45 +0800
Message-ID: <CACVXFVNKAhGkievaHXDvPngw7xW5hWg_0oOSLXD1R4uaxSJs3w@mail.gmail.com>
Subject: [Bug] block/for-next: IO hang in rq_qos_throttle
To: linux-block <linux-block@vger.kernel.org>,
        Josef Bacik <jbacik@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The following IO hang is triggered on dbench test on xfs/usb-storage,
and the test
is run on the latest for-next/block(commit 93d8cf625a32).


[  497.775475] ================start test sanity/006================
[  497.793059] sd 8:0:0:0: [sdd] Synchronizing SCSI cache
[  499.658244] scsi host8: scsi_debug: version 0188 [20180128]
[  499.658244]   dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
[  499.660292] scsi 8:0:0:0: Direct-Access     Linux    scsi_debug
  0188 PQ: 0 ANSI: 7
[  499.661405] sd 8:0:0:0: Power-on or device reset occurred
[  499.664165] sd 8:0:0:0: [sdd] 2097152 512-byte logical blocks:
(1.07 GB/1.00 GiB)
[  499.666017] sd 8:0:0:0: [sdd] Write Protect is off
[  499.666645] sd 8:0:0:0: [sdd] Mode Sense: 73 00 10 08
[  499.669315] sd 8:0:0:0: [sdd] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  499.693097] sd 8:0:0:0: [sdd] Attached SCSI disk
[  500.538241] EXT4-fs (sdc): mounted filesystem with ordered data
mode. Opts: (null)
[  525.642527] EXT4-fs (sdc): mounted filesystem with ordered data
mode. Opts: (null)
[  550.256595] EXT4-fs (sdc): mounted filesystem with ordered data
mode. Opts: (null)
[  574.781686] EXT4-fs (sdc): mounted filesystem with ordered data
mode. Opts: (null)
[  609.888137] usb 1-1: reset high-speed USB device number 2 using ehci-pci
[  640.608104] usb 1-1: reset high-speed USB device number 2 using ehci-pci
[  641.765877] SGI XFS with ACLs, security attributes, realtime,
scrub, no debug enabled
[  641.775402] XFS (sdc): Mounting V5 Filesystem
[  641.880050] XFS (sdc): Ending clean mount
[  666.193467] XFS (sdc): Unmounting Filesystem
[  666.351521] XFS (sdc): Mounting V5 Filesystem
[  666.409923] XFS (sdc): Ending clean mount
[  690.848609] XFS (sdc): Unmounting Filesystem
[  691.030587] XFS (sdc): Mounting V5 Filesystem
[  691.487377] XFS (sdc): Ending clean mount
[  861.151076] INFO: task kworker/3:0:28321 blocked for more than 120 seconds.
[  861.152024]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.152808] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.153802] kworker/3:0     D    0 28321      2 0x80000000
[  861.154799] Workqueue: xfs-sync/sdc xfs_log_worker [xfs]
[  861.155481] Call Trace:
[  861.155811]  ? __schedule+0x71e/0x783
[  861.156281]  schedule+0x7e/0x99
[  861.156685]  io_schedule+0x12/0x33
[  861.157131]  wbt_wait+0x23a/0x283
[  861.157558]  ? wait_woken+0x6d/0x6d
[  861.158017]  rq_qos_throttle+0x31/0x3c
[  861.158520]  blk_mq_make_request+0xe8/0x513
[  861.159063]  generic_make_request+0x1bc/0x328
[  861.159631]  ? xlog_bdstrat+0x15/0x4f [xfs]
[  861.161486]  ? submit_bio+0x103/0x11f
[  861.161982]  submit_bio+0x103/0x11f
[  861.162591]  ? bio_add_page+0x41/0x4a
[  861.163191]  _xfs_buf_ioapply+0x35c/0x3ee [xfs]
[  861.163828]  ? xlog_bdstrat+0x4a/0x4f [xfs]
[  861.164571]  ? xfs_buf_submit+0x177/0x1e8 [xfs]
[  861.165294]  ? xlog_bdstrat+0x4a/0x4f [xfs]
[  861.165866]  xfs_buf_submit+0x177/0x1e8 [xfs]
[  861.166610]  xlog_bdstrat+0x4a/0x4f [xfs]
[  861.167268]  xlog_sync+0x34a/0x450 [xfs]
[  861.167813]  xfs_log_force+0x16b/0x286 [xfs]
[  861.168523]  ? _raw_spin_unlock_irq+0x1d/0x2e
[  861.169193]  ? finish_task_switch+0x16d/0x21f
[  861.169788]  xfs_log_worker+0xdd/0xf4 [xfs]
[  861.170503]  process_one_work+0x1c9/0x2f6
[  861.171118]  ? rescuer_thread+0x282/0x282
[  861.171653]  worker_thread+0x1ca/0x295
[  861.172297]  kthread+0x115/0x11d
[  861.172722]  ? kthread_flush_work_fn+0xe/0xe
[  861.173433]  ret_from_fork+0x35/0x40
[  861.173911] INFO: task dbench:28467 blocked for more than 120 seconds.
[  861.174891]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.175760] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.176832] dbench          D    0 28467  28466 0x00000000
[  861.177618] Call Trace:
[  861.177941]  ? __schedule+0x71e/0x783
[  861.178542]  schedule+0x7e/0x99
[  861.178925]  io_schedule+0x12/0x33
[  861.179420]  wbt_wait+0x23a/0x283
[  861.179796]  ? wait_woken+0x6d/0x6d
[  861.180304]  rq_qos_throttle+0x31/0x3c
[  861.180736]  blk_mq_make_request+0xe8/0x513
[  861.181325]  generic_make_request+0x1bc/0x328
[  861.181811]  ? submit_bio+0x103/0x11f
[  861.182340]  submit_bio+0x103/0x11f
[  861.182762]  ? xfs_setfilesize_trans_alloc+0x41/0x8c [xfs]
[  861.183532]  xfs_submit_ioend+0x111/0x11c [xfs]
[  861.184150]  xfs_vm_writepages+0x75/0x95 [xfs]
[  861.184641]  do_writepages+0x2d/0x51
[  861.185191]  __filemap_fdatawrite_range+0xc3/0xf1
[  861.185713]  file_write_and_wait_range+0x3e/0x6b
[  861.186461]  xfs_file_fsync+0xb9/0x1ef [xfs]
[  861.187119]  ? iomap_write_end+0x5d/0x5d
[  861.187605]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.188346]  __vfs_write+0x113/0x150
[  861.188750]  vfs_write+0xc8/0x16b
[  861.189261]  ksys_pwrite64+0x60/0x7d
[  861.189659]  do_syscall_64+0x84/0x13f
[  861.190210]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.190784] RIP: 0033:0x7ff85f202e83
[  861.191306] Code: Bad RIP value.
[  861.191668] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.192619] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.193470] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.194367] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.195377] R10: 0000000000070000 R11: 0000000000000246 R12: 00007ff85f8f0000
[  861.196230] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  861.197080] INFO: task dbench:28468 blocked for more than 120 seconds.
[  861.197790]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.198581] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.199496] dbench          D    0 28468  28466 0x00000000
[  861.200178] Call Trace:
[  861.200458]  ? __schedule+0x71e/0x783
[  861.200878]  schedule+0x7e/0x99
[  861.201415]  io_schedule+0x12/0x33
[  861.201801]  wbt_wait+0x23a/0x283
[  861.202356]  ? wait_woken+0x6d/0x6d
[  861.202751]  rq_qos_throttle+0x31/0x3c
[  861.203297]  blk_mq_make_request+0xe8/0x513
[  861.203764]  generic_make_request+0x1bc/0x328
[  861.204369]  ? submit_bio+0x103/0x11f
[  861.204778]  submit_bio+0x103/0x11f
[  861.205313]  ? xfs_setfilesize_trans_alloc+0x41/0x8c [xfs]
[  861.205942]  xfs_submit_ioend+0x111/0x11c [xfs]
[  861.206629]  xfs_vm_writepages+0x75/0x95 [xfs]
[  861.207305]  do_writepages+0x2d/0x51
[  861.207701]  __filemap_fdatawrite_range+0xc3/0xf1
[  861.208340]  file_write_and_wait_range+0x3e/0x6b
[  861.208877]  xfs_file_fsync+0xb9/0x1ef [xfs]
[  861.209486]  ? iomap_write_end+0x5d/0x5d
[  861.209952]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.210757]  __vfs_write+0x113/0x150
[  861.211234]  vfs_write+0xc8/0x16b
[  861.211603]  ksys_pwrite64+0x60/0x7d
[  861.212129]  do_syscall_64+0x84/0x13f
[  861.212535]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.213217] RIP: 0033:0x7ff85f202e83
[  861.213610] Code: Bad RIP value.
[  861.213975] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.215138] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.215940] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.216834] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.217708] R10: 0000000000070000 R11: 0000000000000246 R12: 00007ff85f8f0228
[  861.218658] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  861.219519] INFO: task dbench:28469 blocked for more than 120 seconds.
[  861.220298]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.220980] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.221950] dbench          D    0 28469  28466 0x00000000
[  861.222616] Call Trace:
[  861.222903]  ? __schedule+0x71e/0x783
[  861.223449]  schedule+0x7e/0x99
[  861.223809]  io_schedule+0x12/0x33
[  861.224311]  wbt_wait+0x23a/0x283
[  861.224681]  ? wait_woken+0x6d/0x6d
[  861.225198]  rq_qos_throttle+0x31/0x3c
[  861.225612]  blk_mq_make_request+0xe8/0x513
[  861.226232]  generic_make_request+0x1bc/0x328
[  861.226715]  ? _raw_spin_lock_irqsave+0x25/0x46
[  861.227431]  ? submit_bio+0x103/0x11f
[  861.227841]  submit_bio+0x103/0x11f
[  861.228341]  ? bio_alloc_bioset+0x10d/0x1d8
[  861.228805]  submit_bio_wait+0x53/0x7f
[  861.229348]  blkdev_issue_flush+0x81/0xa5
[  861.229826]  xfs_file_fsync+0x1c2/0x1ef [xfs]
[  861.230446]  ? iomap_write_end+0x5d/0x5d
[  861.230922]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.231643]  __vfs_write+0x113/0x150
[  861.232121]  vfs_write+0xc8/0x16b
[  861.232489]  ksys_pwrite64+0x60/0x7d
[  861.232888]  do_syscall_64+0x84/0x13f
[  861.233480]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.234110] RIP: 0033:0x7ff85f202e83
[  861.234583] Code: Bad RIP value.
[  861.235152] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.235992] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.236895] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.237776] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.238764] R10: 0000000000040000 R11: 0000000000000246 R12: 00007ff85f8f0450
[  861.239682] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  861.240534] INFO: task dbench:28470 blocked for more than 120 seconds.
[  861.241407]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.242244] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.243247] dbench          D    0 28470  28466 0x00000000
[  861.243843] Call Trace:
[  861.244125]  ? __schedule+0x71e/0x783
[  861.244561]  schedule+0x7e/0x99
[  861.245007]  __xfs_log_force_lsn+0x13d/0x283 [xfs]
[  861.245624]  ? wake_up_q+0x4d/0x4d
[  861.246033]  ? xfs_file_fsync+0x16d/0x1ef [xfs]
[  861.246639]  xfs_log_force_lsn+0xf7/0x12a [xfs]
[  861.247254]  xfs_file_fsync+0x16d/0x1ef [xfs]
[  861.247817]  ? iomap_write_end+0x5d/0x5d
[  861.248321]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.248917]  __vfs_write+0x113/0x150
[  861.249314]  vfs_write+0xc8/0x16b
[  861.249678]  ksys_pwrite64+0x60/0x7d
[  861.250090]  do_syscall_64+0x84/0x13f
[  861.250569]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.251216] RIP: 0033:0x7ff85f202e83
[  861.251619] Code: Bad RIP value.
[  861.251981] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.252795] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.253564] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.254399] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.255301] R10: 0000000000050000 R11: 0000000000000246 R12: 00007ff85f8f0678
[  861.256141] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  861.256913] INFO: task dbench:28471 blocked for more than 120 seconds.
[  861.257721]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.258503] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.259463] dbench          D    0 28471  28466 0x00000000
[  861.260066] Call Trace:
[  861.260349]  ? __schedule+0x71e/0x783
[  861.260754]  schedule+0x7e/0x99
[  861.261105]  io_schedule+0x12/0x33
[  861.261477]  blk_mq_get_tag+0x153/0x279
[  861.261899]  ? wait_woken+0x6d/0x6d
[  861.262336]  blk_mq_get_request+0x105/0x37e
[  861.262876]  blk_mq_make_request+0x171/0x513
[  861.263410]  generic_make_request+0x1bc/0x328
[  861.263887]  ? _raw_spin_lock_irqsave+0x25/0x46
[  861.264391]  ? submit_bio+0x103/0x11f
[  861.264834]  submit_bio+0x103/0x11f
[  861.265287]  ? bio_alloc_bioset+0x10d/0x1d8
[  861.265827]  submit_bio_wait+0x53/0x7f
[  861.266279]  blkdev_issue_flush+0x81/0xa5
[  861.266821]  xfs_file_fsync+0x1c2/0x1ef [xfs]
[  861.267411]  ? iomap_write_end+0x5d/0x5d
[  861.267948]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.268612]  __vfs_write+0x113/0x150
[  861.269017]  vfs_write+0xc8/0x16b
[  861.269382]  ksys_pwrite64+0x60/0x7d
[  861.269806]  do_syscall_64+0x84/0x13f
[  861.270280]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.270926] RIP: 0033:0x7ff85f202e83
[  861.271378] Code: Bad RIP value.
[  861.271739] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.272554] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.273417] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.274322] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.275228] R10: 0000000000070000 R11: 0000000000000246 R12: 00007ff85f8f08a0
[  861.276122] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  861.276895] INFO: task dbench:28472 blocked for more than 120 seconds.
[  861.277697]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.278495] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.279462] dbench          D    0 28472  28466 0x00000000
[  861.280067] Call Trace:
[  861.280346]  ? __schedule+0x71e/0x783
[  861.280753]  schedule+0x7e/0x99
[  861.281105]  schedule_timeout+0x3a/0x340
[  861.281535]  ? blk_queue_exit+0x5c/0x5e
[  861.281959]  ? generic_make_request+0x283/0x328
[  861.282529]  io_schedule_timeout+0x20/0x3d
[  861.283065]  wait_for_common_io.constprop.2+0x9d/0x120
[  861.283657]  ? wake_up_q+0x4d/0x4d
[  861.284040]  submit_bio_wait+0x5b/0x7f
[  861.284452]  blkdev_issue_flush+0x81/0xa5
[  861.284972]  xfs_file_fsync+0x1c2/0x1ef [xfs]
[  861.285531]  ? iomap_write_end+0x5d/0x5d
[  861.286074]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.286783]  __vfs_write+0x113/0x150
[  861.287258]  vfs_write+0xc8/0x16b
[  861.287665]  ksys_pwrite64+0x60/0x7d
[  861.288137]  do_syscall_64+0x84/0x13f
[  861.288612]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.289168] RIP: 0033:0x7ff85f202e83
[  861.289561] Code: Bad RIP value.
[  861.289976] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.290927] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.291750] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.292514] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.293286] R10: 0000000000040000 R11: 0000000000000246 R12: 00007ff85f8f0ac8
[  861.294059] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  861.294960] INFO: task dbench:28473 blocked for more than 120 seconds.
[  861.295783]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.296504] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.297352] dbench          D    0 28473  28466 0x00000000
[  861.298040] Call Trace:
[  861.298360]  ? __schedule+0x71e/0x783
[  861.298834]  schedule+0x7e/0x99
[  861.299247]  io_schedule+0x12/0x33
[  861.299621]  wbt_wait+0x23a/0x283
[  861.299991]  ? wait_woken+0x6d/0x6d
[  861.300380]  rq_qos_throttle+0x31/0x3c
[  861.300795]  blk_mq_make_request+0xe8/0x513
[  861.301257]  generic_make_request+0x1bc/0x328
[  861.301761]  ? xlog_bdstrat+0x15/0x4f [xfs]
[  861.302256]  ? submit_bio+0x103/0x11f
[  861.302731]  submit_bio+0x103/0x11f
[  861.303183]  ? bio_add_page+0x41/0x4a
[  861.303624]  _xfs_buf_ioapply+0x35c/0x3ee [xfs]
[  861.304128]  ? __kernel_fpu_end+0x61/0x7b
[  861.304593]  ? xlog_bdstrat+0x4a/0x4f [xfs]
[  861.305092]  ? xfs_buf_submit+0x177/0x1e8 [xfs]
[  861.305716]  xfs_buf_submit+0x177/0x1e8 [xfs]
[  861.306307]  xlog_bdstrat+0x4a/0x4f [xfs]
[  861.306853]  xlog_sync+0x34a/0x450 [xfs]
[  861.307378]  __xfs_log_force_lsn+0x17b/0x283 [xfs]
[  861.307979]  ? xfs_file_fsync+0x16d/0x1ef [xfs]
[  861.308585]  xfs_file_fsync+0x16d/0x1ef [xfs]
[  861.309153]  ? iomap_write_end+0x5d/0x5d
[  861.309668]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.310322]  __vfs_write+0x113/0x150
[  861.310792]  vfs_write+0xc8/0x16b
[  861.311222]  ksys_pwrite64+0x60/0x7d
[  861.311627]  do_syscall_64+0x84/0x13f
[  861.312038]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.312586] RIP: 0033:0x7ff85f202e83
[  861.313049] Code: Bad RIP value.
[  861.313463] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.314416] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.315344] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.316260] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.317116] R10: 0000000000070000 R11: 0000000000000246 R12: 00007ff85f8f0cf0
[  861.317919] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  861.318819] INFO: task dbench:28474 blocked for more than 120 seconds.
[  861.319643]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.320347] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.321198] dbench          D    0 28474  28466 0x00000000
[  861.321795] Call Trace:
[  861.322076]  ? __schedule+0x71e/0x783
[  861.322552]  schedule+0x7e/0x99
[  861.322959]  io_schedule+0x12/0x33
[  861.323387]  wbt_wait+0x23a/0x283
[  861.323759]  ? wait_woken+0x6d/0x6d
[  861.324149]  rq_qos_throttle+0x31/0x3c
[  861.324558]  blk_mq_make_request+0xe8/0x513
[  861.325033]  generic_make_request+0x1bc/0x328
[  861.325547]  ? submit_bio+0x103/0x11f
[  861.326025]  submit_bio+0x103/0x11f
[  861.326471]  ? bio_alloc_bioset+0x10d/0x1d8
[  861.327014]  submit_bio_wait+0x53/0x7f
[  861.327464]  blkdev_issue_flush+0x81/0xa5
[  861.327928]  xfs_file_fsync+0x1c2/0x1ef [xfs]
[  861.328496]  ? iomap_write_end+0x5d/0x5d
[  861.329036]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.329642]  __vfs_write+0x113/0x150
[  861.330044]  vfs_write+0xc8/0x16b
[  861.330475]  ksys_pwrite64+0x60/0x7d
[  861.330938]  do_syscall_64+0x84/0x13f
[  861.331398]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.331950] RIP: 0033:0x7ff85f202e83
[  861.332344] Code: Bad RIP value.
[  861.332700] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.333519] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.334338] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.335253] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.336135] R10: 0000000000060000 R11: 0000000000000246 R12: 00007ff85f8f0f18
[  861.336976] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  861.337752] INFO: task dbench:28475 blocked for more than 120 seconds.
[  861.338534]       Not tainted 4.18.0-rc4_93d8cf625a32_for-next+ #1
[  861.339318] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  861.340227] dbench          D    0 28475  28466 0x00000000
[  861.340927] Call Trace:
[  861.341252]  ? __schedule+0x71e/0x783
[  861.341726]  schedule+0x7e/0x99
[  861.342124]  io_schedule+0x12/0x33
[  861.342560]  wbt_wait+0x23a/0x283
[  861.342991]  ? wait_woken+0x6d/0x6d
[  861.343418]  rq_qos_throttle+0x31/0x3c
[  861.343834]  blk_mq_make_request+0xe8/0x513
[  861.344297]  generic_make_request+0x1bc/0x328
[  861.344794]  ? submit_bio+0x103/0x11f
[  861.345199]  submit_bio+0x103/0x11f
[  861.345631]  ? xfs_setfilesize_trans_alloc+0x41/0x8c [xfs]
[  861.346362]  xfs_submit_ioend+0x111/0x11c [xfs]
[  861.346970]  xfs_vm_writepages+0x75/0x95 [xfs]
[  861.347506]  do_writepages+0x2d/0x51
[  861.347904]  __filemap_fdatawrite_range+0xc3/0xf1
[  861.348471]  file_write_and_wait_range+0x3e/0x6b
[  861.349105]  xfs_file_fsync+0xb9/0x1ef [xfs]
[  861.349611]  ? iomap_write_end+0x5d/0x5d
[  861.350074]  xfs_file_buffered_aio_write+0x28e/0x2bc [xfs]
[  861.350783]  __vfs_write+0x113/0x150
[  861.351257]  vfs_write+0xc8/0x16b
[  861.351622]  ksys_pwrite64+0x60/0x7d
[  861.352033]  do_syscall_64+0x84/0x13f
[  861.352434]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  861.352993] RIP: 0033:0x7ff85f202e83
[  861.353388] Code: Bad RIP value.
[  861.353748] RSP: 002b:00007ffe90c48bf8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[  861.354665] RAX: ffffffffffffffda RBX: 0000000001ca8900 RCX: 00007ff85f202e83
[  861.355531] RDX: 0000000000010000 RSI: 0000000001cbb2b0 RDI: 0000000000000005
[  861.356423] RBP: 00000000000026d2 R08: 0000000000010000 R09: 0000000000000079
[  861.357267] R10: 0000000000080000 R11: 0000000000000246 R12: 00007ff85f8f1140
[  861.358045] R13: 0000000000010000 R14: 0000000000010000 R15: 0000000001cbb2b0
[  869.362143] ================end test sanity/006: (HANG, -1)================
[



-- 
Ming Lei
