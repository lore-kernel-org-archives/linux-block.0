Return-Path: <jarkko.nikula@linux.intel.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: SDHCI Regression with 6ce3dd6eec11 ("blk-mq: issue directly if hw
 queue isn't busy in case of 'none'")
To: linux-block@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <855d68f2-17ed-eaae-2f13-d0ff95b6834f@linux.intel.com>
Date: Tue, 21 Aug 2018 15:37:46 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi

I bisected some kind of SDHCI regression to commit 6ce3dd6eec11 
("blk-mq: issue directly if hw queue isn't busy in case of 'none'") 
causing dumps below and one or more systemd-udevd processes being in 
uninterruptible sleep state preventing safe reboot/shutdown.

This is from an Intel Baytrail based tablet with integrated eMMC but my 
up-to-date Debian/testing rootfs (with systemd) is on USB stick.

It doesn't revert cleanly on today's head 778a33959a8a but issue is gone 
if I go to a commit before 6ce3dd6eec11 and occurs at 6ce3dd6eec11.

# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
# CONFIG_CFQ_GROUP_IOSCHED is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

[   15.722769] WARNING: CPU: 1 PID: 156 at drivers/mmc/host/sdhci.c:1239 
sdhci_send_command+0x673/0xb40
[   15.733094] Modules linked in: wdat_wdt regmap_i2c video lpc_ich 
sysfillrect sysimgblt fb_sys_fops processor_thermal_device i2c_hid 
intel_soc_dts_iosf int3403_thermal drm int340x_thermal_zone 
int3400_thermal acpi_thermal_rel i2c_designware_platform 
i2c_designware_core i2c_core button loop
[   15.761805] CPU: 1 PID: 156 Comm: systemd-udevd Not tainted 
4.18.0-rc4+ #23
[   15.769602] RIP: 0010:sdhci_send_command+0x673/0xb40
[   15.775155] Code: 18 48 c7 c6 38 16 ea 81 48 c7 c7 20 57 0e 82 e8 43 
1f d8 ff eb 9e 66 8b 40 0c 83 e0 f3 48 8b 53 18 66 89 42 0c e9 68 fd ff 
ff <0f> 0b e9 5a fa ff ff 0f 0b 0f 0b e9 a9 fa ff ff 0f 0b 0f 0b 0f 0b
[   15.796611] RSP: 0018:ffffc900003877e0 EFLAGS: 00010086
[   15.802464] RAX: 000000001fff0000 RBX: ffff88003676a7c0 RCX: 
0000001095761c20
[   15.810448] RDX: 0000000000145650 RSI: 0000000000000001 RDI: 
000000000014564b
[   15.818432] RBP: ffffc90000387850 R08: 000000007915b4a3 R09: 
0000000000000000
[   15.826415] R10: 0000000000000002 R11: ffff880035865180 R12: 
ffff880035e98e10
[   15.834398] R13: ffff880035e98e90 R14: 0000000000000003 R15: 
ffff88003676a7c0
[   15.842382] FS:  0000000000000000(0000) GS:ffff88003c480000(0063) 
knlGS:00000000f7b91800
[   15.851434] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   15.857852] CR2: 0000000057b55000 CR3: 000000003503d000 CR4: 
00000000001006e0
[   15.865833] Call Trace:
[   15.868574]  sdhci_request+0xb2/0x100
[   15.872674]  __mmc_start_request+0x7e/0x270
[   15.877354]  mmc_start_request+0x90/0xb0
[   15.881743]  mmc_blk_mq_issue_rq+0x2d0/0x824
[   15.886520]  mmc_mq_queue_rq+0x12c/0x240
[   15.890911]  __blk_mq_try_issue_directly+0x11e/0x1c0
[   15.896465]  blk_mq_request_issue_directly+0x60/0x90
[   15.902020]  blk_mq_try_issue_list_directly+0x3f/0x80
[   15.907672]  blk_mq_sched_insert_requests+0x87/0xa0
[   15.913130]  blk_mq_flush_plug_list+0x1ab/0x450
[   15.918200]  blk_flush_plug_list+0xe2/0x240
[   15.922880]  blk_finish_plug+0x21/0x2f
[   15.927074]  read_pages+0x7d/0x160
[   15.930880]  __do_page_cache_readahead+0x2af/0x2d0
[   15.936240]  force_page_cache_readahead+0x93/0xf0
[   15.941503]  page_cache_sync_readahead+0x211/0x220
[   15.946863]  generic_file_buffered_read+0x486/0x6f0
[   15.952320]  generic_file_read_iter+0xc6/0x130
[   15.957292]  blkdev_read_iter+0x30/0x40
[   15.961584]  __vfs_read+0x11e/0x160
[   15.965486]  vfs_read+0x9a/0x150
[   15.969098]  ksys_read+0x53/0xc0
[   15.972708]  __ia32_sys_read+0x13/0x20
[   15.976903]  do_fast_syscall_32+0x95/0x2d0
[   15.981487]  entry_SYSENTER_compat+0x6d/0x7c
[   15.986263] RIP: 0023:0xf7f03b29
[   15.989863] Code: 55 08 8b 88 5c cd ff ff 8b 98 60 cd ff ff 89 c8 85 
d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 
80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
[   16.011274] RSP: 002b:00000000fff26f90 EFLAGS: 00000246 ORIG_RAX: 
0000000000000003
[   16.019746] RAX: ffffffffffffffda RBX: 000000000000000f RCX: 
0000000057b14dac
[   16.027727] RDX: 0000000000000561 RSI: 0000000057b0c1a8 RDI: 
0000000000000561
[   16.035708] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[   16.043688] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[   16.051669] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[   16.059651] irq event stamp: 47406
[   16.063457] hardirqs last  enabled at (47405): [<ffffffff817052e6>] 
_raw_spin_unlock_irqrestore+0x46/0x60
[   16.074160] hardirqs last disabled at (47406): [<ffffffff81705143>] 
_raw_spin_lock_irqsave+0x13/0x50
[   16.084370] softirqs last  enabled at (47180): [<ffffffff81a0027f>] 
__do_softirq+0x27f/0x50b
[   16.093811] softirqs last disabled at (47161): [<ffffffff8105dda7>] 
irq_exit+0x97/0xd0
[   16.102667] ---[ end trace c6109d18f8ad2675 ]---
[   16.107856] WARNING: CPU: 1 PID: 156 at drivers/mmc/host/sdhci.c:890 
sdhci_send_command+0x67c/0xb40
[   16.117967] Modules linked in: wdat_wdt regmap_i2c video lpc_ich 
sysfillrect sysimgblt fb_sys_fops processor_thermal_device i2c_hid 
intel_soc_dts_iosf int3403_thermal drm int340x_thermal_zone 
int3400_thermal acpi_thermal_rel i2c_designware_platform 
i2c_designware_core i2c_core button loop
[   16.146643] CPU: 1 PID: 156 Comm: systemd-udevd Tainted: G        W 
       4.18.0-rc4+ #23
[   16.155988] RIP: 0010:sdhci_send_command+0x67c/0xb40
[   16.161540] Code: c7 c7 20 57 0e 82 e8 43 1f d8 ff eb 9e 66 8b 40 0c 
83 e0 f3 48 8b 53 18 66 89 42 0c e9 68 fd ff ff 0f 0b e9 5a fa ff ff 0f 
0b <0f> 0b e9 a9 fa ff ff 0f 0b 0f 0b 0f 0b e9 e9 fc ff ff f6 43 09 10
[   16.182942] RSP: 0018:ffffc900003877e0 EFLAGS: 00010082
[   16.188791] RAX: ffffc900001a9000 RBX: ffff88003676a7c0 RCX: 
0000000002ff000b
[   16.196772] RDX: 0000000000000000 RSI: ffff880035e98e90 RDI: 
000000000bebc200
[   16.204752] RBP: ffffc90000387850 R08: 000000007915b4a3 R09: 
0000000000000000
[   16.212733] R10: 0000000000000002 R11: ffff880035865180 R12: 
ffff880035e98e10
[   16.220714] R13: ffff880035e98e90 R14: 0000000000000003 R15: 
ffff88003676a7c0
[   16.228696] FS:  0000000000000000(0000) GS:ffff88003c480000(0063) 
knlGS:00000000f7b91800
[   16.237746] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   16.244172] CR2: 0000000057b55000 CR3: 000000003503d000 CR4: 
00000000001006e0
[   16.252153] Call Trace:
[   16.254891]  sdhci_request+0xb2/0x100
[   16.258988]  __mmc_start_request+0x7e/0x270
[   16.263668]  mmc_start_request+0x90/0xb0
[   16.268057]  mmc_blk_mq_issue_rq+0x2d0/0x824
[   16.272833]  mmc_mq_queue_rq+0x12c/0x240
[   16.277213]  __blk_mq_try_issue_directly+0x11e/0x1c0
[   16.282769]  blk_mq_request_issue_directly+0x60/0x90
[   16.288324]  blk_mq_try_issue_list_directly+0x3f/0x80
[   16.293975]  blk_mq_sched_insert_requests+0x87/0xa0
[   16.299432]  blk_mq_flush_plug_list+0x1ab/0x450
[   16.304492]  blk_flush_plug_list+0xe2/0x240
[   16.309172]  blk_finish_plug+0x21/0x2f
[   16.313366]  read_pages+0x7d/0x160
[   16.317163]  __do_page_cache_readahead+0x2af/0x2d0
[   16.322523]  force_page_cache_readahead+0x93/0xf0
[   16.327786]  page_cache_sync_readahead+0x211/0x220
[   16.333145]  generic_file_buffered_read+0x486/0x6f0
[   16.338594]  generic_file_read_iter+0xc6/0x130
[   16.343565]  blkdev_read_iter+0x30/0x40
[   16.347847]  __vfs_read+0x11e/0x160
[   16.351750]  vfs_read+0x9a/0x150
[   16.355360]  ksys_read+0x53/0xc0
[   16.358962]  __ia32_sys_read+0x13/0x20
[   16.363156]  do_fast_syscall_32+0x95/0x2d0
[   16.367730]  entry_SYSENTER_compat+0x6d/0x7c
[   16.372507] RIP: 0023:0xf7f03b29
[   16.376106] Code: 55 08 8b 88 5c cd ff ff 8b 98 60 cd ff ff 89 c8 85 
d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 
80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
[   16.397519] RSP: 002b:00000000fff26f90 EFLAGS: 00000246 ORIG_RAX: 
0000000000000003
[   16.405992] RAX: ffffffffffffffda RBX: 000000000000000f RCX: 
0000000057b14dac
[   16.413973] RDX: 0000000000000561 RSI: 0000000057b0c1a8 RDI: 
0000000000000561
[   16.421953] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[   16.429934] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[   16.437914] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[   16.445896] irq event stamp: 47406
[   16.449701] hardirqs last  enabled at (47405): [<ffffffff817052e6>] 
_raw_spin_unlock_irqrestore+0x46/0x60
[   16.460405] hardirqs last disabled at (47406): [<ffffffff81705143>] 
_raw_spin_lock_irqsave+0x13/0x50
[   16.470623] softirqs last  enabled at (47180): [<ffffffff81a0027f>] 
__do_softirq+0x27f/0x50b
[   16.480063] softirqs last disabled at (47161): [<ffffffff8105dda7>] 
irq_exit+0x97/0xd0
[   16.488917] ---[ end trace c6109d18f8ad2676 ]---
[   16.494309] mmc2: Got data interrupt 0x00000002 even though no data 
operation was in progress.
[   16.504042] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
[   16.511253] mmc2: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
[   16.518462] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[   16.525669] mmc2: sdhci: Argument:  0x00d81a00 | Trn mode: 0x0000003b
[   16.532877] mmc2: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000034
[   16.540084] mmc2: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
[   16.547291] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[   16.554499] mmc2: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
[   16.561707] mmc2: sdhci: Int enab:  0x02ff000b | Sig enab: 0x02ff000b
[   16.568913] mmc2: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
[   16.576120] mmc2: sdhci: Caps:      0x446cc801 | Caps_1:   0x00000807
[   16.583328] mmc2: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[   16.590536] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xfff6dbff
[   16.597742] mmc2: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x00000900
[   16.604949] mmc2: sdhci: Host ctl2: 0x0000008b
[   16.609921] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x35e00208
[   16.617127] mmc2: sdhci: ============================================
