Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19611CD25
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359492; cv=none; b=UnoosS64d0AqNHYyF0fiNFNKsD7VPu5cWrW4KyUIWHtHP+iUovStpXozp2Gf7WRxulQVOEGW4tZqfLq0wmRMAsz2qjdBuKjTsnhL6pn+SUrMVYla2OT3ahrERGtKMCZUQ4jJStBIb/vauAd74q9yvZ2vDmR50JsYKfgkx/pAliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359492; c=relaxed/simple;
	bh=2WEYJX+tt8xq3uCqlo1qWEwOsGP2pZINHnupOdWnyhg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sBnjZjtU+XbKy5D1eUWeOa3q4G7HyVFPwgJVEMBroS4TPnf7B9D1o7ps8kLdGpPs3Fubm4ln2oBWHtDoJPiMG3+PcUkO9b0xeslRwtEod4tFNFCtB4PUfFLJf5Q2tPI89MvlL0QFfR+yLB/xVMlAuN2GjtwCyvTOzAbCsCWBl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zc5p0Gx2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zc5p0Gx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707359487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=4KnHMOv+E7vxRzPvd4oBbK35EoAvIuwl7teetap4ADs=;
	b=Zc5p0Gx2b6ZKjIVXdgCfk3bS54qPgd7siUTwPK/gr6yBzqby3Ah/kaQyFCoBssqqVtVdCh
	06J24kLlVmXbwEGbeiCCBHVm8Lu8IShXN4mzxh7UrczyFyBoh2NGwgUiwFFVl6E7J+CLPl
	0TvJ4PpsGeLRoUiyle2Sj/x77AIvtHA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Oe06m-wnOJenP5gFSphhjg-1; Wed, 07 Feb 2024 21:31:26 -0500
X-MC-Unique: Oe06m-wnOJenP5gFSphhjg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-560f419737fso334571a12.1
        for <linux-block@vger.kernel.org>; Wed, 07 Feb 2024 18:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707359485; x=1707964285;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KnHMOv+E7vxRzPvd4oBbK35EoAvIuwl7teetap4ADs=;
        b=SNUuUWL1NwqC480N7Nb70uJOMB87toO7IHEYIiPPIqByALJMh1wwVs3jj08laNUbEe
         9ASUhswXihr0OK5pMKU+AKtiC59XIBWN9MHMzppiLfS6x8zaNwAO4p2BrGkuWBtGax81
         iFMFyhpmauluGp1mMG0p6p4ki+YnK6lnWAa62b7kDEQH3X/J4TSwsJwG5NStHGRcKQfI
         m+bGf3LuZMc73qG5kauTXG64BjMYxsxnaOy71jZRN2grlAM9Otx7yIgGTeXvSTSos4b+
         xAHfe0zl0QjKq8NaiT0U7Y0h/5o3t5+KcS3wx+88qw5mElw5NRfOCxEJjvFPpm3VL6GL
         +xVw==
X-Forwarded-Encrypted: i=1; AJvYcCVzrFnELhWjhEuBk9RCLzPnM00i/1lrsvzUKbZgRFbPQRntkgBFDZsUGM8U1x+XYIZfzHk2MQm5h6Ppt/FeuCQjbHrrvwpYgeeitkQ=
X-Gm-Message-State: AOJu0YyX1QA6Sk+/c1Xkg5O8k37f8ALptvmocSmU+lafEc6rdDBr8gdP
	HxnPhDueWRLl3wMxP1b1sNRPXUets/0BKFjNWtEhKJkWwigpI2CS0Dyr8OSGuiV7/65lrekT9wS
	ij/UsN77m76B++MgNvrRg4TV0+7GlhLktj/CoF4PCLXszfFPZonBuMV9rZj7q13xaB0S/Xp6Bqo
	9KIiJijNypyo24eFlIAi8obOPYu1gJNyusaqA=
X-Received: by 2002:a50:8a91:0:b0:560:b758:5e2e with SMTP id j17-20020a508a91000000b00560b7585e2emr5373923edj.39.1707359485145;
        Wed, 07 Feb 2024 18:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFDqcEdKoMQI/KEhRQyfP8Y71+8EQTnUvO3qZH5nMMIymLokLTYk+dGDpSozvuwwVE9hEgupbBqT4p3l8cXzc=
X-Received: by 2002:a50:8a91:0:b0:560:b758:5e2e with SMTP id
 j17-20020a508a91000000b00560b7585e2emr5373909edj.39.1707359484786; Wed, 07
 Feb 2024 18:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guangwu Zhang <guazhang@redhat.com>
Date: Thu, 8 Feb 2024 10:32:09 +0800
Message-ID: <CAGS2=YpH-wNutLAQQ+L7teJ1RrJsyAvVk8dbwtHiLhQhnqSkhw@mail.gmail.com>
Subject: [bug report] watchdog: BUG: soft lockup - CPU#19 stuck for 26s! [poll-cancel-all:33473]
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org, 
	Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Found the kernel error with linux-block/for-next  branch.
kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
last commit 69c95a16fe484e6de5f3cc616953cc31d67e7000
Merge: d78544b06104 052618c71c66

reproducer : git://git.kernel.dk/liburing  poll-cancel-all.t


 [ 1722.001827] Running test openat2.t:
[ 1722.029366] Running test open-close.t:
[ 1722.059368] Running test open-direct-link.t:
[ 1722.090178] Running test open-direct-pick.t:
[ 1722.122762] Running test personality.t:
[ 1722.152628] Running test pipe-bug.t:
[ 1722.510823] Running test pipe-eof.t:
[ 1722.540346] Running test pipe-reuse.t:
[ 1722.569774] Running test poll.t:
[ 1722.643305] Running test poll-cancel.t:
[ 1722.673582] Running test poll-cancel-all.t:
[ 1732.010369] restraintd[1656]: *** Current Time: Wed Feb 07 10:20:49
2024  Localwatchdog at: Wed Feb 07 14:18:48 2024
[ 1747.506670] watchdog: BUG: soft lockup - CPU#19 stuck for 26s!
[poll-cancel-all:33473]
[ 1747.514587] Modules linked in: tls rpcsec_gss_krb5 auth_rpcgss
nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc vfat fat
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm
x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel kvm
irqbypass acpi_ipmi rapl mgag200 ipmi_si iTCO_wdt i2c_algo_bit
intel_cstate drm_shmem_helper iTCO_vendor_support dcdbas dell_smbios
mei_me i2c_i801 ipmi_devintf drm_kms_helper intel_uncore mei
dell_wmi_descriptor intel_pch_thermal i2c_smbus wmi_bmof lpc_ich
pcspkr ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c sd_mod
sg ahci nvme crct10dif_pclmul libahci crc32_pclmul crc32c_intel
nvme_core libata megaraid_sas tg3 ghash_clmulni_intel t10_pi wmi
dm_mirror dm_region_hash dm_log dm_mod
[ 1747.587107] CPU: 19 PID: 33473 Comm: poll-cancel-all Kdump: loaded
Not tainted 6.8.0-rc3+ #1
[ 1747.595540] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS
2.15.1 06/15/2022
[ 1747.603104] RIP: 0010:__io_poll_cancel.isra.0+0xa3/0x170
[ 1747.608419] Code: ef 60 49 89 ff 74 73 48 89 ee e8 a8 0e 00 00 84
c0 74 e2 4c 89 24 24 f0 41 81 8f a0 00 00 00 00 00 00 80 41 8b 87 a0
00 00 00 <83> f8 7f 0f 8f 92 00 00 00 b8 01 00 00 00 f0 41 0f c1 87 a0
00 00
[ 1747.627161] RSP: 0018:ffffa16d64997cc8 EFLAGS: 00000282
[ 1747.632387] RAX: 0000000093f4d23b RBX: ffff940d4839bbc0 RCX: 0000000000000000
[ 1747.639521] RDX: 0000000000000001 RSI: ffffa16d64997da8 RDI: ffff940ee22c2e00
[ 1747.646653] RBP: ffffa16d64997da8 R08: 0000000000000001 R09: ffff940d4c12b000
[ 1747.653785] R10: 0000000000000008 R11: 0000000000002cc0 R12: ffff940ec15ed900
[ 1747.660919] R13: 0000000000000000 R14: 0000000000000002 R15: ffff940ee22c2e00
[ 1747.668052] FS:  00007f0758c28740(0000) GS:ffff9410bfa40000(0000)
knlGS:0000000000000000
[ 1747.676135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1747.681882] CR2: 00000000004052b0 CR3: 00000002a2542004 CR4: 00000000007706f0
[ 1747.689013] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1747.696147] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1747.703278] PKRU: 55555554
[ 1747.705983] Call Trace:
[ 1747.708436]  <IRQ>
[ 1747.710456]  ? watchdog_timer_fn+0x1ec/0x270
[ 1747.714726]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 1747.719347]  ? __hrtimer_run_queues+0x10f/0x2b0
[ 1747.723880]  ? hrtimer_interrupt+0xfc/0x230
[ 1747.728066]  ? __sysvec_apic_timer_interrupt+0x4b/0x140
[ 1747.733289]  ? sysvec_apic_timer_interrupt+0x6d/0x90
[ 1747.738257]  </IRQ>
[ 1747.740363]  <TASK>
[ 1747.742468]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 1747.747783]  ? __io_poll_cancel.isra.0+0xa3/0x170
[ 1747.752487]  ? __io_poll_cancel.isra.0+0x88/0x170
[ 1747.757194]  io_poll_cancel+0x24/0x80
[ 1747.760859]  io_try_cancel+0x86/0x100
[ 1747.764525]  __io_async_cancel+0x41/0xf0
[ 1747.768451]  ? fget+0x7a/0xc0
[ 1747.771423]  io_async_cancel+0xa5/0x110
[ 1747.775261]  io_issue_sqe+0x5b/0x3f0
[ 1747.778842]  io_submit_sqes+0x126/0x3d0
[ 1747.782680]  __do_sys_io_uring_enter+0x2c8/0x480
[ 1747.787301]  do_syscall_64+0x7f/0x160
[ 1747.790965]  ? do_user_addr_fault+0x31f/0x690
[ 1747.795325]  ? exc_page_fault+0x65/0x150
[ 1747.799249]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[ 1747.804302] RIP: 0033:0x40402e
[ 1747.807361] Code: 41 89 ca 8b ba cc 00 00 00 41 b9 08 00 00 00 b8
aa 01 00 00 41 83 ca 10 f6 82 d0 00 00 00 01 44 0f 44 d1 45 31 c0 31
d2 0f 05 <c3> 90 89 30 eb 99 0f 1f 40 00 8b 3f 45 31 c0 83 e7 06 41 0f
95 c0
[ 1747.826106] RSP: 002b:00007fff5139edd8 EFLAGS: 00000246 ORIG_RAX:
00000000000001aa
[ 1747.833671] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000040402e
[ 1747.840805] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000005
[ 1747.847937] RBP: 00007fff5139ee40 R08: 0000000000000000 R09: 0000000000000008



-- 
Guangwu Zhang
Thanks

