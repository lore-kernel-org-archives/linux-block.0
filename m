Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053802C1AE
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754740; cv=none; b=CXXd0aGBZjcQQaWHBoNSBj16+weGEvaKcMzwKL2AfSJF7w94m5048mgXM8D9PA5tvKVsMsZivxuSkVQHVlDcU+2NU/NS1EyYHvaj2Z/k4IsDYtf5qusODy8HYW8XZTPTD9Zi4WHrZCt0RKfsblRlXjyfKNJQ6xILb1kP5fgQJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754740; c=relaxed/simple;
	bh=VkbD3qO6bY29wqpKIPjREtkYKg3wadHNfh2cJIHcjUE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iBfw3CuG6XPDyzHQvDgWRhkjT7Z4vxc5PJC/chj910jpyAUD0KazW+SNVv8VAKVZkSUtOAAMdtqEDF1SzmJ3pepQOP2WyS8Rn2/37gltZg3m5zJkzs6WicwgJEID0eqcqLW+ot0Fox9sSDuIY2fGrfZikFZJZQDjkG3XwW60L00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG266llM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG266llM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710754737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pgXAvSkBSMSkx0DCdUD/NLccvpFMAMtVr0jlixngp0M=;
	b=JG266llMiTFjj1TdLZF+xZyhj3XCAtOMWbU9hxl+kxUImliDoHuDtlDGRzoD9MouxL5c04
	CQQt6/OuwE3RaRNRbwe17djvJvuUgNYNxWn2jOsTbjodIb+D+S/Vc6t4b++C1mA1oX9dki
	MyF9G7FIjLXov7v6QmTxsZwe49/pK+8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-8gmZ_vJ5OuiJyugr_aZzow-1; Mon, 18 Mar 2024 05:38:54 -0400
X-MC-Unique: 8gmZ_vJ5OuiJyugr_aZzow-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso3832769a12.0
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 02:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754733; x=1711359533;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgXAvSkBSMSkx0DCdUD/NLccvpFMAMtVr0jlixngp0M=;
        b=kxunVB8TDXq9tFtEh4jxP0QmoN489UjeCCPZWWch7mY7y0mfVCw9vjEejFfU6clVox
         aLOIbXfwCwWYHf7psfV7YoZSYC4HIiJWD2MVK52bZEMW3xgIZyecVJ+60A1g38SJG6Ee
         yhgv6qAxO2BnoSywYQUoLpPkzc8Ppe1cWLbHm+ojFtKsEwes4TvXeebqkavFOHN9yrft
         mr/7uzuiJXiBAv8vsGenierrhWdZp7vnPl6s1gUJrh++wZvDsB2yoHxe27mkoMkRddlR
         PG4WwtaWqX4dr46dkKqioIlCbvmCgLrEYE7w+J0lfn3nzQo2mraqMoL0LsZwyItCo22o
         htvA==
X-Gm-Message-State: AOJu0YyUPJeFQo5Aq6aL30+TVsGBGoX7M9rXw2B4GXHxPWj1OeSjvm0N
	3kPoWj2jV64oR7n+8rO1aKPc0jEb+izn3J0Jz3Xeb64b8JtrptdGH6lH9he+c9TLt2ryeXT5BYy
	7lfrAJgZ0AsOYwJysc6USNoN3yS8IQMPBCP6/fzD5tvWtZo7BIZfpAvo9Dn38QHU6zdOGA8l1Dp
	6QI6KGUQi7MZMO4d11BuyB7HGiPqGlTlNNNcjC250wlrgZlijm
X-Received: by 2002:a17:90b:1110:b0:29f:7cb3:2fae with SMTP id gi16-20020a17090b111000b0029f7cb32faemr7115728pjb.5.1710754732945;
        Mon, 18 Mar 2024 02:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwgrAc/DtAmPQEgUbQ9IjVZFe8y9cT7U9Ko8SSZW2q+DK1GIzxyF4AIlOoeTZnNXFUiHkHpp29tCl8TFk9FLc=
X-Received: by 2002:a17:90b:1110:b0:29f:7cb3:2fae with SMTP id
 gi16-20020a17090b111000b0029f7cb32faemr7115709pjb.5.1710754732595; Mon, 18
 Mar 2024 02:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, 18 Mar 2024 17:38:41 +0800
Message-ID: <CAGVVp+WxUcAzkDcii_2T-wQTUmCjvM=mKJqpWKV-vgG7CvH6yQ@mail.gmail.com>
Subject: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000000
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

found a kernel panic issue on blktests nbd/003, please help check

repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
branch: master
commit HEAD:c442a42363b2ce5c3eb2b0ff1e052ee956f0a29f

[ 2519.746767] run blktests nbd/003 at 2024-03-15 18:22:55
[ 2519.838846] block nbd0: shutting down sockets
[ 2519.843319] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags
0x1000 phys_seg 1 prio class 0
[ 2519.851806] EXT4-fs (nbd0): unable to read superblock
[ 2519.851854] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 4 prio class 0
[ 2519.865085] Buffer I/O error on dev nbd0, logical block 0, async page read
[ 2519.871980] Buffer I/O error on dev nbd0, logical block 1, async page read
[ 2519.878873] Buffer I/O error on dev nbd0, logical block 2, async page read
[ 2519.885770] Buffer I/O error on dev nbd0, logical block 3, async page read
[ 2519.897012] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 4 prio class 0
[ 2519.905219] Buffer I/O error on dev nbd0, logical block 0, async page read
[ 2519.912121] Buffer I/O error on dev nbd0, logical block 1, async page read
[ 2519.919012] Buffer I/O error on dev nbd0, logical block 2, async page read
[ 2519.925898] Buffer I/O error on dev nbd0, logical block 3, async page read
[ 2519.932862] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 4 prio class 0
[ 2519.941066] Buffer I/O error on dev nbd0, logical block 0, async page read
[ 2519.947961] Buffer I/O error on dev nbd0, logical block 1, async page read
[ 2519.954902] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 1 prio class 0
[ 2519.963111] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0
phys_seg 3 prio class 0
[ 2519.963549]  slab kmalloc-2k start ffff892d516dc000 pointer offset
1224 size 2048
[ 2519.971379] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 4 prio class 0
[ 2519.978820] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 2519.978827] #PF: supervisor instruction fetch in kernel mode
[ 2519.987049] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 1 prio class 0
[ 2519.993955] #PF: error_code(0x0010) - not-present page
[ 2519.993963] PGD 12e8f5067 P4D 12e8f5067 PUD 12e8f6067 PMD 0
[ 2519.999692] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0
phys_seg 3 prio class 0
[ 2520.007806] Oops: 0010 [#1] PREEMPT SMP NOPTI
[ 2520.007817] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.8.0+ #1
[ 2520.012986]  nbd0: unable to read partition table
[ 2520.018622] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
2.19.1 06/04/2023
[ 2520.018627] RIP: 0010:0x0
[ 2520.018641] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[ 2520.018646] RSP: 0018:ffffae5b80758ee0 EFLAGS: 00010296
[ 2520.027281] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0
phys_seg 4 prio class 0
[ 2520.031179]
[ 2520.031184] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
[ 2520.031189] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff892d516dc4c8
[ 2520.031193] RBP: ffff8930afab5fc0 R08: 0000000000000002 R09: 0000000000000835
[ 2520.031197] R10: 0000000062616c73 R11: 00000000616c7320 R12: ffff892d432ec180
[ 2520.043947]  nbd0: unable to read partition table
[ 2520.049386] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8930afab6038
[ 2520.049392] FS:  0000000000000000(0000) GS:ffff8930afa80000(0000)
knlGS:0000000000000000
[ 2520.049397] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2520.049402] CR2: ffffffffffffffd6 CR3: 0000000162934001 CR4: 00000000007706f0
[ 2520.049407] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2520.052555]  nbd0: unable to read partition table
[ 2520.058557] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2520.058562] PKRU: 55555554
[ 2520.058565] Call Trace:
[ 2520.058568]  <IRQ>
[ 2520.058573]  ? __die+0x20/0x70
[ 2520.063867] EXT4-fs (nbd0): unable to read superblock
[ 2520.071973]  ? page_fault_oops+0x75/0x170
[ 2520.071990]  ? exc_page_fault+0x64/0x150
[ 2520.072001]  ? asm_exc_page_fault+0x22/0x30
[ 2520.074038]  nbd0: unable to read partition table
[ 2520.080637]  rcu_do_batch+0x1a7/0x530
[ 2520.090467]  nbd0: unable to read partition table
[ 2520.094920]  rcu_core+0x26a/0x420
[ 2520.094934]  __do_softirq+0xc7/0x2a5
[ 2520.102123] EXT4-fs (nbd0): unable to read superblock
[ 2520.106772]  irq_exit_rcu+0xa4/0xc0
[ 2520.106787]  sysvec_apic_timer_interrupt+0x72/0x90
[ 2520.107187]  nbd0: unable to read partition table
[ 2520.108301]  nbd0: unable to read partition table
[ 2520.115021]  nbd0: unable to read partition table
[ 2520.122019]  </IRQ>
[ 2520.122025]  <TASK>
[ 2520.122030]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 2520.127798] nbd0: partition table beyond EOD,
[ 2520.134910] RIP: 0010:intel_idle_irq+0x57/0xa0
[ 2520.134924] Code: f0 31 d2 48 89 d1 65 48 8b 05 a5 50 73 67 0f 01
c8 48 8b 00 a8 08 75 13 66 90 0f 00 2d 7e 2f 43 00 31 c9 48 89 f0 fb
0f 01 c9 <fa> 65 48 8b 05 80 50 73 67 f0 80 60 02 df f0 83 44 24 fc 00
48 8b
[ 2520.142069] truncated
[ 2520.146766] RSP: 0018:ffffae5b8030fe78 EFLAGS: 00000246
[ 2520.146775] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[ 2520.146782] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8930afabffa0
[ 2520.153945] mount_clear_soc: attempt to access beyond end of device
[ 2520.153945] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.156628] RBP: ffff8930afabffa0 R08: 0000000000000001 R09: 0000000000000014
[ 2520.156635] R10: 0000000000000174 R11: ffff8930afab34e4 R12: ffffffff998bbee0
[ 2520.156640] R13: ffffffff998bbf60 R14: 0000000000000001 R15: 0000000000000000
[ 2520.159101] EXT4-fs (nbd0): unable to read superblock
[ 2520.161115]  cpuidle_enter_state+0x7d/0x410
[ 2520.161127]  cpuidle_enter+0x29/0x40
[ 2520.164861] mount_clear_soc: attempt to access beyond end of device
[ 2520.164861] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.169239]  cpuidle_idle_call+0xf8/0x160
[ 2520.173283] EXT4-fs (nbd0): unable to read superblock
[ 2520.177188]  do_idle+0x7a/0xe0
[ 2520.177198]  cpu_startup_entry+0x25/0x30
[ 2520.182171] mount_clear_soc: attempt to access beyond end of device
[ 2520.182171] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.186089]  start_secondary+0x115/0x140
[ 2520.186103]  common_startup_64+0x13e/0x141
[ 2520.189784] EXT4-fs (nbd0): unable to read superblock
[ 2520.194483]  </TASK>
[ 2520.194488] Modules linked in: nbd
[ 2520.198640] mount_clear_soc: attempt to access beyond end of device
[ 2520.198640] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.201392]  null_blk loop ext4 mbcache jbd2 tls rpcsec_gss_krb5 auth_rpcgss
[ 2520.206473] EXT4-fs (nbd0): unable to read superblock
[ 2520.209955]  nfsv4 dns_resolver nfs lockd grace netfs rfkill sunrpc
vfat fat dm_multipath
[ 2520.215576] mount_clear_soc: attempt to access beyond end of device
[ 2520.215576] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.219471]  intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common isst_if_common
skx_edac
[ 2520.224205] EXT4-fs (nbd0): unable to read superblock
[ 2520.228898]  nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp
[ 2520.231796] mount_clear_soc: attempt to access beyond end of device
[ 2520.231796] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.233120]  kvm_intel kvm ipmi_ssif irqbypass mgag200 rapl
intel_cstate iTCO_wdt i2c_algo_bit
[ 2520.238295] EXT4-fs (nbd0): unable to read superblock
[ 2520.242724]  iTCO_vendor_support drm_shmem_helper acpi_ipmi
drm_kms_helper intel_uncore ipmi_si dcdbas mei_me dell_smbios
[ 2520.247897] mount_clear_soc: attempt to access beyond end of device
[ 2520.247897] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.265934]  i2c_i801 dell_wmi_descriptor ipmi_devintf wmi_bmof mei
pcspkr lpc_ich i2c_smbus intel_pch_thermal ipmi_msghandler
[ 2520.268238] EXT4-fs (nbd0): unable to read superblock
[ 2520.273456]  acpi_power_meter drm fuse xfs libcrc32c sd_mod sg ahci
crct10dif_pclmul nvme
[ 2520.281379] mount_clear_soc: attempt to access beyond end of device
[ 2520.281379] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.287738]  libahci bnxt_en crc32_pclmul crc32c_intel nvme_core
libata tg3 ghash_clmulni_intel megaraid_sas t10_pi wmi
[ 2520.299593] EXT4-fs (nbd0): unable to read superblock
[ 2520.306708]  dm_mirror dm_region_hash dm_log dm_mod [last unloaded:
scsi_debug]
[ 2520.306721] CR2: 0000000000000000
[ 2520.306726] ---[ end trace 0000000000000000 ]---
[ 2520.314657] mount_clear_soc: attempt to access beyond end of device
[ 2520.314657] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.331320] RIP: 0010:0x0
[ 2520.334983] EXT4-fs (nbd0): unable to read superblock
[ 2520.339155] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[ 2520.339161] RSP: 0018:ffffae5b80758ee0 EFLAGS: 00010296
[ 2520.339168] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
[ 2520.339173] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff892d516dc4c8
[ 2520.343697] mount_clear_soc: attempt to access beyond end of device
[ 2520.343697] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[ 2520.354564] RBP: ffff8930afab5fc0 R08: 0000000000000002 R09: 0000000000000835
[ 2520.354570] R10: 0000000062616c73 R11: 00000000616c7320 R12: ffff892d432ec180
[ 2520.354574] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8930afab6038
[ 2520.354578] FS:  0000000000000000(0000) GS:ffff8930afa80000(0000)
knlGS:0000000000000000
[ 2520.354583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2520.358612] EXT4-fs (nbd0): unable to read superblock
[ 2520.363648] CR2: ffffffffffffffd6 CR3: 0000000162934001 CR4: 00000000007706f0
[ 2520.363655] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2520.363659] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2520.363663] PKRU: 55555554
[ 2520.363666] Kernel panic - not syncing: Fatal exception in interrupt
[ 2520.366747] Kernel Offset: 0x16c00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 2520.733124] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

Thanks,

