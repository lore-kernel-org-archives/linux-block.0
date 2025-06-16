Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BA279903
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074366; cv=none; b=Czo0T45QPdT0wOkVDmS4O9E78zVJeZcHODCrTt/MQXUOFI2r9Y4kT+MK7HsO+sdR90aHVahaPVld0intQie8ng5gPQsemCvjCG1LjXWu6TtimhpL/GEuEF5aMHz8dH8SVxokujVZhRG7EE2mh3NcpQQTpMJfHN3In4vDayntpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074366; c=relaxed/simple;
	bh=9fbAy0zLwBbHdK5dJkAuqXhTExJ7n1tvUM7FInjEW9s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=W0vtxl1tA3Bl+6J+ovj+6v7Z9BXfFyaC2JKLzWy4vxTDA2lBpi+4dndCmSYoB6S9+EQshiYCp3J/LGIsdHMKEOIdy+WQKOANrshrZLub+kOqpygaNQ4smoUkHAeraYjUCRt6nIbXOe+fNQrIdBq1e4jtR9Ow1n71orYLvM3ByjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTLCVdaG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTLCVdaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750074363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=TkYkOQdSj4ghBQj9CtJE1am8p5lX8R9AyfaurPK1VSo=;
	b=jTLCVdaGVZ2MOIfaCTXlwWqhcK5uiDNY4xtzb3j+RgPubGrw5+eugRe9XoEBE0/tvo+LkG
	DTdvcC+Ou4lAmo3LT4+dI5TnurthoAxkSV0/ySAZp7S9gB89Leu5LxvofAFII3xcxCLEpj
	HUmU3BtFYEmOulKdXRuNAbR3dKYUq2w=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-hqM7MALZOuesNbtLFAR9kg-1; Mon, 16 Jun 2025 07:46:01 -0400
X-MC-Unique: hqM7MALZOuesNbtLFAR9kg-1
X-Mimecast-MFC-AGG-ID: hqM7MALZOuesNbtLFAR9kg_1750074360
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b3162348fso17637201fa.1
        for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 04:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750074359; x=1750679159;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkYkOQdSj4ghBQj9CtJE1am8p5lX8R9AyfaurPK1VSo=;
        b=VrV5zBmsK4BzUL89ON2QZkgy8Bqh1PKXE5Y9myaFryb/UnOabgVXObFm1q09Vn4lyz
         uTgVYbt/RmVVmOrRNeJRnZCpJiE2K9V6qmTVbMXDl/BsDDXNr1GFQW+LRR/5FzNRdpg6
         ZGiIBzIF/KsHuYc1hQVmjuYvHeZIR7ZdlKQr8j5feiVnPVHf6qlyWjU2xR719LY1Ovuk
         gG6L8RyAmWSCcTD3RXYDaujPafh+OUtvU2qhAX6rsTPtWnW4I94YTohQxFePup+wviA4
         tjcj2eIL+Qi/g0aUWGQf4jb1+ymsWZtPdiYDNOeTo8ezNTh8nOCOEjEiw3TOqOQ+vu7x
         PUvA==
X-Gm-Message-State: AOJu0Ywk2IS9hhv5EaBsEOCa/ptDFbPCd3+AHymhylMWFvUNWPuv+5ZL
	yTFK+2yeKkHu4W2F9//L/0z9aEOazaS7sGASFbqTssILZQ5Fp5wroA+8aExfjPB+ozotqzdgvjy
	duYbxvssE+hxBdHMfP4Q4nwENNcFsSEEP+TAt7rdrHsVvZMh9E7FJSke8HoZwQIdLqmGjeuHnZC
	6+lGjsGCAqxIBsh6l0cHi+zX6X0zNpwPjiNRvmLune/fqDspwsrJav
X-Gm-Gg: ASbGncuEv+NrI5sz0c6rS+L3OUifCdKtCyRGPXpGitsDcjsWc4OkoiwqspmoRtjHS1X
	euidshu1OqAkewTbskmF0gHPBqcOe9LW4vfqsubeV6OMDBBkjn3dnQ80n4q81ppZtvwjBWB+8bo
	ErktaV
X-Received: by 2002:a2e:bc1a:0:b0:32a:7a4d:9450 with SMTP id 38308e7fff4ca-32b4a5c4df4mr26012431fa.33.1750074358906;
        Mon, 16 Jun 2025 04:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx3pspRyahrad6SR0AXZuy8WndNI7MNm+g7ZcD4fz7KLVu/L9VT7u0XBLyniae77qziSue/5lOMiy+eTvfdX8=
X-Received: by 2002:a2e:bc1a:0:b0:32a:7a4d:9450 with SMTP id
 38308e7fff4ca-32b4a5c4df4mr26012341fa.33.1750074358391; Mon, 16 Jun 2025
 04:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 16 Jun 2025 19:45:46 +0800
X-Gm-Features: AX0GCFv5c5LT_OH2OMDL5pt0d99DJIDUOHU0uvOCt_dvcc7_wQvPQ2vA5Kb6Pzw
Message-ID: <CAHj4cs92q3Lc8f=mEZ-e9piZtLj62eJ2Z5iSO-wJuRepspkbsA@mail.gmail.com>
Subject: [bug report] kernel BUG at mm/hugetlb.c:5880! triggered by blktests nvme/029
To: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi
CKI triggered the following issue[2] with the block/fo-next commit[1],
please help check it, thanks.

[1]
commit: 1cbac730bb6b Merge branch 'block-6.16' into for-next

[2]
[ 1207.436193] run blktests nvme/029 at 2025-06-13 16:11:12
[ 1207.476177] loop0: detected capacity change from 0 to 2097152
[ 1207.488130] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1207.506313] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1207.556941] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1207.560824] nvme nvme0: creating 32 I/O queues.
[ 1207.561919] nvme nvme0: failed to connect socket: -512
[ 1207.569392] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1207.572517] nvme nvme0: creating 32 I/O queues.
[ 1207.580131] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 1207.599121] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 1207.916342] ------------[ cut here ]------------
[ 1207.917026] kernel BUG at mm/hugetlb.c:5880!
[ 1207.917801] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[ 1207.918227] CPU: 18 UID: 0 PID: 47801 Comm: nvme Not tainted
6.16.0-rc1 #1 PREEMPT(lazy)
[ 1207.918683] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/14/2018
[ 1207.919300] RIP: 0010:__unmap_hugepage_range+0x7a4/0x7f0
[ 1207.919611] Code: 89 ef 48 89 c6 e8 2c 90 ff ff 48 8b 3c 24 e8 73
c3 d9 00 e9 bf fb ff ff 0f 0b 49 8b 50 30 48 f7 d2 4c 85 e2 0f 84 e3
f8 ff ff <0f> 0b 0f 0b 65 48 8b 05 28 a2 0c 03 48 8b 10 f7 c2 00 00 00
20 74
[ 1207.920942] RSP: 0018:ffffcd058ced7ae0 EFLAGS: 00010206
[ 1207.921231] RAX: 0000000000400000 RBX: 0000000000000000 RCX: 0000000000000009
[ 1207.922070] RDX: 00000000001fffff RSI: ffff8cb38c141c80 RDI: ffffcd058ced7c48
[ 1207.922850] RBP: ffffffffffffffff R08: ffffffffacb56e98 R09: 0000000000200000
[ 1207.923618] R10: 00007f6120006000 R11: ffff8cb4fb586000 R12: 00007f611fe06000
[ 1207.924421] R13: ffffcd058ced7c48 R14: ffff8cb38c141c80 R15: ffffcd058ced7c00
[ 1207.925221] FS:  00007f61210db840(0000) GS:ffff8cb70b096000(0000)
knlGS:0000000000000000
[ 1207.925639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1207.926357] CR2: 00007f6120f4d710 CR3: 000000025c3ba000 CR4: 00000000000406f0
[ 1207.927164] Call Trace:
[ 1207.927319]  <TASK>
[ 1207.927833]  unmap_vmas+0xa6/0x180
[ 1207.928565]  exit_mmap+0xf0/0x3b0
[ 1207.929175]  __mmput+0x3e/0x130
[ 1207.929790]  exit_mm+0xaf/0x110
[ 1207.930457]  do_exit+0x1a5/0x450
[ 1207.931054]  do_group_exit+0x30/0x80
[ 1207.931287]  __x64_sys_exit_group+0x18/0x20
[ 1207.931504]  x64_sys_call+0xfdb/0x14f0
[ 1207.931751]  do_syscall_64+0x84/0x2c0
[ 1207.931977]  ? count_memcg_events+0x167/0x1d0
[ 1207.932623]  ? handle_mm_fault+0x220/0x340
[ 1207.932879]  ? do_user_addr_fault+0x2c3/0x7f0
[ 1207.933528]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1207.933842] RIP: 0033:0x7f6120f4d728
[ 1207.934079] Code: Unable to access opcode bytes at 0x7f6120f4d6fe.
[ 1207.934818] RSP: 002b:00007ffe4c80b528 EFLAGS: 00000206 ORIG_RAX:
00000000000000e7
[ 1207.935606] RAX: ffffffffffffffda RBX: 00007f6121076fc8 RCX: 00007f6120f4d728
[ 1207.936392] RDX: 00007f61210dbb48 RSI: ffffffffffffff90 RDI: 0000000000000001
[ 1207.937391] RBP: 00007ffe4c80b580 R08: 0000000000000000 R09: 0000000000000000
[ 1207.938510] R10: 00007ffe4c80b310 R11: 0000000000000206 R12: 0000000000000001
[ 1207.939326] R13: 0000000000000001 R14: 00007f6121075680 R15: 00007f6121076fe0
[ 1207.940102]  </TASK>
[ 1207.940260] Modules linked in: nvmet_tcp nvmet nvme_tcp
nvme_fabrics nvme nvme_core nvme_keyring nvme_auth nbd pktcdvd rfkill
sunrpc amd64_edac edac_mce_amd ipmi_ssif kvm tg3 i2c_piix4
fam15h_power acpi_power_meter k10temp hpilo pcspkr ipmi_si i2c_smbus
irqbypass acpi_ipmi acpi_cpufreq ipmi_devintf ipmi_msghandler fuse
loop nfnetlink zram lz4hc_compress lz4_compress xfs polyval_clmulni
ata_generic ghash_clmulni_intel pata_acpi sha512_ssse3 hpsa mgag200
serio_raw sha1_ssse3 pata_atiixp sp5100_tco scsi_transport_sas hpwdt
i2c_algo_bit [last unloaded: nvmet]
[10: 00007f6120006000 R11: ffff8cb4fb586000 R12: 00007f611fe06000
[ 1208.443808] R13: ffffcd058ced7c48 R14: ffff8cb38c141c80 R15: ffffcd058ced7c00
[ 1208.444605] FS:  00007f61210db840(0000) GS:ffff8cb70b016000(0000)
knlGS:0000000000000000
[ 1208.445062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1208.445777] CR2: 0000562c0be4a000 CR3: 000000025c3ba000 CR4: 00000000000406f0
[ 1208.446610] Kernel panic - not syncing: Fatal exception
[ 1208.447172] Kernel Offset: 0x28200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1208.451887] ERST: [Firmware Warn]: Firmware does not respond in time.
[ 1208.484105] ---[ end Kernel panic - not syncing: Fatal exception ]---

-- 
Best Regards,
  Yi Zhang

