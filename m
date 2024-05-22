Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D937FBDA
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366236; cv=none; b=gT9VwefIX5oXtncsFzvcWjnferkk37mIMKtuSFpZT0oxRedxA/xYq6GnRlAsmUKckayBtzwRzRZ3EFoKgs3gbyk76GLGQ5gg+/v4Hu5xNpAig0EBKWTnjPA26aLqdnU0ga7c1CxMGG8agOBucXhdfW65RxThO3OHQtZVUMy45c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366236; c=relaxed/simple;
	bh=++DXWDiMSQFt6RGChN0s7qjIdg7DcuKi8u5c+if9Pmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpgtXT4aldJD6/MXysmeSjEImXyKLGGgxGPtgElqG+m/F8b0HtLyYWYTAndyESiR4gvE6TsRuJJs1bXhikU4Z/QzvmRi+RqLX9t9lvlGguA0SvpGCjJfdXtlPv4sDOHckIXptSnOQW5NiPvIbMIJmcDCNTP7XvkSGe+sWbitCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkkpm16F7z4f3kKj
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 16:23:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EA83F1A0C32
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 16:23:49 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgDH6w6Qq01mOQa6Ng--.7633S3;
	Wed, 22 May 2024 16:23:48 +0800 (CST)
Message-ID: <c96a0c6c-9fdf-e135-f269-e7e4f75eebfa@huaweicloud.com>
Date: Wed, 22 May 2024 16:23:44 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bug report] kernel panic with concurrent power on/off operation
 for null-blk
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Ming Lei <ming.lei@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "houtao1@huawei.com" <houtao1@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDH6w6Qq01mOQa6Ng--.7633S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry8Cw17GFWrJF43tw4rAFb_yoWfCFykpF
	1jkr15Gw48Xr1UGrW3Z3yUGFs8Ja17uF17Gr1xJr1kXF48Xw1DJF9rGFWUJ3WDC3yxXry2
	q3WDXw1xKFyUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
	Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
	AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xF
	o4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	VOJ7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

Hi, Yi Zhang

在 2024/5/22 12:40, Yi Zhang 写道:
> Hello
> With Sagi's new blktests case scenario[1], I tried the concurrent
> power on/off for null-blk[2] and found it will lead to kernel
> panic[3],  please help check it and let me know if you need any
> info/testing for it, thanks.
> BTW, I will submit one blktests case for it later.
> 
> [1] https://lore.kernel.org/linux-nvme/20240521085623.87681-1-sagi@grimberg.me/
> 
> [2]Reproducer:
> nullb1="/sys/kernel/config/nullb/nullb1"
> modprobe null-blk nr_devices=0
> mkdir $nullb1
> echo 1024 > $nullb1/size
> echo 1 > $nullb1/memory_backed
> null_blk_power_loop() {
>         local iterations=10
>         for ((i = 1; i <= ${iterations}; i++)); do
>                 echo 0 > $nullb1/power
>                 echo 1 > $nullb1/power
>         done
> }
> null_blk_power_loop &
> null_blk_power_loop &

Concurrent creation and deletion of null_blk processes can lead to this
issue. Consider the following scenario:

T1				T2
echo 0 > power
  null_del_dev
   free nullb			
				echo 1 > power			
				 null_add_dev
  				  dev->nullb = nullb
				   ...
   dev->nullb = NULL

T2 creates a new device and sets dev->nullb, but T1 sets dev->nullb to NULL
later. after that, anyone trying to access dev->nullb will trigger NULL
pointer dereference.

I will fix it soon. Thanks for your report.

> wait
> 
> [3]
> [ 1200.017939] null_blk: disk nullb1 created
> [ 1200.043860] BUG: kernel NULL pointer dereference, address: 0000000000000130
> [ 1200.051627] #PF: supervisor write access in kernel mode
> [ 1200.057458] #PF: error_code(0x0002) - not-present page
> [ 1200.063192] PGD 0 P4D 0
> [ 1200.066021] Oops: 0002 [#1] PREEMPT SMP PTI
> [ 1200.070691] CPU: 0 PID: 1724 Comm: sh Not tainted 6.9.0-64.eln136.x86_64 #1
> [ 1200.078462] Hardware name: Dell Inc. PowerEdge R730xd/ɲ�Pow, BIOS
> 2.19.0 12/12/2023
> [ 1200.087105] RIP: 0010:_raw_spin_lock_irq+0x18/0x30
> [ 1200.092459] Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 f3 0f 1e fa 0f 1f 44 00 00 fa 65 ff 05 47 28 26 7c 31 c0 ba 01
> 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 46 01 00 00 90 c3
> cc cc
> [ 1200.113416] RSP: 0018:ffffb973431e7420 EFLAGS: 00010046
> [ 1200.119249] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000008
> [ 1200.127212] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000130
> [ 1200.135175] RBP: 0000000000000008 R08: ffff9645c44e4400 R09: 0000000000000000
> [ 1200.143140] R10: 0000000000000014 R11: 0000000000000000 R12: ffff964743a2d800
> [ 1200.151103] R13: 0000000000000130 R14: ffff9645d05580f8 R15: 0000000000000001
> [ 1200.159067] FS:  00007f67cea3b740(0000) GS:ffff964737a00000(0000)
> knlGS:0000000000000000
> [ 1200.168099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1200.174511] CR2: 0000000000000130 CR3: 00000002819c4001 CR4: 00000000001706f0
> [ 1200.182473] Call Trace:
> [ 1200.185200]  <TASK>
> [ 1200.187541]  ? show_trace_log_lvl+0x1b0/0x2f0
> [ 1200.192406]  ? show_trace_log_lvl+0x1b0/0x2f0
> [ 1200.197272]  ? null_handle_rq+0x3f/0x500 [null_blk]
> [ 1200.202735]  ? __die_body.cold+0x8/0x12
> [ 1200.207008]  ? page_fault_oops+0x146/0x160
> [ 1200.211583]  ? exc_page_fault+0x73/0x160
> [ 1200.215963]  ? asm_exc_page_fault+0x26/0x30
> [ 1200.220634]  ? _raw_spin_lock_irq+0x18/0x30
> [ 1200.225303]  null_handle_rq+0x3f/0x500 [null_blk]
> [ 1200.230567]  ? pcpu_alloc+0x369/0x900
> [ 1200.234654]  ? lock_timer_base+0x76/0xa0
> [ 1200.239035]  null_process_cmd+0xb4/0x100 [null_blk]
> [ 1200.244490]  null_handle_cmd+0x36/0x130 [null_blk]
> [ 1200.249849]  null_queue_rq+0x130/0x200 [null_blk]
> [ 1200.255110]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 1200.260948]  __blk_mq_issue_directly+0x4b/0xc0
> [ 1200.265911]  blk_mq_try_issue_directly+0x88/0x110
> [ 1200.271155]  blk_mq_submit_bio+0x596/0x690
> [ 1200.275720]  submit_bio_noacct_nocheck+0x162/0x240
> [ 1200.281071]  ? submit_bio_noacct+0x24/0x540
> [ 1200.285740]  block_read_full_folio+0x1f8/0x300
> [ 1200.290702]  ? __pfx_blkdev_get_block+0x10/0x10
> [ 1200.295760]  ? __pfx_blkdev_read_folio+0x10/0x10
> [ 1200.300913]  ? __pfx_blkdev_read_folio+0x10/0x10
> [ 1200.306064]  filemap_read_folio+0x43/0xe0
> [ 1200.310542]  ? __pfx_blkdev_read_folio+0x10/0x10
> [ 1200.315693]  do_read_cache_folio+0x7c/0x190
> [ 1200.320365]  read_part_sector+0x33/0xb0
> [ 1200.324650]  read_lba+0xc1/0x180
> [ 1200.328256]  find_valid_gpt.constprop.0+0xe1/0x520
> [ 1200.333609]  efi_partition+0x7c/0x3a0
> [ 1200.337699]  ? snprintf+0x53/0x70
> [ 1200.341401]  ? __pfx_efi_partition+0x10/0x10
> [ 1200.346170]  check_partition+0x101/0x1c0
> [ 1200.350550]  bdev_disk_changed+0x193/0x330
> [ 1200.355121]  ? security_file_alloc+0x61/0xf0
> [ 1200.359889]  blkdev_get_whole+0x5f/0xa0
> [ 1200.364170]  bdev_open+0x205/0x3c0
> [ 1200.367966]  bdev_file_open_by_dev+0xbd/0x110
> [ 1200.372829]  disk_scan_partitions+0x6e/0x100
> [ 1200.377594]  device_add_disk+0x3bb/0x3c0
> [ 1200.381972]  null_add_dev+0x479/0x650 [null_blk]
> [ 1200.387139]  nullb_device_power_store+0x7c/0x120 [null_blk]
> [ 1200.393370]  configfs_write_iter+0xbc/0x120
> [ 1200.398042]  vfs_write+0x296/0x460
> [ 1200.401841]  ksys_write+0x6d/0xf0
> [ 1200.405543]  do_syscall_64+0x7e/0x160
> [ 1200.409634]  ? syscall_exit_work+0xf3/0x120
> [ 1200.414302]  ? syscall_exit_to_user_mode+0x71/0x1f0
> [ 1200.419740]  ? do_syscall_64+0x8a/0x160
> [ 1200.424019]  ? syscall_exit_work+0xf3/0x120
> [ 1200.428686]  ? syscall_exit_to_user_mode+0x71/0x1f0
> [ 1200.434131]  ? do_syscall_64+0x8a/0x160
> [ 1200.438413]  ? syscall_exit_work+0xf3/0x120
> [ 1200.443081]  ? syscall_exit_to_user_mode+0x71/0x1f0
> [ 1200.448525]  ? do_syscall_64+0x8a/0x160
> [ 1200.452807]  ? syscall_exit_work+0xf3/0x120
> [ 1200.457475]  ? syscall_exit_to_user_mode+0x71/0x1f0
> [ 1200.462921]  ? do_syscall_64+0x8a/0x160
> [ 1200.467202]  ? syscall_exit_to_user_mode+0x71/0x1f0
> [ 1200.472638]  ? do_syscall_64+0x8a/0x160
> [ 1200.476918]  ? exc_page_fault+0x73/0x160
> [ 1200.481296]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1200.486933] RIP: 0033:0x7f67ce8fda57
> [ 1200.490931] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
> 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
> 74 24
> [ 1200.511886] RSP: 002b:00007ffd30172638 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 1200.520335] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f67ce8fda57
> [ 1200.528297] RDX: 0000000000000002 RSI: 0000557fdb881c90 RDI: 0000000000000001
> [ 1200.536258] RBP: 0000557fdb881c90 R08: 0000000000000000 R09: 00007f67ce9b14e0
> [ 1200.544219] R10: 00007f67ce9b13e0 R11: 0000000000000246 R12: 0000000000000002
> [ 1200.552181] R13: 00007f67ce9fb780 R14: 0000000000000002 R15: 00007f67ce9f69e0
> [ 1200.560145]  </TASK>
> [ 1200.562581] Modules linked in: null_blk sunrpc vfat fat
> intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp dell_wmi_descriptor kvm_intel sparse_keymap
> cdc_ether rfkill ipmi_ssif usbnet video kvm mei_me iTCO_wdt dcdbas mii
> iTCO_vendor_support mei ipmi_si rapl mgag200 mxm_wmi pcspkr
> intel_cstate ipmi_devintf acpi_power_meter ipmi_msghandler
> intel_uncore i2c_algo_bit lpc_ich fuse xfs sd_mod sg nvme ahci libahci
> crct10dif_pclmul crc32_pclmul crc32c_intel libata ghash_clmulni_intel
> nvme_core tg3 megaraid_sas nvme_auth t10_pi wmi dm_mirror
> dm_region_hash dm_log dm_mod [last unloaded: null_blk]
> [ 1200.624314] CR2: 0000000000000130
> [ 1200.628012] ---[ end trace 0000000000000000 ]---
> [ 1200.688370] RIP: 0010:_raw_spin_lock_irq+0x18/0x30
> [ 1200.693747] Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 f3 0f 1e fa 0f 1f 44 00 00 fa 65 ff 05 47 28 26 7c 31 c0 ba 01
> 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 46 01 00 00 90 c3
> cc cc
> [ 1200.714704] RSP: 0018:ffffb973431e7420 EFLAGS: 00010046
> [ 1200.720535] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000008
> [ 1200.728498] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000130
> [ 1200.736461] RBP: 0000000000000008 R08: ffff9645c44e4400 R09: 0000000000000000
> [ 1200.744423] R10: 0000000000000014 R11: 0000000000000000 R12: ffff964743a2d800
> [ 1200.752384] R13: 0000000000000130 R14: ffff9645d05580f8 R15: 0000000000000001
> [ 1200.760348] FS:  00007f67cea3b740(0000) GS:ffff964737a00000(0000)
> knlGS:0000000000000000
> [ 1200.769378] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1200.775789] CR2: 0000000000000130 CR3: 00000002819c4001 CR4: 00000000001706f0
> [ 1200.783754] Kernel panic - not syncing: Fatal exception
> [ 1200.789636] Kernel Offset: 0x2000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 1200.856453] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Best Regards,
>    Yi Zhang
> 
> 
> .

-- 
Thanks,
Nan

