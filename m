Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEDC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655C261250
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 11:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhIOL1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 07:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232526AbhIOL1n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 07:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631705184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSUc4NdjKkdRmh4Gh2b5v38VUSKOP/Vty204+UxVfJQ=;
        b=MAWn/9BjSGXcl4Tsm5B/llTnjLeZSGzVAAPpKnBLe9uyomhk+kMjiD3Ctj1k8Ca8dVvhqK
        rlFrHxemFShlDieqCCj+mwRk+TQjOK53IB1Wux1g0BDBrUXRkpm7Z6L3t2mdGE6W1Vn6Z+
        9GwtBMMOtNxuDPTtq6KXb4KSN2E/wo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-snZFdiKINXi-M2Hufy4sRA-1; Wed, 15 Sep 2021 07:26:22 -0400
X-MC-Unique: snZFdiKINXi-M2Hufy4sRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C35EC1006AB7
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 11:26:21 +0000 (UTC)
Received: from T590 (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FC036A257;
        Wed, 15 Sep 2021 11:26:04 +0000 (UTC)
Date:   Wed, 15 Sep 2021 19:26:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Ming Lei <minlei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: Fwd: [bug report] WARNING at block/genhd.c:537
 device_add_disk+0x1ad/0x390 observed with blktests block/001
Message-ID: <YUHYVtMXADA3aicd@T590>
References: <CAHj4cs9v-z4NXmtoU3dhxjXZY0Ecxh_rQU+ic7DOA2CVSVotcw@mail.gmail.com>
 <CAHj4cs8EUAET8X2LKHnG2yVwqkGuAV2Jb37W1z1pr7KK64yNfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8EUAET8X2LKHnG2yVwqkGuAV2Jb37W1z1pr7KK64yNfg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 07:13:55PM +0800, Yi Zhang wrote:
> Hi Ming
> Just want let you know I found this issue during blktests block/001 on
> storage-qe-36 server, I send this report to linux-block, but the mail was
> blocked. :(

That is sad, :-(

BTW, the following patch can fix the issue:

https://lore.kernel.org/linux-block/20210915092547.990285-1-ming.lei@redhat.com/T/#u


> 
> ---------- Forwarded message ---------
> From: Yi Zhang <yi.zhang@redhat.com>
> Date: Wed, Sep 15, 2021 at 1:28 PM
> Subject: [bug report] WARNING at block/genhd.c:537
> device_add_disk+0x1ad/0x390 observed with blktests block/001
> To: linux-block <linux-block@vger.kernel.org>
> 
> 
> Hello
> 
> The following kernel warnings/panic triggered on 5.15.0-rc1 with blktests
> block/001, feel free to let me know if you need more info.
> 
> [  138.287801] run blktests block/001 at 2021-09-15 01:15:33
> [  138.310004] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues
> to 0. poll_q/nr_hw = (0/1)
> [  138.319283] sd 15:0:0:0: Power-on or device reset occurred
> [  138.319292] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues
> to 0. poll_q/nr_hw = (0/1)
> [  138.333918] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues
> to 0. poll_q/nr_hw = (0/1)
> [  138.334012] sd 16:0:0:0: Power-on or device reset occurred
> [  138.348549] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues
> to 0. poll_q/nr_hw = (0/1)
> [  138.348629] sd 17:0:0:0: Power-on or device reset occurred
> [  138.363189] sd 18:0:0:0: Power-on or device reset occurred
> [  138.461052] ------------[ cut here ]------------
> [  138.465670] WARNING: CPU: 1 PID: 1161 at block/genhd.c:537
> device_add_disk+0x1ad/0x390
> [  138.473591] Modules linked in: dm_service_time scsi_debug
> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
> netfs rfkill sunrpc vfat fat dm_multipath intel_rapl_msr intel_rapl_common
> isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp
> kvm_intel kvm mgag200 i2c_algo_bit drm_kms_helper irqbypass iTCO_wdt
> crct10dif_pclmul iTCO_vendor_support crc32_pclmul ipmi_ssif syscopyarea
> sysfillrect sysimgblt ghash_clmulni_intel fb_sys_fops rapl acpi_ipmi drm
> ipmi_si intel_cstate mei_me ipmi_devintf dax_pmem_compat intel_uncore mei
> i2c_i801 pcspkr wmi_bmof nd_pmem device_dax lpc_ich ipmi_msghandler
> intel_pch_thermal i2c_smbus nd_btt dax_pmem_core acpi_power_meter xfs
> libcrc32c sd_mod t10_pi sg ahci libahci libata nfit tg3 megaraid_sas
> crc32c_intel libnvdimm wmi dm_mirror dm_region_hash dm_log dm_mod
> [  138.533963] BUG: kernel NULL pointer dereference, address:
> 0000000000000098
> [  138.546449] CPU: 1 PID: 1161 Comm: multipathd Tainted: G S        I
>   5.15.0-rc1 #1
> [  138.553403] #PF: supervisor read access in kernel mode
> [  138.553404] #PF: error_code(0x0000) - not-present page
> [  138.553405] PGD 0 P4D 0
> [  138.561405] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.11.2
> 004/21/2021
> [  138.566542]
> [  138.566543] Oops: 0000 [#1] SMP NOPTI
> [  138.566545] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S        I
> 5.15.0-rc1 #1
> [  138.571683] RIP: 0010:device_add_disk+0x1ad/0x390
> [  138.574221] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.11.2
> 004/21/2021
> [  138.574222] RIP: 0010:wb_timer_fn+0x37/0x320
> [  138.581872] Code: 81 3b 03 01 00 00 0f 85 39 ff ff ff e9 25 ff ff ff 0f
> 0b bd ea ff ff ff e9 30 ff ff ff 4c 89 ef e8 a8 b6 1b 00 e9 f8 fe ff ff
> <0f> 0b bd 01 00 00 00 e9 17 ff ff ff 0f 0b bd ea ff ff ff e9 0b ff
> [  138.583363] Code: 48 8b 5f 60 4c 8b 67 50 8b ab 98 00 00 00 8b 93 b8 00
> 00 00 8b 83 d8 00 00 00 4c 8b 6b 28 01 d5 01 c5 48 8b 43 60 48 8b 40 78
> <4c> 8b b0 98 00 00 00 4d 85 ed 0f 84 c0 00 00 00 48 83 7b 30 00 0f
> [  138.583365] RSP: 0018:ffffb4d7c0300e80 EFLAGS: 00010246
> [  138.587029] RSP: 0018:ffffb4d7c0e2bc40 EFLAGS: 00010282
> [  138.594672] RAX: 0000000000000000 RBX: ffff9fd941d74a00 RCX:
> 0000000000000020
> [  138.594674] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff9fd9418cfd80
> [  138.594674] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> [  138.594675] R10: 000000000000001f R11: 00000000000003a8 R12:
> ffff9fd9420a0cc0
> [  138.599381]
> [  138.607032] R13: 0000000000000000 R14: ffff9fd9418cfd90 R15:
> ffff9fe87fa97f70
> [  138.607033] FS:  0000000000000000(0000) GS:ffff9fe87fa80000(0000)
> knlGS:0000000000000000
> [  138.607035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  138.611306] RAX: 0000000000000000 RBX: ffff9fd9e4187400 RCX:
> dead000000000122
> [  138.630049] CR2: 0000000000000098 CR3: 000000010371e004 CR4:
> 00000000007706e0
> [  138.630051] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  138.630051] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [  138.630052] PKRU: 55555554
> [  138.648797] RDX: ffff9fd98299bf00 RSI: ffffffffa8eac593 RDI:
> 0000000000000000
> [  138.654021] Call Trace:
> [  138.654023]  <IRQ>
> [  138.654025]  ? blk_stat_free_callback_rcu+0x30/0x30
> [  138.659248] RBP: 00000000fffffffe R08: 0000000000000001 R09:
> ffffffffa8dfdb00
> [  138.666378]  call_timer_fn+0x24/0xf0
> [  138.673512] R10: ffff9fd94f701780 R11: 0000000000000001 R12:
> ffff9fda40024800
> [  138.680643]  run_timer_softirq+0x1c7/0x3d0
> [  138.680646]  ? update_process_times+0xb0/0xc0
> [  138.687777] R13: ffff9fda40024840 R14: ffff9fda40024800 R15:
> 0000000000000000
> [  138.689276]  ? tick_sched_handle.isra.24+0x1f/0x60
> [  138.696408] FS:  00007f473d28d700(0000) GS:ffff9fe87fa40000(0000)
> knlGS:0000000000000000
> [  138.704494]  ? timerqueue_add+0x6f/0x80
> [  138.704496]  ? enqueue_hrtimer+0x2f/0x70
> [  138.710242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  138.717371]  ? ktime_get+0x3b/0xa0
> [  138.717373]  __do_softirq+0xc6/0x285
> [  138.724505] CR2: 00007f347b9e0590 CR3: 000000010c092006 CR4:
> 00000000007706e0
> [  138.731638]  irq_exit_rcu+0xa6/0xc0
> [  138.738771] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  138.741482]  sysvec_apic_timer_interrupt+0x6e/0x90
> [  138.741485]  </IRQ>
> [  138.748614] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [  138.751056]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  138.753076] PKRU: 55555554
> [  138.757948] RIP: 0010:cpuidle_enter_state+0xd6/0x350
> [  138.765080] Call Trace:
> [  138.768652] Code: 49 89 c4 0f 1f 44 00 00 31 ff e8 05 05 98 ff 45 84 ff
> 74 12 9c 58 f6 c4 02 0f 85 32 02 00 00 31 ff e8 ce a4 9e ff fb 45 85 f6
> <0f> 88 e0 00 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04 82 49
> [  138.768653] RSP: 0018:ffffb4d7c01bbe80 EFLAGS: 00000202
> [  138.768654] RAX: ffff9fe87faa7c00 RBX: 0000000000000002 RCX:
> 000000000000001f
> [  138.775787]  dm_setup_md_queue+0xbe/0xf0 [dm_mod]
> [  138.779883] RDX: 0000002041447a1c RSI: 000000002c3ddb16 RDI:
> 0000000000000000
> [  138.779884] RBP: ffffd4d7bf680588 R08: 0000000000000002 R09:
> 0000000000027440
> [  138.779884] R10: 000000a2559bce5c R11: ffff9fe87faa6944 R12:
> 0000002041447a1c
> [  138.779885] R13: ffffffffaa4ca6a0 R14: 0000000000000002 R15:
> 0000000000000000
> [  138.784243]  table_load+0x1c0/0x2e0 [dm_mod]
> [  138.791376]  cpuidle_enter+0x29/0x40
> [  138.796169]  ? retrieve_status+0x1e0/0x1e0 [dm_mod]
> [  138.804251]  do_idle+0x257/0x2a0
> [  138.808092]  ctl_ioctl+0x1ad/0x420 [dm_mod]
> [  138.812009]  cpu_startup_entry+0x19/0x20
> [  138.812011]  start_secondary+0x116/0x150
> [  138.817758]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
> [  138.821159]  secondary_startup_64_no_verify+0xc2/0xcb
> [  138.821162] Modules linked in:
> [  138.824740]  __x64_sys_ioctl+0x81/0xc0
> [  138.831872]  dm_service_time scsi_debug rpcsec_gss_krb5 auth_rpcgss
> nfsv4 dns_resolver
> [  138.835366]  do_syscall_64+0x37/0x80
> [  138.842496]  nfs lockd grace fscache netfs rfkill sunrpc vfat
> [  138.847290]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  138.849386]  fat dm_multipath intel_rapl_msr intel_rapl_common
> isst_if_common skx_edac x86_pkg_temp_thermal
> [  138.856519] RIP: 0033:0x7f473b4dd62b
> [  138.861650]  intel_powerclamp coretemp kvm_intel kvm mgag200
> i2c_algo_bit drm_kms_helper irqbypass
> [  138.864362] Code: 0f 1e fa 48 8b 05 5d b8 2c 00 64 c7 00 26 00 00 00 48
> c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05
> <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d b8 2c 00 f7 d8 64 89 01 48
> [  138.869319]  iTCO_wdt crct10dif_pclmul iTCO_vendor_support crc32_pclmul
> ipmi_ssif syscopyarea sysfillrect
> [  138.871773] RSP: 002b:00007f473d28b428 EFLAGS: 00000206
> [  138.890517]  sysimgblt ghash_clmulni_intel fb_sys_fops rapl acpi_ipmi
> drm ipmi_si intel_cstate mei_me
> [  138.895745]  ORIG_RAX: 0000000000000010
> [  138.902874]  ipmi_devintf dax_pmem_compat intel_uncore mei i2c_i801
> pcspkr wmi_bmof nd_pmem
> [  138.907582] RAX: ffffffffffffffda RBX: 00007f473bf6b270 RCX:
> 00007f473b4dd62b
> [  138.914713]  device_dax lpc_ich ipmi_msghandler intel_pch_thermal
> i2c_smbus nd_btt dax_pmem_core acpi_power_meter
> [  138.921848] RDX: 00007f472401dbf0 RSI: 00000000c138fd09 RDI:
> 0000000000000005
> [  138.928978]  xfs libcrc32c sd_mod t10_pi sg ahci libahci libata nfit
> [  138.936111] RBP: 00007f473bfa6f83 R08: 00007f473d289180 R09:
> 00007f473c1b5058
> [  138.940373]  tg3 megaraid_sas crc32c_intel libnvdimm wmi dm_mirror
> dm_region_hash
> [  138.943956] R10: 0000000000000000 R11: 0000000000000206 R12:
> 00007f472401dbf0
> [  138.948834]  dm_log dm_mod
> [  138.948836] CR2: 0000000000000098
> [  138.948837] ---[ end trace 3235ef2b3e8a55ec ]---
> [  138.952068] R13: 00007f472401dca0 R14: 0000000000000000 R15:
> 00007f4724007530
> [  138.959447] RIP: 0010:wb_timer_fn+0x37/0x320
> [  138.961114] ---[ end trace 3235ef2b3e8a55ed ]---
> [  138.965030] Code: 48 8b 5f 60 4c 8b 67 50 8b ab 98 00 00 00 8b 93 b8 00
> 00 00 8b 83 d8 00 00 00 4c 8b 6b 28 01 d5 01 c5 48 8b 43 60 48 8b 40 78
> <4c> 8b b0 98 00 00 00 4d 85 ed 0f 84 c0 00 00 00 48 83 7b 30 00 0f
> [  138.965032] RSP: 0018:ffffb4d7c0300e80 EFLAGS: 00010246
> [  138.969219] kobject_add_internal failed for dm (error: -2 parent: dm-3)
> [  138.974269] RAX: 0000000000000000 RBX: ffff9fd941d74a00 RCX:
> 0000000000000020
> [  138.974271] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff9fd9418cfd80
> [  138.974271] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> [  138.974272] R10: 000000000000001f R11: 00000000000003a8 R12:
> ffff9fd9420a0cc0
> [  138.974273] R13: 0000000000000000 R14: ffff9fd9418cfd90 R15:
> ffff9fe87fa97f70
> [  138.975397] scsi 15:0:0:0: Direct-Access     Linux    scsi_debug
> 0190 PQ: 0 ANSI: 7
> [  138.975475] sd 15:0:0:0: Attached scsi generic sg1 type 0
> [  138.975496] sd 15:0:0:0: Power-on or device reset occurred
> [  138.976516] sd 15:0:0:0: [sdc] Read Capacity(16) failed: Result:
> hostbyte=DID_ERROR driverbyte=DRIVER_OK
> [  138.976518] sd 15:0:0:0: [sdc] Sense not available.
> [  138.976520] sd 15:0:0:0: [sdc] Read Capacity(10) failed: Result:
> hostbyte=DID_ERROR driverbyte=DRIVER_OK
> [  138.976521] sd 15:0:0:0: [sdc] Sense not available.
> [  138.976524] sd 15:0:0:0: [sdc] 0 512-byte logical blocks: (0 B/0 B)
> [  138.976525] sd 15:0:0:0: [sdc] 0-byte physical blocks
> [  138.976526] sd 15:0:0:0: [sdc] Write Protect is off
> [  138.976527] sd 15:0:0:0: [sdc] Mode Sense: 00 00 00 00
> [  138.976528] sd 15:0:0:0: [sdc] Asking for cache data failed
> [  138.976529] sd 15:0:0:0: [sdc] Assuming drive cache: write through
> [  138.977337] ------------[ cut here ]------------
> [  138.981081] FS:  0000000000000000(0000) GS:ffff9fe87fa80000(0000)
> knlGS:0000000000000000
> [  138.981082] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  138.981083] CR2: 0000000000000098 CR3: 000000010371e004 CR4:
> 00000000007706e0
> [  138.981084] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  138.988993] WARNING: CPU: 1 PID: 1161 at block/genhd.c:564
> del_gendisk+0x186/0x1c0
> [  138.992562] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [  138.992563] PKRU: 55555554
> [  138.992564] Kernel panic - not syncing: Fatal exception in interrupt
> [  139.493526] Kernel Offset: 0x27a00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  139.872338] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
> 
> 
> 
> -- 
> Best Regards,
>   Yi Zhang
> 
> 
> -- 
> Best Regards,
>   Yi Zhang

-- 
Ming

