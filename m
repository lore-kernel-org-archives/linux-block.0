Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302291D8DE1
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816176; cv=none; b=jtQ5gdx9y3J1nEl8VbXYQotCDjZ9IXIfuU4GsJoOasoWpwDyfOyb4YYhM2tAP1H+dzDbVlprdYme2jDyQpP1XdyCxzJjmAOCKCcTwd5KgDDpWOsyMu5iF/Y/SwQVO6hyvSpYSb1NhBVg3XVfnV5owpJ8AeYk6bUqaAmNAjY55Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816176; c=relaxed/simple;
	bh=8pxnBO4Tc2O3Pp9dSAhgEnb/hwed4eMwQ59QfPv6C0s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=V8yO51B2b2mOpu46tK8l9jXOndIihXoS0QHs27U1U+3VWoLmnhQ350KAZfl+u0HbRWidAlXWQvY65ho+IK97WZeJErGN/DDcXRKJGFZupAfOTvb7IuUTWvJ/oQf0h552/+ornrMWN+w9MRsh3+z4So9BiDtYhVqflBQJPb2Meps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCasGYly; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCasGYly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730816173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YqP+f60ltF1zKv84dv82s0R6zTK2sGaAnRbihEoRRC4=;
	b=UCasGYlylp75hLMLvyYIf10WnJQYgxIe9KAEyRMr0lLvRW9Yo/Do9xUIXOV3lWz3HqjjfS
	6SIg8RCAch/4l8z5Kmi9XauuyNQkTa4ydrBQJyc5DtQGj7pri2vZHRcoEBrHujqwdeRir0
	RjQQtQAioJ/WbmWHlBMhH9ACZYLlqc4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324--8SU_HsVPKCEA5BGMZuzOQ-1; Tue, 05 Nov 2024 09:16:11 -0500
X-MC-Unique: -8SU_HsVPKCEA5BGMZuzOQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fb3f99c9a7so32631751fa.1
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2024 06:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730816169; x=1731420969;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqP+f60ltF1zKv84dv82s0R6zTK2sGaAnRbihEoRRC4=;
        b=iCzdOQ48rR8UzjdZOba2Fi9bR6DfaNPWUqJb+9DG6WZFeMaSxEjz8TFlrjAOnNRjcV
         BtFRYfrzIu5nx0PR0q57qNnjm0o2p1Nbq1lXvSUi+8RAiyZMK/7dYf3Y8hYHMcPTNjyf
         2dAXjb9xg/fmtSqkOXdO2dMXDoEUbyGvVRxOSEUgJggBvAIoxcVkakdI44BJ7ZACZdSp
         DRujEmfLMUCfOQDTx2HH0PzlEfslFSVJmo+SPVTmfR09hd1ElW+YZnGVNPgRPYx0BKTZ
         gdC38JCazi3cC1KcYUUJy/I4nem3yuotL8Ouhv9SDp49m1cRmr41VDeyabBs6xk13xCH
         pHjA==
X-Gm-Message-State: AOJu0YyRgnt5tbjWZKseTekfFRf9HUYapgycZOIL7l2b2pGKP8tfBwmL
	Dr/DCaJBjAZ+IDCLWtVf7/OEbBqjk4mA8s/N13IDkgn8wM6zrb7oHX6NQfe3DanzzL8P+A9gLiJ
	6oATP/bfOIV8IZDCznGFAQILlAy0gu3R04P9dnM4uhYOtNfPyZnrMq93v5GLhWeYbyq99BDPWLI
	0A9ZnBnaFUXKh3Z2qH7E7r7TmFjyG+ZtNzYBqNIvQtDuQlD5FJ
X-Received: by 2002:a2e:b88e:0:b0:2fa:e658:27b4 with SMTP id 38308e7fff4ca-2fcbdf5fe55mr171995011fa.4.1730816169369;
        Tue, 05 Nov 2024 06:16:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq5XEUX3+HewjpiinOII7TsYLXEDQbcp6y8RjHg5GgtTPRyYNm+rI49OZO12WmpkCaQRTmV2iQxi+NbyjOWvI=
X-Received: by 2002:a2e:b88e:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fcbdf5fe55mr171994771fa.4.1730816168870; Tue, 05 Nov 2024
 06:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 5 Nov 2024 22:15:57 +0800
Message-ID: <CAHj4cs8vzJzqMApULdywxc7GJaOR5ehVY-gUtSnZKW2rOPD08w@mail.gmail.com>
Subject: [bug report]WARNING: CPU: 42 PID: 2893 at block/blk-settings.c:75 blk_validate_limits+0x475/0x4a0
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello

CKI reported this new issue with the latest linux-block/for-next[1],
please help check it and let me know if you need any info/test for it.

[1]
b872afe6c5f2 (HEAD -> for-next, origin/for-next) Merge branch
'for-6.13/io_uring' into for-next

# ./check zbd/011
zbd/011 (DM zone resource limits stacking)                   [failed]
    runtime    ...  2.892s
    --- tests/zbd/011.out 2024-11-05 09:06:01.299153291 -0500
    +++ /root/blktests/results/nodev/zbd/011.out.bad 2024-11-05
09:08:01.693669820 -0500
    @@ -1,2 +1,15 @@
     Running zbd/011
    +device-mapper: reload ioctl on zbd_011-linear (253:3) failed:
Invalid argument
    +Command failed.
    +tests/zbd/011: line 143: /sys/block/mapper/queue/zoned: No such
file or directory
    +Invalid zoned model:  should be none
    +Test 3 failed: Map all CNV zones of the 1st nullb
    +device-mapper: remove ioctl on   failed: No such device or address
    ...
    (Run 'diff -u tests/zbd/011.out
/root/blktests/results/nodev/zbd/011.out.bad' to see the entire diff)

[  209.988649] run blktests zbd/011 at 2024-11-05 09:07:58
[  210.010958] null_blk: nullb_zbd_011_1: using native zone append
[  210.013913] null_blk: disk nullb_zbd_011_1 created
[  210.018942] null_blk: nullb_zbd_011_2: using native zone append
[  210.021698] null_blk: disk nullb_zbd_011_2 created
[  210.035289] device-mapper: zone: dm-3 using emulated zone append
[  210.146683] device-mapper: zone: dm-3 using emulated zone append
[  210.254299] ------------[ cut here ]------------
[  210.258940] WARNING: CPU: 42 PID: 2893 at block/blk-settings.c:75
blk_validate_limits+0x475/0x4a0
[  210.267828] Modules linked in: dm_crypt null_blk tls rfkill
intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common skx_edac skx_edac_common
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sunrpc kvm
mgag200 dell_pc mei_me dell_smbios rapl iTCO_wdt ipmi_ssif cdc_ether
i2c_algo_bit platform_profile intel_cstate iTCO_vendor_support
drm_shmem_helper dcdbas drm_kms_helper intel_uncore usbnet
dell_wmi_descriptor pcspkr wmi_bmof mei i2c_i801 mii lpc_ich i2c_smbus
intel_pch_thermal acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf
ipmi_msghandler dax_pmem drm fuse xfs libcrc32c nd_pmem nd_btt sd_mod
sg ahci libahci crct10dif_pclmul crc32_pclmul bnxt_en crc32c_intel
ghash_clmulni_intel libata megaraid_sas tg3 wmi nfit libnvdimm
dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dm_crypt]
[  210.340378] CPU: 42 UID: 0 PID: 2893 Comm: dmsetup Kdump: loaded
Not tainted 6.12.0-rc5+ #1
[  210.348729] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.20.1 09/13/2023
[  210.356301] RIP: 0010:blk_validate_limits+0x475/0x4a0
[  210.361363] Code: 0b e9 25 fd ff ff 0f 0b b8 ea ff ff ff c3 cc cc
cc cc 0f 0b b8 ea ff ff ff c3 cc cc cc cc 0f 0b b8 ea ff ff ff c3 cc
cc cc cc <0f> 0b b8 ea ff ff ff c3 cc cc cc cc 48 c7 c7 54 d4 45 8b e8
d3 cf
[  210.380116] RSP: 0018:ffffab34cf547ba8 EFLAGS: 00010286
[  210.385349] RAX: 0000000000000000 RBX: ffff9ba17c03c4a0 RCX: 0000000000000000
[  210.392480] RDX: 00000000ffffffff RSI: ffffab34cf547bf8 RDI: 0000000000000000
[  210.399615] RBP: ffffab34cf547bf8 R08: 0000000000000000 R09: 0000000000000000
[  210.406756] R10: 0000000000000200 R11: 0000000000000a00 R12: ffff9ba17c03c4a0
[  210.413894] R13: 0000000000000001 R14: ffff9ba148587800 R15: 0000000000000000
[  210.421027] FS:  00007f1d06417840(0000) GS:ffff9bc030480000(0000)
knlGS:0000000000000000
[  210.429113] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  210.434866] CR2: 000055faac4b7298 CR3: 0000000116a72003 CR4: 00000000007726f0
[  210.441998] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  210.449130] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  210.456262] PKRU: 55555554
[  210.458974] Call Trace:
[  210.461428]  <TASK>
[  210.463533]  ? __warn+0x84/0x130
[  210.466775]  ? blk_validate_limits+0x475/0x4a0
[  210.471230]  ? report_bug+0x18a/0x1a0
[  210.474904]  ? handle_bug+0x53/0x90
[  210.478403]  ? exc_invalid_op+0x14/0x70
[  210.482244]  ? asm_exc_invalid_op+0x16/0x20
[  210.486440]  ? blk_validate_limits+0x475/0x4a0
[  210.490893]  ? mutex_lock+0xe/0x30
[  210.494307]  queue_limits_commit_update+0x17/0x80
[  210.499020]  dm_table_set_restrictions+0x27e/0x320 [dm_mod]
[  210.504612]  dm_setup_md_queue+0x72/0x1d0 [dm_mod]
[  210.509413]  table_load+0x12a/0x2b0 [dm_mod]
[  210.513694]  ctl_ioctl+0x203/0x350 [dm_mod]
[  210.517889]  dm_ctl_ioctl+0xa/0x20 [dm_mod]
[  210.522080]  __x64_sys_ioctl+0x87/0xc0
[  210.525835]  do_syscall_64+0x79/0x150
[  210.529507]  ? do_user_addr_fault+0x33d/0x6b0
[  210.533878]  ? exc_page_fault+0x64/0x140
[  210.537809]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  210.542870] RIP: 0033:0x7f1d0630375b
[  210.546450] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d
4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 56 0f 00 f7 d8 64 89
01 48
[  210.565196] RSP: 002b:00007ffd4492b0a8 EFLAGS: 00000202 ORIG_RAX:
0000000000000010
[  210.572768] RAX: ffffffffffffffda RBX: 00007f1d0653ebd0 RCX: 00007f1d0630375b
[  210.579901] RDX: 000055faac4b3290 RSI: 00000000c138fd09 RDI: 0000000000000003
[  210.587031] RBP: 00007f1d0657ca91 R08: 00007f1d0657e400 R09: 00007ffd4492af00
[  210.594165] R10: 00007f1d0657b156 R11: 0000000000000202 R12: 000055faac4b3290
[  210.601296] R13: 000055faac4b3340 R14: 00007f1d0657ca91 R15: 000055faac4b1c90
[  210.608430]  </TASK>
[  210.610629] ---[ end trace 0000000000000000 ]---
[  210.615247] device-mapper: ioctl: unable to set up device queue for
new table.
[  210.644746] device-mapper: zone: dm-3 using emulated zone append
[  210.727814] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  210.735352] device-mapper: zone: dm-3 using emulated zone append
[  210.817091] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  210.824511] device-mapper: zone: dm-3 using emulated zone append
[  210.902194] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  210.909715] device-mapper: zone: dm-3 using emulated zone append
[  211.008742] device-mapper: zone: dm-3 using emulated zone append
[  211.111794] device-mapper: zone: dm-3 using emulated zone append
[  211.211322] device-mapper: zone: dm-3 using emulated zone append
[  211.330772] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  211.338110] device-mapper: zone: dm-3 using emulated zone append
[  211.446137] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  211.453591] device-mapper: zone: dm-3 using emulated zone append
[  211.586887] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  211.594405] device-mapper: zone: dm-3 using emulated zone append
[  211.718959] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  211.726472] device-mapper: zone: dm-3 using emulated zone append
[  211.845784] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  211.853187] device-mapper: zone: dm-3 using emulated zone append
[  211.949385] device-mapper: zone: dm-3 using emulated zone append
[  211.973862] Buffer I/O error on dev dm-3, logical block 589808,
async page read
[  212.065117] device-mapper: zone: dm-3 using emulated zone append
[  212.214317] device-mapper: ioctl: unable to set up device queue for
new table.
[  212.304826] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  212.312189] device-mapper: zone: dm-3 using emulated zone append
[  212.454394] device-mapper: zone: dm-3 zone resource limits may be unreliable
[  212.461804] device-mapper: zone: dm-3 using emulated zone append
[  212.609907] device-mapper: zone: dm-3 using emulated zone append


-- 
Best Regards,
  Yi Zhang

