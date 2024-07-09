Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06812C54B
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506090; cv=none; b=twyc2pJih3FKmkH+GPryVA3fR8cGbBX5ZABbEL9A6vQcVj/XmkRfc5z46mINQj+PKeCwxoDJz+mOuu6M1DQOUZCk9CVG5Be+4gHOipgqfIdlBfp67/QeNjbMq2HGVVnsyL7y0re42yBmke8NqmIsvs/Wmzd7QwXhQzDpOssJPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506090; c=relaxed/simple;
	bh=bxaqbwdyOCfIV3Vzbb25CEqJJEmpGnTqfpWYSWqsG/Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nOzeZZBfjGSPQjXOHF61QssNK9NZFK3bNpyE614YOEPhJEtg+Ssusi8n1DTDTbo9b9lwEtv8ExfM+4F0K8tbzt1PhqM5v7+MUAqwpO/WWcc9VdTsLr/ZyJbFGzoEEavB686HGEpQCMwlZkvlvq6xwiOGHV8ZGduO9cDgT5lJxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws2kQeL4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws2kQeL4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720506088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Keisktrw/o9uCdqCizNQvL5wZqByQ0c4OHzGjvxqJ1o=;
	b=Ws2kQeL4vd9yLytZ+1uTS1NDEFiClMswYbjAszbxsRta/qgJqK+o/MFlj3+QSkIVX1dY2g
	HzKoe1hiGEBA7nSO7UUViLDGrbEc4ST5688vsqFwYxwwjT3rPJ4LN/Dao3D3ytJKnShf9C
	bkwJjPSb59/rzoj29uNrKAXOxV45UPg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-Xu602jdDOIaqGVmNM_BRLQ-1; Tue, 09 Jul 2024 02:21:26 -0400
X-MC-Unique: Xu602jdDOIaqGVmNM_BRLQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70b0a02f2d1so3662125b3a.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2024 23:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506085; x=1721110885;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Keisktrw/o9uCdqCizNQvL5wZqByQ0c4OHzGjvxqJ1o=;
        b=fwxq6Gx5UHG2UwmmUrSiVoBK/GDjdw2t95VgIAicxMTknQHNpg9hORyEiIZFjt4AKH
         pk8g7eCEua2uIhksomHVwHVYu04fQC5gozj/kvOrzR2nkLtlNDCuoXs5J3R19EedjwMr
         zpjnJSKASwKIFYApdbho4r0o2xzo5zpROBJDhSnNyeXGxcxoZLzWy2ItuJY8CDPNQb/A
         ti3/zMZEqmURAnODkow1fUh4YROEjJxxE7rluc6+AdyenR00S18v6zms1qwrUtXLLHtE
         JEk1GMyQ3BYlmz3fTAqjRg9c7CfuNnx4eJKn2WXSBQUJLvzIZnXlo/+XjoWG3J1XQC9n
         Rsrw==
X-Gm-Message-State: AOJu0YyQ8yfVaMCEBsBFd3uDxlcnpmR8MtwoMuNkJFnVfV67lonvw4hF
	kRh1IXoewzB+1ZXQcmTQG3UDk6wgvzbtetu3DoksURQPh+zdYyse+gxcSsPyFE0ZXj/MtZT4NCO
	6r2V5zTsol8ruDwkQC+60kShJHE1h0E6RP9oB0C/X3RAREVEQnqARIurkMgM0NplRZoDeaXiY7d
	51o82TvgmDusUPyFy3c/VTr5NqZAm/7EyEybI=
X-Received: by 2002:a05:6a20:2a1a:b0:1be:b30d:3b37 with SMTP id adf61e73a8af0-1c29824d679mr1418832637.36.1720506085018;
        Mon, 08 Jul 2024 23:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiAes8TGKO7O/kkryurqwUE6DRHdyU9kzFGgeEOBJovlKfb4JT4BwuZyL8TU8hmsImehwctS62Vc2ncPCI1aY=
X-Received: by 2002:a05:6a20:2a1a:b0:1be:b30d:3b37 with SMTP id
 adf61e73a8af0-1c29824d679mr1418817637.36.1720506084593; Mon, 08 Jul 2024
 23:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 9 Jul 2024 14:21:12 +0800
Message-ID: <CAHj4cs9=iWKY8emDOtaX-jrh1p3XXpEabv8O4BuL_zgR-S0Vjw@mail.gmail.com>
Subject: [bug report] WARNING at block/blk-merge.c:607 __blk_rq_map_sg+0xf0/0x110
 and BUG at drivers/scsi/scsi_lib.c:1160! on linux-block/for-next
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello
blktests block/032 triggered the below issue on commit [1] during CKI
tests, please help check it, thanks.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git @ for-next
Commit Hash: 7f8851d381f71952787db6a1a71bef4d286f3df0
https://datawarehouse.cki-project.org/kcidb/checkouts/redhat:1364149314

[  416.295727] run blktests block/032 at 2024-07-08 06:21:48
[  416.359441] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  416.368491] scsi host48: scsi_debug: version 0191 [20210520]
[  416.368491]   dev_size_mb=300, opts=0x0, submit_queues=1, statistics=0
[  416.380875] scsi 48:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[  416.389131] scsi 48:0:0:0: Power-on or device reset occurred
[  416.398529] sd 48:0:0:0: Attached scsi generic sg1 type 0
[  416.404965] sd 48:0:0:0: [sdb] 614400 512-byte logical blocks: (315
MB/300 MiB)
[  416.413275] sd 48:0:0:0: [sdb] Write Protect is off
[  416.420165] sd 48:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  416.434793] sd 48:0:0:0: [sdb] permanent stream count = 5
[  416.443204] sd 48:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[  416.449460] sd 48:0:0:0: [sdb] Optimal transfer size 524288 bytes
[  416.492664] sd 48:0:0:0: [sdb] Attached SCSI disk
[  416.772750] ------------[ cut here ]------------
[  416.777361] WARNING: CPU: 99 PID: 17829 at block/blk-merge.c:607
__blk_rq_map_sg+0xf0/0x110
[  416.785705] Modules linked in: scsi_debug pktcdvd rfkill sunrpc
vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu igb ipmi_devintf arm_cmn
arm_dmc620_pmu ipmi_msghandler acpiphp_ampere_altra arm_dsu_pmu
cppc_cpufreq acpi_tad loop fuse nfnetlink zram xfs crct10dif_ce
polyval_ce polyval_generic ghash_ce sbsa_gwdt ast onboard_usb_dev
i2c_algo_bit xgene_hwmon [last unloaded: null_blk]
[  416.818633] CPU: 99 PID: 17829 Comm: mkfs.xfs Not tainted 6.10.0-rc6 #1
[  416.825234] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
F31n (SCP: 2.10.20220810) 09/30/2022
[  416.834526] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  416.841475] pc : __blk_rq_map_sg+0xf0/0x110
[  416.845646] lr : __blk_rq_map_sg+0x34/0x110
[  416.849817] sp : ffff8000874eb2e0
[  416.853118] x29: ffff8000874eb2e0 x28: ffff07ffee061a00 x27: ffff07ffedb16c00
[  416.860241] x26: ffff07ffec440000 x25: 0000000000000008 x24: 0000000000000000
[  416.867364] x23: ffff080087b260d8 x22: ffff07ffec440000 x21: 0000000000000002
[  416.874488] x20: ffff8000874eb330 x19: ffff080087b25f00 x18: ffffb5fd2a5a1538
[  416.881610] x17: 0000000000000400 x16: fffffe1fbeead042 x15: 0000000000000c00
[  416.888733] x14: 0000000000000fff x13: ffffb5fd2a5a1000 x12: 0000000000000004
[  416.895855] x11: 0000000000000000 x10: 0000000000000c00 x9 : 0000000000001000
[  416.902978] x8 : ffff080087b2617c x7 : 0000000000000c00 x6 : 0000000000000000
[  416.910100] x5 : 0000000000001000 x4 : 0000000000000001 x3 : ffff8000874eb330
[  416.917223] x2 : 0000000000002302 x1 : 0000000000000002 x0 : 0000000000000004
[  416.924345] Call trace:
[  416.926779]  __blk_rq_map_sg+0xf0/0x110
[  416.930603]  scsi_alloc_sgtables+0x90/0x350
[  416.934775]  sd_setup_read_write_cmnd+0x98/0x660
[  416.939381]  sd_init_command+0x84/0x4f0
[  416.943205]  scsi_prepare_cmd+0x134/0x1d0
[  416.947202]  scsi_queue_rq+0x3d0/0x4a0
[  416.950938]  blk_mq_dispatch_rq_list+0x118/0x500
[  416.955543]  __blk_mq_do_dispatch_sched+0x330/0x350
[  416.960408]  __blk_mq_sched_dispatch_requests+0x170/0x1c0
[  416.965795]  blk_mq_sched_dispatch_requests+0x34/0x80
[  416.970834]  blk_mq_run_hw_queue+0x1ac/0x1d0
[  416.975091]  blk_mq_dispatch_plug_list+0x164/0x2c8
[  416.979869]  blk_mq_flush_plug_list.part.0+0x44/0x178
[  416.984907]  blk_mq_flush_plug_list+0x24/0x40
[  416.989251]  __blk_flush_plug+0x110/0x180
[  416.993248]  __submit_bio+0x1b0/0x230
[  416.996897]  submit_bio_noacct_nocheck+0x144/0x268
[  417.001675]  submit_bio_noacct+0x144/0x5e8
[  417.005758]  submit_bio+0xc0/0x250
[  417.009147]  submit_bio_wait+0x5c/0xb0
[  417.012884]  __blkdev_direct_IO_simple+0x10c/0x238
[  417.017662]  blkdev_direct_IO+0x144/0x188
[  417.021659]  blkdev_write_iter+0x1d0/0x2a8
[  417.025743]  vfs_write+0x24c/0x380
[  417.029134]  ksys_pwrite64+0x84/0xd0
[  417.032696]  __arm64_sys_pwrite64+0x28/0x40
[  417.036866]  invoke_syscall+0x74/0x100
[  417.040604]  el0_svc_common.constprop.0+0xc8/0xf0
[  417.045294]  do_el0_svc+0x24/0x38
[  417.048596]  el0_svc+0x3c/0x158
[  417.051726]  el0t_64_sync_handler+0x120/0x138
[  417.056071]  el0t_64_sync+0x194/0x198
[  417.059720] ---[ end trace 0000000000000000 ]---
[  417.064350] ------------[ cut here ]------------
[  417.068954] kernel BUG at drivers/scsi/scsi_lib.c:1160!
[  417.074167] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[  417.080248] Modules linked in: scsi_debug pktcdvd rfkill sunrpc
vfat fat acpi_ipmi ipmi_ssif arm_spe_pmu igb ipmi_devintf arm_cmn
arm_dmc620_pmu ipmi_msghandler acpiphp_ampere_altra arm_dsu_pmu
cppc_cpufreq acpi_tad loop fuse nfnetlink zram xfs crct10dif_ce
polyval_ce polyval_generic ghash_ce sbsa_gwdt ast onboard_usb_dev
i2c_algo_bit xgene_hwmon [last unloaded: null_blk]
[  417.113166] CPU: 99 PID: 17829 Comm: mkfs.xfs Tainted: G        W
       6.10.0-rc6 #1
[  417.121243] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
F31n (SCP: 2.10.20220810) 09/30/2022
[  417.130534] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  417.137483] pc : scsi_alloc_sgtables+0x310/0x350
[  417.142088] lr : scsi_alloc_sgtables+0x90/0x350
[  417.146605] sp : ffff8000874eb320
[  417.149907] x29: ffff8000874eb340 x28: ffff07ffee061a00 x27: ffff07ffedb16c00
[  417.157030] x26: ffff07ffec440000 x25: 0000000000000008 x24: 0000000000000000
[  417.164152] x23: ffff080087b260d8 x22: ffff07ffec440000 x21: 0000000000000004
[  417.171274] x20: ffff080087b25f00 x19: ffff080087b26010 x18: ffffb5fd2a5a1538
[  417.178397] x17: 0000000000000400 x16: fffffe1fbeead042 x15: 0000000000000c00
[  417.185519] x14: 0000000000000fff x13: ffffb5fd2a5a1000 x12: 0000000000000004
[  417.192641] x11: 0000000000000000 x10: 0000000000000c00 x9 : 0000000000001000
[  417.199764] x8 : ffff080087b2617c x7 : 0000000000000c00 x6 : 0000000000000000
[  417.206888] x5 : 0000000000001000 x4 : 0000000000000001 x3 : ffff8000874eb330
[  417.214010] x2 : 0000000000002302 x1 : 0000000000000000 x0 : 0000000000000002
[  417.221133] Call trace:
[  417.223566]  scsi_alloc_sgtables+0x310/0x350
[  417.227823]  sd_setup_read_write_cmnd+0x98/0x660
[  417.232428]  sd_init_command+0x84/0x4f0
[  417.236252]  scsi_prepare_cmd+0x134/0x1d0
[  417.240249]  scsi_queue_rq+0x3d0/0x4a0
[  417.243985]  blk_mq_dispatch_rq_list+0x118/0x500
[  417.248590]  __blk_mq_do_dispatch_sched+0x330/0x350
[  417.253455]  __blk_mq_sched_dispatch_requests+0x170/0x1c0
[  417.258841]  blk_mq_sched_dispatch_requests+0x34/0x80
[  417.263880]  blk_mq_run_hw_queue+0x1ac/0x1d0
[  417.268137]  blk_mq_dispatch_plug_list+0x164/0x2c8
[  417.272915]  blk_mq_flush_plug_list.part.0+0x44/0x178
[  417.277953]  blk_mq_flush_plug_list+0x24/0x40
[  417.282298]  __blk_flush_plug+0x110/0x180
[  417.286294]  __submit_bio+0x1b0/0x230
[  417.289943]  submit_bio_noacct_nocheck+0x144/0x268
[  417.294721]  submit_bio_noacct+0x144/0x5e8
[  417.298805]  submit_bio+0xc0/0x250
[  417.302193]  submit_bio_wait+0x5c/0xb0
[  417.305930]  __blkdev_direct_IO_simple+0x10c/0x238
[  417.310708]  blkdev_direct_IO+0x144/0x188
[  417.314705]  blkdev_write_iter+0x1d0/0x2a8
[  417.318788]  vfs_write+0x24c/0x380
[  417.322178]  ksys_pwrite64+0x84/0xd0
[  417.325740]  __arm64_sys_pwrite64+0x28/0x40
[  417.329910]  invoke_syscall+0x74/0x100
[  417.333646]  el0_svc_common.constprop.0+0xc8/0xf0
[  417.338337]  do_el0_svc+0x24/0x38
[  417.341639]  el0_svc+0x3c/0x158
[  417.344768]  el0t_64_sync_handler+0x120/0x138
[  417.349112]  el0t_64_sync+0x194/0x198
[  417.352762] Code: 52800156 17ffff87 52800136 17ffff85 (d4210000)
[  417.358843] ---[ end trace 0000000000000000 ]---
[  417.363447] Kernel panic - not syncing: Oops - BUG: Fatal exception
[  417.369700] SMP: stopping secondary CPUs
[  417.373935] Kernel Offset: 0x35fca88f0000 from 0xffff800080000000
[  417.380015] PHYS_OFFSET: 0x80000000
[  417.383490] CPU features: 0x00,0000010b,80140528,4241720b
[  417.388875] Memory Limit: none
[  417.391917] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal
exception ]---




-- 
Best Regards,
  Yi Zhang

