Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A028004F
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367131; cv=none; b=VDRv3wBOUT4ZQoHrGXRSJZpTMqrdOyrSl6+VHezzTeC3axuFc2g6p/EoE03HI6P1NaD9TS6ujS3+amFfcaDeb8zQE8nT07+kH5Fn+TYqNene/pp1L89Zwl4Mj72kGdS8fragHWBOe0lrA+NuLuAidm68h6xSKDqz+Ye1Nl6n3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367131; c=relaxed/simple;
	bh=NVf5YnfpX1aExmYddPSrcP0CEQbOclozgrFsUsFIefw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r/TO1JIbRItl3J6v0BpBv0slfVNZDGyNPR3TZp7G9z66tT85USMifqd+pkza7VHm4zRX4qlxl1mAX6qL+YzNyJXqBqaNWNc+d7/w4TX2RgdpNkJlOw0AOUta8hs6jWAUmWfGDsdeAVTKflJNqICpfBfQnlhDEOTTkGgodOBQa20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkl7t0s5bz4f3n5t
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 16:38:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 968B31A0199
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 16:38:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxARr01m6fdpNQ--.56612S3;
	Wed, 22 May 2024 16:38:43 +0800 (CST)
Subject: Re: [bug report] kernel panic with concurrent power on/off operation
 for null-blk
To: Li Nan <linan666@huaweicloud.com>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Ming Lei <ming.lei@redhat.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "houtao1@huawei.com" <houtao1@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com>
 <c96a0c6c-9fdf-e135-f269-e7e4f75eebfa@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7102a318-f43a-e5ef-bcc1-c4b597b46cdf@huaweicloud.com>
Date: Wed, 22 May 2024 16:38:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c96a0c6c-9fdf-e135-f269-e7e4f75eebfa@huaweicloud.com>
Content-Type: multipart/mixed;
 boundary="------------36A49B88F911AC9B2FE57AA6"
X-CM-TRANSID:cCh0CgDHlxARr01m6fdpNQ--.56612S3
X-Coremail-Antispam: 1UD129KBjvJXoW3tr15Cw1rKr4fGFWUXFWDArb_yoWDAr4kpr
	10vr13GrW8Jr18G3y5Xr4UGFZ8Ja17u3W7Gr1xXF1kXF1UXwnFq39ruF1jg3WDArWxWry2
	qr1DZw129FyUCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI0EjI02j7AqF2xKxwAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FcxC0VAYjxAxZF0Ex2IqxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJwCE64xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x0JUQTmhUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

This is a multi-part message in MIME format.
--------------36A49B88F911AC9B2FE57AA6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2024/05/22 16:23, Li Nan 写道:
> Hi, Yi Zhang
> 
> 在 2024/5/22 12:40, Yi Zhang 写道:
>> Hello
>> With Sagi's new blktests case scenario[1], I tried the concurrent
>> power on/off for null-blk[2] and found it will lead to kernel
>> panic[3],  please help check it and let me know if you need any
>> info/testing for it, thanks.
>> BTW, I will submit one blktests case for it later.
>>
>> [1] 
>> https://lore.kernel.org/linux-nvme/20240521085623.87681-1-sagi@grimberg.me/ 
>>
>>
>> [2]Reproducer:
>> nullb1="/sys/kernel/config/nullb/nullb1"
>> modprobe null-blk nr_devices=0
>> mkdir $nullb1
>> echo 1024 > $nullb1/size
>> echo 1 > $nullb1/memory_backed
>> null_blk_power_loop() {
>>         local iterations=10
>>         for ((i = 1; i <= ${iterations}; i++)); do
>>                 echo 0 > $nullb1/power
>>                 echo 1 > $nullb1/power
>>         done
>> }
>> null_blk_power_loop &
>> null_blk_power_loop &

I tried to fix this:

https://lore.kernel.org/all/20230610074618.2673673-1-yukuai1@huaweicloud.com/

Hi, Yi, can you give the attached patch a test? I just rebase it with
block/for-next branch.

Thanks,
Kuai

> 
> Concurrent creation and deletion of null_blk processes can lead to this
> issue. Consider the following scenario:
> 
> T1                T2
> echo 0 > power
>   null_del_dev
>    free nullb
>                  echo 1 > power
>                   null_add_dev
>                     dev->nullb = nullb
>                     ...
>    dev->nullb = NULL
> 
> T2 creates a new device and sets dev->nullb, but T1 sets dev->nullb to NULL
> later. after that, anyone trying to access dev->nullb will trigger NULL
> pointer dereference.
> 
> I will fix it soon. Thanks for your report.
> 
>> wait
>>
>> [3]
>> [ 1200.017939] null_blk: disk nullb1 created
>> [ 1200.043860] BUG: kernel NULL pointer dereference, address: 
>> 0000000000000130
>> [ 1200.051627] #PF: supervisor write access in kernel mode
>> [ 1200.057458] #PF: error_code(0x0002) - not-present page
>> [ 1200.063192] PGD 0 P4D 0
>> [ 1200.066021] Oops: 0002 [#1] PREEMPT SMP PTI
>> [ 1200.070691] CPU: 0 PID: 1724 Comm: sh Not tainted 
>> 6.9.0-64.eln136.x86_64 #1
>> [ 1200.078462] Hardware name: Dell Inc. PowerEdge R730xd/ɲ�Pow, BIOS
>> 2.19.0 12/12/2023
>> [ 1200.087105] RIP: 0010:_raw_spin_lock_irq+0x18/0x30
>> [ 1200.092459] Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>> 90 90 f3 0f 1e fa 0f 1f 44 00 00 fa 65 ff 05 47 28 26 7c 31 c0 ba 01
>> 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 46 01 00 00 90 c3
>> cc cc
>> [ 1200.113416] RSP: 0018:ffffb973431e7420 EFLAGS: 00010046
>> [ 1200.119249] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
>> 0000000000000008
>> [ 1200.127212] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
>> 0000000000000130
>> [ 1200.135175] RBP: 0000000000000008 R08: ffff9645c44e4400 R09: 
>> 0000000000000000
>> [ 1200.143140] R10: 0000000000000014 R11: 0000000000000000 R12: 
>> ffff964743a2d800
>> [ 1200.151103] R13: 0000000000000130 R14: ffff9645d05580f8 R15: 
>> 0000000000000001
>> [ 1200.159067] FS:  00007f67cea3b740(0000) GS:ffff964737a00000(0000)
>> knlGS:0000000000000000
>> [ 1200.168099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1200.174511] CR2: 0000000000000130 CR3: 00000002819c4001 CR4: 
>> 00000000001706f0
>> [ 1200.182473] Call Trace:
>> [ 1200.185200]  <TASK>
>> [ 1200.187541]  ? show_trace_log_lvl+0x1b0/0x2f0
>> [ 1200.192406]  ? show_trace_log_lvl+0x1b0/0x2f0
>> [ 1200.197272]  ? null_handle_rq+0x3f/0x500 [null_blk]
>> [ 1200.202735]  ? __die_body.cold+0x8/0x12
>> [ 1200.207008]  ? page_fault_oops+0x146/0x160
>> [ 1200.211583]  ? exc_page_fault+0x73/0x160
>> [ 1200.215963]  ? asm_exc_page_fault+0x26/0x30
>> [ 1200.220634]  ? _raw_spin_lock_irq+0x18/0x30
>> [ 1200.225303]  null_handle_rq+0x3f/0x500 [null_blk]
>> [ 1200.230567]  ? pcpu_alloc+0x369/0x900
>> [ 1200.234654]  ? lock_timer_base+0x76/0xa0
>> [ 1200.239035]  null_process_cmd+0xb4/0x100 [null_blk]
>> [ 1200.244490]  null_handle_cmd+0x36/0x130 [null_blk]
>> [ 1200.249849]  null_queue_rq+0x130/0x200 [null_blk]
>> [ 1200.255110]  ? __pfx_autoremove_wake_function+0x10/0x10
>> [ 1200.260948]  __blk_mq_issue_directly+0x4b/0xc0
>> [ 1200.265911]  blk_mq_try_issue_directly+0x88/0x110
>> [ 1200.271155]  blk_mq_submit_bio+0x596/0x690
>> [ 1200.275720]  submit_bio_noacct_nocheck+0x162/0x240
>> [ 1200.281071]  ? submit_bio_noacct+0x24/0x540
>> [ 1200.285740]  block_read_full_folio+0x1f8/0x300
>> [ 1200.290702]  ? __pfx_blkdev_get_block+0x10/0x10
>> [ 1200.295760]  ? __pfx_blkdev_read_folio+0x10/0x10
>> [ 1200.300913]  ? __pfx_blkdev_read_folio+0x10/0x10
>> [ 1200.306064]  filemap_read_folio+0x43/0xe0
>> [ 1200.310542]  ? __pfx_blkdev_read_folio+0x10/0x10
>> [ 1200.315693]  do_read_cache_folio+0x7c/0x190
>> [ 1200.320365]  read_part_sector+0x33/0xb0
>> [ 1200.324650]  read_lba+0xc1/0x180
>> [ 1200.328256]  find_valid_gpt.constprop.0+0xe1/0x520
>> [ 1200.333609]  efi_partition+0x7c/0x3a0
>> [ 1200.337699]  ? snprintf+0x53/0x70
>> [ 1200.341401]  ? __pfx_efi_partition+0x10/0x10
>> [ 1200.346170]  check_partition+0x101/0x1c0
>> [ 1200.350550]  bdev_disk_changed+0x193/0x330
>> [ 1200.355121]  ? security_file_alloc+0x61/0xf0
>> [ 1200.359889]  blkdev_get_whole+0x5f/0xa0
>> [ 1200.364170]  bdev_open+0x205/0x3c0
>> [ 1200.367966]  bdev_file_open_by_dev+0xbd/0x110
>> [ 1200.372829]  disk_scan_partitions+0x6e/0x100
>> [ 1200.377594]  device_add_disk+0x3bb/0x3c0
>> [ 1200.381972]  null_add_dev+0x479/0x650 [null_blk]
>> [ 1200.387139]  nullb_device_power_store+0x7c/0x120 [null_blk]
>> [ 1200.393370]  configfs_write_iter+0xbc/0x120
>> [ 1200.398042]  vfs_write+0x296/0x460
>> [ 1200.401841]  ksys_write+0x6d/0xf0
>> [ 1200.405543]  do_syscall_64+0x7e/0x160
>> [ 1200.409634]  ? syscall_exit_work+0xf3/0x120
>> [ 1200.414302]  ? syscall_exit_to_user_mode+0x71/0x1f0
>> [ 1200.419740]  ? do_syscall_64+0x8a/0x160
>> [ 1200.424019]  ? syscall_exit_work+0xf3/0x120
>> [ 1200.428686]  ? syscall_exit_to_user_mode+0x71/0x1f0
>> [ 1200.434131]  ? do_syscall_64+0x8a/0x160
>> [ 1200.438413]  ? syscall_exit_work+0xf3/0x120
>> [ 1200.443081]  ? syscall_exit_to_user_mode+0x71/0x1f0
>> [ 1200.448525]  ? do_syscall_64+0x8a/0x160
>> [ 1200.452807]  ? syscall_exit_work+0xf3/0x120
>> [ 1200.457475]  ? syscall_exit_to_user_mode+0x71/0x1f0
>> [ 1200.462921]  ? do_syscall_64+0x8a/0x160
>> [ 1200.467202]  ? syscall_exit_to_user_mode+0x71/0x1f0
>> [ 1200.472638]  ? do_syscall_64+0x8a/0x160
>> [ 1200.476918]  ? exc_page_fault+0x73/0x160
>> [ 1200.481296]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [ 1200.486933] RIP: 0033:0x7f67ce8fda57
>> [ 1200.490931] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
>> 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
>> 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
>> 74 24
>> [ 1200.511886] RSP: 002b:00007ffd30172638 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000001
>> [ 1200.520335] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
>> 00007f67ce8fda57
>> [ 1200.528297] RDX: 0000000000000002 RSI: 0000557fdb881c90 RDI: 
>> 0000000000000001
>> [ 1200.536258] RBP: 0000557fdb881c90 R08: 0000000000000000 R09: 
>> 00007f67ce9b14e0
>> [ 1200.544219] R10: 00007f67ce9b13e0 R11: 0000000000000246 R12: 
>> 0000000000000002
>> [ 1200.552181] R13: 00007f67ce9fb780 R14: 0000000000000002 R15: 
>> 00007f67ce9f69e0
>> [ 1200.560145]  </TASK>
>> [ 1200.562581] Modules linked in: null_blk sunrpc vfat fat
>> intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
>> intel_powerclamp coretemp dell_wmi_descriptor kvm_intel sparse_keymap
>> cdc_ether rfkill ipmi_ssif usbnet video kvm mei_me iTCO_wdt dcdbas mii
>> iTCO_vendor_support mei ipmi_si rapl mgag200 mxm_wmi pcspkr
>> intel_cstate ipmi_devintf acpi_power_meter ipmi_msghandler
>> intel_uncore i2c_algo_bit lpc_ich fuse xfs sd_mod sg nvme ahci libahci
>> crct10dif_pclmul crc32_pclmul crc32c_intel libata ghash_clmulni_intel
>> nvme_core tg3 megaraid_sas nvme_auth t10_pi wmi dm_mirror
>> dm_region_hash dm_log dm_mod [last unloaded: null_blk]
>> [ 1200.624314] CR2: 0000000000000130
>> [ 1200.628012] ---[ end trace 0000000000000000 ]---
>> [ 1200.688370] RIP: 0010:_raw_spin_lock_irq+0x18/0x30
>> [ 1200.693747] Code: 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>> 90 90 f3 0f 1e fa 0f 1f 44 00 00 fa 65 ff 05 47 28 26 7c 31 c0 ba 01
>> 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 46 01 00 00 90 c3
>> cc cc
>> [ 1200.714704] RSP: 0018:ffffb973431e7420 EFLAGS: 00010046
>> [ 1200.720535] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
>> 0000000000000008
>> [ 1200.728498] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
>> 0000000000000130
>> [ 1200.736461] RBP: 0000000000000008 R08: ffff9645c44e4400 R09: 
>> 0000000000000000
>> [ 1200.744423] R10: 0000000000000014 R11: 0000000000000000 R12: 
>> ffff964743a2d800
>> [ 1200.752384] R13: 0000000000000130 R14: ffff9645d05580f8 R15: 
>> 0000000000000001
>> [ 1200.760348] FS:  00007f67cea3b740(0000) GS:ffff964737a00000(0000)
>> knlGS:0000000000000000
>> [ 1200.769378] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1200.775789] CR2: 0000000000000130 CR3: 00000002819c4001 CR4: 
>> 00000000001706f0
>> [ 1200.783754] Kernel panic - not syncing: Fatal exception
>> [ 1200.789636] Kernel Offset: 0x2000000 from 0xffffffff81000000
>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [ 1200.856453] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> Best Regards,
>>    Yi Zhang
>>
>>
>> .
> 

--------------36A49B88F911AC9B2FE57AA6
Content-Type: text/plain; charset=UTF-8;
 name="0001-null_blk-fix-null-ptr-dereference-while-configuring-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-null_blk-fix-null-ptr-dereference-while-configuring-.pa";
 filename*1="tch"

RnJvbSBhYzM2NTQ0NDUyM2JiOGRjMTU0MDBmZDFkMzk1ZDQ4MzYzN2FjMjQ5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBZdSBLdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+CkRh
dGU6IFNhdCwgMTAgSnVuIDIwMjMgMTU6NDY6MTggKzA4MDAKU3ViamVjdDogW1BBVENIXSBu
dWxsX2JsazogZml4IG51bGwtcHRyLWRlcmVmZXJlbmNlIHdoaWxlIGNvbmZpZ3VyaW5nICdw
b3dlcicKIGFuZCAnc3VibWl0X3F1ZXVlcycKCldyaXRpbmcgJ3Bvd2VyJyBhbmQgJ3N1Ym1p
dF9xdWV1ZXMnIGNvbmN1cnJlbnRseSB3aWxsIHRyaWdnZXIga2VybmVsCnBhbmljOgoKVGVz
dCBzY3JpcHQ6Cgptb2Rwcm9iZSBudWxsX2JsayBucl9kZXZpY2VzPTAKbWtkaXIgLXAgL3N5
cy9rZXJuZWwvY29uZmlnL251bGxiL251bGxiMAp3aGlsZSB0cnVlOyBkbyBlY2hvIDEgPiBz
dWJtaXRfcXVldWVzOyBlY2hvIDQgPiBzdWJtaXRfcXVldWVzOyBkb25lICYKd2hpbGUgdHJ1
ZTsgZG8gZWNobyAxID4gcG93ZXI7IGVjaG8gMCA+IHBvd2VyOyBkb25lCgpUZXN0IHJlc3Vs
dDoKCkJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAw
MDAwMDAwMDAwMDE0OApPb3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAKUklQOiAwMDEwOl9f
bG9ja19hY3F1aXJlKzB4NDFkLzB4MjhmMApDYWxsIFRyYWNlOgogPFRBU0s+CiBsb2NrX2Fj
cXVpcmUrMHgxMjEvMHg0NTAKIGRvd25fd3JpdGUrMHg1Zi8weDFkMAogc2ltcGxlX3JlY3Vy
c2l2ZV9yZW1vdmFsKzB4MTJmLzB4NWMwCiBibGtfbXFfZGVidWdmc191bnJlZ2lzdGVyX2hj
dHhzKzB4N2MvMHgxMDAKIGJsa19tcV91cGRhdGVfbnJfaHdfcXVldWVzKzB4NGEzLzB4NzIw
CiBudWxsYl91cGRhdGVfbnJfaHdfcXVldWVzKzB4NzEvMHhmMCBbbnVsbF9ibGtdCiBudWxs
Yl9kZXZpY2Vfc3VibWl0X3F1ZXVlc19zdG9yZSsweDc5LzB4ZjAgW251bGxfYmxrXQogY29u
ZmlnZnNfd3JpdGVfaXRlcisweDExOS8weDFlMAogdmZzX3dyaXRlKzB4MzI2LzB4NzMwCiBr
c3lzX3dyaXRlKzB4NzQvMHgxNTAKClRoaXMgaXMgYmVjYXVzZSBkZWxfZ2VuZGlzaygpIGNh
biBjb25jdXJyZW50IHdpdGgKYmxrX21xX3VwZGF0ZV9ucl9od19xdWV1ZXMoKToKCm51bGxi
X2RldmljZV9wb3dlcl9zdG9yZQludWxsYl9hcHBseV9zdWJtaXRfcXVldWVzCiBudWxsX2Rl
bF9kZXYKIGRlbF9nZW5kaXNrCgkJCQkgbnVsbGJfdXBkYXRlX25yX2h3X3F1ZXVlcwoJCQkJ
ICBpZiAoIWRldi0+bnVsbGIpCgkJCQkgIC8vIHN0aWxsIHNldCB3aGlsZSBnZW5kaXNrIGlz
IGRlbGV0ZWQKCQkJCSAgIHJldHVybiAwCgkJCQkgIGJsa19tcV91cGRhdGVfbnJfaHdfcXVl
dWVzCiBkZXYtPm51bGxiID0gTlVMTAoKRml4IHRoaXMgcHJvYmxlbSBieSBzeW5jaHJvbml6
ZSBudWxsYl9kZXZpY2VfcG93ZXJfc3RvcmUoKSBhbmQKbnVsbGJfdXBkYXRlX25yX2h3X3F1
ZXVlcygpIHdpdGggYSBtdXRleC4KCkZpeGVzOiA0NTkxOWZiZmUxYzQgKCJudWxsX2Jsazog
RW5hYmxlIG1vZGlmeWluZyAnc3VibWl0X3F1ZXVlcycgYWZ0ZXIgYW4gaW5zdGFuY2UgaGFz
IGJlZW4gY29uZmlndXJlZCIpClNpZ25lZC1vZmYtYnk6IFl1IEt1YWkgPHl1a3VhaTNAaHVh
d2VpLmNvbT4KLS0tCiBkcml2ZXJzL2Jsb2NrL2xvb3AuYyAgICAgICAgICB8ICAyICstCiBk
cml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYyB8IDQwICsrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDE1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbG9vcC5jIGIvZHJp
dmVycy9ibG9jay9sb29wLmMKaW5kZXggMjhhOTVmZDM2NmZlLi4zZTFjNGY1ZWY3MTQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvYmxvY2svbG9vcC5jCisrKyBiL2RyaXZlcnMvYmxvY2svbG9v
cC5jCkBAIC0yMTQwLDcgKzIxNDAsNyBAQCBzdGF0aWMgaW50IGxvb3BfY29udHJvbF9yZW1v
dmUoaW50IGlkeCkKIAkJcHJfd2Fybl9vbmNlKCJkZWxldGluZyBhbiB1bnNwZWNpZmllZCBs
b29wIGRldmljZSBpcyBub3Qgc3VwcG9ydGVkLlxuIik7CiAJCXJldHVybiAtRUlOVkFMOwog
CX0KLQkJCisKIAkvKiBIaWRlIHRoaXMgbG9vcCBkZXZpY2UgZm9yIHNlcmlhbGl6YXRpb24u
ICovCiAJcmV0ID0gbXV0ZXhfbG9ja19raWxsYWJsZSgmbG9vcF9jdGxfbXV0ZXgpOwogCWlm
IChyZXQpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYyBiL2Ry
aXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jCmluZGV4IDVkNTZhZDRjZTAxYS4uZWIwMjNk
MjY3MzY5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYworKysg
Yi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYwpAQCAtNDEzLDEzICs0MTMsMjUgQEAg
c3RhdGljIGludCBudWxsYl91cGRhdGVfbnJfaHdfcXVldWVzKHN0cnVjdCBudWxsYl9kZXZp
Y2UgKmRldiwKIHN0YXRpYyBpbnQgbnVsbGJfYXBwbHlfc3VibWl0X3F1ZXVlcyhzdHJ1Y3Qg
bnVsbGJfZGV2aWNlICpkZXYsCiAJCQkJICAgICB1bnNpZ25lZCBpbnQgc3VibWl0X3F1ZXVl
cykKIHsKLQlyZXR1cm4gbnVsbGJfdXBkYXRlX25yX2h3X3F1ZXVlcyhkZXYsIHN1Ym1pdF9x
dWV1ZXMsIGRldi0+cG9sbF9xdWV1ZXMpOworCWludCByZXQ7CisKKwltdXRleF9sb2NrKCZs
b2NrKTsKKwlyZXQgPSBudWxsYl91cGRhdGVfbnJfaHdfcXVldWVzKGRldiwgc3VibWl0X3F1
ZXVlcywgZGV2LT5wb2xsX3F1ZXVlcyk7CisJbXV0ZXhfdW5sb2NrKCZsb2NrKTsKKworCXJl
dHVybiByZXQ7CiB9CiAKIHN0YXRpYyBpbnQgbnVsbGJfYXBwbHlfcG9sbF9xdWV1ZXMoc3Ry
dWN0IG51bGxiX2RldmljZSAqZGV2LAogCQkJCSAgIHVuc2lnbmVkIGludCBwb2xsX3F1ZXVl
cykKIHsKLQlyZXR1cm4gbnVsbGJfdXBkYXRlX25yX2h3X3F1ZXVlcyhkZXYsIGRldi0+c3Vi
bWl0X3F1ZXVlcywgcG9sbF9xdWV1ZXMpOworCWludCByZXQ7CisKKwltdXRleF9sb2NrKCZs
b2NrKTsKKwlyZXQgPSBudWxsYl91cGRhdGVfbnJfaHdfcXVldWVzKGRldiwgZGV2LT5zdWJt
aXRfcXVldWVzLCBwb2xsX3F1ZXVlcyk7CisJbXV0ZXhfdW5sb2NrKCZsb2NrKTsKKworCXJl
dHVybiByZXQ7CiB9CiAKIE5VTExCX0RFVklDRV9BVFRSKHNpemUsIHVsb25nLCBOVUxMKTsK
QEAgLTQ2OCwyOCArNDgwLDMxIEBAIHN0YXRpYyBzc2l6ZV90IG51bGxiX2RldmljZV9wb3dl
cl9zdG9yZShzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sCiAJaWYgKHJldCA8IDApCiAJCXJl
dHVybiByZXQ7CiAKKwlyZXQgPSBjb3VudDsKKwltdXRleF9sb2NrKCZsb2NrKTsKIAlpZiAo
IWRldi0+cG93ZXIgJiYgbmV3cCkgewogCQlpZiAodGVzdF9hbmRfc2V0X2JpdChOVUxMQl9E
RVZfRkxfVVAsICZkZXYtPmZsYWdzKSkKLQkJCXJldHVybiBjb3VudDsKKwkJCWdvdG8gb3V0
OworCiAJCXJldCA9IG51bGxfYWRkX2RldihkZXYpOwogCQlpZiAocmV0KSB7CiAJCQljbGVh
cl9iaXQoTlVMTEJfREVWX0ZMX1VQLCAmZGV2LT5mbGFncyk7Ci0JCQlyZXR1cm4gcmV0Owor
CQkJZ290byBvdXQ7CiAJCX0KIAogCQlzZXRfYml0KE5VTExCX0RFVl9GTF9DT05GSUdVUkVE
LCAmZGV2LT5mbGFncyk7CiAJCWRldi0+cG93ZXIgPSBuZXdwOwogCX0gZWxzZSBpZiAoZGV2
LT5wb3dlciAmJiAhbmV3cCkgewogCQlpZiAodGVzdF9hbmRfY2xlYXJfYml0KE5VTExCX0RF
Vl9GTF9VUCwgJmRldi0+ZmxhZ3MpKSB7Ci0JCQltdXRleF9sb2NrKCZsb2NrKTsKIAkJCWRl
di0+cG93ZXIgPSBuZXdwOwogCQkJbnVsbF9kZWxfZGV2KGRldi0+bnVsbGIpOwotCQkJbXV0
ZXhfdW5sb2NrKCZsb2NrKTsKIAkJfQogCQljbGVhcl9iaXQoTlVMTEJfREVWX0ZMX0NPTkZJ
R1VSRUQsICZkZXYtPmZsYWdzKTsKIAl9CiAKLQlyZXR1cm4gY291bnQ7CitvdXQ6CisJbXV0
ZXhfdW5sb2NrKCZsb2NrKTsKKwlyZXR1cm4gcmV0OwogfQogCiBDT05GSUdGU19BVFRSKG51
bGxiX2RldmljZV8sIHBvd2VyKTsKQEAgLTE5MzIsMTUgKzE5NDcsMTIgQEAgc3RhdGljIGlu
dCBudWxsX2FkZF9kZXYoc3RydWN0IG51bGxiX2RldmljZSAqZGV2KQogCW51bGxiLT5xLT5x
dWV1ZWRhdGEgPSBudWxsYjsKIAlibGtfcXVldWVfZmxhZ19zZXQoUVVFVUVfRkxBR19OT05S
T1QsIG51bGxiLT5xKTsKIAotCW11dGV4X2xvY2soJmxvY2spOwogCXJ2ID0gaWRhX2FsbG9j
KCZudWxsYl9pbmRleGVzLCBHRlBfS0VSTkVMKTsKLQlpZiAocnYgPCAwKSB7Ci0JCW11dGV4
X3VubG9jaygmbG9jayk7CisJaWYgKHJ2IDwgMCkKIAkJZ290byBvdXRfY2xlYW51cF9kaXNr
OwotCX0KKwogCW51bGxiLT5pbmRleCA9IHJ2OwogCWRldi0+aW5kZXggPSBydjsKLQltdXRl
eF91bmxvY2soJmxvY2spOwogCiAJaWYgKGNvbmZpZ19pdGVtX25hbWUoJmRldi0+Z3JvdXAu
Y2dfaXRlbSkpIHsKIAkJLyogVXNlIGNvbmZpZ2ZzIGRpciBuYW1lIGFzIHRoZSBkZXZpY2Ug
bmFtZSAqLwpAQCAtMTk2OSw5ICsxOTgxLDcgQEAgc3RhdGljIGludCBudWxsX2FkZF9kZXYo
c3RydWN0IG51bGxiX2RldmljZSAqZGV2KQogCWlmIChydikKIAkJZ290byBvdXRfaWRhX2Zy
ZWU7CiAKLQltdXRleF9sb2NrKCZsb2NrKTsKIAlsaXN0X2FkZF90YWlsKCZudWxsYi0+bGlz
dCwgJm51bGxiX2xpc3QpOwotCW11dGV4X3VubG9jaygmbG9jayk7CiAKIAlwcl9pbmZvKCJk
aXNrICVzIGNyZWF0ZWRcbiIsIG51bGxiLT5kaXNrX25hbWUpOwogCkBAIC0yMDIwLDcgKzIw
MzAsOSBAQCBzdGF0aWMgaW50IG51bGxfY3JlYXRlX2Rldih2b2lkKQogCWlmICghZGV2KQog
CQlyZXR1cm4gLUVOT01FTTsKIAorCW11dGV4X2xvY2soJmxvY2spOwogCXJldCA9IG51bGxf
YWRkX2RldihkZXYpOworCW11dGV4X3VubG9jaygmbG9jayk7CiAJaWYgKHJldCkgewogCQlu
dWxsX2ZyZWVfZGV2KGRldik7CiAJCXJldHVybiByZXQ7Ci0tIAoyLjM5LjIKCg==
--------------36A49B88F911AC9B2FE57AA6--

