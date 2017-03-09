Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbdCII5L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Mar 2017 03:57:11 -0500
Date: Thu, 9 Mar 2017 09:56:20 +0100
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>,
        Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
        Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: Re: [4.11-rc1 block]: Boot failure due to memory corruption.
Message-ID: <20170309085620.GB15874@quack2.suse.cz>
References: <201703090625.v296PNFI070895@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201703090625.v296PNFI070895@www262.sakura.ne.jp>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,


On Thu 09-03-17 15:25:23, Tetsuo Handa wrote:
> I noticed that 4.11-rc1 crashes upon boot.

Thanks for report. It should be fixed by patches I've posted yesterday:

https://www.mail-archive.com/linux-block@vger.kernel.org/msg05566.html

								Honza


> 
> ----------------------------------------
> [    5.358848] Fusion MPT base driver 3.04.20
> [    5.360468] Copyright (c) 1999-2008 LSI Corporation
> [    5.377993] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    5.380697] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    5.383907] Fusion MPT SPI Host driver 3.04.20
> [    5.384772] scsi host0: ata_piix
> [    5.389732] scsi host1: ata_piix
> [    5.391435] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1060 irq 14
> [    5.400844] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1068 irq 15
> [    5.408349] mptbase: ioc0: Initiating bringup
> [    5.446375] ioc0: LSI53C1030 B0: Capabilities={Initiator}
> [    5.535645] scsi host2: ioc0: LSI53C1030 B0, FwRev=01032920h, Ports=1, MaxQ=128, IRQ=17
> [    5.575721] ata2.00: ATAPI: VMware Virtual IDE CDROM Drive, 00000001, max UDMA/33
> [    5.583595] ata2.00: configured for UDMA/33
> [    5.592101] scsi 2:0:0:0: Direct-Access     VMware,  VMware Virtual S 1.0  PQ: 0 ANSI: 2
> [    5.595206] scsi target2:0:0: Beginning Domain Validation
> [    5.598405] scsi 1:0:0:0: CD-ROM            NECVMWar VMware IDE CDR10 1.00 PQ: 0 ANSI: 5
> [    5.605254] [drm] DMA map mode: Using physical TTM page addresses.
> [    5.605571] scsi target2:0:0: Domain Validation skipping write tests
> [    5.605573] scsi target2:0:0: Ending Domain Validation
> [    5.605696] scsi target2:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 127)
> [    5.625342] BUG: unable to handle kernel paging request at ffff88006b443e58
> [    5.625349] IP: rb_erase+0x301/0x350
> [    5.625350] PGD 31ae067 
> [    5.625350] PUD 31b1067 
> [    5.625351] PMD 7fda6067 
> [    5.625351] PTE 800000006b443060
> [    5.625352] 
> [    5.625353] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
> [    5.625354] Modules linked in: serio_raw vmwgfx(+) drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm mptspi drm ata_piix scsi_transport_spi mptscsih e1000(+) i2c_core mptbase libata
> [    5.625366] CPU: 3 PID: 9 Comm: rcuos/0 Not tainted 4.11.0-rc1 #112
> [    5.625367] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/31/2013
> [    5.625368] task: ffff880074970240 task.stack: ffffc9000036c000
> [    5.625369] RIP: 0010:rb_erase+0x301/0x350
> [    5.625370] RSP: 0018:ffffc9000036fe18 EFLAGS: 00010046
> [    5.625371] RAX: 0000000000000000 RBX: ffff88006ae742c0 RCX: 0000000000000000
> [    5.625372] RDX: 0000000000000001 RSI: ffff88006b443e58 RDI: ffff88006ae742e0
> [    5.625372] RBP: ffffc9000036fe18 R08: 0000000000000000 R09: 0000000000000001
> [    5.625373] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
> [    5.625373] R13: ffff88006b440800 R14: ffffffff81359c30 R15: ffff88006b7c77a0
> [    5.625374] FS:  0000000000000000(0000) GS:ffff880075800000(0000) knlGS:0000000000000000
> [    5.625375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.625376] CR2: ffff88006b443e58 CR3: 000000006a6c7000 CR4: 00000000001406e0
> [    5.625408] Call Trace:
> [    5.625411]  wb_congested_put+0x6a/0xb0
> [    5.625414]  __blkg_release_rcu+0xe3/0x1c0
> [    5.625418]  rcu_nocb_kthread+0x1c8/0x570
> [    5.625419]  ? rcu_nocb_kthread+0xf8/0x570
> [    5.625424]  kthread+0x10a/0x140
> [    5.625425]  ? rcu_all_qs+0x90/0x90
> [    5.625427]  ? kthread_create_on_node+0x60/0x60
> [    5.625429]  ret_from_fork+0x31/0x40
> [    5.625432] Code: 01 4c 89 07 49 89 c8 eb 9a 48 89 16 48 89 fa e9 e7 fe ff ff 48 89 51 10 48 89 fa e9 db fe ff ff 4c 89 06 5d c3 4c 89 42 10 5d c3 <4c> 89 06 e9 b1 fd ff ff 83 e2 01 0f 85 e1 fd ff ff 5d c3 4c 89 
> [    5.625453] RIP: rb_erase+0x301/0x350 RSP: ffffc9000036fe18
> [    5.625453] CR2: ffff88006b443e58
> [    5.625502] ---[ end trace 0415a22853a9a611 ]---
> [    5.625503] Kernel panic - not syncing: Fatal exception in interrupt
> [    6.708465] Shutting down cpus with NMI
> [    6.708610] Kernel Offset: disabled
> [    6.789338] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> ----------------------------------------
> 
> Judging from the timing, I suspect that this problem is caused by memory corruption
> caused by commit 165a5e22fafb127 ("block: Move bdi_unregister() to del_gendisk()").
> 
> ----------------------------------------
> # bad: [a3b4924b027f9a4b95ce89a914c1e0459e76f18a] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> # good: [15dd03811d99dcf828f4eeb2c2b6a02ddc1201c7] scsi: megaraid_sas: NVME Interface detection and prop settings
> # good: [857de6e00778738dc3d61f75acbac35bdc48e533] scsi: use 'scsi_device_from_queue()' for scsi_dh
> # good: [825c6abbc316f496cd2b66e1fa72892cf4b49a9f] scsi: lpfc: use proper format string for dma_addr_t
> # good: [54d7989f476ca57fc3c5cc71524c480ccb74c481] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> # good: [41dc529a4602ac737020f423f84686a81de38e6d] qla2xxx: Improve RSCN handling in driver
> # good: [821fd6f6cb6500cd04a6c7e8f701f9b311a5c2b3] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending
> # good: [1827adb11ad26b2290dc9fe2aaf54976b2439865] Merge branch 'WIP.sched-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> # good: [42a70abddd90374518057e989f5b7289b7b535d8] scsi: qedi: Fix memory leak in tmf response processing.
> # good: [c470abd4fde40ea6a0846a2beab642a578c0b8cd] Linux 4.10
> # good: [69973b830859bc6529a7a0468ba0d80ee5117826] Linux 4.9
> # good: [c8d2bc9bc39ebea8437fd974fdbc21847bb897a3] Linux 4.8
> # good: [523d939ef98fd712632d93a5a2b588e477a7565e] Linux 4.7
> # good: [2dcd0af568b0cf583645c8a317dd12e344b1c72a] Linux 4.6
> # good: [b562e44f507e863c6792946e4e1b1449fbbac85d] Linux 4.5
> # good: [afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc] Linux 4.4
> # good: [6a13feb9c82803e2b815eca72fa7a9f5561d7861] Linux 4.3
> # good: [64291f7db5bd8150a74ad2036f1037e6a0428df2] Linux 4.2
> # good: [b953c0d234bc72e8489d3bf51a276c5c4ec85345] Linux 4.1
> # good: [39a8804455fb23f09157341d3ba7db6d7ae6ee76] Linux 4.0
> git bisect start 'a3b4924b027f9a4b95ce89a914c1e0459e76f18a' '15dd03811d99dcf828f4eeb2c2b6a02ddc1201c7' '857de6e00778738dc3d61f75acbac35bdc48e533' '825c6abbc316f496cd2b66e1fa72892cf4b49a9f' '54d7989f476ca57fc3c5cc71524c480ccb74c481' '41dc529a4602ac737020f423f84686a81de38e6d' '821fd6f6cb6500cd04a6c7e8f701f9b311a5c2b3' '1827adb11ad26b2290dc9fe2aaf54976b2439865' '42a70abddd90374518057e989f5b7289b7b535d8' 'v4.10' 'v4.9' 'v4.8' 'v4.7' 'v4.6' 'v4.5' 'v4.4' 'v4.3' 'v4.2' 'v4.1' 'v4.0'
> # bad: [0a040b2113ec226bcf56fcbe02d035bb5b30c35e] Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6
> git bisect bad 0a040b2113ec226bcf56fcbe02d035bb5b30c35e
> # bad: [590dce2d4934fb909b112cd80c80486362337744] Merge branch 'rebased-statx' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect bad 590dce2d4934fb909b112cd80c80486362337744
> # good: [6bae363ee3057a14eec93440826813603559273a] blk-mq: Export blk_mq_freeze_queue_wait
> git bisect good 6bae363ee3057a14eec93440826813603559273a
> # good: [7b36a7189fc320f0b783dd51bd1f541db56cfbdd] block: don't call ioc_exit_icq() with the queue lock held for blk-mq
> git bisect good 7b36a7189fc320f0b783dd51bd1f541db56cfbdd
> # bad: [165a5e22fafb127ecb5914e12e8c32a1f0d3f820] block: Move bdi_unregister() to del_gendisk()
> git bisect bad 165a5e22fafb127ecb5914e12e8c32a1f0d3f820
> # good: [113285b473824922498d07d7f82459507b9792eb] blk-mq: ensure that bd->last is always set correctly
> git bisect good 113285b473824922498d07d7f82459507b9792eb
> # first bad commit: [165a5e22fafb127ecb5914e12e8c32a1f0d3f820] block: Move bdi_unregister() to del_gendisk()
> ----------------------------------------
> 
> ----------------------------------------
> [    7.085750] Fusion MPT base driver 3.04.20
> [    7.089530] Copyright (c) 1999-2008 LSI Corporation
> [    7.100570] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    7.105792] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    7.131191] Fusion MPT SPI Host driver 3.04.20
> [    7.140779] scsi host0: ata_piix
> [    7.167165] scsi host1: ata_piix
> [    7.170280] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1060 irq 14
> [    7.175137] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1068 irq 15
> [    7.191972] mptbase: ioc0: Initiating bringup
> [    7.235233] ioc0: LSI53C1030 B0: Capabilities={Initiator}
> [    7.313420] scsi host2: ioc0: LSI53C1030 B0, FwRev=01032920h, Ports=1, MaxQ=128, IRQ=17
> [    7.349960] ata2.00: ATAPI: VMware Virtual IDE CDROM Drive, 00000001, max UDMA/33
> [    7.354987] ata2.00: configured for UDMA/33
> [    7.361167] scsi 1:0:0:0: CD-ROM            NECVMWar VMware IDE CDR10 1.00 PQ: 0 ANSI: 5
> [    7.375845] scsi 2:0:0:0: Direct-Access     VMware,  VMware Virtual S 1.0  PQ: 0 ANSI: 2
> [    7.384024] scsi target2:0:0: Beginning Domain Validation
> [    7.390020] [drm] DMA map mode: Using physical TTM page addresses.
> [    7.391766] scsi target2:0:0: Domain Validation skipping write tests
> [    7.391768] scsi target2:0:0: Ending Domain Validation
> [    7.393883] scsi target2:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 127)
> [    7.405278] [drm] Capabilities:
> [    7.407604] [drm]   Rect copy.
> [    7.409767] [drm]   Cursor.
> [    7.411635] [drm]   Cursor bypass.
> [    7.413996] [drm]   Cursor bypass 2.
> [    7.416423] [drm]   8bit emulation.
> [    7.418671] [drm]   Alpha cursor.
> [    7.420855] [drm]   Extended Fifo.
> [    7.421073] =============================================================================
> [    7.421076] BUG kmalloc-2048 (Not tainted): Poison overwritten
> [    7.421076] -----------------------------------------------------------------------------
> [    7.421076] 
> [    7.421077] Disabling lock debugging due to kernel taint
> [    7.421078] INFO: 0xffff8802247350e0-0xffff8802247350e7. First byte 0x0 instead of 0x6b
> [    7.421082] INFO: Allocated in attribute_container_add_device+0x7a/0x140 age=7 cpu=3 pid=87
> [    7.421084] 	___slab_alloc+0x592/0x600
> [    7.421085] 	__slab_alloc+0x51/0x90
> [    7.421086] 	kmem_cache_alloc_trace+0x284/0x3a0
> [    7.421087] 	attribute_container_add_device+0x7a/0x140
> [    7.421087] 	transport_setup_device+0x15/0x20
> [    7.421090] 	scsi_alloc_target+0x22f/0x2d0
> [    7.421091] 	__scsi_scan_target+0x77/0x250
> [    7.421092] 	scsi_scan_channel+0x81/0xa0
> [    7.421093] 	scsi_scan_host_selected+0xec/0x150
> [    7.421094] 	do_scsi_scan_host+0x8d/0x90
> [    7.421095] 	do_scan_async+0x1c/0x1a0
> [    7.421097] 	async_run_entry_fn+0x39/0x170
> [    7.421098] 	process_one_work+0x260/0x7d0
> [    7.421099] 	worker_thread+0x4e/0x4a0
> [    7.421100] 	kthread+0x10f/0x150
> [    7.421102] 	ret_from_fork+0x31/0x40
> [    7.421105] INFO: Freed in attribute_container_release+0x17/0x30 age=3 cpu=3 pid=87
> [    7.421105] 	__slab_free+0x1df/0x280
> [    7.421106] 	kfree+0x16e/0x340
> [    7.421108] 	attribute_container_release+0x17/0x30
> [    7.421110] 	device_release+0x32/0x90
> [    7.421111] 	kobject_release+0x6a/0x170
> [    7.421112] 	kobject_put+0x2f/0x60
> [    7.421113] 	put_device+0x17/0x20
> [    7.421115] 	internal_container_klist_put+0x12/0x20
> [    7.421116] 	klist_next+0x83/0xf0
> [    7.421117] 	attribute_container_remove_device+0x8c/0x110
> [    7.421118] 	transport_destroy_device+0x15/0x20
> [    7.421119] 	scsi_target_destroy+0x61/0xf0
> [    7.421120] 	scsi_target_reap_ref_release+0x35/0x40
> [    7.421121] 	scsi_target_reap+0x2e/0x40
> [    7.421122] 	__scsi_scan_target+0xb7/0x250
> [    7.421123] 	scsi_scan_channel+0x81/0xa0
> [    7.421124] INFO: Slab 0xffffea000891cc00 objects=13 used=13 fp=0x          (null) flags=0x2fffff80008100
> [    7.421125] INFO: Object 0xffff880224734a88 @offset=19080 fp=0x          (null)
> [    7.421125] 
> [    7.421126] Redzone ffff880224734a80: bb bb bb bb bb bb bb bb                          ........
> [    7.421127] Object ffff880224734a88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421127] Object ffff880224734a98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421128] Object ffff880224734aa8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421129] Object ffff880224734ab8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421129] Object ffff880224734ac8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421130] Object ffff880224734ad8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421130] Object ffff880224734ae8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421131] Object ffff880224734af8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421132] Object ffff880224734b08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421132] Object ffff880224734b18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421133] Object ffff880224734b28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421133] Object ffff880224734b38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421134] Object ffff880224734b48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421135] Object ffff880224734b58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421135] Object ffff880224734b68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421136] Object ffff880224734b78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421136] Object ffff880224734b88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421137] Object ffff880224734b98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421138] Object ffff880224734ba8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421138] Object ffff880224734bb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421139] Object ffff880224734bc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421139] Object ffff880224734bd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421140] Object ffff880224734be8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421140] Object ffff880224734bf8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421141] Object ffff880224734c08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421142] Object ffff880224734c18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421142] Object ffff880224734c28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421143] Object ffff880224734c38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421143] Object ffff880224734c48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421144] Object ffff880224734c58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421145] Object ffff880224734c68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421145] Object ffff880224734c78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421146] Object ffff880224734c88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421146] Object ffff880224734c98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421147] Object ffff880224734ca8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421148] Object ffff880224734cb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421148] Object ffff880224734cc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421149] Object ffff880224734cd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421149] Object ffff880224734ce8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421150] Object ffff880224734cf8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421151] Object ffff880224734d08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421151] Object ffff880224734d18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421152] Object ffff880224734d28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421152] Object ffff880224734d38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421153] Object ffff880224734d48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421154] Object ffff880224734d58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421154] Object ffff880224734d68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421155] Object ffff880224734d78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421155] Object ffff880224734d88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421156] Object ffff880224734d98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421156] Object ffff880224734da8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421157] Object ffff880224734db8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421158] Object ffff880224734dc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421158] Object ffff880224734dd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421159] Object ffff880224734de8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421159] Object ffff880224734df8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421160] Object ffff880224734e08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421161] Object ffff880224734e18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421161] Object ffff880224734e28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421162] Object ffff880224734e38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421162] Object ffff880224734e48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421163] Object ffff880224734e58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421163] Object ffff880224734e68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421164] Object ffff880224734e78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421165] Object ffff880224734e88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421165] Object ffff880224734e98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421166] Object ffff880224734ea8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421166] Object ffff880224734eb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421167] Object ffff880224734ec8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421167] Object ffff880224734ed8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421168] Object ffff880224734ee8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421169] Object ffff880224734ef8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421169] Object ffff880224734f08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421170] Object ffff880224734f18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421170] Object ffff880224734f28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421171] Object ffff880224734f38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421171] Object ffff880224734f48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421172] Object ffff880224734f58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421173] Object ffff880224734f68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421173] Object ffff880224734f78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421174] Object ffff880224734f88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421174] Object ffff880224734f98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421175] Object ffff880224734fa8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421176] Object ffff880224734fb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421176] Object ffff880224734fc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421177] Object ffff880224734fd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421177] Object ffff880224734fe8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421178] Object ffff880224734ff8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421178] Object ffff880224735008: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421179] Object ffff880224735018: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421180] Object ffff880224735028: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421180] Object ffff880224735038: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421181] Object ffff880224735048: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421181] Object ffff880224735058: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421182] Object ffff880224735068: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421183] Object ffff880224735078: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421183] Object ffff880224735088: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421184] Object ffff880224735098: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421184] Object ffff8802247350a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421185] Object ffff8802247350b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421185] Object ffff8802247350c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421186] Object ffff8802247350d8: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00  kkkkkkkk........
> [    7.421187] Object ffff8802247350e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421187] Object ffff8802247350f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421188] Object ffff880224735108: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421188] Object ffff880224735118: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421189] Object ffff880224735128: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421190] Object ffff880224735138: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421190] Object ffff880224735148: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421191] Object ffff880224735158: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421191] Object ffff880224735168: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421192] Object ffff880224735178: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421192] Object ffff880224735188: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421193] Object ffff880224735198: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421194] Object ffff8802247351a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421194] Object ffff8802247351b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421195] Object ffff8802247351c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421195] Object ffff8802247351d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421196] Object ffff8802247351e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421196] Object ffff8802247351f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421197] Object ffff880224735208: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421198] Object ffff880224735218: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421198] Object ffff880224735228: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421199] Object ffff880224735238: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421199] Object ffff880224735248: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421200] Object ffff880224735258: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421200] Object ffff880224735268: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.421201] Object ffff880224735278: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
> [    7.421202] Redzone ffff880224735288: bb bb bb bb bb bb bb bb                          ........
> [    7.421202] Padding ffff8802247353c8: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> [    7.421204] CPU: 3 PID: 87 Comm: kworker/u128:1 Tainted: G    B           4.10.0+ #146
> [    7.421205] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/31/2013
> [    7.421207] Workqueue: events_unbound async_run_entry_fn
> [    7.421208] Call Trace:
> [    7.421211]  dump_stack+0x86/0xc3
> [    7.421212]  print_trailer+0x165/0x260
> [    7.421214]  check_bytes_and_report+0xc1/0x100
> [    7.421216]  check_object+0x241/0x290
> [    7.421218]  ? blkg_alloc+0x4b/0x240
> [    7.421220]  ? blkg_alloc+0x4b/0x240
> [    7.421221]  alloc_debug_processing+0x113/0x1b0
> [    7.421222]  ___slab_alloc+0x592/0x600
> [    7.421225]  ? blkg_alloc+0x4b/0x240
> [    7.421228]  ? blkg_alloc+0x4b/0x240
> [    7.421229]  __slab_alloc+0x51/0x90
> [    7.421231]  kmem_cache_alloc_node_trace+0xae/0x3e0
> [    7.421234]  blkg_alloc+0x4b/0x240
> [    7.421236]  blkcg_init_queue+0x29/0x1b0
> [    7.421238]  ? percpu_ref_init+0x23/0x90
> [    7.421240]  blk_alloc_queue_node+0x2aa/0x310
> [    7.421241]  scsi_alloc_queue+0x1e/0xf0
> [    7.421243]  scsi_alloc_sdev+0x24b/0x380
> [    7.421245]  scsi_probe_and_add_lun+0x9eb/0xeb0
> [    7.421248]  ? _raw_spin_unlock_irqrestore+0x36/0x60
> [    7.421250]  ? trace_hardirqs_on_caller+0xf5/0x1b0
> [    7.421252]  ? trace_hardirqs_on+0xd/0x10
> [    7.421254]  ? __pm_runtime_resume+0x5b/0x90
> [    7.421256]  __scsi_scan_target+0xf6/0x250
> [    7.421258]  scsi_scan_channel+0x81/0xa0
> [    7.421261]  scsi_scan_host_selected+0xec/0x150
> [    7.421261]  ? process_one_work+0x1e4/0x7d0
> [    7.421263]  do_scsi_scan_host+0x8d/0x90
> [    7.421265]  do_scan_async+0x1c/0x1a0
> [    7.421267]  async_run_entry_fn+0x39/0x170
> [    7.421268]  process_one_work+0x260/0x7d0
> [    7.421269]  ? process_one_work+0x1cd/0x7d0
> [    7.421272]  worker_thread+0x4e/0x4a0
> [    7.421274]  kthread+0x10f/0x150
> [    7.421275]  ? process_one_work+0x7d0/0x7d0
> [    7.421276]  ? kthread_create_on_node+0x60/0x60
> [    7.421278]  ret_from_fork+0x31/0x40
> [    7.421282] FIX kmalloc-2048: Restoring 0xffff8802247350e0-0xffff8802247350e7=0x6b
> [    7.421282] 
> [    7.421282] FIX kmalloc-2048: Marking all objects used
> [    7.463551] =============================================================================
> [    7.463553] BUG kmalloc-2048 (Tainted: G    B          ): Poison overwritten
> [    7.463554] -----------------------------------------------------------------------------
> [    7.463554] 
> [    7.463555] INFO: 0xffff880222b66cd0-0xffff880222b66cd7. First byte 0x0 instead of 0x6b
> [    7.463559] INFO: Allocated in bdi_alloc_node+0x2a/0x70 age=33 cpu=3 pid=87
> [    7.463561] 	___slab_alloc+0x592/0x600
> [    7.463562] 	__slab_alloc+0x51/0x90
> [    7.463563] 	kmem_cache_alloc_node_trace+0xae/0x3e0
> [    7.463564] 	bdi_alloc_node+0x2a/0x70
> [    7.463566] 	blk_alloc_queue_node+0x7f/0x310
> [    7.463569] 	scsi_alloc_queue+0x1e/0xf0
> [    7.463570] 	scsi_alloc_sdev+0x24b/0x380
> [    7.463571] 	scsi_probe_and_add_lun+0x9eb/0xeb0
> [    7.463572] 	__scsi_scan_target+0xf6/0x250
> [    7.463573] 	scsi_scan_channel+0x81/0xa0
> [    7.463574] 	scsi_scan_host_selected+0xec/0x150
> [    7.463575] 	do_scsi_scan_host+0x8d/0x90
> [    7.463575] 	do_scan_async+0x1c/0x1a0
> [    7.463577] 	async_run_entry_fn+0x39/0x170
> [    7.463578] 	process_one_work+0x260/0x7d0
> [    7.463579] 	worker_thread+0x4e/0x4a0
> [    7.463580] INFO: Freed in release_bdi+0x1e/0x30 age=30 cpu=3 pid=87
> [    7.463581] 	__slab_free+0x1df/0x280
> [    7.463582] 	kfree+0x16e/0x340
> [    7.463583] 	release_bdi+0x1e/0x30
> [    7.463584] 	bdi_put+0x22/0x30
> [    7.463585] 	blk_release_queue+0x1f/0xf0
> [    7.463587] 	kobject_release+0x6a/0x170
> [    7.463587] 	kobject_put+0x2f/0x60
> [    7.463588] 	blk_put_queue+0x15/0x20
> [    7.463589] 	scsi_device_dev_release_usercontext+0x1b6/0x210
> [    7.463590] 	execute_in_process_context+0x94/0xa0
> [    7.463591] 	scsi_device_dev_release+0x1c/0x20
> [    7.463594] 	device_release+0x32/0x90
> [    7.463594] 	kobject_release+0x6a/0x170
> [    7.463595] 	kobject_put+0x2f/0x60
> [    7.463596] 	put_device+0x17/0x20
> [    7.463598] 	__scsi_remove_device+0x92/0xd0
> [    7.463599] INFO: Slab 0xffffea00088ad800 objects=13 used=13 fp=0x          (null) flags=0x2fffff80008100
> [    7.463600] INFO: Object 0xffff880222b66678 @offset=26232 fp=0xffff880222b60958
> [    7.463600] 
> [    7.463601] Redzone ffff880222b66670: bb bb bb bb bb bb bb bb                          ........
> [    7.463602] Object ffff880222b66678: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463602] Object ffff880222b66688: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463603] Object ffff880222b66698: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463603] Object ffff880222b666a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463604] Object ffff880222b666b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463604] Object ffff880222b666c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463605] Object ffff880222b666d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463606] Object ffff880222b666e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463606] Object ffff880222b666f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463607] Object ffff880222b66708: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463607] Object ffff880222b66718: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463608] Object ffff880222b66728: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463608] Object ffff880222b66738: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463609] Object ffff880222b66748: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463609] Object ffff880222b66758: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463610] Object ffff880222b66768: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463610] Object ffff880222b66778: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463611] Object ffff880222b66788: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463611] Object ffff880222b66798: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463612] Object ffff880222b667a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463612] Object ffff880222b667b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463613] Object ffff880222b667c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463613] Object ffff880222b667d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463614] Object ffff880222b667e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463615] Object ffff880222b667f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463615] Object ffff880222b66808: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463616] Object ffff880222b66818: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463616] Object ffff880222b66828: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463617] Object ffff880222b66838: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463617] Object ffff880222b66848: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463618] Object ffff880222b66858: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463618] Object ffff880222b66868: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463619] Object ffff880222b66878: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463619] Object ffff880222b66888: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463620] Object ffff880222b66898: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463620] Object ffff880222b668a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463621] Object ffff880222b668b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463621] Object ffff880222b668c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463622] Object ffff880222b668d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463622] Object ffff880222b668e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463623] Object ffff880222b668f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463624] Object ffff880222b66908: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463624] Object ffff880222b66918: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463625] Object ffff880222b66928: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463625] Object ffff880222b66938: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463626] Object ffff880222b66948: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463626] Object ffff880222b66958: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463627] Object ffff880222b66968: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463627] Object ffff880222b66978: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463628] Object ffff880222b66988: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463628] Object ffff880222b66998: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463629] Object ffff880222b669a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463629] Object ffff880222b669b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463630] Object ffff880222b669c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463630] Object ffff880222b669d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463631] Object ffff880222b669e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463631] Object ffff880222b669f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463632] Object ffff880222b66a08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463633] Object ffff880222b66a18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463633] Object ffff880222b66a28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463634] Object ffff880222b66a38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463634] Object ffff880222b66a48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463635] Object ffff880222b66a58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463635] Object ffff880222b66a68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463636] Object ffff880222b66a78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463636] Object ffff880222b66a88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463637] Object ffff880222b66a98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463637] Object ffff880222b66aa8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463638] Object ffff880222b66ab8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463638] Object ffff880222b66ac8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463639] Object ffff880222b66ad8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463639] Object ffff880222b66ae8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463640] Object ffff880222b66af8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463640] Object ffff880222b66b08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463641] Object ffff880222b66b18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463642] Object ffff880222b66b28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463642] Object ffff880222b66b38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463643] Object ffff880222b66b48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463643] Object ffff880222b66b58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463644] Object ffff880222b66b68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463644] Object ffff880222b66b78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463645] Object ffff880222b66b88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463645] Object ffff880222b66b98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463646] Object ffff880222b66ba8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463646] Object ffff880222b66bb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463647] Object ffff880222b66bc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463647] Object ffff880222b66bd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463648] Object ffff880222b66be8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463648] Object ffff880222b66bf8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463649] Object ffff880222b66c08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463649] Object ffff880222b66c18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463650] Object ffff880222b66c28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463650] Object ffff880222b66c38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463651] Object ffff880222b66c48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463652] Object ffff880222b66c58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463652] Object ffff880222b66c68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463653] Object ffff880222b66c78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463653] Object ffff880222b66c88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463654] Object ffff880222b66c98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463654] Object ffff880222b66ca8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463655] Object ffff880222b66cb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463655] Object ffff880222b66cc8: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00  kkkkkkkk........
> [    7.463656] Object ffff880222b66cd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463656] Object ffff880222b66ce8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463657] Object ffff880222b66cf8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463657] Object ffff880222b66d08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463658] Object ffff880222b66d18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463658] Object ffff880222b66d28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463659] Object ffff880222b66d38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463660] Object ffff880222b66d48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463660] Object ffff880222b66d58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463661] Object ffff880222b66d68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463661] Object ffff880222b66d78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463662] Object ffff880222b66d88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463662] Object ffff880222b66d98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463663] Object ffff880222b66da8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463663] Object ffff880222b66db8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463664] Object ffff880222b66dc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463664] Object ffff880222b66dd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463665] Object ffff880222b66de8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463665] Object ffff880222b66df8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463666] Object ffff880222b66e08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463666] Object ffff880222b66e18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463667] Object ffff880222b66e28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463667] Object ffff880222b66e38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463668] Object ffff880222b66e48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463668] Object ffff880222b66e58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.463669] Object ffff880222b66e68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
> [    7.463670] Redzone ffff880222b66e78: bb bb bb bb bb bb bb bb                          ........
> [    7.463670] Padding ffff880222b66fb8: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> [    7.463672] CPU: 3 PID: 87 Comm: kworker/u128:1 Tainted: G    B           4.10.0+ #146
> [    7.463672] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/31/2013
> [    7.463674] Workqueue: events_unbound async_run_entry_fn
> [    7.463675] Call Trace:
> [    7.463677]  dump_stack+0x86/0xc3
> [    7.463679]  print_trailer+0x165/0x260
> [    7.463680]  check_bytes_and_report+0xc1/0x100
> [    7.463682]  check_object+0x241/0x290
> [    7.463684]  ? attribute_container_add_device+0x7a/0x140
> [    7.463685]  ? attribute_container_add_device+0x7a/0x140
> [    7.463686]  alloc_debug_processing+0x113/0x1b0
> [    7.463687]  ___slab_alloc+0x592/0x600
> [    7.463689]  ? attribute_container_add_device+0x7a/0x140
> [    7.463692]  ? __mutex_lock+0x245/0x9d0
> [    7.463693]  ? attribute_container_add_device+0x26/0x140
> [    7.463694]  ? attribute_container_add_device+0x7a/0x140
> [    7.463695]  __slab_alloc+0x51/0x90
> [    7.463696]  ? attribute_container_add_device+0x7a/0x140
> [    7.463697]  kmem_cache_alloc_trace+0x284/0x3a0
> [    7.463699]  ? anon_transport_dummy_function+0x10/0x10
> [    7.463700]  attribute_container_add_device+0x7a/0x140
> [    7.463701]  transport_setup_device+0x15/0x20
> [    7.463702]  scsi_alloc_target+0x22f/0x2d0
> [    7.463705]  __scsi_scan_target+0x77/0x250
> [    7.463707]  scsi_scan_channel+0x81/0xa0
> [    7.463709]  scsi_scan_host_selected+0xec/0x150
> [    7.463710]  ? process_one_work+0x1e4/0x7d0
> [    7.463712]  do_scsi_scan_host+0x8d/0x90
> [    7.463713]  do_scan_async+0x1c/0x1a0
> [    7.463715]  async_run_entry_fn+0x39/0x170
> [    7.463716]  process_one_work+0x260/0x7d0
> [    7.463717]  ? process_one_work+0x1cd/0x7d0
> [    7.463719]  worker_thread+0x4e/0x4a0
> [    7.463722]  kthread+0x10f/0x150
> [    7.463723]  ? process_one_work+0x7d0/0x7d0
> [    7.463724]  ? kthread_create_on_node+0x60/0x60
> [    7.463725]  ret_from_fork+0x31/0x40
> [    7.463729] FIX kmalloc-2048: Restoring 0xffff880222b66cd0-0xffff880222b66cd7=0x6b
> [    7.463729] 
> [    7.463730] FIX kmalloc-2048: Marking all objects used
> [    7.468650] =============================================================================
> [    7.468651] BUG kmalloc-2048 (Tainted: G    B          ): Poison overwritten
> [    7.468651] -----------------------------------------------------------------------------
> [    7.468651] 
> [    7.468652] INFO: 0xffff880224732ba0-0xffff880224732ba7. First byte 0x0 instead of 0x6b
> [    7.468655] INFO: Allocated in bdi_alloc_node+0x2a/0x70 age=47 cpu=3 pid=87
> [    7.468656] 	___slab_alloc+0x592/0x600
> [    7.468657] 	__slab_alloc+0x51/0x90
> [    7.468658] 	kmem_cache_alloc_node_trace+0xae/0x3e0
> [    7.468659] 	bdi_alloc_node+0x2a/0x70
> [    7.468660] 	blk_alloc_queue_node+0x7f/0x310
> [    7.468661] 	scsi_alloc_queue+0x1e/0xf0
> [    7.468662] 	scsi_alloc_sdev+0x24b/0x380
> [    7.468663] 	scsi_probe_and_add_lun+0x9eb/0xeb0
> [    7.468664] 	__scsi_scan_target+0xf6/0x250
> [    7.468665] 	scsi_scan_channel+0x81/0xa0
> [    7.468666] 	scsi_scan_host_selected+0xec/0x150
> [    7.468667] 	do_scsi_scan_host+0x8d/0x90
> [    7.468668] 	do_scan_async+0x1c/0x1a0
> [    7.468669] 	async_run_entry_fn+0x39/0x170
> [    7.468670] 	process_one_work+0x260/0x7d0
> [    7.468671] 	worker_thread+0x4e/0x4a0
> [    7.468672] INFO: Freed in release_bdi+0x1e/0x30 age=43 cpu=3 pid=87
> [    7.468673] 	__slab_free+0x1df/0x280
> [    7.468674] 	kfree+0x16e/0x340
> [    7.468674] 	release_bdi+0x1e/0x30
> [    7.468675] 	bdi_put+0x22/0x30
> [    7.468676] 	blk_release_queue+0x1f/0xf0
> [    7.468678] 	kobject_release+0x6a/0x170
> [    7.468679] 	kobject_put+0x2f/0x60
> [    7.468679] 	blk_put_queue+0x15/0x20
> [    7.468681] 	scsi_device_dev_release_usercontext+0x1b6/0x210
> [    7.468681] 	execute_in_process_context+0x94/0xa0
> [    7.468683] 	scsi_device_dev_release+0x1c/0x20
> [    7.468684] 	device_release+0x32/0x90
> [    7.468685] 	kobject_release+0x6a/0x170
> [    7.468686] 	kobject_put+0x2f/0x60
> [    7.468687] 	put_device+0x17/0x20
> [    7.468688] 	__scsi_remove_device+0x92/0xd0
> [    7.468689] INFO: Slab 0xffffea000891cc00 objects=13 used=13 fp=0x          (null) flags=0x2fffff80008100
> [    7.468689] INFO: Object 0xffff880224732548 @offset=9544 fp=0xffff880224735d28
> [    7.468689] 
> [    7.468690] Redzone ffff880224732540: bb bb bb bb bb bb bb bb                          ........
> [    7.468691] Object ffff880224732548: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468692] Object ffff880224732558: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468692] Object ffff880224732568: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468693] Object ffff880224732578: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468693] Object ffff880224732588: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468694] Object ffff880224732598: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468694] Object ffff8802247325a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468695] Object ffff8802247325b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468695] Object ffff8802247325c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468696] Object ffff8802247325d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468697] Object ffff8802247325e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468697] Object ffff8802247325f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468698] Object ffff880224732608: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468698] Object ffff880224732618: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468699] Object ffff880224732628: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468699] Object ffff880224732638: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468700] Object ffff880224732648: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468700] Object ffff880224732658: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468701] Object ffff880224732668: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468701] Object ffff880224732678: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468702] Object ffff880224732688: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468702] Object ffff880224732698: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468703] Object ffff8802247326a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468703] Object ffff8802247326b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468704] Object ffff8802247326c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468705] Object ffff8802247326d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468705] Object ffff8802247326e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468706] Object ffff8802247326f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468706] Object ffff880224732708: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468707] Object ffff880224732718: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468707] Object ffff880224732728: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468708] Object ffff880224732738: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468708] Object ffff880224732748: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468709] Object ffff880224732758: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468709] Object ffff880224732768: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468710] Object ffff880224732778: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468710] Object ffff880224732788: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468711] Object ffff880224732798: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468711] Object ffff8802247327a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468712] Object ffff8802247327b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468712] Object ffff8802247327c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468713] Object ffff8802247327d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468714] Object ffff8802247327e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468714] Object ffff8802247327f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468715] Object ffff880224732808: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468715] Object ffff880224732818: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468716] Object ffff880224732828: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468716] Object ffff880224732838: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468717] Object ffff880224732848: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468717] Object ffff880224732858: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468718] Object ffff880224732868: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468718] Object ffff880224732878: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468719] Object ffff880224732888: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468719] Object ffff880224732898: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468720] Object ffff8802247328a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468720] Object ffff8802247328b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468721] Object ffff8802247328c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468721] Object ffff8802247328d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468722] Object ffff8802247328e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468722] Object ffff8802247328f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468723] Object ffff880224732908: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468724] Object ffff880224732918: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468724] Object ffff880224732928: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468725] Object ffff880224732938: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468725] Object ffff880224732948: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468726] Object ffff880224732958: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468726] Object ffff880224732968: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468727] Object ffff880224732978: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468727] Object ffff880224732988: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468728] Object ffff880224732998: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468728] Object ffff8802247329a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468729] Object ffff8802247329b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468729] Object ffff8802247329c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468730] Object ffff8802247329d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468730] Object ffff8802247329e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468731] Object ffff8802247329f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468731] Object ffff880224732a08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468732] Object ffff880224732a18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468733] Object ffff880224732a28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468733] Object ffff880224732a38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468734] Object ffff880224732a48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468734] Object ffff880224732a58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468735] Object ffff880224732a68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468735] Object ffff880224732a78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468736] Object ffff880224732a88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468736] Object ffff880224732a98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468737] Object ffff880224732aa8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468737] Object ffff880224732ab8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468738] Object ffff880224732ac8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468738] Object ffff880224732ad8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468739] Object ffff880224732ae8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468739] Object ffff880224732af8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468740] Object ffff880224732b08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468740] Object ffff880224732b18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468741] Object ffff880224732b28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468741] Object ffff880224732b38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468742] Object ffff880224732b48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468743] Object ffff880224732b58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468743] Object ffff880224732b68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468744] Object ffff880224732b78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468744] Object ffff880224732b88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468745] Object ffff880224732b98: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00  kkkkkkkk........
> [    7.468745] Object ffff880224732ba8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468746] Object ffff880224732bb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468746] Object ffff880224732bc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468747] Object ffff880224732bd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468747] Object ffff880224732be8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468748] Object ffff880224732bf8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468748] Object ffff880224732c08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468749] Object ffff880224732c18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468749] Object ffff880224732c28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468750] Object ffff880224732c38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468750] Object ffff880224732c48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468751] Object ffff880224732c58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468751] Object ffff880224732c68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468752] Object ffff880224732c78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468753] Object ffff880224732c88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468753] Object ffff880224732c98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468754] Object ffff880224732ca8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468754] Object ffff880224732cb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468755] Object ffff880224732cc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468755] Object ffff880224732cd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468756] Object ffff880224732ce8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468756] Object ffff880224732cf8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468757] Object ffff880224732d08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468757] Object ffff880224732d18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468758] Object ffff880224732d28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.468758] Object ffff880224732d38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
> [    7.468759] Redzone ffff880224732d48: bb bb bb bb bb bb bb bb                          ........
> [    7.468759] Padding ffff880224732e88: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> [    7.468761] CPU: 3 PID: 87 Comm: kworker/u128:1 Tainted: G    B           4.10.0+ #146
> [    7.468761] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/31/2013
> [    7.468763] Workqueue: events_unbound async_run_entry_fn
> [    7.468764] Call Trace:
> [    7.468766]  dump_stack+0x86/0xc3
> [    7.468767]  print_trailer+0x165/0x260
> [    7.468769]  check_bytes_and_report+0xc1/0x100
> [    7.468770]  check_object+0x241/0x290
> [    7.468772]  ? attribute_container_add_device+0x7a/0x140
> [    7.468773]  ? attribute_container_add_device+0x7a/0x140
> [    7.468774]  alloc_debug_processing+0x113/0x1b0
> [    7.468775]  ___slab_alloc+0x592/0x600
> [    7.468777]  ? attribute_container_add_device+0x7a/0x140
> [    7.468780]  ? __mutex_lock+0x245/0x9d0
> [    7.468780]  ? attribute_container_add_device+0x26/0x140
> [    7.468781]  ? attribute_container_add_device+0x7a/0x140
> [    7.468782]  __slab_alloc+0x51/0x90
> [    7.468784]  ? attribute_container_add_device+0x7a/0x140
> [    7.468785]  kmem_cache_alloc_trace+0x284/0x3a0
> [    7.468786]  ? anon_transport_dummy_function+0x10/0x10
> [    7.468787]  attribute_container_add_device+0x7a/0x140
> [    7.468789]  transport_setup_device+0x15/0x20
> [    7.468790]  scsi_alloc_target+0x22f/0x2d0
> [    7.468793]  __scsi_scan_target+0x77/0x250
> [    7.468795]  scsi_scan_channel+0x81/0xa0
> [    7.468797]  scsi_scan_host_selected+0xec/0x150
> [    7.468798]  ? process_one_work+0x1e4/0x7d0
> [    7.468800]  do_scsi_scan_host+0x8d/0x90
> [    7.468801]  do_scan_async+0x1c/0x1a0
> [    7.468802]  async_run_entry_fn+0x39/0x170
> [    7.468804]  process_one_work+0x260/0x7d0
> [    7.468804]  ? process_one_work+0x1cd/0x7d0
> [    7.468807]  worker_thread+0x4e/0x4a0
> [    7.468810]  kthread+0x10f/0x150
> [    7.468810]  ? process_one_work+0x7d0/0x7d0
> [    7.468812]  ? kthread_create_on_node+0x60/0x60
> [    7.468813]  ret_from_fork+0x31/0x40
> [    7.468817] FIX kmalloc-2048: Restoring 0xffff880224732ba0-0xffff880224732ba7=0x6b
> [    7.468817] 
> [    7.468817] FIX kmalloc-2048: Marking all objects used
> [    7.553698] sd 2:0:0:0: [sda] 104857600 512-byte logical blocks: (53.7 GB/50.0 GiB)
> [    7.553812] sd 2:0:0:0: [sda] Write Protect is off
> [    7.553901] =============================================================================
> [    7.553902] BUG kmalloc-2048 (Tainted: G    B          ): Poison overwritten
> [    7.553903] -----------------------------------------------------------------------------
> [    7.553903] 
> [    7.553904] INFO: 0xffff880222942ba0-0xffff880222942ba7. First byte 0x0 instead of 0x6b
> [    7.553908] INFO: Allocated in bdi_alloc_node+0x2a/0x70 age=68 cpu=3 pid=87
> [    7.553910] 	___slab_alloc+0x592/0x600
> [    7.553911] 	__slab_alloc+0x51/0x90
> [    7.553912] 	kmem_cache_alloc_node_trace+0xae/0x3e0
> [    7.553913] 	bdi_alloc_node+0x2a/0x70
> [    7.553915] 	blk_alloc_queue_node+0x7f/0x310
> [    7.553917] 	scsi_alloc_queue+0x1e/0xf0
> [    7.553918] 	scsi_alloc_sdev+0x24b/0x380
> [    7.553919] 	scsi_probe_and_add_lun+0x9eb/0xeb0
> [    7.553920] 	__scsi_scan_target+0xf6/0x250
> [    7.553921] 	scsi_scan_channel+0x81/0xa0
> [    7.553922] 	scsi_scan_host_selected+0xec/0x150
> [    7.553930] 	do_scsi_scan_host+0x8d/0x90
> [    7.553931] 	do_scan_async+0x1c/0x1a0
> [    7.553933] 	async_run_entry_fn+0x39/0x170
> [    7.553935] 	process_one_work+0x260/0x7d0
> [    7.553935] 	worker_thread+0x4e/0x4a0
> [    7.553937] INFO: Freed in release_bdi+0x1e/0x30 age=67 cpu=3 pid=87
> [    7.553938] 	__slab_free+0x1df/0x280
> [    7.553938] 	kfree+0x16e/0x340
> [    7.553939] 	release_bdi+0x1e/0x30
> [    7.553940] 	bdi_put+0x22/0x30
> [    7.553942] 	blk_release_queue+0x1f/0xf0
> [    7.553944] 	kobject_release+0x6a/0x170
> [    7.553944] 	kobject_put+0x2f/0x60
> [    7.553945] 	blk_put_queue+0x15/0x20
> [    7.553947] 	scsi_device_dev_release_usercontext+0x1b6/0x210
> [    7.553947] 	execute_in_process_context+0x94/0xa0
> [    7.553948] 	scsi_device_dev_release+0x1c/0x20
> [    7.553951] 	device_release+0x32/0x90
> [    7.553952] 	kobject_release+0x6a/0x170
> [    7.553952] 	kobject_put+0x2f/0x60
> [    7.553954] 	put_device+0x17/0x20
> [    7.553955] 	__scsi_remove_device+0x92/0xd0
> [    7.553956] INFO: Slab 0xffffea00088a5000 objects=13 used=13 fp=0x          (null) flags=0x2fffff80008100
> [    7.553957] INFO: Object 0xffff880222942548 @offset=9544 fp=0xffff880222940958
> [    7.553957] 
> [    7.553958] Redzone ffff880222942540: bb bb bb bb bb bb bb bb                          ........
> [    7.553959] Object ffff880222942548: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553959] Object ffff880222942558: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553960] Object ffff880222942568: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553960] Object ffff880222942578: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553961] Object ffff880222942588: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553961] Object ffff880222942598: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553962] Object ffff8802229425a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553963] Object ffff8802229425b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553963] Object ffff8802229425c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553964] Object ffff8802229425d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553964] Object ffff8802229425e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553965] Object ffff8802229425f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553966] Object ffff880222942608: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553966] Object ffff880222942618: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553967] Object ffff880222942628: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553967] Object ffff880222942638: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553968] Object ffff880222942648: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553968] Object ffff880222942658: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553969] Object ffff880222942668: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553970] Object ffff880222942678: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553970] Object ffff880222942688: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553971] Object ffff880222942698: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553971] Object ffff8802229426a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553972] Object ffff8802229426b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553973] Object ffff8802229426c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553973] Object ffff8802229426d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553974] Object ffff8802229426e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553974] Object ffff8802229426f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553975] Object ffff880222942708: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553975] Object ffff880222942718: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553976] Object ffff880222942728: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553976] Object ffff880222942738: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553977] Object ffff880222942748: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553978] Object ffff880222942758: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553978] Object ffff880222942768: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553979] Object ffff880222942778: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553979] Object ffff880222942788: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553980] Object ffff880222942798: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553980] Object ffff8802229427a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553981] Object ffff8802229427b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553981] Object ffff8802229427c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553982] Object ffff8802229427d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553982] Object ffff8802229427e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553983] Object ffff8802229427f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553983] Object ffff880222942808: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553984] Object ffff880222942818: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553984] Object ffff880222942828: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553985] Object ffff880222942838: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553985] Object ffff880222942848: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553986] Object ffff880222942858: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553987] Object ffff880222942868: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553987] Object ffff880222942878: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553988] Object ffff880222942888: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553988] Object ffff880222942898: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553989] Object ffff8802229428a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553989] Object ffff8802229428b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553990] Object ffff8802229428c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553990] Object ffff8802229428d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553991] Object ffff8802229428e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553992] Object ffff8802229428f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553992] Object ffff880222942908: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553993] Object ffff880222942918: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553993] Object ffff880222942928: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553994] Object ffff880222942938: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553994] Object ffff880222942948: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553995] Object ffff880222942958: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553995] Object ffff880222942968: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553996] Object ffff880222942978: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553997] Object ffff880222942988: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553997] Object ffff880222942998: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553998] Object ffff8802229429a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553998] Object ffff8802229429b8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.553999] Object ffff8802229429c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554000] Object ffff8802229429d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554000] Object ffff8802229429e8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554001] Object ffff8802229429f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554001] Object ffff880222942a08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554002] Object ffff880222942a18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554002] Object ffff880222942a28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554003] Object ffff880222942a38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554003] Object ffff880222942a48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554004] Object ffff880222942a58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554005] Object ffff880222942a68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554005] Object ffff880222942a78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554006] Object ffff880222942a88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554006] Object ffff880222942a98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554007] Object ffff880222942aa8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554007] Object ffff880222942ab8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554008] Object ffff880222942ac8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554009] sd 2:0:0:0: [sda] Cache data unavailable
> [    7.554009] Object ffff880222942ad8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554010] Object ffff880222942ae8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554010] sd 2:0:0:0: [sda] Assuming drive cache: write through
> [    7.554011] Object ffff880222942af8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554012] Object ffff880222942b08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554012] Object ffff880222942b18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554013] Object ffff880222942b28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554013] Object ffff880222942b38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554014] Object ffff880222942b48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554014] Object ffff880222942b58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554015] Object ffff880222942b68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554015] Object ffff880222942b78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554016] Object ffff880222942b88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554017] Object ffff880222942b98: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00  kkkkkkkk........
> [    7.554017] Object ffff880222942ba8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554018] Object ffff880222942bb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554018] Object ffff880222942bc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554019] Object ffff880222942bd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554019] Object ffff880222942be8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554020] Object ffff880222942bf8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554021] Object ffff880222942c08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554021] Object ffff880222942c18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554022] Object ffff880222942c28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554022] Object ffff880222942c38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554023] Object ffff880222942c48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554023] Object ffff880222942c58: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554024] Object ffff880222942c68: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554025] Object ffff880222942c78: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554025] Object ffff880222942c88: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554026] Object ffff880222942c98: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554026] Object ffff880222942ca8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554027] Object ffff880222942cb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554027] Object ffff880222942cc8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554028] Object ffff880222942cd8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554028] Object ffff880222942ce8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554029] Object ffff880222942cf8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554030] Object ffff880222942d08: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554030] Object ffff880222942d18: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554031] Object ffff880222942d28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [    7.554031] Object ffff880222942d38: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
> [    7.554032] Redzone ffff880222942d48: bb bb bb bb bb bb bb bb                          ........
> [    7.554033] Padding ffff880222942e88: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> [    7.554035] CPU: 1 PID: 266 Comm: systemd-udevd Tainted: G    B           4.10.0+ #146
> [    7.554035] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/31/2013
> [    7.554036] Call Trace:
> [    7.554039]  dump_stack+0x86/0xc3
> [    7.554040]  print_trailer+0x165/0x260
> [    7.554042]  check_bytes_and_report+0xc1/0x100
> [    7.554044]  check_object+0x241/0x290
> [    7.554047]  ? neigh_sysctl_register+0x42/0x1f0
> [    7.554048]  ? neigh_sysctl_register+0x42/0x1f0
> [    7.554049]  alloc_debug_processing+0x113/0x1b0
> [    7.554051]  ___slab_alloc+0x592/0x600
> [    7.554053]  ? neigh_sysctl_register+0x42/0x1f0
> [    7.554055]  ? __proc_create+0xb7/0x2a0
> [    7.554058]  ? neigh_sysctl_register+0x42/0x1f0
> [    7.554059]  __slab_alloc+0x51/0x90
> [    7.554061]  ? neigh_sysctl_register+0x42/0x1f0
> [    7.554062]  __kmalloc_track_caller+0x29f/0x3f0
> [    7.554065]  ? ndisc_constructor+0x430/0x430
> [    7.554075]  kmemdup+0x20/0x50
> [    7.554077]  neigh_sysctl_register+0x42/0x1f0
> [    7.554079]  ? trace_hardirqs_on+0xd/0x10
> [    7.554081]  ? __local_bh_enable_ip+0x70/0xc0
> [    7.554084]  addrconf_sysctl_register+0x64/0xa0
> [    7.554086]  ipv6_add_dev+0x365/0x4c0
> [    7.554087]  ? kmem_cache_alloc_trace+0x250/0x3a0
> [    7.554089]  addrconf_notify+0x2d2/0x980
> [    7.554092]  notifier_call_chain+0x39/0xa0
> [    7.554094]  raw_notifier_call_chain+0x16/0x20
> [    7.554096]  call_netdevice_notifiers_info+0x35/0x60
> [    7.554098]  register_netdevice+0x474/0x5c0
> [    7.554100]  register_netdev+0x1a/0x30
> [    7.554113]  e1000_probe+0xbcb/0x1180 [e1000]
> [    7.554114]  ? trace_hardirqs_on_caller+0xf5/0x1b0
> [    7.554115]  ? work_on_cpu+0xd0/0xd0
> [    7.554119]  local_pci_probe+0x45/0xa0
> [    7.554120]  ? pci_match_device+0xca/0x110
> [    7.554123]  pci_device_probe+0xfd/0x150
> [    7.554124]  ? _raw_spin_unlock+0x27/0x40
> [    7.554127]  driver_probe_device+0x2bb/0x460
> [    7.554129]  __driver_attach+0xe3/0xf0
> [    7.554130]  ? driver_probe_device+0x460/0x460
> [    7.554131]  bus_for_each_dev+0x73/0xc0
> [    7.554133]  driver_attach+0x1e/0x20
> [    7.554134]  bus_add_driver+0x173/0x270
> [    7.554136]  driver_register+0x60/0xe0
> [    7.554138]  __pci_register_driver+0x60/0x70
> [    7.554139]  ? 0xffffffffa012e000
> [    7.554149]  e1000_init_module+0x4c/0x1000 [e1000]
> [    7.554151]  ? 0xffffffffa012e000
> [    7.554152]  do_one_initcall+0x52/0x1b0
> [    7.554154]  ? rcu_read_lock_sched_held+0x4a/0x80
> [    7.554155]  ? kmem_cache_alloc_trace+0x300/0x3a0
> [    7.554156]  ? kfree+0x16e/0x340
> [    7.554158]  ? do_init_module+0x27/0x1fa
> [    7.554161]  do_init_module+0x5f/0x1fa
> [    7.554163]  load_module+0x1876/0x1cd0
> [    7.554164]  ? m_show+0x1b0/0x1b0
> [    7.554165]  ? show_coresize+0x30/0x30
> [    7.554170]  SYSC_finit_module+0xdf/0x110
> [    7.554174]  SyS_finit_module+0xe/0x10
> [    7.554176]  entry_SYSCALL_64_fastpath+0x1f/0xc2
> [    7.554177] RIP: 0033:0x7f26031a4bf9
> [    7.554185] RSP: 002b:00007ffdb44d1d18 EFLAGS: 00000206 ORIG_RAX: 0000000000000139
> [    7.554186] RAX: ffffffffffffffda RBX: 00007f2603cc3cc0 RCX: 00007f26031a4bf9
> [    7.554187] RDX: 0000000000000000 RSI: 00007f2603abfcf9 RDI: 0000000000000007
> [    7.554187] RBP: 00007ffdb44d1d10 R08: 0000000000000000 R09: 0000000000000000
> [    7.554188] R10: 0000000000000007 R11: 0000000000000206 R12: 0000558e8eaf1870
> [    7.554188] R13: 0000558e8eaee2e0 R14: 00007ffdb44d1cb0 R15: 0000000000000006
> [    7.554193] FIX kmalloc-2048: Restoring 0xffff880222942ba0-0xffff880222942ba7=0x6b
> [    7.554193] 
> [    7.554194] FIX kmalloc-2048: Marking all objects used
> [    7.554554] e1000 0000:02:00.0 eth0: (PCI:66MHz:32-bit) 00:0c:29:50:dc:9e
> [    7.554561] e1000 0000:02:00.0 eth0: Intel(R) PRO/1000 Network Connection
> [    7.569181]  sda: sda1
> [    7.595531] sd 2:0:0:0: [sda] Attached SCSI disk
> ----------------------------------------
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
