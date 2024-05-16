Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC94501A
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847376; cv=none; b=LgcI/Fxjj/8Kn2UStuaJFD57T962QsMpHzlpFzvZ/Itr+jPls/vc4dksbaxOmicZRTDrUk5GvgZlyC7uYxqxcyUBa0Gvlj50baLNpBOaGTv/7t3GABJf0qY4+uoqwgieR//I9+uiq7/snNpnBEpaCgwJ2GPIjUZROA/r/hu0ngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847376; c=relaxed/simple;
	bh=tDt71eGGQkoblpp9Y5LfqmxQi3nRgWoKVUr+dpD9mxM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tSXWu04PEHdPlPEg47+vWxK3GmChkI3Qwpi2L0I3qlkMvzSlRGnFtwYlVpG7Gf3N9hgIIuHwV3SJGj9NRLzXCurMs3SOrYqrheCTRkbdsg2Tmrv2+oihzre0k7haqFTEfBfo19bIolUvZ0keT+Pwl3mN077QuolUujhV4SyBAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3HAsEDI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3HAsEDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715847374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xnwDuIMb6i6CXOQgNM+5GCFZE9JiN5nslAlN+738RQA=;
	b=P3HAsEDISg9mNgQdHQzmiFCcjgvFu357JVAU7b0r/raHz+77jLWJnf7eLW7juNIfMOeS32
	fPNX7Vjd8d07K9LgJE9dVVrGo13aOKioiFIkWYo8MDLa+lX3Q9ygZaENCV5PC4G22NcSG8
	0vN3IgbDpmQENkyYMFrkLw2Tka9fncI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-GGJjH7jkOXOD9mWgZx3Z1Q-1; Thu, 16 May 2024 04:15:57 -0400
X-MC-Unique: GGJjH7jkOXOD9mWgZx3Z1Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b6215bcdf2so7434026a91.3
        for <linux-block@vger.kernel.org>; Thu, 16 May 2024 01:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715847356; x=1716452156;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnwDuIMb6i6CXOQgNM+5GCFZE9JiN5nslAlN+738RQA=;
        b=C575B1no25PAv1VJNo3O2ZLa3rhfj64X7fIUqvtxq5AlUif86KEsGjZUjsBci1yE+c
         kd4PM5HKFxMpqcnac60f3SrziVOesJhiNR+OwmKVeqKFDVaOOcaFptZQh1EtOiF5uXjy
         HcObZKVtlHnKw59W+VFguf2fgbA16J/4ziaXWo4azyJ865fS/VNtlAhlRHT86TlAEXCg
         jEbSA2S2gOR9U8xyOQddLDRb2NiyqeAobXcRfOedZO0e3o0GVQil77lvjMBs0KSz8jgk
         1/4fVES08wVhy3XY+lAfJNyaOH4imgX+vKKENIyQNUYK1uCUs26pHxUPSBX5fOGQrze2
         vo5A==
X-Gm-Message-State: AOJu0YxpdTB2eVLqCl/ueJdE1A5mljmdOUWnackkisaszLaf9eJ8us9h
	xkenp/EuKeAUq+te2z0QLqiN/frbm7vKEqUR4E75SYARDM4EmPXMScCyRL75E4MulXag2Q+p1Sq
	csJR+DNgScfjcKrf2lgQX/nTSGsSBg3OoucOECpe/FBRR8pCJv8i58dUIbhRBaK9zSmNn+PYyyY
	8+DyG2n5dDo5iE6eR3mFpYiIkrhy1YqN8O1tyOFCQSBgBTAASS
X-Received: by 2002:a17:90a:d998:b0:2b0:d249:4e88 with SMTP id 98e67ed59e1d1-2b6cc76d343mr19089690a91.26.1715847355003;
        Thu, 16 May 2024 01:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo2Dgdn/0lrpLIv7V8a/FJzbq329gha5JlyuwwenwLaEzQzG0W++8TzrAMIh0U48Raa/0hkyrvQmHYf37mgFQ=
X-Received: by 2002:a17:90a:d998:b0:2b0:d249:4e88 with SMTP id
 98e67ed59e1d1-2b6cc76d343mr19089662a91.26.1715847354402; Thu, 16 May 2024
 01:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 16 May 2024 16:15:42 +0800
Message-ID: <CAHj4cs-PHTh==_yd2y=mfkNmHA_t-ZZfFP1Up=kmEg+yg9rgvg@mail.gmail.com>
Subject: [bug report] blktests stress block/027 lead kernel panic
To: linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello

I reproduced the panic issue when I did stress blktests block/027 on
the latest linux-block/for-next, please help check it and let me know
if you need any info/testing for it, thanks.

reproducer: blktests block/027
===============================1046
block/027 (stress device hotplugging with running fio jobs and
different schedulers)
    runtime  19.133s  ...

console log:
[21450.047669] run blktests block/027 at 2024-05-16 03:57:49
[21450.214851] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[21450.224506] scsi 17:0:0:0: Power-on or device reset occurred
[21450.230875] scsi 17:0:0:1: Power-on or device reset occurred
[21450.237001] scsi 17:0:0:2: Power-on or device reset occurred
[21450.243487] scsi 17:0:0:3: Power-on or device reset occurred
[21450.249872] scsi 17:0:0:4: Power-on or device reset occurred
[21450.256304] scsi 17:0:0:5: Power-on or device reset occurred
[21450.262757] scsi 17:0:0:6: Power-on or device reset occurred
[21450.269045] scsi 17:0:0:7: Power-on or device reset occurred
[21450.275510] scsi 17:0:0:8: Power-on or device reset occurred
[21450.281862] scsi 17:0:0:9: Power-on or device reset occurred
[21450.288123] scsi 17:0:0:10: Power-on or device reset occurred
[21450.294574] scsi 17:0:0:11: Power-on or device reset occurred
[21450.300826] scsi 17:0:0:12: Power-on or device reset occurred
[21450.307109] scsi 17:0:0:13: Power-on or device reset occurred
[21450.313300] scsi 17:0:0:14: Power-on or device reset occurred
[21450.319797] scsi 17:0:0:15: Power-on or device reset occurred
[21450.326257] scsi 17:0:0:16: Power-on or device reset occurred
[21450.332660] scsi 17:0:0:17: Power-on or device reset occurred
[21450.339060] scsi 17:0:0:18: Power-on or device reset occurred
[21450.345420] scsi 17:0:0:19: Power-on or device reset occurred
[21450.351566] scsi 17:0:0:20: Power-on or device reset occurred
[21457.215692] blk_print_req_error: 2506 callbacks suppressed
[21457.215700] device offline error, dev sdb, sector 172826112 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[21457.215702] device offline error, dev sdb, sector 175335984 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[21457.215707] device offline error, dev sdb, sector 176399576 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[21457.288323] device offline error, dev sdc, sector 2306480 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[21457.353288] device offline error, dev sdl, sector 147510656 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[21457.353296] device offline error, dev sdl, sector 81428152 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[21457.384691] device offline error, dev sdm, sector 179529120 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[21457.384692] device offline error, dev sdm, sector 228392936 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[21457.384698] device offline error, dev sdm, sector 264609872 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[21457.384707] device offline error, dev sdm, sector 26074432 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[21469.410622] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[21469.420770] scsi 17:0:0:0: Power-on or device reset occurred
[21469.650142] run blktests block/027 at 2024-05-16 03:58:09
[21469.815935] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[21469.825846] scsi 17:0:0:0: Power-on or device reset occurred
[21469.832285] scsi 17:0:0:1: Power-on or device reset occurred
[21469.838768] scsi 17:0:0:2: Power-on or device reset occurred
[21469.845054] scsi 17:0:0:3: Power-on or device reset occurred
[21469.851464] scsi 17:0:0:4: Power-on or device reset occurred
[21469.857809] scsi 17:0:0:5: Power-on or device reset occurred
[21469.864156] scsi 17:0:0:6: Power-on or device reset occurred
[21469.870390] scsi 17:0:0:7: Power-on or device reset occurred
[21469.876601] scsi 17:0:0:8: Power-on or device reset occurred
[21469.882868] scsi 17:0:0:9: Power-on or device reset occurred
[21469.889069] scsi 17:0:0:10: Power-on or device reset occurred
[21469.895510] scsi 17:0:0:11: Power-on or device reset occurred
[21469.901815] scsi 17:0:0:12: Power-on or device reset occurred
[21469.908128] scsi 17:0:0:13: Power-on or device reset occurred
[21469.914432] scsi 17:0:0:14: Power-on or device reset occurred
[21469.920777] scsi 17:0:0:15: Power-on or device reset occurred
[21469.927035] scsi 17:0:0:16: Power-on or device reset occurred
[21469.933238] scsi 17:0:0:17: Power-on or device reset occurred
[21469.939574] scsi 17:0:0:18: Power-on or device reset occurred
[21469.945898] scsi 17:0:0:19: Power-on or device reset occurred
[21469.952065] scsi 17:0:0:20: Power-on or device reset occurred
[21491.358889] watchdog: Watchdog detected hard LOCKUP on cpu 40
[21491.358894] Modules linked in: scsi_debug rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs rfkill vfat fat
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common isst_if_common skx_edac nfit ipmi_ssif
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
rapl iTCO_wdt acpi_ipmi iTCO_vendor_support intel_cstate ipmi_si
mgag200 mei_me intel_uncore i2c_i801 dcdbas ipmi_devintf dell_smbios
mei tg3 pcspkr dell_wmi_descriptor wmi_bmof intel_pch_thermal
i2c_algo_bit i2c_smbus lpc_ich ipmi_msghandler acpi_power_meter fuse
loop dm_multipath nfnetlink xfs rpcrdma sunrpc rdma_ucm ib_umad
ib_srpt ib_isert ib_ipoib iscsi_target_mod target_core_mod ib_iser
libiscsi scsi_transport_iscsi mlx5_ib iw_cxgb4 bnxt_re macsec rdma_cm
ib_uverbs iw_cm ib_cm sd_mod libcxgb ib_core csiostor crct10dif_pclmul
mlx5_core cxgb4 crc32_pclmul nvme crc32c_intel bnxt_en nvme_core ahci
mlxfw libahci psample nvme_auth ghash_clmulni_intel tls
pci_hyperv_intf t10_pi libata megaraid_sas
[21491.358957]  scsi_transport_fc dimlib wmi dm_mirror dm_region_hash
dm_log dm_mod [last unloaded: scsi_debug]
[21491.358965] CPU: 40 PID: 263 Comm: ksoftirqd/40 Not tainted 6.9.0+ #1
[21491.358968] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS
2.21.2 02/19/2024
[21491.358970] RIP: 0010:native_queued_spin_lock_slowpath+0x26d/0x2a0
[21491.358979] Code: c1 ea 12 83 e0 03 83 ea 01 48 c1 e0 05 48 63 d2
48 05 40 65 03 00 48 03 04 d5 20 5d 70 a0 48 89 28 8b 45 08 85 c0 75
09 f3 90 <8b> 45 08 85 c0 74 f7 48 8b 55 00 48 85 d2 0f 84 77 ff ff ff
0f 0d
[21491.358982] RSP: 0018:ffffa3eb070b7cf0 EFLAGS: 00000046
[21491.358985] RAX: 0000000000000000 RBX: ffff8bf0dac28b80 RCX: 0000000000000000
[21491.358986] RDX: 0000000000000010 RSI: 0000000000440101 RDI: ffff8bf0dac28b80
[21491.358988] RBP: ffff8bfb91036540 R08: 0000000000000001 R09: 0000000000000066
[21491.358990] R10: 000000000003b740 R11: 0000000000000024 R12: 0000000000a40000
[21491.358992] R13: 0000000000a40000 R14: 0000000000000000 R15: ffffc3df0103e540
[21491.358993] FS:  0000000000000000(0000) GS:ffff8bfb91000000(0000)
knlGS:0000000000000000
[21491.358995] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21491.358997] CR2: 000055e6becc3c40 CR3: 0000000c9c104001 CR4: 00000000007706f0
[21491.358998] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[21491.358999] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[21491.359000] PKRU: 55555554
[21491.359001] Call Trace:
[21491.359004]  <NMI>
[21491.359008]  ? show_trace_log_lvl+0x1b0/0x2f0
[21491.359012]  ? show_trace_log_lvl+0x1b0/0x2f0
[21491.359016]  ? _raw_spin_lock_irqsave+0x31/0x40
[21491.359019]  ? watchdog_hardlockup_check.cold+0xea/0xef
[21491.359023]  ? __perf_event_overflow+0xe5/0x2a0
[21491.359028]  ? handle_pmi_common+0x19b/0x3b0
[21491.359038]  ? intel_pmu_handle_irq+0x10b/0x2a0
[21491.359042]  ? perf_event_nmi_handler+0x2a/0x50
[21491.359046]  ? nmi_handle+0x5e/0x120
[21491.359052]  ? default_do_nmi+0x40/0x130
[21491.359058]  ? exc_nmi+0x103/0x180
[21491.359061]  ? end_repeat_nmi+0xf/0x53
[21491.359067]  ? native_queued_spin_lock_slowpath+0x26d/0x2a0
[21491.359070]  ? native_queued_spin_lock_slowpath+0x26d/0x2a0
[21491.359073]  ? native_queued_spin_lock_slowpath+0x26d/0x2a0
[21491.359075]  </NMI>
[21491.359076]  <TASK>
[21491.359077]  _raw_spin_lock_irqsave+0x31/0x40
[21491.359080]  __wake_up+0x21/0x60
[21491.359085]  sbitmap_queue_wake_up+0x74/0xb0
[21491.359090]  sbitmap_queue_clear+0x3b/0x60
[21491.359093]  __blk_mq_free_request+0xac/0xe0
[21491.359099]  scsi_end_request+0xdb/0x1b0
[21491.359105]  scsi_io_completion+0x56/0x390
[21491.359109]  blk_complete_reqs+0x3d/0x50
[21491.359112]  handle_softirqs+0xdf/0x2a0
[21491.359118]  ? __pfx_smpboot_thread_fn+0x10/0x10
[21491.359121]  run_ksoftirqd+0x25/0x30
[21491.359124]  smpboot_thread_fn+0xda/0x1d0
[21491.359126]  kthread+0xcf/0x100
[21491.359130]  ? __pfx_kthread+0x10/0x10
[21491.359133]  ret_from_fork+0x31/0x50
[21491.359137]  ? __pfx_kthread+0x10/0x10
[21491.359139]  ret_from_fork_asm+0x1a/0x30
[21491.359144]  </TASK>
[21491.359146] Kernel panic - not syncing: Hard LOCKUP
[21491.359147] CPU: 40 PID: 263 Comm: ksoftirqd/40 Not tainted 6.9.0+ #1
[21491.359149] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS
2.21.2 02/19/2024
[21491.359151] Call Trace:
[21491.359152]  <NMI>
[21491.359153]  dump_stack_lvl+0x4e/0x70
[21491.359157]  panic+0x113/0x2be
[21491.359161]  nmi_panic.cold+0xc/0xc
[21491.359162]  watchdog_hardlockup_check.cold+0xca/0xef
[21491.359165]  __perf_event_overflow+0xe5/0x2a0
[21491.359168]  handle_pmi_common+0x19b/0x3b0
[21491.359177]  intel_pmu_handle_irq+0x10b/0x2a0
[21491.359181]  perf_event_nmi_handler+0x2a/0x50
[21491.359184]  nmi_handle+0x5e/0x120
[21491.359188]  default_do_nmi+0x40/0x130
[21491.359191]  exc_nmi+0x103/0x180
[21491.359195]  end_repeat_nmi+0xf/0x53
[21491.359198] RIP: 0010:native_queued_spin_lock_slowpath+0x26d/0x2a0
[21491.359200] Code: c1 ea 12 83 e0 03 83 ea 01 48 c1 e0 05 48 63 d2
48 05 40 65 03 00 48 03 04 d5 20 5d 70 a0 48 89 28 8b 45 08 85 c0 75
09 f3 90 <8b> 45 08 85 c0 74 f7 48 8b 55 00 48 85 d2 0f 84 77 ff ff ff
0f 0d
[21491.359203] RSP: 0018:ffffa3eb070b7cf0 EFLAGS: 00000046
[21491.359204] RAX: 0000000000000000 RBX: ffff8bf0dac28b80 RCX: 0000000000000000
[21491.359206] RDX: 0000000000000010 RSI: 0000000000440101 RDI: ffff8bf0dac28b80
[21491.359207] RBP: ffff8bfb91036540 R08: 0000000000000001 R09: 0000000000000066
[21491.359208] R10: 000000000003b740 R11: 0000000000000024 R12: 0000000000a40000
[21491.359210] R13: 0000000000a40000 R14: 0000000000000000 R15: ffffc3df0103e540
[21491.359213]  ? native_queued_spin_lock_slowpath+0x26d/0x2a0
[21491.359216]  ? native_queued_spin_lock_slowpath+0x26d/0x2a0
[21491.359218]  </NMI>
[21491.359219]  <TASK>
[21491.359220]  _raw_spin_lock_irqsave+0x31/0x40
[21491.359222]  __wake_up+0x21/0x60
[21491.359225]  sbitmap_queue_wake_up+0x74/0xb0
[21491.359227]  sbitmap_queue_clear+0x3b/0x60
[21491.359230]  __blk_mq_free_request+0xac/0xe0
[21491.359233]  scsi_end_request+0xdb/0x1b0
[21491.359236]  scsi_io_completion+0x56/0x390
[21491.359239]  blk_complete_reqs+0x3d/0x50
[21491.359241]  handle_softirqs+0xdf/0x2a0
[21491.359244]  ? __pfx_smpboot_thread_fn+0x10/0x10
[21491.359246]  run_ksoftirqd+0x25/0x30
[21491.359248]  smpboot_thread_fn+0xda/0x1d0
[21491.359250]  kthread+0xcf/0x100
[21491.359252]  ? __pfx_kthread+0x10/0x10
[21491.359254]  ret_from_fork+0x31/0x50
[21491.359257]  ? __pfx_kthread+0x10/0x10
[21491.359259]  ret_from_fork_asm+0x1a/0x30
[21491.359263]  </TASK>
[21492.420618] Shutting down cpus with NMI
[21492.434119] Kernel Offset: 0x1e000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[21493.133039] ---[ end Kernel panic - not syncing: Hard LOCKUP ]---

--
Best Regards,
  Yi Zhang

