Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272837144
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716352848; cv=none; b=VDNAWbLchWYUPzgsWoQ0fowwaktHlgOINcZ1MAmasf4pkqtErk98IweANdnkHSpeolARhQId2Ve+6ObF3C0zK7pTc9vKUjRwvkgUxwQ717ed2LN8FQCrNU8+cIdBg26UpBXJs8Ab0sWoqzn5F0sgDTCRKqIFzUGHDIKRLwd8/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716352848; c=relaxed/simple;
	bh=sxV0jvu7FgOKrK2uIwSVad+e7CNT3+8g9HE6z90zlDw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q9KVvpmX6Bp0UBtjIunAeYncpYWiRwKU5KGmm+a3YQoFqbSvMgJXMBu6rJWGQdHGu0K2M+dleES6xasEn0+USzuXfhBAev6JD3C20wBiUWU6TJfQDawIQ+wHiLTVT85POgz0jEIb9aGlNQMGXUGJkcpkUXCfGJY4H/DAMQzkqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKHxUi0T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKHxUi0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716352845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iI6N3IogeYy6i9V5xofPFS322yv6z3Gl6XncK4yQfxY=;
	b=bKHxUi0TEjlPhxLsL6wHYzZoMpsrGVDhav0sLuoor4f/0J/KXDvwqW7oGdJunMxcm909Uz
	K1gqVHmSobXQkx9ikW6aL04wyY+v2eGWGgsMETYT+9wifExtuPSqLU0B59BEABJuHVEyPH
	CVwQ8Oe5c2NODHvAKivutIJjt9kv684=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-Uqp7Ut5FNxCWnUhCk0MPng-1; Wed, 22 May 2024 00:40:43 -0400
X-MC-Unique: Uqp7Ut5FNxCWnUhCk0MPng-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b2a648f23dso11550518a91.3
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 21:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716352841; x=1716957641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iI6N3IogeYy6i9V5xofPFS322yv6z3Gl6XncK4yQfxY=;
        b=uXztx6779NHsRo2ItqQMmkfqCQfoRTYPjRjgvtS437xm0AreZzlD8ruAPxp2aeheiH
         J3SfNvbwS4C5sW95fNKnm3wyX6NURNWNrBEWI6JhDixJKWOPgBdCwEMc0qApnXASqU7d
         LR55qa1uYd/F8gQlVv2o1q3++5pKNQT+OVUGVykacCT6fgOhiyMm4OIJKk9/qt1NOwDh
         XdQasU0j0tM5QMI5hH28kT+euTF6f8ExgoNR7sXFdgcsmgi7xtYL51/PY/OtZ7dqsRfp
         FkdM2DTVqhbnZhGwLn61wcHwlIv/e5XvjzXE1zuoTxnp0Q/b9AUHHtfls9sa5i2VqqxH
         KC1A==
X-Gm-Message-State: AOJu0Yz+GgMuZZcCL+ZvGD5oAiYq+2kjCIy32NhIWPL/3EAhkMwy/RAf
	Kz7mCFZ5i56cJWYeDTevnMnnIplXO3pp2SFqwtBaT+/WK0TJBiQtakpXsDEF4DTQI5Re4+PH8d1
	bGDjbQ30MXhbzOoC8aLp/OkSFlvpuB3hhHnh7stfH0ikKQipusaGMk11HE92ctUhPTXpeQpXKfn
	l57Hs3JMjMgKdJzUg9KVPibHnABM7FL1W+98FZeBg5uWnGlTVW
X-Received: by 2002:a17:90a:a506:b0:2ad:6294:7112 with SMTP id 98e67ed59e1d1-2bd9f456c77mr1135755a91.14.1716352840782;
        Tue, 21 May 2024 21:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8OCwlJqD4p6aUDjNyxsTdVTggWRIpaGaMaWa1clgJ2zXzxb6+vlGwd0PEVsubO9/GGIRNsTo8ye0JdL8FofM=
X-Received: by 2002:a17:90a:a506:b0:2ad:6294:7112 with SMTP id
 98e67ed59e1d1-2bd9f456c77mr1135742a91.14.1716352840371; Tue, 21 May 2024
 21:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 22 May 2024 12:40:28 +0800
Message-ID: <CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com>
Subject: [bug report] kernel panic with concurrent power on/off operation for null-blk
To: linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello
With Sagi's new blktests case scenario[1], I tried the concurrent
power on/off for null-blk[2] and found it will lead to kernel
panic[3],  please help check it and let me know if you need any
info/testing for it, thanks.
BTW, I will submit one blktests case for it later.

[1] https://lore.kernel.org/linux-nvme/20240521085623.87681-1-sagi@grimberg=
.me/

[2]Reproducer:
nullb1=3D"/sys/kernel/config/nullb/nullb1"
modprobe null-blk nr_devices=3D0
mkdir $nullb1
echo 1024 > $nullb1/size
echo 1 > $nullb1/memory_backed
null_blk_power_loop() {
       local iterations=3D10
       for ((i =3D 1; i <=3D ${iterations}; i++)); do
               echo 0 > $nullb1/power
               echo 1 > $nullb1/power
       done
}
null_blk_power_loop &
null_blk_power_loop &
wait

[3]
[ 1200.017939] null_blk: disk nullb1 created
[ 1200.043860] BUG: kernel NULL pointer dereference, address: 0000000000000=
130
[ 1200.051627] #PF: supervisor write access in kernel mode
[ 1200.057458] #PF: error_code(0x0002) - not-present page
[ 1200.063192] PGD 0 P4D 0
[ 1200.066021] Oops: 0002 [#1] PREEMPT SMP PTI
[ 1200.070691] CPU: 0 PID: 1724 Comm: sh Not tainted 6.9.0-64.eln136.x86_64=
 #1
[ 1200.078462] Hardware name: Dell Inc. PowerEdge R730xd/=C9=B2=EF=BF=BDPow=
, BIOS
2.19.0 12/12/2023
[ 1200.087105] RIP: 0010:_raw_spin_lock_irq+0x18/0x30
[ 1200.092459] Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 f3 0f 1e fa 0f 1f 44 00 00 fa 65 ff 05 47 28 26 7c 31 c0 ba 01
00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 46 01 00 00 90 c3
cc cc
[ 1200.113416] RSP: 0018:ffffb973431e7420 EFLAGS: 00010046
[ 1200.119249] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00008
[ 1200.127212] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000000=
00130
[ 1200.135175] RBP: 0000000000000008 R08: ffff9645c44e4400 R09: 00000000000=
00000
[ 1200.143140] R10: 0000000000000014 R11: 0000000000000000 R12: ffff964743a=
2d800
[ 1200.151103] R13: 0000000000000130 R14: ffff9645d05580f8 R15: 00000000000=
00001
[ 1200.159067] FS:  00007f67cea3b740(0000) GS:ffff964737a00000(0000)
knlGS:0000000000000000
[ 1200.168099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1200.174511] CR2: 0000000000000130 CR3: 00000002819c4001 CR4: 00000000001=
706f0
[ 1200.182473] Call Trace:
[ 1200.185200]  <TASK>
[ 1200.187541]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 1200.192406]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 1200.197272]  ? null_handle_rq+0x3f/0x500 [null_blk]
[ 1200.202735]  ? __die_body.cold+0x8/0x12
[ 1200.207008]  ? page_fault_oops+0x146/0x160
[ 1200.211583]  ? exc_page_fault+0x73/0x160
[ 1200.215963]  ? asm_exc_page_fault+0x26/0x30
[ 1200.220634]  ? _raw_spin_lock_irq+0x18/0x30
[ 1200.225303]  null_handle_rq+0x3f/0x500 [null_blk]
[ 1200.230567]  ? pcpu_alloc+0x369/0x900
[ 1200.234654]  ? lock_timer_base+0x76/0xa0
[ 1200.239035]  null_process_cmd+0xb4/0x100 [null_blk]
[ 1200.244490]  null_handle_cmd+0x36/0x130 [null_blk]
[ 1200.249849]  null_queue_rq+0x130/0x200 [null_blk]
[ 1200.255110]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1200.260948]  __blk_mq_issue_directly+0x4b/0xc0
[ 1200.265911]  blk_mq_try_issue_directly+0x88/0x110
[ 1200.271155]  blk_mq_submit_bio+0x596/0x690
[ 1200.275720]  submit_bio_noacct_nocheck+0x162/0x240
[ 1200.281071]  ? submit_bio_noacct+0x24/0x540
[ 1200.285740]  block_read_full_folio+0x1f8/0x300
[ 1200.290702]  ? __pfx_blkdev_get_block+0x10/0x10
[ 1200.295760]  ? __pfx_blkdev_read_folio+0x10/0x10
[ 1200.300913]  ? __pfx_blkdev_read_folio+0x10/0x10
[ 1200.306064]  filemap_read_folio+0x43/0xe0
[ 1200.310542]  ? __pfx_blkdev_read_folio+0x10/0x10
[ 1200.315693]  do_read_cache_folio+0x7c/0x190
[ 1200.320365]  read_part_sector+0x33/0xb0
[ 1200.324650]  read_lba+0xc1/0x180
[ 1200.328256]  find_valid_gpt.constprop.0+0xe1/0x520
[ 1200.333609]  efi_partition+0x7c/0x3a0
[ 1200.337699]  ? snprintf+0x53/0x70
[ 1200.341401]  ? __pfx_efi_partition+0x10/0x10
[ 1200.346170]  check_partition+0x101/0x1c0
[ 1200.350550]  bdev_disk_changed+0x193/0x330
[ 1200.355121]  ? security_file_alloc+0x61/0xf0
[ 1200.359889]  blkdev_get_whole+0x5f/0xa0
[ 1200.364170]  bdev_open+0x205/0x3c0
[ 1200.367966]  bdev_file_open_by_dev+0xbd/0x110
[ 1200.372829]  disk_scan_partitions+0x6e/0x100
[ 1200.377594]  device_add_disk+0x3bb/0x3c0
[ 1200.381972]  null_add_dev+0x479/0x650 [null_blk]
[ 1200.387139]  nullb_device_power_store+0x7c/0x120 [null_blk]
[ 1200.393370]  configfs_write_iter+0xbc/0x120
[ 1200.398042]  vfs_write+0x296/0x460
[ 1200.401841]  ksys_write+0x6d/0xf0
[ 1200.405543]  do_syscall_64+0x7e/0x160
[ 1200.409634]  ? syscall_exit_work+0xf3/0x120
[ 1200.414302]  ? syscall_exit_to_user_mode+0x71/0x1f0
[ 1200.419740]  ? do_syscall_64+0x8a/0x160
[ 1200.424019]  ? syscall_exit_work+0xf3/0x120
[ 1200.428686]  ? syscall_exit_to_user_mode+0x71/0x1f0
[ 1200.434131]  ? do_syscall_64+0x8a/0x160
[ 1200.438413]  ? syscall_exit_work+0xf3/0x120
[ 1200.443081]  ? syscall_exit_to_user_mode+0x71/0x1f0
[ 1200.448525]  ? do_syscall_64+0x8a/0x160
[ 1200.452807]  ? syscall_exit_work+0xf3/0x120
[ 1200.457475]  ? syscall_exit_to_user_mode+0x71/0x1f0
[ 1200.462921]  ? do_syscall_64+0x8a/0x160
[ 1200.467202]  ? syscall_exit_to_user_mode+0x71/0x1f0
[ 1200.472638]  ? do_syscall_64+0x8a/0x160
[ 1200.476918]  ? exc_page_fault+0x73/0x160
[ 1200.481296]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1200.486933] RIP: 0033:0x7f67ce8fda57
[ 1200.490931] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
74 24
[ 1200.511886] RSP: 002b:00007ffd30172638 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 1200.520335] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f67ce8=
fda57
[ 1200.528297] RDX: 0000000000000002 RSI: 0000557fdb881c90 RDI: 00000000000=
00001
[ 1200.536258] RBP: 0000557fdb881c90 R08: 0000000000000000 R09: 00007f67ce9=
b14e0
[ 1200.544219] R10: 00007f67ce9b13e0 R11: 0000000000000246 R12: 00000000000=
00002
[ 1200.552181] R13: 00007f67ce9fb780 R14: 0000000000000002 R15: 00007f67ce9=
f69e0
[ 1200.560145]  </TASK>
[ 1200.562581] Modules linked in: null_blk sunrpc vfat fat
intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp dell_wmi_descriptor kvm_intel sparse_keymap
cdc_ether rfkill ipmi_ssif usbnet video kvm mei_me iTCO_wdt dcdbas mii
iTCO_vendor_support mei ipmi_si rapl mgag200 mxm_wmi pcspkr
intel_cstate ipmi_devintf acpi_power_meter ipmi_msghandler
intel_uncore i2c_algo_bit lpc_ich fuse xfs sd_mod sg nvme ahci libahci
crct10dif_pclmul crc32_pclmul crc32c_intel libata ghash_clmulni_intel
nvme_core tg3 megaraid_sas nvme_auth t10_pi wmi dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: null_blk]
[ 1200.624314] CR2: 0000000000000130
[ 1200.628012] ---[ end trace 0000000000000000 ]---
[ 1200.688370] RIP: 0010:_raw_spin_lock_irq+0x18/0x30
[ 1200.693747] Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 f3 0f 1e fa 0f 1f 44 00 00 fa 65 ff 05 47 28 26 7c 31 c0 ba 01
00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 46 01 00 00 90 c3
cc cc
[ 1200.714704] RSP: 0018:ffffb973431e7420 EFLAGS: 00010046
[ 1200.720535] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00008
[ 1200.728498] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000000=
00130
[ 1200.736461] RBP: 0000000000000008 R08: ffff9645c44e4400 R09: 00000000000=
00000
[ 1200.744423] R10: 0000000000000014 R11: 0000000000000000 R12: ffff964743a=
2d800
[ 1200.752384] R13: 0000000000000130 R14: ffff9645d05580f8 R15: 00000000000=
00001
[ 1200.760348] FS:  00007f67cea3b740(0000) GS:ffff964737a00000(0000)
knlGS:0000000000000000
[ 1200.769378] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1200.775789] CR2: 0000000000000130 CR3: 00000002819c4001 CR4: 00000000001=
706f0
[ 1200.783754] Kernel panic - not syncing: Fatal exception
[ 1200.789636] Kernel Offset: 0x2000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1200.856453] ---[ end Kernel panic - not syncing: Fatal exception ]---

Best Regards,
  Yi Zhang

