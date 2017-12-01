Return-Path: <ivan@ludios.org>
Return-Path: <ivan@ludios.org>
From: ivan@ludios.org
To: axboe@kernel.dk, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, oleksandr@natalenko.name
Subject: blk-mq + bfq IO hangs after writing partition table
Date: Fri, 01 Dec 2017 06:52:37 +0000
Message-ID: <87fu8v7xe2.fsf@ksca2.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Hi,

I think I am triggering a blk-mq + bfq bug that I can reproduce 100%
of the time by using gdisk (1.0.1-1 in Debian stretch) to write a
partition table to a USB flash drive.  After it is triggered, IO hangs
forever to that device and the machine cannot be shut down cleanly.
I have reproduced this on two very different amd64 machines and two
different USB drives.  I don't know if this affects other storage
devices.  This happens *only* with blk-mq + bfq, never with mq-deadline
or kyber.

I built df8ba95c572a187ed2aa7403e97a7a7f58c01f00 (2017-11-30) from
Linus's tree with make-kpkg, without patches of any sort.

My cmdline was:
scsi_mod.use_blk_mq=y dm_mod.use_blk_mq=y apparmor=1 security=apparmor

.config file:
https://gist.githubusercontent.com/ivan/35935783e3153878ce650ab105c1695f/raw/b3de6c85eabd342118b5fecf2b4fab362bde7aa6/config

To reproduce:
boot with blk-mq
plug in a USB stick without any data you want to keep
echo bfq > /sys/block/sdX/queue/scheduler
gdisk /dev/sdX
delete some partitions or add some partitions
"w" to write the partition table
observe IO hang and call trace (below) in the journal after 2 minutes

Note the log below does not show "bfq" because it was loaded earlier.

If it does not reproduce, try another USB flash drive; if that does not
reproduce, cat /dev/zero over it first.

Best regards,

Ivan

Dec 01 05:12:17 kernel: usb 3-1: new high-speed USB device number 2 using xhci_hcd
Dec 01 05:12:18 kernel: usb 3-1: New USB device found, idVendor=26bf, idProduct=201a
Dec 01 05:12:18 kernel: usb 3-1: New USB device strings: Mfr=0, Product=3, SerialNumber=4
Dec 01 05:12:18 kernel: usb 3-1: Product: STORAGE DEVICE
Dec 01 05:12:18 kernel: usb 3-1: SerialNumber: 44705421454402634814
Dec 01 05:12:18 mtp-probe[3289]: checking bus 3, device 2: "/sys/devices/pci0000:00/0000:00:1c.7/0000:26:00.0/usb3/3-1"
Dec 01 05:12:18 mtp-probe[3289]: bus: 3, device: 2 was not an MTP device
Dec 01 05:12:18 kernel: usb-storage 3-1:1.0: USB Mass Storage device detected
Dec 01 05:12:18 kernel: scsi host6: usb-storage 3-1:1.0
Dec 01 05:12:18 kernel: usbcore: registered new interface driver usb-storage
Dec 01 05:12:18 kernel: usbcore: registered new interface driver uas
Dec 01 05:12:19 kernel: scsi 6:0:0:0: Direct-Access     Specific STORAGE DEVICE   0009 PQ: 0 ANSI: 5
Dec 01 05:12:19 kernel: sd 6:0:0:0: Attached scsi generic sg2 type 0
Dec 01 05:12:19 kernel: sd 6:0:0:0: [sdc] 7864320 512-byte logical blocks: (4.03 GB/3.75 GiB)
Dec 01 05:12:19 kernel: sd 6:0:0:0: [sdc] Attached SCSI removable disk
Dec 01 05:12:19 kernel:  sdc:
Dec 01 05:12:24 kernel:  sdc:
Dec 01 05:12:35 kernel:  sdc: sdc1 sdc2
Dec 01 05:12:36 kernel:  sdc: sdc1 sdc2
Dec 01 05:12:40 kernel: io scheduler kyber registered
Dec 01 05:12:41 kernel:  sdc: sdc1 sdc2
Dec 01 05:12:52 kernel:  sdc: sdc1
Dec 01 05:12:53 kernel:  sdc: sdc1
Dec 01 05:12:59 kernel:  sdc: sdc1
Dec 01 05:14:00 systemd-udevd[331]: seq 2520 '/devices/pci0000:00/0000:00:1c.7/0000:26:00.0/usb3/3-1/3-1:1.0/host6/target6:0:0/6:0:0:0/block/sdc' is taking a long time
Dec 01 05:14:05 systemd[1]: Started Getty on tty3.
Dec 01 05:14:09 login[3339]: pam_unix(login:session): session opened for user root by LOGIN(uid=0)
Dec 01 05:14:09 systemd[1]: Created slice User Slice of root.
Dec 01 05:14:09 systemd[1]: Starting User Manager for UID 0...
Dec 01 05:14:09 systemd[3344]: pam_unix(systemd-user:session): session opened for user root by (uid=0)
Dec 01 05:14:09 systemd-logind[545]: New session 3 of user root.
Dec 01 05:14:09 systemd[1]: Started Session 3 of user root.
Dec 01 05:14:09 systemd[3344]: Reached target Paths.
Dec 01 05:14:09 systemd[3344]: Starting D-Bus User Message Bus Socket.
Dec 01 05:14:09 systemd[3344]: Listening on GnuPG cryptographic agent and passphrase cache (restricted).
Dec 01 05:14:09 systemd[3344]: Listening on GnuPG cryptographic agent and passphrase cache.
Dec 01 05:14:09 systemd[3344]: Listening on GnuPG cryptographic agent (access for web browsers).
Dec 01 05:14:09 systemd[3344]: Listening on GnuPG cryptographic agent (ssh-agent emulation).
Dec 01 05:14:09 systemd[3344]: Reached target Timers.
Dec 01 05:14:09 systemd[3344]: Listening on D-Bus User Message Bus Socket.
Dec 01 05:14:09 systemd[3344]: Reached target Sockets.
Dec 01 05:14:09 systemd[3344]: Reached target Basic System.
Dec 01 05:14:09 systemd[3344]: Reached target Default.
Dec 01 05:14:09 systemd[3344]: Startup finished in 13ms.
Dec 01 05:14:09 systemd[1]: Started User Manager for UID 0.
Dec 01 05:14:09 login[3350]: ROOT LOGIN  on '/dev/tty3'
Dec 01 05:15:23 kernel: INFO: task kworker/2:1:34 blocked for more than 120 seconds.
Dec 01 05:15:23 kernel:       Not tainted 4.15.0-rc1+ #2
Dec 01 05:15:23 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 01 05:15:23 kernel: kworker/2:1     D    0    34      2 0x80000000
Dec 01 05:15:23 kernel: Workqueue: events_freezable_power_ disk_events_workfn
Dec 01 05:15:23 kernel: Call Trace:
Dec 01 05:15:23 kernel:  ? __schedule+0x3cb/0x850
Dec 01 05:15:23 kernel:  schedule+0x32/0x80
Dec 01 05:15:23 kernel:  io_schedule+0x12/0x40
Dec 01 05:15:23 kernel:  blk_mq_get_tag+0x15e/0x250
Dec 01 05:15:23 kernel:  ? remove_wait_queue+0x60/0x60
Dec 01 05:15:23 kernel:  blk_mq_get_request+0xcb/0x390
Dec 01 05:15:23 kernel:  blk_mq_alloc_request+0x7d/0xd0
Dec 01 05:15:23 kernel:  blk_get_request_flags+0x40/0x190
Dec 01 05:15:23 kernel:  scsi_execute+0x38/0x250 [scsi_mod]
Dec 01 05:15:23 kernel:  scsi_test_unit_ready+0x75/0xf0 [scsi_mod]
Dec 01 05:15:23 kernel:  sd_check_events+0x125/0x1a0 [sd_mod]
Dec 01 05:15:23 kernel:  disk_check_events+0x63/0x150
Dec 01 05:15:23 kernel:  process_one_work+0x184/0x380
Dec 01 05:15:23 kernel:  worker_thread+0x4d/0x3c0
Dec 01 05:15:23 kernel:  kthread+0xf5/0x130
Dec 01 05:15:23 kernel:  ? process_one_work+0x380/0x380
Dec 01 05:15:23 kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
Dec 01 05:15:23 kernel:  ret_from_fork+0x1f/0x30
Dec 01 05:15:23 kernel: INFO: task kworker/u16:3:131 blocked for more than 120 seconds.
Dec 01 05:15:23 kernel:       Not tainted 4.15.0-rc1+ #2
Dec 01 05:15:23 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 01 05:15:23 kernel: kworker/u16:3   D    0   131      2 0x80000000
Dec 01 05:15:23 kernel: Workqueue: writeback wb_workfn (flush-8:32)
Dec 01 05:15:23 kernel: Call Trace:
Dec 01 05:15:23 kernel:  ? __schedule+0x3cb/0x850
Dec 01 05:15:23 kernel:  schedule+0x32/0x80
Dec 01 05:15:23 kernel:  io_schedule+0x12/0x40
Dec 01 05:15:23 kernel:  blk_mq_get_tag+0x15e/0x250
Dec 01 05:15:23 kernel:  ? elv_merge+0x69/0xe0
Dec 01 05:15:23 kernel:  ? remove_wait_queue+0x60/0x60
Dec 01 05:15:23 kernel:  blk_mq_get_request+0xcb/0x390
Dec 01 05:15:23 kernel:  blk_mq_make_request+0x12b/0x5e0
Dec 01 05:15:23 kernel:  generic_make_request+0x11e/0x2f0
Dec 01 05:15:23 kernel:  ? submit_bio+0x6c/0x140
Dec 01 05:15:23 kernel:  submit_bio+0x6c/0x140
Dec 01 05:15:23 kernel:  ? guard_bio_eod+0x26/0xe0
Dec 01 05:15:23 kernel:  submit_bh_wbc+0x14b/0x170
Dec 01 05:15:23 kernel:  __block_write_full_page+0x17c/0x400
Dec 01 05:15:23 kernel:  ? I_BDEV+0x10/0x10
Dec 01 05:15:23 kernel:  ? page_referenced_one+0x160/0x160
Dec 01 05:15:23 kernel:  __writepage+0x13/0x50
Dec 01 05:15:23 kernel:  write_cache_pages+0x1ed/0x430
Dec 01 05:15:23 kernel:  ? __wb_calc_thresh+0x130/0x130
Dec 01 05:15:23 kernel:  ? bit_clear+0x110/0x110
Dec 01 05:15:23 kernel:  ? drm_fb_helper_cfb_fillrect+0x12/0x30 [drm_kms_helper]
Dec 01 05:15:23 kernel:  generic_writepages+0x61/0xa0
Dec 01 05:15:23 kernel:  ? do_writepages+0x17/0x60
Dec 01 05:15:23 kernel:  do_writepages+0x17/0x60
Dec 01 05:15:23 kernel:  __writeback_single_inode+0x3d/0x310
Dec 01 05:15:23 kernel:  writeback_sb_inodes+0x221/0x4b0
Dec 01 05:15:23 kernel:  __writeback_inodes_wb+0x87/0xb0
Dec 01 05:15:23 kernel:  wb_writeback+0x282/0x310
Dec 01 05:15:23 kernel:  ? cpumask_next+0x16/0x20
Dec 01 05:15:23 kernel:  ? wb_workfn+0x345/0x450
Dec 01 05:15:23 kernel:  wb_workfn+0x345/0x450
Dec 01 05:15:23 kernel:  process_one_work+0x184/0x380
Dec 01 05:15:23 kernel:  worker_thread+0x4d/0x3c0
Dec 01 05:15:23 kernel:  kthread+0xf5/0x130
Dec 01 05:15:23 kernel:  ? process_one_work+0x380/0x380
Dec 01 05:15:23 kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
Dec 01 05:15:23 kernel:  ret_from_fork+0x1f/0x30
Dec 01 05:15:23 kernel: INFO: task gdisk:3337 blocked for more than 120 seconds.
Dec 01 05:15:23 kernel:       Not tainted 4.15.0-rc1+ #2
Dec 01 05:15:23 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 01 05:15:23 kernel: gdisk           D    0  3337   3253 0x00000000
Dec 01 05:15:23 kernel: Call Trace:
Dec 01 05:15:23 kernel:  ? __schedule+0x3cb/0x850
Dec 01 05:15:23 kernel:  schedule+0x32/0x80
Dec 01 05:15:23 kernel:  io_schedule+0x12/0x40
Dec 01 05:15:23 kernel:  blk_mq_get_tag+0x15e/0x250
Dec 01 05:15:23 kernel:  ? elv_merge+0x69/0xe0
Dec 01 05:15:23 kernel:  ? remove_wait_queue+0x60/0x60
Dec 01 05:15:23 kernel:  blk_mq_get_request+0xcb/0x390
Dec 01 05:15:23 kernel:  blk_mq_make_request+0x12b/0x5e0
Dec 01 05:15:23 kernel:  generic_make_request+0x11e/0x2f0
Dec 01 05:15:23 kernel:  ? submit_bio+0x6c/0x140
Dec 01 05:15:23 kernel:  submit_bio+0x6c/0x140
Dec 01 05:15:23 kernel:  ? guard_bio_eod+0x26/0xe0
Dec 01 05:15:23 kernel:  submit_bh_wbc+0x14b/0x170
Dec 01 05:15:23 kernel:  __block_write_full_page+0x17c/0x400
Dec 01 05:15:23 kernel:  ? I_BDEV+0x10/0x10
Dec 01 05:15:23 kernel:  ? page_referenced_one+0x160/0x160
Dec 01 05:15:23 kernel:  __writepage+0x13/0x50
Dec 01 05:15:23 kernel:  write_cache_pages+0x1ed/0x430
Dec 01 05:15:23 kernel:  ? __wb_calc_thresh+0x130/0x130
Dec 01 05:15:23 kernel:  ? _cond_resched+0x16/0x40
Dec 01 05:15:23 kernel:  ? flush_work+0x43/0x1d0
Dec 01 05:15:23 kernel:  ? pick_next_task_fair+0x308/0x5d0
Dec 01 05:15:23 kernel:  generic_writepages+0x61/0xa0
Dec 01 05:15:23 kernel:  ? fdatawait_one_bdev+0x20/0x20
Dec 01 05:15:23 kernel:  ? do_writepages+0x17/0x60
Dec 01 05:15:23 kernel:  do_writepages+0x17/0x60
Dec 01 05:15:23 kernel:  __filemap_fdatawrite_range+0xc8/0x100
Dec 01 05:15:23 kernel:  ? _xfs_log_force+0x8a/0x2a0 [xfs]
Dec 01 05:15:23 kernel:  iterate_bdevs+0x140/0x150
Dec 01 05:15:23 kernel:  sys_sync+0x6e/0xb0
Dec 01 05:15:23 kernel:  entry_SYSCALL_64_fastpath+0x1e/0x81
Dec 01 05:15:23 kernel: RIP: 0033:0x7f0b4eaeb5e7
Dec 01 05:15:23 kernel: RSP: 002b:00007ffdaa3c1db8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
Dec 01 05:15:23 kernel: RAX: ffffffffffffffda RBX: 00007ffdaa3c3878 RCX: 00007f0b4eaeb5e7
Dec 01 05:15:23 kernel: RDX: 00007ffdaa3c1cf0 RSI: 00007ffdaa3c1cf0 RDI: 0000000000000003
Dec 01 05:15:23 kernel: RBP: 00007ffdaa3c1b80 R08: 00005640d1adf940 R09: 0000000000000210
Dec 01 05:15:23 kernel: R10: 0000000000016830 R11: 0000000000000202 R12: 0000000000000001
Dec 01 05:15:23 kernel: R13: 00007ffdaa3c3878 R14: 0000000000000000 R15: 00007ffdaa3c26a2
Dec 01 05:16:00 systemd-udevd[331]: seq 2520 '/devices/pci0000:00/0000:00:1c.7/0000:26:00.0/usb3/3-1/3-1:1.0/host6/target6:0:0/6:0:0:0/block/sdc' killed
