Return-Path: <bootc@boo.tc>
To: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
From: Chris Boot <bootc@boo.tc>
Subject: Hard lockup in blk_mq_free_request() / wbt_done() / wake_up_all()
Message-ID: <9788e0e6-a448-bf85-1f41-88f42dc0071d@boo.tc>
Date: Tue, 12 Jun 2018 16:38:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi folks,

I maintain a large (to me) system with 112 threads (4x Intel E7-4830 v4)
which has a MegaRAID SAS 9361-24i controller. This system is currently
running Debian's 4.16.12 kernel (from stretch-backports) with blk_mq
enabled.

I've run into a lockup which appears to involve blq_mq and writeback
throttling. It's hard to tell if I've run into this same thing with
older kernels; I'm trying to track down a deadlock but so far I've been
fairly certain that involved the OOM killer, but this doesn't seem to.

I've disabled blk_mq and I'm trying to reproduce the other lockup but in
the mean time I'm mailing about this. Is this something new that I've
stumbled across? I've had a look in the Git history from
4.16..8efcf34a2639 but nothing obvious pops out at me.

Console output below:

[ 6528.523172] NMI watchdog: Watchdog detected hard LOCKUP on cpu 39
[ 6528.523174] Modules linked in: netconsole configfs nfsv3 rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iTCO_wdt iTCO_vendor_support xfs intel_cstate ast ttm intel_uncore libcrc32c drm_kms_helper intel_rapl_perf drm sg i2c_algo_bit pcspkr tpm_tis mei_me tpm_tis_core tpm evdev joydev mei ioatdma shpchp lpc_ich wmi rng_core acp
i_pad button nfsd auth_rpcgss nfs_acl lockd grace sunrpc ipmi_si ipmi_poweroff ipmi_devintf ipmi_msghandler ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb dm_mod sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper nvme nvme_core ahci libahci ehci_pci ehci_hcd
[ 6528.523230]  libata megaraid_sas usbcore scsi_mod i2c_i801 ixgbe usb_common dca mdio
[ 6528.523239] CPU: 39 PID: 0 Comm: swapper/39 Not tainted 4.16.0-0.bpo.2-amd64 #1 Debian 4.16.12-1~bpo9+1
[ 6528.523240] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS 3.0a 05/30/2017
[ 6528.523250] RIP: 0010:native_queued_spin_lock_slowpath+0x115/0x190
[ 6528.523251] RSP: 0000:ffff9001ff8c3d18 EFLAGS: 00000046
[ 6528.523253] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9001ff8e2480
[ 6528.523254] RDX: 000000000000005f RSI: 0000000001800000 RDI: ffff8fe1fb7af9e8
[ 6528.523254] RBP: 00000000ffc2b312 R08: 0000000000a00000 R09: 0000000000000000
[ 6528.523255] R10: 00000000000002fb R11: 0000000000000027 R12: 0000000000000002
[ 6528.523256] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
[ 6528.523258] FS:  0000000000000000(0000) GS:ffff9001ff8c0000(0000) knlGS:0000000000000000
[ 6528.523259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6528.523259] CR2: 0000555fc96a7708 CR3: 00000031ad40a003 CR4: 00000000003606e0
[ 6528.523261] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6528.523261] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6528.523262] Call Trace:
[ 6528.523266]  <IRQ>
[ 6528.523270]  _raw_spin_lock_irqsave+0x32/0x40
[ 6528.523275]  __wake_up_common_lock+0x63/0xc0
[ 6528.523283]  wbt_done+0x6a/0x90
[ 6528.523286]  blk_mq_free_request+0xbc/0x190
[ 6528.523302]  scsi_end_request+0x95/0x1e0 [scsi_mod]
[ 6528.523308]  scsi_io_completion+0x409/0x680 [scsi_mod]
[ 6528.523310]  __blk_mq_complete_request+0xba/0x170
[ 6528.523312]  blk_mq_complete_request+0x50/0xa0
[ 6528.523317]  complete_cmd_fusion+0x23a/0x4a0 [megaraid_sas]
[ 6528.523321]  megasas_isr_fusion+0x36/0x180 [megaraid_sas]
[ 6528.523323]  __handle_irq_event_percpu+0x81/0x190
[ 6528.523325]  handle_irq_event_percpu+0x30/0x80
[ 6528.523327]  handle_irq_event+0x3c/0x60
[ 6528.523329]  handle_edge_irq+0x94/0x1f0
[ 6528.523335]  handle_irq+0x1f/0x30
[ 6528.523339]  do_IRQ+0x41/0xc0
[ 6528.523341]  common_interrupt+0xf/0xf
[ 6528.523342]  </IRQ>
[ 6528.523346] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
[ 6528.523346] RSP: 0000:ffff9b6c0c663e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
[ 6528.523348] RAX: ffff9001ff8e18c0 RBX: 0000000000000002 RCX: 000000000000001f
[ 6528.523349] RDX: 000005edfeda7b89 RSI: 0000000040000219 RDI: 0000000000000000
[ 6528.523350] RBP: ffff9001ff8eab20 R08: 000000000000004a R09: 0000000000000018
[ 6528.523350] R10: 00000000000002da R11: 000000000000004a R12: ffffffff910b2c78
[ 6528.523351] R13: 0000000000000002 R14: 0000000000000002 R15: 000005edfeda3109
[ 6528.523355]  do_idle+0x193/0x200
[ 6528.523357]  cpu_startup_entry+0x6f/0x80
[ 6528.523362]  start_secondary+0x1a4/0x1f0
[ 6528.523366]  secondary_startup_64+0xa5/0xb0
[ 6528.523367] Code: 12 83 e0 03 83 ea 01 48 c1 e0 04 48 63 d2 48 05 80 24 02 00 48 03 04 d5 80 e4 ea 90 48 89 08 8b 41 08 85 c0 75 09 f3 90 8b 41 08 <85> c0 74 f7 4c 8b 09 4d 85 c9 74 08 41 0f 0d 09 eb 02 f3 90 8b 
[ 6540.752247] INFO: rcu_sched detected stalls on CPUs/tasks:
[ 6540.753441]  39-...0: (1 GPs behind) idle=2be/0/1 softirq=118190/119299 fqs=2283 
[ 6540.754342]  (detected by 36, t=5252 jiffies, g=160509, c=160508, q=190578)
[ 6540.755220] Sending NMI from CPU 36 to CPUs 39:
[ 6540.756066] NMI backtrace for cpu 39
[ 6540.756070] CPU: 39 PID: 0 Comm: swapper/39 Not tainted 4.16.0-0.bpo.2-amd64 #1 Debian 4.16.12-1~bpo9+1
[ 6540.756071] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS 3.0a 05/30/2017
[ 6540.756080] RIP: 0010:enqueue_task_fair+0x3e/0x7d0
[ 6540.756081] RSP: 0000:ffff9001ff8c3bc8 EFLAGS: 00000082
[ 6540.756083] RAX: 0000000000000027 RBX: ffff9001f0673b00 RCX: ffff9001ff8c3c70
[ 6540.756083] RDX: 0000000000000004 RSI: 000005f2e371165e RDI: ffff9011f8e76808
[ 6540.756084] RBP: ffff9001f0673b80 R08: 0000000000000022 R09: 0000000000000247
[ 6540.756085] R10: 0000000000000000 R11: 0000000000000027 R12: 0000000000000009
[ 6540.756086] R13: ffffffff9054f690 R14: 0000000000000046 R15: 00000000000218c0
[ 6540.756088] FS:  0000000000000000(0000) GS:ffff9001ff8c0000(0000) knlGS:0000000000000000
[ 6540.756089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6540.756090] CR2: 0000555fc96a7708 CR3: 00000031ad40a003 CR4: 00000000003606e0
[ 6540.756091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6540.756092] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6540.756093] Call Trace:
[ 6540.756097]  <IRQ>
[ 6540.756100]  ? __update_load_avg_blocked_se.isra.34+0xc7/0x130
[ 6540.756106]  ttwu_do_activate+0x44/0x80
[ 6540.756108]  try_to_wake_up+0x1bf/0x480
[ 6540.756112]  autoremove_wake_function+0x11/0x50
[ 6540.756114]  __wake_up_common+0x96/0x180
[ 6540.756115]  __wake_up_common_lock+0x7c/0xc0
[ 6540.756125]  wbt_done+0x6a/0x90
[ 6540.756129]  blk_mq_free_request+0xbc/0x190
[ 6540.756147]  scsi_end_request+0x95/0x1e0 [scsi_mod]
[ 6540.756153]  scsi_io_completion+0x409/0x680 [scsi_mod]
[ 6540.756156]  __blk_mq_complete_request+0xba/0x170
[ 6540.756158]  blk_mq_complete_request+0x50/0xa0
[ 6540.756163]  complete_cmd_fusion+0x23a/0x4a0 [megaraid_sas]
[ 6540.756167]  megasas_isr_fusion+0x36/0x180 [megaraid_sas]
[ 6540.756170]  __handle_irq_event_percpu+0x81/0x190
[ 6540.756172]  handle_irq_event_percpu+0x30/0x80
[ 6540.756174]  handle_irq_event+0x3c/0x60
[ 6540.756176]  handle_edge_irq+0x94/0x1f0
[ 6540.756180]  handle_irq+0x1f/0x30
[ 6540.756186]  do_IRQ+0x41/0xc0
[ 6540.756189]  common_interrupt+0xf/0xf
[ 6540.756191]  </IRQ>
[ 6540.756195] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
[ 6540.756196] RSP: 0000:ffff9b6c0c663e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
[ 6540.756197] RAX: ffff9001ff8e18c0 RBX: 0000000000000002 RCX: 000000000000001f
[ 6540.756198] RDX: 000005edfeda7b89 RSI: 0000000040000219 RDI: 0000000000000000
[ 6540.756199] RBP: ffff9001ff8eab20 R08: 000000000000004a R09: 0000000000000018
[ 6540.756200] R10: 00000000000002da R11: 000000000000004a R12: ffffffff910b2c78
[ 6540.756200] R13: 0000000000000002 R14: 0000000000000002 R15: 000005edfeda3109
[ 6540.756205]  do_idle+0x193/0x200
[ 6540.756208]  cpu_startup_entry+0x6f/0x80
[ 6540.756214]  start_secondary+0x1a4/0x1f0
[ 6540.756218]  secondary_startup_64+0xa5/0xb0
[ 6540.756220] Code: 8d ae 80 00 00 00 48 89 f3 48 83 ec 38 f6 86 88 04 00 00 02 48 89 7c 24 08 0f 85 14 07 00 00 48 85 ed 74 4a 44 8b 93 c0 00 00 00 <45> 85 d2 74 14 e9 8a 00 00 00 44 8b 4d 40 41 bc 01 00 00 00 45 

(Lots of soft-lockup messages follow; I can post them all somewhere if
they are useful).

Thanks,
Chris

-- 
Chris Boot
bootc@boo.tc
