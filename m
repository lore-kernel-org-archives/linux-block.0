Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD11C17
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522592; cv=none; b=lMmMLEKrXmzOn68TUD91w+PIXQ5AgfDPY+DnMFWEZL5RAOtmyAOd4K7mTZH798T/rrj82p3JD1k3HIbY23o9p+GUo77zqekDpS9EnKbPqGu/Hr1wAu/0Gs48elt82Mxf4S5j5ufQAGx1G022Yfhfyk47DEL7WMuVqKigJAkgFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522592; c=relaxed/simple;
	bh=l6Xob5QDK5tpeJPp9s/d9svEDmEA/JMDGro82O0hrY0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qELvduNAypubDbHZaPCHQyNO2MVX4h3h+l1MV/lbUOKLwfGTp6QN5KNn6CArGm2Pb6Oed6zeZEXZw7s8cpTKjrhvu6L9HA2RKK59VXiAIjmpgu5+nso3TpYIWAL3iUkKcXRIK9doDdmtfX/R7wtE6qaIHLW1cLFetDrZTXDtF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5zsDRJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5zsDRJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716522589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SW7PnDv+qXOv7Q+AP1YCRKO3K28HjKgWz5Vf2KgrQiI=;
	b=f5zsDRJZSUaiASVnRC9SCCs0yNtyGExTww/Onr28SdnBbX2cDDo9uHoI9Y6gLMSWytPE8U
	VCE7qk7XUUSLNxY2GLLCaOcEBF79Jok8MIfHOeDqBYr4ez/WRI3uyyEV1+cLZhfLt7dVvS
	gDkP5aWNQy766R3dqC5MrOKQByUzcPI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-DfiNRXq1Npm6KzYsautfxQ-1; Thu, 23 May 2024 23:49:47 -0400
X-MC-Unique: DfiNRXq1Npm6KzYsautfxQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6f8e8199ca9so544766b3a.0
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 20:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716522586; x=1717127386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SW7PnDv+qXOv7Q+AP1YCRKO3K28HjKgWz5Vf2KgrQiI=;
        b=oAX8HxWUr94vQ8Mydcp9lvuTTe/5JxrVNbVzC7thLBMYYtivjI3k54R8hJgJWRsiu+
         1Q1t4/RVUQ7Z2aONb/GpCSEVQpBG3QwApljNQB9c92ha9VL1Wp1OtdQi/gLho3htAOvx
         BpWt9yCKMZ3noOTzT7N7wsGcxW/7/RYAVKPFzONR4CrcRhqKKx5ROok3J/JBXKwZLDWU
         qs2zIUCAqy3yF0AVntNobRWTVg/z70PiQ/MqhCQFtS4Iyrt5M0ni+okFne210cVNeqPD
         0WZOE47twKdzJ39SqEPOGpKT6JnCh5F9ST69N0v2M/QimDzEpiVGfA5+AaFRh6S5ox6e
         c8zg==
X-Gm-Message-State: AOJu0YzcCiz3zuDICZq3/an/MRbj5k+257eoTape3gy6ItePvEP1jM0t
	V7vUSfK3qr3T1koe/DaXLWoGLB69RQzDwsTZkqBEm73taWth3jqwfo4rb1hf6lIyRfgnTamqCPK
	H5iMXB2jbuKhMxVvtOa6Pvt+oomdpl87BVmSLECTUHoR8CYQKgeAZJNkI3RxRcO3LcJaopeZ3Ke
	GFC+9WVM9bMey96KB4c/yWTTjwupTvuLpQHncmqiWXCoEL8lDN
X-Received: by 2002:a05:6a00:2786:b0:6ed:cbe2:3bc8 with SMTP id d2e1a72fcca58-6f8f3f9082emr1244284b3a.22.1716522586382;
        Thu, 23 May 2024 20:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcaHDoyiiZkKQdBA9se1W7XilmiZnmc58yZF1/5ur3xzt3l1tnXwkID0S7LwbzUQX/q5mp8kUucaaBAmJPi9s=
X-Received: by 2002:a05:6a00:2786:b0:6ed:cbe2:3bc8 with SMTP id
 d2e1a72fcca58-6f8f3f9082emr1244269b3a.22.1716522585730; Thu, 23 May 2024
 20:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Fri, 24 May 2024 11:49:34 +0800
Message-ID: <CAGVVp+UvLiS+bhNXV-h2icwX1dyybbYHeQUuH7RYqUvMQf6N3w@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 2 PID: 3445306 at drivers/block/ublk_drv.c:2633
 ublk_ctrl_start_recovery.constprop.0+0x74/0x180
To: Linux Block Devices <linux-block@vger.kernel.org>, io-uring@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I hit the kernel panic when running test ubdsrv  generic/005=EF=BC=8C
please help check it and let me know if you need any info/testing for
it, thanks.

repo:https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
branch:for-next
commit: b785211c726fbe77ff559f0241aab8d3dadd9988

dmesg log=EF=BC=9A
[ 7203.196155] ------------[ cut here ]------------
[ 7203.200779] WARNING: CPU: 2 PID: 3445306 at
drivers/block/ublk_drv.c:2633
ublk_ctrl_start_recovery.constprop.0+0x74/0x180
[ 7203.211732] Modules linked in: ext4 mbcache jbd2 raid10 raid1 raid0
dm_raid raid456 async_raid6_recov async_memcpy async_pq async_xor xor
async_tx raid6_pq loop nf_tables nfnetlink tls rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc
vfat fat dm_multipath intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
ipmi_ssif kvm mgag200 dax_hmem iTCO_wdt i2c_algo_bit rapl
iTCO_vendor_support cxl_acpi drm_shmem_helper intel_cstate cxl_core
drm_kms_helper acpi_power_meter mei_me dcdbas dell_smbios i2c_i801
intel_uncore einj isst_if_mmio isst_if_mbox_pci ipmi_si
dell_wmi_descriptor wmi_bmof pcspkr mei i2c_smbus isst_if_common
acpi_ipmi intel_vsec intel_pch_thermal ipmi_devintf ipmi_msghandler
drm fuse xfs libcrc32c sd_mod t10_pi sg ahci libahci crct10dif_pclmul
crc32_pclmul crc32c_intel libata tg3 ghash_clmulni_intel wmi dm_mirror
dm_region_hash dm_log dm_mod
[ 7203.211779]  [last unloaded: null_blk]
[ 7203.303523] CPU: 2 PID: 3445306 Comm: iou-wrk-3445292 Not tainted 6.9.0+=
 #1
[ 7203.310482] Hardware name: Dell Inc. PowerEdge R650xs/0PPTY2, BIOS
1.4.4 10/07/2021
[ 7203.318135] RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x74/0x180
[ 7203.324573] Code: 00 0f 84 9e 00 00 00 45 31 f6 bd ff ff ff ff 44
89 f3 41 0f af 5d 10 49 03 5d 08 48 8b 7b 10 48 85 ff 74 06 f6 47 2c
04 75 02 <0f> 0b 31 d2 4c 8d 47 28 89 e8 66 89 53 38 f0 0f c1 47 28 83
f8 01
[ 7203.343319] RSP: 0018:ff59ae67453ffce0 EFLAGS: 00010246
[ 7203.348544] RAX: 0000000000000002 RBX: ff2fabb3b5682000 RCX: 00000000000=
00000
[ 7203.355678] RDX: ff2fabb261e18000 RSI: ffffffffa324ee00 RDI: 00000000000=
00000
[ 7203.362812] RBP: 00000000ffffffff R08: 0000000000000000 R09: ffffffffa36=
e33e0
[ 7203.369943] R10: 0000000000000000 R11: 0000000000000000 R12: ff2fabb3ae4=
4a468
[ 7203.377078] R13: ff2fabb3ae44a000 R14: 0000000000000000 R15: ff2fabb3ce1=
50080
[ 7203.384210] FS:  00007fbed107c740(0000) GS:ff2fabb5af700000(0000)
knlGS:0000000000000000
[ 7203.392294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7203.398041] CR2: 00007f4428078584 CR3: 000000011baa0004 CR4: 00000000007=
71ef0
[ 7203.405174] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 7203.412308] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 7203.419441] PKRU: 55555554
[ 7203.422151] Call Trace:
[ 7203.424605]  <TASK>
[ 7203.426713]  ? __warn+0x7f/0x120
[ 7203.429943]  ? ublk_ctrl_start_recovery.constprop.0+0x74/0x180
[ 7203.435778]  ? report_bug+0x18a/0x1a0
[ 7203.439445]  ? handle_bug+0x3c/0x70
[ 7203.442943]  ? exc_invalid_op+0x14/0x70
[ 7203.446782]  ? asm_exc_invalid_op+0x16/0x20
[ 7203.450970]  ? ublk_ctrl_start_recovery.constprop.0+0x74/0x180
[ 7203.456802]  ublk_ctrl_uring_cmd+0x4f7/0x6c0
[ 7203.461075]  ? pick_next_task_idle+0x26/0x40
[ 7203.465347]  io_uring_cmd+0x9a/0x1b0
[ 7203.468929]  io_issue_sqe+0x193/0x3f0
[ 7203.472602]  io_wq_submit_work+0x9b/0x390
[ 7203.476613]  io_worker_handle_work+0x165/0x360
[ 7203.481059]  io_wq_worker+0xcb/0x2f0
[ 7203.484640]  ? finish_task_switch.isra.0+0x203/0x290
[ 7203.489608]  ? finish_task_switch.isra.0+0x203/0x290
[ 7203.494572]  ? __pfx_io_wq_worker+0x10/0x10
[ 7203.498758]  ret_from_fork+0x2d/0x50
[ 7203.502338]  ? __pfx_io_wq_worker+0x10/0x10
[ 7203.506523]  ret_from_fork_asm+0x1a/0x30
[ 7203.510451]  </TASK>
[ 7203.512643] ---[ end trace 0000000000000000 ]---
[ 7203.517263] BUG: kernel NULL pointer dereference, address: 0000000000000=
028
[ 7203.524220] #PF: supervisor write access in kernel mode
[ 7203.529445] #PF: error_code(0x0002) - not-present page
[ 7203.534584] PGD 2761af067 P4D 442db4067 PUD 1727a2067 PMD 0
[ 7203.540244] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
[ 7203.545123] CPU: 2 PID: 3445306 Comm: iou-wrk-3445292 Tainted: G
    W          6.9.0+ #1
[ 7203.553556] Hardware name: Dell Inc. PowerEdge R650xs/0PPTY2, BIOS
1.4.4 10/07/2021
[ 7203.561208] RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x82/0x180
[ 7203.567647] Code: ff 44 89 f3 41 0f af 5d 10 49 03 5d 08 48 8b 7b
10 48 85 ff 74 06 f6 47 2c 04 75 02 0f 0b 31 d2 4c 8d 47 28 89 e8 66
89 53 38 <f0> 0f c1 47 28 83 f8 01 0f 84 b5 00 00 00 85 c0 0f 8e b7 00
00 00
[ 7203.586395] RSP: 0018:ff59ae67453ffce0 EFLAGS: 00010246
[ 7203.591622] RAX: 00000000ffffffff RBX: ff2fabb3b5682000 RCX: 00000000000=
00000
[ 7203.598755] RDX: 0000000000000000 RSI: ffffffffa324ee00 RDI: 00000000000=
00000
[ 7203.605886] RBP: 00000000ffffffff R08: 0000000000000028 R09: ffffffffa36=
e33e0
[ 7203.613020] R10: 0000000000000000 R11: 0000000000000000 R12: ff2fabb3ae4=
4a468
[ 7203.620153] R13: ff2fabb3ae44a000 R14: 0000000000000000 R15: ff2fabb3ce1=
50080
[ 7203.627284] FS:  00007fbed107c740(0000) GS:ff2fabb5af700000(0000)
knlGS:0000000000000000
[ 7203.635371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7203.641117] CR2: 0000000000000028 CR3: 000000011baa0004 CR4: 00000000007=
71ef0
[ 7203.648248] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 7203.655383] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 7203.662514] PKRU: 55555554
[ 7203.665227] Call Trace:
[ 7203.667681]  <TASK>
[ 7203.669785]  ? __die+0x20/0x70
[ 7203.672845]  ? page_fault_oops+0x75/0x170
[ 7203.676860]  ? exc_page_fault+0x64/0x140
[ 7203.680785]  ? asm_exc_page_fault+0x22/0x30
[ 7203.684969]  ? ublk_ctrl_start_recovery.constprop.0+0x82/0x180
[ 7203.690804]  ublk_ctrl_uring_cmd+0x4f7/0x6c0
[ 7203.695076]  ? pick_next_task_idle+0x26/0x40
[ 7203.699350]  io_uring_cmd+0x9a/0x1b0
[ 7203.702927]  io_issue_sqe+0x193/0x3f0
[ 7203.706595]  io_wq_submit_work+0x9b/0x390
[ 7203.710607]  io_worker_handle_work+0x165/0x360
[ 7203.715054]  io_wq_worker+0xcb/0x2f0
[ 7203.718633]  ? finish_task_switch.isra.0+0x203/0x290
[ 7203.723597]  ? finish_task_switch.isra.0+0x203/0x290
[ 7203.728564]  ? __pfx_io_wq_worker+0x10/0x10
[ 7203.732749]  ret_from_fork+0x2d/0x50
[ 7203.736330]  ? __pfx_io_wq_worker+0x10/0x10
[ 7203.740514]  ret_from_fork_asm+0x1a/0x30
[ 7203.744441]  </TASK>
[ 7203.746634] Modules linked in: ext4 mbcache jbd2 raid10 raid1 raid0
dm_raid raid456 async_raid6_recov async_memcpy async_pq async_xor xor
async_tx raid6_pq loop nf_tables nfnetlink tls rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc
vfat fat dm_multipath intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
ipmi_ssif kvm mgag200 dax_hmem iTCO_wdt i2c_algo_bit rapl
iTCO_vendor_support cxl_acpi drm_shmem_helper intel_cstate cxl_core
drm_kms_helper acpi_power_meter mei_me dcdbas dell_smbios i2c_i801
intel_uncore einj isst_if_mmio isst_if_mbox_pci ipmi_si
dell_wmi_descriptor wmi_bmof pcspkr mei i2c_smbus isst_if_common
acpi_ipmi intel_vsec intel_pch_thermal ipmi_devintf ipmi_msghandler
drm fuse xfs libcrc32c sd_mod t10_pi sg ahci libahci crct10dif_pclmul
crc32_pclmul crc32c_intel libata tg3 ghash_clmulni_intel wmi dm_mirror
dm_region_hash dm_log dm_mod
[ 7203.746668]  [last unloaded: null_blk]
[ 7203.838416] CR2: 0000000000000028
[ 7203.841734] ---[ end trace 0000000000000000 ]---
[ 7203.919227] RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x82/0x180
[ 7203.925673] Code: ff 44 89 f3 41 0f af 5d 10 49 03 5d 08 48 8b 7b
10 48 85 ff 74 06 f6 47 2c 04 75 02 0f 0b 31 d2 4c 8d 47 28 89 e8 66
89 53 38 <f0> 0f c1 47 28 83 f8 01 0f 84 b5 00 00 00 85 c0 0f 8e b7 00
00 00
[ 7203.944417] RSP: 0018:ff59ae67453ffce0 EFLAGS: 00010246
[ 7203.949646] RAX: 00000000ffffffff RBX: ff2fabb3b5682000 RCX: 00000000000=
00000
[ 7203.956778] RDX: 0000000000000000 RSI: ffffffffa324ee00 RDI: 00000000000=
00000
[ 7203.963909] RBP: 00000000ffffffff R08: 0000000000000028 R09: ffffffffa36=
e33e0
[ 7203.971042] R10: 0000000000000000 R11: 0000000000000000 R12: ff2fabb3ae4=
4a468
[ 7203.978174] R13: ff2fabb3ae44a000 R14: 0000000000000000 R15: ff2fabb3ce1=
50080
[ 7203.985307] FS:  00007fbed107c740(0000) GS:ff2fabb5af700000(0000)
knlGS:0000000000000000
[ 7203.993395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7203.999139] CR2: 0000000000000028 CR3: 000000011baa0004 CR4: 00000000007=
71ef0
[ 7204.006274] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 7204.013405] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 7204.020537] PKRU: 55555554
[ 7204.023250] Kernel panic - not syncing: Fatal exception
[ 7204.028542] Kernel Offset: 0x20a00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 7204.110552] ---[ end Kernel panic - not syncing: Fatal exception ]---

--
Best Regards,
     Changhui

