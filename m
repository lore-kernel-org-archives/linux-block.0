Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9DA32
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248984; cv=none; b=Vun5HDNzjgrQ8wMV8famYNOhzqWiSvX2bV0F7VdCMZHrENImAHSRp8NBQTSPkarFX5atYNgBJpz2Og4v4brFprX6f8hAOa8TMLWmRT944ZA63VAXYkTXpn/pRM5WAdnwQA4djJ02oqRdXlFbrSoGpfzHtLPWI1GdGnMHlf+tjTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248984; c=relaxed/simple;
	bh=06itOAoFiT4/qWKFIQpnfZimpdvtvvHkgSc12yazOig=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QTuBdRZkeIZmQaIaJeKT88w9vH5YQAMYkXSnmRg4Xwf8FJJJcWL94OuWIKpV/lbAN5fawFqw5v8fGFLVHxGBsm2ZqpnHLIs8gArG1tt/G3fkvC3ga80TvrJS4nOCbv5jUEcz6omMPIVwbRTHoZTakrl7si1GkeNMqUXC9CD2ztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFTdpWiM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFTdpWiM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725248981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=MHzVnCsHGmIdJtwcIOm/NoWOV1NM5BN3GxiNUcT5Diw=;
	b=VFTdpWiMQLIKZbBQo3KoE7alM+tp2i6iGRh483aLpOJJhpGADIGsS8x1JCY9Tq2+wuAfJO
	3g3Qnh3o1FjiwBzhHPYGuBMHlqqXUpaDsMfh/sIFo6hPNkKu3PGm2GTqF5qG0k3vFmcQ9I
	qsZvPGw10qWZLWmcKX7eLONbxSIkzRs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-NiudBtP9Mr2yWMSGZXoFRw-1; Sun, 01 Sep 2024 23:49:38 -0400
X-MC-Unique: NiudBtP9Mr2yWMSGZXoFRw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d876431c4aso2290061a91.0
        for <linux-block@vger.kernel.org>; Sun, 01 Sep 2024 20:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725248977; x=1725853777;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHzVnCsHGmIdJtwcIOm/NoWOV1NM5BN3GxiNUcT5Diw=;
        b=hg+UAPWqgwQGxoTvbg4VyvCZLB0qVo+Hp7spxwSfX0gyqWU2631mLIIKxl4qJyuALV
         avem49hY/hgNc4uhb2TjzmAxQQML5R7sChntr4waBjw62YXUwP6tTI7+WbCpgae2qPG5
         Lz8XvrOsuvGsu6YIGZrqj8Hqy5iec/OV57g2ATcKqGdolv3klP77Sv6S4ZF6zDlndqEp
         FRZjGdqWxDhGDeTK1opyvEuE33OUzQSnxpAw4G6/K1gKjwKRkfwU0rxhj5QAXImrOOSu
         hgKVzyxSuImdX3hEkYwMi64r7JySLinot9+B4TzEtr3TVcvdCUbLeG8rQA0JnblbmIB+
         qv5w==
X-Gm-Message-State: AOJu0Yw8wzehPKOH1abFkWJ/zitvZGJE07CfbqCqiovj/AZVS5LTQML7
	2wl/8ooCyDOV00RVjO4atX7iqmQFY6wZzzstKuWAIE36Ido8P/Z9rwBZ4FfaWnY5cKPun+k/Fw/
	7WDRUjjhHiSdCUUqCVG+yg6uudsWh2s4zrZJQlC9DNN8U3GxS+g1KBcSHMbMSxOGgUEOaKSTS8u
	gZXbujAbCCW7sfqu1i1Fj107fZCmQS7weOpYdA5IAZXc7x0Xmq
X-Received: by 2002:a17:90b:52c8:b0:2d8:bf47:946a with SMTP id 98e67ed59e1d1-2d8bf479580mr1929383a91.12.1725248977418;
        Sun, 01 Sep 2024 20:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtAvhnH8iaOXALXndWxNJHzABoRAbkD0oAb3f0UbCJm8y9m5ZG1q85skvzrJeeNTNlpvgAjWhP4MHDxC1wKMM=
X-Received: by 2002:a17:90b:52c8:b0:2d8:bf47:946a with SMTP id
 98e67ed59e1d1-2d8bf479580mr1929372a91.12.1725248976758; Sun, 01 Sep 2024
 20:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, 2 Sep 2024 11:49:25 +0800
Message-ID: <CAGVVp+XHCoW07TV4HG9L=aPoR=wL2d+Ykxp=KW2GGPLJsJKSNg@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 23 PID: 67278 at drivers/block/ublk_drv.c:2665
 ublk_ctrl_start_recovery.constprop.0+0x7b/0x180
To: Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

hit warning issue and kernel panic when running test ubdsrv generic/006,
the fix patch for kernel panic is still not merged yet, can we merge
the fix asap?
https://lore.kernel.org/linux-block/CAGVVp+UvLiS+bhNXV-h2icwX1dyybbYHeQUuH7RYqUvMQf6N3w@mail.gmail.com/T/#mc8bcd0a95e528bb0cbaf2be6f0e117e82308f01e

repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
branch: for-next
commit HEAD: 4da1b0ec4dd2ae3edf880b6aac49cc5cfdc121cb

dmesg log:
[16641.027175] ------------[ cut here ]------------
[16641.032547] WARNING: CPU: 23 PID: 67278 at
drivers/block/ublk_drv.c:2665
ublk_ctrl_start_recovery.constprop.0+0x7b/0x180
[16641.044847] Modules linked in: loop scsi_debug tls ext4 mbcache
jbd2 rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace
netfs rfkill sunrpc dm_multipath intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common i10nm_edac
skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm dax_hmem cxl_acpi mgag200 cxl_core iTCO_wdt
rapl acpi_power_meter isst_if_mbox_pci isst_if_mmio mei_me
i2c_algo_bit iTCO_vendor_support ipmi_ssif drm_shmem_helper
intel_cstate drm_kms_helper intel_uncore mei intel_th_gth ioatdma
i2c_i801 einj pcspkr intel_th_pci isst_if_common intel_vsec i2c_smbus
intel_pch_thermal intel_th dca ipmi_si acpi_ipmi ipmi_devintf
ipmi_msghandler acpi_pad drm fuse xfs libcrc32c sd_mod sg ahci
crct10dif_pclmul libahci crc32_pclmul crc32c_intel libata tg3
ghash_clmulni_intel wmi dm_mirror dm_region_hash dm_log dm_mod [last
unloaded: null_blk]
[16641.137685] CPU: 23 UID: 0 PID: 67278 Comm: iou-wrk-67264 Kdump:
loaded Not tainted 6.11.0-rc5+ #1
[16641.147732] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE120G-1.40 09/20/2022
[16641.157488] RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x7b/0x180
[16641.164728] Code: a3 00 00 00 45 31 ed 41 be ff ff ff ff 44 89 eb
41 0f af 5c 24 10 49 03 5c 24 08 48 8b 7b 10 48 85 ff 74 06 f6 47 2c
04 75 02 <0f> 0b 31 d2 4c 8d 47 28 44 89 f0 66 89 53 38 f0 0f c1 47 28
83 f8
[16641.185731] RSP: 0018:ff3e23418adefcf0 EFLAGS: 00010246
[16641.191603] RAX: 0000000000000002 RBX: ff11587666b3c000 RCX: 0000000000000000
[16641.199611] RDX: ff1158792fea8000 RSI: 0000000000000010 RDI: 0000000000000000
[16641.207626] RBP: ff11587662973468 R08: 0000000045e451fd R09: ffffffffa96e6660
[16641.215632] R10: 0000000000000000 R11: 0000000000000000 R12: ff11587662973000
[16641.223663] R13: 0000000000000000 R14: 00000000ffffffff R15: ff115876962bc080
[16641.231669] FS:  00007fe1f6eba740(0000) GS:ff1158796ff80000(0000)
knlGS:0000000000000000
[16641.240743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16641.247209] CR2: 00007fbb11bfbae0 CR3: 000000040f4c2006 CR4: 0000000000771ef0
[16641.255215] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16641.263222] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16641.271237] PKRU: 55555554
[16641.274300] Call Trace:
[16641.277074]  <TASK>
[16641.279460]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.284757]  ? __warn+0x7f/0x120
[16641.288400]  ? ublk_ctrl_start_recovery.constprop.0+0x7b/0x180
[16641.294967]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.300266]  ? report_bug+0x18a/0x1a0
[16641.304421]  ? handle_bug+0x3c/0x70
[16641.308364]  ? exc_invalid_op+0x14/0x70
[16641.312697]  ? asm_exc_invalid_op+0x16/0x20
[16641.317452]  ? ublk_ctrl_start_recovery.constprop.0+0x7b/0x180
[16641.324043]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.329342]  ublk_ctrl_uring_cmd+0x2b5/0x5e0
[16641.334195]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.339485]  io_uring_cmd+0x9b/0x1e0
[16641.343538]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.348825]  io_issue_sqe+0x18f/0x3f0
[16641.352983]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.358281]  io_wq_submit_work+0x98/0x350
[16641.362820]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.368114]  io_worker_handle_work+0x34c/0x450
[16641.373153]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.378449]  io_wq_worker+0xcb/0x2f0
[16641.382495]  ? trace_graph_return+0x90/0xd0
[16641.387215]  ? ret_from_fork+0x17/0x50
[16641.391473]  ? __pfx_io_wq_worker+0x10/0x10
[16641.396204]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.401513]  ret_from_fork+0x2d/0x50
[16641.405549]  ? __pfx_io_wq_worker+0x10/0x10
[16641.410267]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.415565]  ret_from_fork_asm+0x1a/0x30
[16641.420051]  </TASK>
[16641.422529] ---[ end trace 0000000000000000 ]---
[16641.427728] BUG: kernel NULL pointer dereference, address: 0000000000000028
[16641.435503] #PF: supervisor write access in kernel mode
[16641.441339] #PF: error_code(0x0002) - not-present page
[16641.447077] PGD 182aef067 P4D 40502c067 PUD 172c05067 PMD 0
[16641.453412] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
[16641.458862] CPU: 23 UID: 0 PID: 67278 Comm: iou-wrk-67264 Kdump:
loaded Tainted: G        W          6.11.0-rc5+ #1
[16641.470518] Tainted: [W]=WARN
[16641.473831] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE120G-1.40 09/20/2022
[16641.483546] RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x8a/0x180
[16641.490741] Code: eb 41 0f af 5c 24 10 49 03 5c 24 08 48 8b 7b 10
48 85 ff 74 06 f6 47 2c 04 75 02 0f 0b 31 d2 4c 8d 47 28 44 89 f0 66
89 53 38 <f0> 0f c1 47 28 83 f8 01 0f 84 ba 00 00 00 85 c0 0f 8e bc 00
00 00
[16641.511702] RSP: 0018:ff3e23418adefcf0 EFLAGS: 00010246
[16641.517539] RAX: 00000000ffffffff RBX: ff11587666b3c000 RCX: 0000000000000000
[16641.525507] RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000000000
[16641.533477] RBP: ff11587662973468 R08: 0000000000000028 R09: ffffffffa96e6660
[16641.541447] R10: 0000000000000000 R11: 0000000000000000 R12: ff11587662973000
[16641.549416] R13: 0000000000000000 R14: 00000000ffffffff R15: ff115876962bc080
[16641.557386] FS:  00007fe1f6eba740(0000) GS:ff1158796ff80000(0000)
knlGS:0000000000000000
[16641.566420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16641.572836] CR2: 0000000000000028 CR3: 000000040f4c2006 CR4: 0000000000771ef0
[16641.580805] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16641.588772] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16641.596739] PKRU: 55555554
[16641.599761] Call Trace:
[16641.602495]  <TASK>
[16641.604841]  ? __die+0x20/0x70
[16641.608257]  ? page_fault_oops+0x75/0x170
[16641.612747]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.618005]  ? exc_page_fault+0x64/0x140
[16641.622392]  ? asm_exc_page_fault+0x22/0x30
[16641.627082]  ? ublk_ctrl_start_recovery.constprop.0+0x8a/0x180
[16641.633605]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.638859]  ublk_ctrl_uring_cmd+0x2b5/0x5e0
[16641.643637]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.648893]  io_uring_cmd+0x9b/0x1e0
[16641.652893]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.658150]  io_issue_sqe+0x18f/0x3f0
[16641.662250]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.667507]  io_wq_submit_work+0x98/0x350
[16641.671993]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.677249]  io_worker_handle_work+0x34c/0x450
[16641.682226]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.687483]  io_wq_worker+0xcb/0x2f0
[16641.691481]  ? trace_graph_return+0x90/0xd0
[16641.696156]  ? ret_from_fork+0x17/0x50
[16641.700352]  ? __pfx_io_wq_worker+0x10/0x10
[16641.705030]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.710286]  ret_from_fork+0x2d/0x50
[16641.714280]  ? __pfx_io_wq_worker+0x10/0x10
[16641.718957]  ? ftrace_stub_direct_tramp+0x10/0x10
[16641.724213]  ret_from_fork_asm+0x1a/0x30
[16641.728614]  </TASK>
[16641.731057] Modules linked in: loop scsi_debug tls ext4 mbcache
jbd2 rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace
netfs rfkill sunrpc dm_multipath intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common i10nm_edac
skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm dax_hmem cxl_acpi mgag200 cxl_core iTCO_wdt
rapl acpi_power_meter isst_if_mbox_pci isst_if_mmio mei_me
i2c_algo_bit iTCO_vendor_support ipmi_ssif drm_shmem_helper
intel_cstate drm_kms_helper intel_uncore mei intel_th_gth ioatdma
i2c_i801 einj pcspkr intel_th_pci isst_if_common intel_vsec i2c_smbus
intel_pch_thermal intel_th dca ipmi_si acpi_ipmi ipmi_devintf
ipmi_msghandler acpi_pad drm fuse xfs libcrc32c sd_mod sg ahci
crct10dif_pclmul libahci crc32_pclmul crc32c_intel libata tg3
ghash_clmulni_intel wmi dm_mirror dm_region_hash dm_log dm_mod [last
unloaded: null_blk]
[16641.821812] CR2: 0000000000000028
[    0.021790] CPU topo: Boot CPU APIC ID not the first enumerated
APIC ID: 17 != 0
[    0.021792] CPU topo: Crash kernel detected. Disabling real BSP to
prevent machine INIT
[    0.021792] CPU topo: CPU limit of 1 reached. Ignoring further CPUs
[    0.027879] Misrouted IRQ fixup and polling support enabled
[    0.027880] This may significantly impact system performance
[    0.042210] Spurious LAPIC timer interrupt on cpu 0
[    0.100454] x86/cpu: SGX disabled by BIOS.
[    0.123956] [Firmware Bug]: the BIOS has corrupted hw-PMU resources
(MSR 38d is b0)
[    0.124420] Intel PMU driver.
[    0.581405] Initramfs unpacking failed: write error
[    0.608767] mce: Unable to init MCE device (rc: -5)
[    0.790162] Failed to execute /init (error -2)
[    0.795392] Kernel panic - not syncing: No working init found.  Try
passing init= option to kernel. See Linux
Documentation/admin-guide/init.rst for guidance.
[    0.811174] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5+ #1
[    0.818918] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE120G-1.40 09/20/2022
[    0.828604] Call Trace:
[    0.831325]  <TASK>
[    0.833661]  panic+0x339/0x360
[    0.837064]  ? kernel_execve+0x114/0x150
[    0.841425]  ? __pfx_kernel_init+0x10/0x10
[    0.845986]  kernel_init+0x185/0x1d0
[    0.849967]  ret_from_fork+0x2d/0x50
[    0.853940]  ? __pfx_kernel_init+0x10/0x10
[    0.858501]  ret_from_fork_asm+0x1a/0x30
[    0.862869]  </TASK>
[    0.865304] Kernel Offset: disabled
[    0.937284] Rebooting in 10 seconds..

Thanks,
Changhui

