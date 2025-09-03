Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD12E3B15
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888584; cv=none; b=Me0Y65bpbrzB7VuSWwiDisvCZhUUptClmQ2rLqhFHA445a6aooaoyi7cZE5uEVUJdWAngSfozYiIqI5RB9a+YVzvSuRXiqk7Q7ZBxGNHPoiAtNFfRU0GQTvzH4jhUfbBGoSH3kiit6tnItPrOv4RUASIncxT67pcs6lTXp+Ho/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888584; c=relaxed/simple;
	bh=olxkUNFwK0Tag6o4j7p6P9GWmZAFPKdlUvs7dlGbxUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aA6Ju1GEZhRL9T70olH5JxfKdKMjjicrTnhtIK5oYctLeyJN+Uz6eCDBXWE6fSEEWiWpwq4ElDQ2eX7ZBK/JhWzH5wVXc6pc2HKycYcqgQojCkzWDHC3V43mYaqhiinMP643cZYf0JgdcFZjC9VJgvpFp3Uwm9ztbl2ibspQkKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiSfB5DH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiSfB5DH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756888581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ATJnjvon6PGHuf6owIZ/V8GyLUWmctCBG5gDKklYycE=;
	b=YiSfB5DH9Le7S8JjOVqZtkwZv1tfzYXyGqBoXaaxPB3WfNFWO2apgFpfygQ4ZWBTu7dGWN
	iH0Kh0/gzNfKqjlXp93RD+rOtw8q980hZKopIvploPwSGTvdmFTQtrDMJCblh4a7sAbAFl
	VvDsOnOFTILxPDGgU5fNzAH6z7cO/kM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-6lYbltmqM4mqsdp-xvp4pg-1; Wed, 03 Sep 2025 04:36:20 -0400
X-MC-Unique: 6lYbltmqM4mqsdp-xvp4pg-1
X-Mimecast-MFC-AGG-ID: 6lYbltmqM4mqsdp-xvp4pg_1756888579
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-336e13bf342so15568211fa.3
        for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 01:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888577; x=1757493377;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATJnjvon6PGHuf6owIZ/V8GyLUWmctCBG5gDKklYycE=;
        b=Y25sbzZyLEJcmydK5Mq5JM90S2cV3FL6/HMqlfSKiD+7nL8kcSHF27AgjBq9T1xM+B
         myzlAqLP8oU4HMxDMFe4VW08nqMhmaF7+nD2JSrohF4RGDmrnVLRbGnm3hZuZnfoObHK
         oA1LdhZ3qbdhJt3hjE7UJHPqvbkRJfowg54db3iO264uYYfkdKmlbqE675r+QgYaI56F
         bpvmCz3McnoqGcPG15+J/a9tFsrbhKxSJ1bqHrAwcFxEM3MyvR0rupBSrb46c7Oyp4eR
         EivYbYTMC89x3np0wMMvVtjRfSStA/gQ0mxbA/a4t6EsVkKlO3VSagLdm1XGWMtn4WPo
         B+Tg==
X-Gm-Message-State: AOJu0Yxr7O0HHIe/U5RjjvAAP8FH0XbU+lTM9hLI2MgOjCCRuuVX58JV
	s/Tcx7CnU8EBDZHq8u7HixzkTGh6e2bh6O9S08KEpeL/LgvlCMEkh11g0O4GvNYNG77J5/xLDMZ
	KTJ9ZJ4/6xlgylDQyQmh10mBQAsRlMDNVPLxZU4YPsVjfx5R4Td2dfdyusH89Fqa4+0FlufoQkF
	9OYCPSzBIAapnNz4rOYw6Ty5q/DlxtrbMWYwjcAS6vnxIiV2fIV8ZxUW4=
X-Gm-Gg: ASbGncteNZiCL9eocs2pNwPQPrrma3pZhwp4cJP9RqAmP8zJ6NecJ8T7WQ90pKEjT4E
	Blrsvk+GCjwy2CsJc9kwSsXWaSobfRrMHSy7lbES23oLTLXmIg6CwMzdkR+24jFEHIU/VOZkuxX
	gZKpgqy73cJBpYhf5FZHRywQ==
X-Received: by 2002:a05:651c:41d1:b0:336:bbff:2739 with SMTP id 38308e7fff4ca-336caafe852mr43766081fa.27.1756888577141;
        Wed, 03 Sep 2025 01:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiH6oJawsKiaV2emBtiCryq7VxvYGkKuppaAF88afZzAOgAqdZC7ekdUHgogv4bl+cw6YY3CT+cp1n9V/U4qk=
X-Received: by 2002:a05:651c:41d1:b0:336:bbff:2739 with SMTP id
 38308e7fff4ca-336caafe852mr43765921fa.27.1756888576663; Wed, 03 Sep 2025
 01:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 3 Sep 2025 16:36:04 +0800
X-Gm-Features: Ac12FXzrYUwte2yTaoqyfew2-kR5ijplB6Zqzb8AbHJYfj3dgzlxAx1SOZrhtFQ
Message-ID: <CAHj4cs8-cS2E+-xQ-d2Bj6vMJZ+CwT_cbdWBTju4BV35LsvEYw@mail.gmail.com>
Subject: [bug report]kernel BUG at fs/btrfs/zoned.c:2587! triggered by
 blktests zbd/009
To: linux-block <linux-block@vger.kernel.org>, linux-btrfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello
The kernel BUG was triggered by blktests zbd/009 on v6.17-rc3, please
help check it and let me know if you need any infor/test for it,
thanks.

# ./check zbd/009
zbd/009 (test gap zone support with BTRFS)                   [failed]
    runtime  1.777s  ...  5.890s
    --- tests/zbd/009.out 2025-09-02 20:08:01.638628999 -0400
    +++ /root/blktests/results/nodev/zbd/009.out.bad 2025-09-03
04:18:32.360095891 -0400
    @@ -1,2 +1,4 @@
     Running zbd/009
    -Test complete
    +tests/zbd/009: line 42:  1461 Segmentation fault         mount -t
btrfs "${dev}" "${mount_dir}"
    +modprobe: FATAL: Module scsi_debug is in use.
    +Test failed
modprobe: FATAL: Module scsi_debug is in use.

[  317.501900] run blktests zbd/009 at 2025-09-03 04:33:43
[  317.661628] sd 13:0:0:0: [sdn] Synchronizing SCSI cache
[  318.464792] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  318.474936] scsi host13: scsi_debug: version 0191 [20210520]
                 dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
[  318.502019] scsi 13:0:0:0: Direct-Access-ZBC Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[  318.514301] scsi 13:0:0:0: Power-on or device reset occurred
[  318.526186] sd 13:0:0:0: Attached scsi generic sg13 type 20
[  318.527006] sd 13:0:0:0: [sdn] Host-managed zoned block device
[  318.543292] sd 13:0:0:0: [sdn] 262144 4096-byte logical blocks:
(1.07 GB/1.00 GiB)
[  318.552614] sd 13:0:0:0: [sdn] Write Protect is off
[  318.558137] sd 13:0:0:0: [sdn] Mode Sense: 5b 00 10 08
[  318.558555] sd 13:0:0:0: [sdn] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  318.568950] sd 13:0:0:0: [sdn] permanent stream count = 5
[  318.576121] sd 13:0:0:0: [sdn] Preferred minimum I/O size 4096 bytes
[  318.583446] sd 13:0:0:0: [sdn] Optimal transfer size 4194304 bytes
[  318.593500] sd 13:0:0:0: [sdn] 256 zones of 1024 logical blocks
[  318.651787] sd 13:0:0:0: [sdn] Attached SCSI disk
[  319.736198] BTRFS: device fsid 2c2dcb97-3f07-481c-ad31-dce6d400c303
devid 1 transid 8 /dev/sdn (8:208) scanned by mount (1370)
[  319.755053] BTRFS info (device sdn): first mount of filesystem
2c2dcb97-3f07-481c-ad31-dce6d400c303
[  319.765257] BTRFS info (device sdn): using crc32c (crc32c-lib)
checksum algorithm
[  319.795471] BTRFS info (device sdn): host-managed zoned block
device /dev/sdn, 256 zones of 4194304 bytes
[  319.806542] BTRFS info (device sdn): zoned mode enabled with zone
size 4194304
[  319.819821] assertion failed: bg->zone_unusable == 0 :: 0, in
fs/btrfs/zoned.c:2587
[  319.828449] ------------[ cut here ]------------
[  319.833618] kernel BUG at fs/btrfs/zoned.c:2587!
[  319.838793] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[  319.844829] CPU: 3 UID: 0 PID: 1370 Comm: mount Tainted: G        W
         ------  ---
6.17.0-0.rc3.250826gfab1beda7597.32.fc44.x86_64+debug #1 PREEMPT(lazy)
[  319.860948] Tainted: [W]=WARN
[  319.864259] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS
2.19.0 12/12/2023
[  319.872704] RIP: 0010:btrfs_zoned_reserve_data_reloc_bg.cold+0xb2/0xb4
[  319.880014] Code: ab e8 7e ab f7 ff 0f 0b 41 b8 1b 0a 00 00 48 c7
c1 80 9f 59 ab 31 d2 48 c7 c6 20 b8 59 ab 48 c7 c7 20 a0 59 ab e8 5a
ab f7 ff <0f> 0b 41 b8 5f 0a 00 00 48 c7 c1 80 9f 59 ab 31 d2 48 c7 c6
00 b9
[  319.900977] RSP: 0018:ffffc9000c21f930 EFLAGS: 00010282
[  319.906816] RAX: 0000000000000047 RBX: ffff8888d1a54000 RCX: 0000000000000000
[  319.914783] RDX: 0000000000000047 RSI: 1ffffffff629cc84 RDI: fffff52001843f18
[  319.922742] RBP: ffff888121b7c000 R08: ffffffffa802cbb5 R09: fffff52001843edc
[  319.930709] R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
[  319.938666] R13: 0000000000000001 R14: ffff888121b7c128 R15: ffff88810f379800
[  319.946625] FS:  00007fbd89e98840(0000) GS:ffff8890af8e8000(0000)
knlGS:0000000000000000
[  319.955661] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  319.962077] CR2: 0000559e0ad4b540 CR3: 00000008e14ce003 CR4: 00000000003726f0
[  319.970046] Call Trace:
[  319.972767]  <TASK>
[  319.975102]  ? create_space_info+0x155/0x390
[  319.979880]  open_ctree+0x1874/0x2203
[  319.983977]  btrfs_fill_super.cold+0x2c/0x16d
[  319.988850]  btrfs_get_tree_super+0x936/0xd60
[  319.993725]  btrfs_get_tree_subvol+0x230/0x5f0
[  319.998692]  vfs_get_tree+0x8b/0x2f0
[  320.002690]  ? capable+0x58/0xc0
[  320.006299]  vfs_cmd_create+0xbd/0x280
[  320.010490]  __do_sys_fsconfig+0x659/0xa40
[  320.015066]  ? __pfx___do_sys_fsconfig+0x10/0x10
[  320.020223]  ? rcu_is_watching+0x15/0xe0
[  320.024608]  ? __pfx___mutex_lock+0x10/0x10
[  320.029282]  ? fscontext_read+0x24e/0x2a0
[  320.033761]  ? file_has_perm+0x25b/0x320
[  320.038149]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[  320.043892]  do_syscall_64+0x98/0x3c0
[  320.047991]  ? fscontext_read+0x24e/0x2a0
[  320.052468]  ? rw_verify_area+0x6f/0x5f0
[  320.056855]  ? vfs_read+0x171/0xb20
[  320.060753]  ? vfs_fstatat+0x75/0xa0
[  320.064752]  ? __pfx_vfs_read+0x10/0x10
[  320.069038]  ? vfs_fstatat+0x75/0xa0
[  320.073032]  ? __pfx_map_id_range_up+0x10/0x10
[  320.078002]  ? __do_sys_newfstatat+0x83/0xe0
[  320.082773]  ? __pfx___do_sys_newfstatat+0x10/0x10
[  320.088128]  ? from_kgid_munged+0x8c/0x120
[  320.092707]  ? ksys_read+0xff/0x200
[  320.096606]  ? __pfx_ksys_read+0x10/0x10
[  320.100987]  ? trace_hardirqs_on_prepare+0x1d/0x30
[  320.106342]  ? do_syscall_64+0x161/0x3c0
[  320.110725]  ? trace_irq_enable.constprop.0+0xc0/0x100
[  320.116465]  ? rcu_is_watching+0x15/0xe0
[  320.120847]  ? trace_irq_enable.constprop.0+0xc0/0x100
[  320.126587]  ? trace_hardirqs_on_prepare+0x1d/0x30
[  320.131938]  ? do_syscall_64+0x161/0x3c0
[  320.136322]  ? trace_hardirqs_on_prepare+0x1d/0x30
[  320.141674]  ? do_syscall_64+0x161/0x3c0
[  320.146055]  ? rcu_is_watching+0x15/0xe0
[  320.150438]  ? trace_irq_enable.constprop.0+0xc0/0x100
[  320.156178]  ? trace_hardirqs_on_prepare+0x1d/0x30
[  320.161529]  ? do_syscall_64+0x161/0x3c0
[  320.165912]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  320.171556] RIP: 0033:0x7fbd8a0782ce
[  320.175566] Code: 73 01 c3 48 8b 0d 32 3b 0f 00 f7 d8 64 89 01 48
83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 3b 0f 00 f7 d8 64 89
01 48
[  320.196527] RSP: 002b:00007ffee3b47c88 EFLAGS: 00000246 ORIG_RAX:
00000000000001af
[  320.204984] RAX: ffffffffffffffda RBX: 0000557b66ff26f0 RCX: 00007fbd8a0782ce
[  320.212951] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
[  320.220917] RBP: 00007ffee3b47dd0 R08: 0000000000000000 R09: 0000000000000000
[  320.228876] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  320.236843] R13: 0000557b66ff3860 R14: 00007fbd8a1f9a60 R15: 0000557b66ff3928
[  320.244817]  </TASK>
[  320.247257] Modules linked in: scsi_debug null_blk platform_profile
dell_wmi dell_smbios dell_wmi_descriptor sparse_keymap iTCO_wdt rfkill
intel_rapl_msr video intel_pmc_bxt iTCO_vendor_support
intel_rapl_common dcdbas intel_uncore_frequency
intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass rapl intel_cstate
intel_uncore bnx2x mxm_wmi i40e mei_me mei mdio libie bna lpc_ich
libie_adminq ipmi_ssif ipmi_si acpi_power_meter acpi_ipmi ipmi_devintf
ipmi_msghandler fuse loop nfnetlink zram lz4hc_compress lz4_compress
nvme mgag200 polyval_clmulni nvme_core i2c_algo_bit
ghash_clmulni_intel nvme_keyring bfa nvme_auth megaraid_sas
scsi_transport_fc wmi i2c_dev [last unloaded: scsi_debug]
[  320.320131] ---[ end trace 0000000000000000 ]---
[  320.389848] RIP: 0010:btrfs_zoned_reserve_data_reloc_bg.cold+0xb2/0xb4
[  320.397161] Code: ab e8 7e ab f7 ff 0f 0b 41 b8 1b 0a 00 00 48 c7
c1 80 9f 59 ab 31 d2 48 c7 c6 20 b8 59 ab 48 c7 c7 20 a0 59 ab e8 5a
ab f7 ff <0f> 0b 41 b8 5f 0a 00 00 48 c7 c1 80 9f 59 ab 31 d2 48 c7 c6
00 b9
[  320.418138] RSP: 0018:ffffc9000c21f930 EFLAGS: 00010282
[  320.423987] RAX: 0000000000000047 RBX: ffff8888d1a54000 RCX: 0000000000000000
[  320.431967] RDX: 0000000000000047 RSI: 1ffffffff629cc84 RDI: fffff52001843f18
[  320.439947] RBP: ffff888121b7c000 R08: ffffffffa802cbb5 R09: fffff52001843edc
[  320.447924] R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
[  320.455903] R13: 0000000000000001 R14: ffff888121b7c128 R15: ffff88810f379800
[  320.463881] FS:  00007fbd89e98840(0000) GS:ffff8890af8e8000(0000)
knlGS:0000000000000000
[  320.472926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  320.479353] CR2: 0000559e0ad4b540 CR3: 00000008e14ce003 CR4: 00000000003726f0
[  320.487333] note: mount[1370] exited with preempt_count 1


-- 
Best Regards,
  Yi Zhang

