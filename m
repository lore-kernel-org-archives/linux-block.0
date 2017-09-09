Return-Path: <oleksandr@natalenko.name>
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 0/5] Make SCSI device suspend work reliably
Date: Sat, 09 Sep 2017 16:35:51 +0200
Message-ID: <11578315.3oQBsOxjPs@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Hello.

> Recently it was reported on the block layer mailing list that suspend
> does not work reliably neither for the legacy block layer nor for blk-mq.

Since I was one of the reporters, please consider adding me to CC next time as 
I'm interested in resolving this issue properly and test each related 
patchset.

> The purpose of this patch series is to make device suspend work reliably
> without affecting the hot path significantly and without introducing any
> race conditions between request queue cleanup and blk_get_request().

Unfortunately, your patchset does not solve the issue. I/O hang is easily 
reproducible with SATA drives, RAID10 and QEMU exactly as before. See the 
stacktrace below, it is caught on executing sync after resuming. Hang also may 
happen on suspending (see second stacktrace below as well).

(Just to remind, Ming's patchset fixes the issue completely for me.)

Regards,
  Oleksandr.

=== after resume
[  243.687874] INFO: task md0_raid10:171 blocked for more than 120 seconds.
[  243.688924]       Not tainted 4.13.0-pf2 #1
[  243.689748] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.690929] md0_raid10      D    0   171      2 0x00000000
[  243.691703] Call Trace:
[  243.692067]  __schedule+0x239/0x890
[  243.692563]  schedule+0x3d/0x90
[  243.693016]  md_super_wait+0x6e/0xa0 [md_mod]
[  243.693896]  ? wait_woken+0x80/0x80
[  243.694653]  md_update_sb.part.59+0x3df/0x840 [md_mod]
[  243.695760]  ? percpu_ref_switch_to_percpu+0x36/0x40
[  243.696448]  md_check_recovery+0x453/0x520 [md_mod]
[  243.697130]  raid10d+0x62/0x1420 [raid10]
[  243.698086]  ? __schedule+0x241/0x890
[  243.699001]  ? schedule+0x3d/0x90
[  243.699857]  ? schedule_timeout+0x208/0x390
[  243.700735]  md_thread+0x120/0x160 [md_mod]
[  243.701536]  ? md_thread+0x120/0x160 [md_mod]
[  243.702700]  ? wait_woken+0x80/0x80
[  243.703581]  kthread+0x125/0x140
[  243.704313]  ? state_show+0x2f0/0x2f0 [md_mod]
[  243.705888]  ? kthread_create_on_node+0x70/0x70
[  243.707228]  ? SyS_exit_group+0x14/0x20
[  243.708470]  ret_from_fork+0x25/0x30
[  243.709708] INFO: task dmcrypt_write:193 blocked for more than 120 seconds.
[  243.711105]       Not tainted 4.13.0-pf2 #1
[  243.712604] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.715273] dmcrypt_write   D    0   193      2 0x00000000
[  243.720576] Call Trace:
[  243.722297]  __schedule+0x239/0x890
[  243.724151]  schedule+0x3d/0x90
[  243.725964]  md_write_start+0xe3/0x270 [md_mod]
[  243.728747]  ? wait_woken+0x80/0x80
[  243.730321]  raid10_make_request+0x3f/0x140 [raid10]
[  243.731722]  md_make_request+0xa2/0x290 [md_mod]
[  243.733265]  ? _raw_spin_unlock_irq+0x10/0x30
[  243.735165]  ? finish_task_switch+0x75/0x200
[  243.736755]  generic_make_request+0x125/0x320
[  243.738484]  dmcrypt_write+0x22d/0x250 [dm_crypt]
[  243.739928]  ? dmcrypt_write+0x22d/0x250 [dm_crypt]
[  243.741751]  ? wake_up_q+0x80/0x80
[  243.742801]  kthread+0x125/0x140
[  243.743809]  ? kthread+0x125/0x140
[  243.744807]  ? crypt_iv_essiv_dtr+0x70/0x70 [dm_crypt]
[  243.746001]  ? kthread_create_on_node+0x70/0x70
[  243.749974]  ? SyS_exit_group+0x14/0x20
[  243.751381]  ret_from_fork+0x25/0x30
[  243.752795] INFO: task xfsaild/dm-7:282 blocked for more than 120 seconds.
[  243.754723]       Not tainted 4.13.0-pf2 #1
[  243.756224] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.758005] xfsaild/dm-7    D    0   282      2 0x00000000
[  243.760096] Call Trace:
[  243.760943]  __schedule+0x239/0x890
[  243.761929]  schedule+0x3d/0x90
[  243.762842]  schedule_timeout+0x208/0x390
[  243.763869]  ? blk_finish_plug+0x2c/0x40
[  243.764894]  ? _xfs_buf_ioapply+0x36a/0x4d0 [xfs]
[  243.766058]  ? _xfs_buf_find+0x97/0x570 [xfs]
[  243.767181]  wait_for_completion+0xa5/0x120
[  243.768938]  ? wait_for_completion+0xa5/0x120
[  243.771572]  ? wake_up_q+0x80/0x80
[  243.773227]  ? _xfs_buf_read+0x23/0x30 [xfs]
[  243.775604]  xfs_buf_submit_wait+0x81/0x260 [xfs]
[  243.779552]  _xfs_buf_read+0x23/0x30 [xfs]
[  243.780717]  xfs_buf_read_map+0x116/0x190 [xfs]
[  243.782760]  ? xfs_trans_read_buf_map+0xaa/0x340 [xfs]
[  243.784156]  xfs_trans_read_buf_map+0xaa/0x340 [xfs]
[  243.785969]  xfs_imap_to_bp+0x67/0xe0 [xfs]
[  243.787345]  xfs_iflush+0x109/0x230 [xfs]
[  243.789120]  xfs_inode_item_push+0xee/0x150 [xfs]
[  243.790835]  xfsaild+0x230/0x7a0 [xfs]
[  243.791907]  kthread+0x125/0x140
[  243.792801]  ? kthread+0x125/0x140
[  243.793708]  ? xfs_trans_ail_cursor_first+0x90/0x90 [xfs]
[  243.794915]  ? kthread_create_on_node+0x70/0x70
[  243.795943]  ? SyS_exit_group+0x14/0x20
[  243.796874]  ret_from_fork+0x25/0x30
[  243.797884] INFO: task kworker/u8:25:606 blocked for more than 120 seconds.
[  243.799454]       Not tainted 4.13.0-pf2 #1
[  243.801095] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.803250] kworker/u8:25   D    0   606      2 0x00000000
[  243.804784] Workqueue: dm-thin do_worker [dm_thin_pool]
[  243.806505] Call Trace:
[  243.810079]  __schedule+0x239/0x890
[  243.811217]  schedule+0x3d/0x90
[  243.812638]  md_flush_request+0x63/0x110 [md_mod]
[  243.814342]  ? wait_woken+0x80/0x80
[  243.815739]  raid10_make_request+0x106/0x140 [raid10]
[  243.817333]  md_make_request+0xa2/0x290 [md_mod]
[  243.819560]  generic_make_request+0x125/0x320
[  243.821160]  issue+0x36/0xa0 [dm_thin_pool]
[  243.823273]  ? issue+0x36/0xa0 [dm_thin_pool]
[  243.824798]  remap_and_issue+0x3e/0x70 [dm_thin_pool]
[  243.826577]  process_cell+0xa1/0x4d0 [dm_thin_pool]
[  243.828385]  ? dm_bio_detain+0x51/0x70 [dm_bio_prison]
[  243.830029]  ? bio_detain.isra.35+0x46/0x70 [dm_thin_pool]
[  243.831928]  process_bio+0xb0/0xc0 [dm_thin_pool]
[  243.833151]  do_worker+0x6d0/0x8a0 [dm_thin_pool]
[  243.835020]  process_one_work+0x1de/0x430
[  243.836766]  ? process_one_work+0x1de/0x430
[  243.842434]  worker_thread+0x47/0x3f0
[  243.844278]  kthread+0x125/0x140
[  243.845575]  ? process_one_work+0x430/0x430
[  243.847016]  ? kthread_create_on_node+0x70/0x70
[  243.848700]  ret_from_fork+0x25/0x30
[  243.850811] INFO: task sync:620 blocked for more than 120 seconds.
[  243.854003]       Not tainted 4.13.0-pf2 #1
[  243.856830] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.859405] sync            D    0   620    502 0x00000000
[  243.860763] Call Trace:
[  243.861569]  __schedule+0x239/0x890
[  243.862479]  ? update_load_avg+0x522/0x5a0
[  243.863452]  schedule+0x3d/0x90
[  243.864312]  io_schedule+0x16/0x40
[  243.865199]  wait_on_page_bit_common+0xe7/0x170
[  243.866208]  ? page_cache_tree_insert+0xc0/0xc0
[  243.867398]  __filemap_fdatawait_range+0x10d/0x170
[  243.868676]  filemap_fdatawait_keep_errors+0x27/0x50
[  243.873627]  sync_inodes_sb+0x204/0x2a0
[  243.874991]  ? SyS_tee+0x3d0/0x3d0
[  243.876315]  sync_inodes_one_sb+0x16/0x20
[  243.877326]  iterate_supers+0x94/0x100
[  243.878352]  sys_sync+0x44/0xb0
[  243.879418]  entry_SYSCALL_64_fastpath+0x1a/0xa5
[  243.880492] RIP: 0033:0x7f291f5e21d7
[  243.881447] RSP: 002b:00007ffd22622128 EFLAGS: 00000206 ORIG_RAX: 
00000000000000a2
[  243.882869] RAX: ffffffffffffffda RBX: 00007ffd22622258 RCX: 
00007f291f5e21d7
[  243.884734] RDX: 00007f291f89ee01 RSI: 0000000000000000 RDI: 
00007f291f6677d3
[  243.886256] RBP: 0000000000000001 R08: 0000000000000000 R09: 
0000000000000000
[  243.888775] R10: 000000000000082c R11: 0000000000000206 R12: 
0000000000000000
[  243.890671] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
===

=== before suspend
[   27.898255] sd 0:0:0:0: [sda] Stopping disk
[  243.670227] INFO: task kworker/u8:1:50 blocked for more than 120 seconds.
[  243.673307]       Not tainted 4.13.0-pf2 #1
[  243.674956] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.678002] kworker/u8:1    D    0    50      2 0x00000000
[  243.680211] Workqueue: events_unbound async_run_entry_fn
[  243.682677] Call Trace:
[  243.684443]  __schedule+0x239/0x890
[  243.685174]  schedule+0x3d/0x90
[  243.685731]  schedule_timeout+0x208/0x390
[  243.686432]  ? select_idle_sibling+0x330/0x430
[  243.687208]  ? cpuacct_charge+0x90/0xa0
[  243.687887]  wait_for_completion+0xa5/0x120
[  243.688618]  ? wait_for_completion+0xa5/0x120
[  243.689380]  ? wake_up_q+0x80/0x80
[  243.689979]  ? dpm_wait+0x40/0x40
[  243.690578]  dpm_wait+0x32/0x40
[  243.691138]  dpm_wait_fn+0x11/0x20
[  243.691735]  device_for_each_child+0x50/0x90
[  243.692476]  dpm_wait_for_subordinate+0x3e/0xc0
[  243.693470]  __device_suspend+0x39/0x390
[  243.694166]  async_suspend+0x1f/0xa0
[  243.694799]  async_run_entry_fn+0x36/0x150
[  243.695534]  process_one_work+0x1de/0x430
[  243.696239]  worker_thread+0x47/0x3f0
[  243.696885]  kthread+0x125/0x140
[  243.697456]  ? process_one_work+0x430/0x430
[  243.698195]  ? kthread_create_on_node+0x70/0x70
[  243.698988]  ret_from_fork+0x25/0x30
[  243.699654] INFO: task kworker/u8:4:152 blocked for more than 120 seconds.
[  243.700899]       Not tainted 4.13.0-pf2 #1
[  243.701638] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.702986] kworker/u8:4    D    0   152      2 0x00000000
[  243.703944] Workqueue: events_unbound async_run_entry_fn
[  243.704907] Call Trace:
[  243.705367]  __schedule+0x239/0x890
[  243.705987]  schedule+0x3d/0x90
[  243.706549]  io_schedule+0x16/0x40
[  243.707154]  blk_mq_get_tag+0x16d/0x270
[  243.707826]  ? wait_woken+0x80/0x80
[  243.708443]  blk_mq_get_request+0xed/0x3e0
[  243.709161]  blk_mq_alloc_request+0x10a/0x170
[  243.709926]  blk_get_request+0x2e/0x100
[  243.710618]  scsi_execute+0x4e/0x260 [scsi_mod]
[  243.711415]  sd_sync_cache+0xa0/0x180 [sd_mod]
[  243.712220]  sd_suspend_common+0x7b/0x130 [sd_mod]
[  243.713070]  ? scsi_print_sense+0x50/0x50 [scsi_mod]
[  243.713944]  sd_suspend_system+0x13/0x20 [sd_mod]
[  243.714776]  do_scsi_suspend+0x1b/0x20 [scsi_mod]
[  243.715617]  scsi_bus_suspend_common+0x67/0xc0 [scsi_mod]
[  243.716594]  ? device_for_each_child+0x69/0x90
[  243.717380]  scsi_bus_suspend+0x15/0x20 [scsi_mod]
[  243.718219]  dpm_run_callback+0x57/0x180
[  243.718913]  ? scsi_bus_freeze+0x20/0x20 [scsi_mod]
[  243.719952]  __device_suspend+0x11f/0x390
[  243.721146]  async_suspend+0x1f/0xa0
[  243.721788]  async_run_entry_fn+0x36/0x150
[  243.722508]  process_one_work+0x1de/0x430
[  243.723390]  worker_thread+0x47/0x3f0
[  243.724045]  kthread+0x125/0x140
[  243.724621]  ? process_one_work+0x430/0x430
[  243.725373]  ? kthread_create_on_node+0x70/0x70
[  243.726174]  ret_from_fork+0x25/0x30
[  243.726841] INFO: task kworker/u8:6:154 blocked for more than 120 seconds.
[  243.729057]       Not tainted 4.13.0-pf2 #1
[  243.730593] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.733712] kworker/u8:6    D    0   154      2 0x00000000
[  243.735820] Workqueue: events_unbound async_run_entry_fn
[  243.737556] Call Trace:
[  243.738395]  __schedule+0x239/0x890
[  243.739558]  schedule+0x3d/0x90
[  243.740599]  schedule_timeout+0x208/0x390
[  243.741924]  ? usb_set_device_state+0x9c/0x160 [usbcore]
[  243.743664]  wait_for_completion+0xa5/0x120
[  243.745048]  ? wait_for_completion+0xa5/0x120
[  243.746488]  ? wake_up_q+0x80/0x80
[  243.747625]  ? dpm_wait+0x40/0x40
[  243.748728]  dpm_wait+0x32/0x40
[  243.749774]  dpm_wait_fn+0x11/0x20
[  243.750930]  device_for_each_child+0x50/0x90
[  243.752337]  dpm_wait_for_subordinate+0x3e/0xc0
[  243.753927]  __device_suspend+0x39/0x390
[  243.755259]  async_suspend+0x1f/0xa0
[  243.756459]  async_run_entry_fn+0x36/0x150
[  243.757835]  process_one_work+0x1de/0x430
[  243.759180]  worker_thread+0x47/0x3f0
[  243.760233]  kthread+0x125/0x140
[  243.761147]  ? process_one_work+0x430/0x430
[  243.762362]  ? kthread_create_on_node+0x70/0x70
[  243.763686]  ret_from_fork+0x25/0x30
[  243.764730] INFO: task md0_raid10:170 blocked for more than 120 seconds.
[  243.766666]       Not tainted 4.13.0-pf2 #1
[  243.767874] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.770464] md0_raid10      D    0   170      2 0x00000000
[  243.771435] Call Trace:
[  243.771882]  __schedule+0x239/0x890
[  243.772500]  schedule+0x3d/0x90
[  243.773056]  io_schedule+0x16/0x40
[  243.773659]  blk_mq_get_tag+0x16d/0x270
[  243.774337]  ? wait_woken+0x80/0x80
[  243.774952]  blk_mq_get_request+0xed/0x3e0
[  243.775691]  blk_mq_make_request+0x104/0x6c0
[  243.776597]  generic_make_request+0x125/0x320
[  243.777362]  submit_bio+0x73/0x150
[  243.777959]  ? submit_bio+0x73/0x150
[  243.778594]  md_super_write.part.58+0xbd/0xe0 [md_mod]
[  243.779487]  md_update_sb.part.59+0x534/0x840 [md_mod]
[  243.780451]  md_check_recovery+0x453/0x520 [md_mod]
[  243.781306]  raid10d+0x62/0x1420 [raid10]
[  243.782006]  ? __schedule+0x241/0x890
[  243.782656]  ? schedule+0x3d/0x90
[  243.783348]  ? schedule_timeout+0x208/0x390
[  243.784081]  md_thread+0x120/0x160 [md_mod]
[  243.784812]  ? md_thread+0x120/0x160 [md_mod]
[  243.786237]  ? wait_woken+0x80/0x80
[  243.787312]  kthread+0x125/0x140
[  243.788005]  ? state_show+0x2f0/0x2f0 [md_mod]
[  243.788783]  ? kthread_create_on_node+0x70/0x70
[  243.789579]  ret_from_fork+0x25/0x30
[  243.790243] INFO: task md0_resync:172 blocked for more than 120 seconds.
[  243.791392]       Not tainted 4.13.0-pf2 #1
[  243.792119] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.794017] md0_resync      D    0   172      2 0x00000000
[  243.795085] Call Trace:
[  243.795560]  __schedule+0x239/0x890
[  243.796183]  schedule+0x3d/0x90
[  243.796758]  io_schedule+0x16/0x40
[  243.797361]  blk_mq_get_tag+0x16d/0x270
[  243.798051]  ? wait_woken+0x80/0x80
[  243.798666]  blk_mq_get_request+0xed/0x3e0
[  243.799432]  blk_mq_make_request+0x104/0x6c0
[  243.800275]  generic_make_request+0x125/0x320
[  243.801041]  raid10_sync_request+0x17f8/0x1c90 [raid10]
[  243.801951]  ? raid10_sync_request+0x17f8/0x1c90 [raid10]
[  243.802887]  ? pick_next_task_fair+0x15f/0x560
[  243.803663]  ? __switch_to+0x225/0x480
[  243.804322]  ? is_mddev_idle+0x103/0x115 [md_mod]
[  243.805158]  md_do_sync+0x8dd/0xf00 [md_mod]
[  243.805903]  ? wait_woken+0x80/0x80
[  243.806543]  md_thread+0x120/0x160 [md_mod]
[  243.807327]  ? md_thread+0x120/0x160 [md_mod]
[  243.808098]  kthread+0x125/0x140
[  243.808671]  ? state_show+0x2f0/0x2f0 [md_mod]
[  243.809447]  ? kthread_create_on_node+0x70/0x70
[  243.810270]  ? SyS_exit_group+0x14/0x20
[  243.810967]  ret_from_fork+0x25/0x30
[  243.811698] INFO: task systemd-sleep:584 blocked for more than 120 seconds.
[  243.812907]       Not tainted 4.13.0-pf2 #1
[  243.813848] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.815246] systemd-sleep   D    0   584      1 0x00000000
[  243.816210] Call Trace:
[  243.816659]  __schedule+0x239/0x890
[  243.817284]  schedule+0x3d/0x90
[  243.818250]  async_synchronize_cookie_domain+0x97/0x150
[  243.819306]  ? wait_woken+0x80/0x80
[  243.819922]  async_synchronize_full+0x17/0x20
[  243.820755]  dpm_suspend+0x214/0x310
[  243.821440]  dpm_suspend_start+0x50/0x60
[  243.822173]  suspend_devices_and_enter+0xbf/0x850
[  243.823042]  pm_suspend+0x349/0x3c0
[  243.823959]  state_store+0x5a/0x90
[  243.824601]  kobj_attr_store+0xf/0x20
[  243.825734]  sysfs_kf_write+0x37/0x40
[  243.827016]  kernfs_fop_write+0x11c/0x1a0
[  243.828456]  __vfs_write+0x37/0x150
[  243.829703]  ? handle_mm_fault+0xde/0x1e0
[  243.831142]  vfs_write+0xb1/0x1a0
[  243.832261]  SyS_write+0x55/0xc0
[  243.833355]  ? trace_do_page_fault+0x37/0xf0
[  243.834809]  entry_SYSCALL_64_fastpath+0x1a/0xa5
[  243.836418] RIP: 0033:0x7f652d246bf0
[  243.837643] RSP: 002b:00007ffc03a9b4d8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[  243.840154] RAX: ffffffffffffffda RBX: 00000000000000c6 RCX: 
00007f652d246bf0
[  243.842495] RDX: 0000000000000004 RSI: 0000557303e6a390 RDI: 
0000000000000004
[  243.844937] RBP: 000000000000270f R08: 0000557303e6a240 R09: 
00007f652d7188c0
[  243.846312] R10: 00007f652d507ad8 R11: 0000000000000246 R12: 
00007f652d507ad8
[  243.847616] R13: 0000000000001010 R14: 0000557303e6a380 R15: 
00007f652d507a80
[  243.848864] INFO: task kworker/u8:11:590 blocked for more than 120 seconds.
[  243.850085]       Not tainted 4.13.0-pf2 #1
[  243.850818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.852160] kworker/u8:11   D    0   590      2 0x00000000
[  243.853115] Workqueue: events_unbound async_run_entry_fn
[  243.854035] Call Trace:
[  243.854483]  __schedule+0x239/0x890
[  243.855100]  ? update_load_avg+0x426/0x5a0
[  243.855829]  schedule+0x3d/0x90
[  243.856389]  schedule_timeout+0x208/0x390
[  243.857093]  ? __x2apic_send_IPI_dest.constprop.3+0x31/0x40
[  243.858100]  ? x2apic_send_IPI+0x27/0x30
[  243.858801]  ? native_smp_send_reschedule+0x27/0x40
[  243.859684]  wait_for_completion+0xa5/0x120
[  243.860462]  ? wait_for_completion+0xa5/0x120
[  243.861233]  ? wake_up_q+0x80/0x80
[  243.861842]  ? dpm_wait+0x40/0x40
[  243.862435]  dpm_wait+0x32/0x40
[  243.862999]  dpm_wait_fn+0x11/0x20
[  243.863607]  device_for_each_child+0x50/0x90
[  243.864357]  dpm_wait_for_subordinate+0x3e/0xc0
[  243.865218]  __device_suspend+0x39/0x390
[  243.866341]  async_suspend+0x1f/0xa0
[  243.867388]  async_run_entry_fn+0x36/0x150
[  243.868109]  process_one_work+0x1de/0x430
[  243.868811]  worker_thread+0x47/0x3f0
[  243.869457]  kthread+0x125/0x140
[  243.870057]  ? process_one_work+0x430/0x430
[  243.870788]  ? kthread_create_on_node+0x70/0x70
[  243.871614]  ? SyS_exit_group+0x14/0x20
[  243.872291]  ret_from_fork+0x25/0x30
[  243.872934] INFO: task kworker/u8:12:591 blocked for more than 120 seconds.
[  243.875252]       Not tainted 4.13.0-pf2 #1
[  243.875992] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.877345] kworker/u8:12   D    0   591      2 0x00000000
[  243.878310] Workqueue: events_unbound async_run_entry_fn
[  243.879239] Call Trace:
[  243.879693]  __schedule+0x239/0x890
[  243.880418]  schedule+0x3d/0x90
[  243.881017]  schedule_timeout+0x208/0x390
[  243.881763]  ? select_idle_sibling+0x393/0x430
[  243.882587]  ? update_load_avg+0x426/0x5a0
[  243.883462]  wait_for_completion+0xa5/0x120
[  243.884400]  ? wait_for_completion+0xa5/0x120
[  243.885457]  ? wake_up_q+0x80/0x80
[  243.886160]  ? dpm_wait+0x40/0x40
[  243.887167]  dpm_wait+0x32/0x40
[  243.888061]  dpm_wait_fn+0x11/0x20
[  243.889133]  device_for_each_child+0x50/0x90
[  243.890694]  dpm_wait_for_subordinate+0x3e/0xc0
[  243.892233]  __device_suspend+0x39/0x390
[  243.893556]  async_suspend+0x1f/0xa0
[  243.894759]  async_run_entry_fn+0x36/0x150
[  243.895702]  process_one_work+0x1de/0x430
[  243.896466]  worker_thread+0x47/0x3f0
[  243.897120]  kthread+0x125/0x140
[  243.897699]  ? process_one_work+0x430/0x430
[  243.898436]  ? kthread_create_on_node+0x70/0x70
[  243.899245]  ret_from_fork+0x25/0x30
[  243.899895] INFO: task kworker/u8:19:598 blocked for more than 120 seconds.
[  243.901149]       Not tainted 4.13.0-pf2 #1
[  243.901876] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  243.903364] kworker/u8:19   D    0   598      2 0x00000000
[  243.905217] Workqueue: events_unbound async_run_entry_fn
[  243.906205] Call Trace:
[  243.906676]  __schedule+0x239/0x890
[  243.907300]  ? update_load_avg+0x426/0x5a0
[  243.908024]  schedule+0x3d/0x90
[  243.908586]  schedule_timeout+0x208/0x390
[  243.909297]  ? resched_curr+0x57/0xd0
[  243.909948]  ? check_preempt_wakeup+0x130/0x240
[  243.910761]  wait_for_completion+0xa5/0x120
[  243.911502]  ? wait_for_completion+0xa5/0x120
[  243.912269]  ? wake_up_q+0x80/0x80
[  243.912910]  ? dpm_wait+0x40/0x40
[  243.913572]  dpm_wait+0x32/0x40
[  243.914428]  dpm_wait_fn+0x11/0x20
[  243.915444]  device_for_each_child+0x50/0x90
[  243.916198]  dpm_wait_for_subordinate+0x3e/0xc0
[  243.917014]  __device_suspend+0x39/0x390
[  243.917714]  async_suspend+0x1f/0xa0
[  243.918400]  async_run_entry_fn+0x36/0x150
[  243.919122]  process_one_work+0x1de/0x430
[  243.919823]  worker_thread+0x47/0x3f0
[  243.920589]  kthread+0x125/0x140
[  243.921213]  ? process_one_work+0x430/0x430
[  243.922220]  ? kthread_create_on_node+0x70/0x70
[  243.923030]  ret_from_fork+0x25/0x30
===
