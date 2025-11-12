Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47E3093C0
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945416; cv=none; b=Q2qPJMGqs2+MAdCv6oLPRbQdtNTCkuoX4/x5NPhJRN0h5JkuqU51Yk3ybOGJO9/XGjP1H0xj9ZTqCZCRoFHvNM/y88ts7jR7XPfCXC8VIVV+lgngWfMqlrG1wICozbL2yogsjsxem1ohFKeiAjOrxVXL9B7azIvpgt23JPBnVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945416; c=relaxed/simple;
	bh=ebTeNFOw+VWD6uxCQxu5kbvUaiYWmEYDJ+VFR5eJHsk=;
	h=To:Mime-Version:In-Reply-To:Message-Id:Subject:Date:References:
	 Content-Type:From; b=XsZZFpAyZaGkrh/8ZKD9IRXuCvDILQ+XbpEXUptDgXXnqJqE2m74nrqPOTYP3zUVyZX59zkw3T9/JFuhc9vbO/Cx5oFZ/JBwDmuleX0juDMMkCfSvylgI3SdkoJQnC+9wH1LkVur1OaZsf7DfdDppylWbdOfWb/iz0zlmNCHSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Ri40OtpM; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Ri40OtpM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762945406;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=0CjZ7yKPIx7RWMpuY806pSNw5rEDvV0Lmbzi1GPLH+Q=;
 b=Ri40OtpMNdU9MhY9MWu1K5/7kLyvUYYxZ0hVDgJkIsX4ItjS9LXDPRwFIVYGa0rkXBN/0F
 R6D7AjapBvTg5V9m1d2ftivjjB/LM6Xt3F0pwbytnx3z4k0lbNW2kXcGn2SnXYuHejpKz/
 BjxlKaE8lOTJ44BeoaifwJkLNsTlYSGEbs/lysFJywPeOCXLJHiJ+Lu3HIrIFT/s6djswA
 n1hOrRSTi8aJ3RvjILPA7tosXocqgZ7vdATrc4tBotD5rMjSO5WA9c/B8OrVcQN3nbfBWv
 j24IOlD9iONLMuv1J5AyQdaD1NDAfEaiWVEc0ukSxkGwaOOQ38ufwhLyKHuxvA==
To: "Changhui Zhong" <czhong@redhat.com>, 
	"Linux Block Devices" <linux-block@vger.kernel.org>, 
	"Li Nan" <linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <CAGVVp+VqVnvGeneUoTbYvBv2cw6GwQRrR3B-iQ-_9rVfyumoKA@mail.gmail.com>
Organization: fnnas
X-Lms-Return-Path: <lba+26914697d+587de9+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
Message-Id: <163bdaef-4d94-498e-af00-40d4000af7a2@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Wed, 12 Nov 2025 19:03:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000050
Date: Wed, 12 Nov 2025 19:03:22 +0800
References: <CAGVVp+VqVnvGeneUoTbYvBv2cw6GwQRrR3B-iQ-_9rVfyumoKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
From: "Yu Kuai" <yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>

+CC Li Nan

=E5=9C=A8 2025/11/12 17:02, Changhui Zhong =E5=86=99=E9=81=93:
> the following kernel panic was triggered,
> please help check and let me know if you need any info/test, thanks.
>
> repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/
> branch: for-next
> INFO: HEAD of cloned kernel
> commit 9d5d227cc571e4dde525aa4fa00bb049c436a9b9
> Merge: 6e2eeb8123bc 6d7e3870af11
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Nov 11 08:39:32 2025 -0700
>
>      Merge branch 'for-6.19/block' into for-next
>
>      * for-6.19/block:
>        blk-mq-dma: fix kernel-doc function name for integrity DMA iterato=
r
>
> reproducer:
> # cat repro.sh
> #!/bin/bash
>
> for i in {0..3};do
>          dd if=3D/dev/zero bs=3D1M count=3D2000 of=3Dfile$i.img
>          sleep 1
>          device=3D$(losetup -fP --show file$i.img)
>          devices+=3D" $device"
>          eval "dev$i=3D$device"
>          sleep 1
>          mkfs -t xfs -f $device
> done
>
> echo "dev list: $dev0 ,$dev1 ,$dev2 ,$dev3"
> pvcreate -y $devices
> vgcreate  black_bird $devices
>
> lvcreate --type raid0 --stripesize 64k -i 3 \
>          -n non_synced_primary_raid_3legs_1 -L 1G \
>          black_bird $dev0:0-300 $dev1:0-300 \
>          $dev2:0-300 $dev3:0-300
>
>
> dmesg log:
> [  375.341923] BUG: kernel NULL pointer dereference, address: 00000000000=
00050
> [  375.349711] #PF: supervisor read access in kernel mode
> [  375.355450] #PF: error_code(0x0000) - not-present page
> [  375.361178] PGD 1366f3067 P4D 0
> [  375.364783] Oops: Oops: 0000 [#1] SMP NOPTI
> [  375.369454] CPU: 15 UID: 0 PID: 9991 Comm: lvcreate Kdump: loaded
> Tainted: G S                  6.18.0-rc5+ #1 PREEMPT(voluntary)
> [  375.382561] Tainted: [S]=3DCPU_OUT_OF_SPEC
> [  375.386938] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
> BIOS AFE118M-1.32 06/29/2022
> [  375.396647] RIP: 0010:create_strip_zones+0x3c/0x7d0 [raid0]
> [  375.402872] Code: 49 89 fc 55 53 48 89 f3 48 83 ec 48 48 8b 3d 63
> 86 2a f3 48 89 74 24 38 be c0 0d 00 00 e8 9c c5 f9 f1 49 89 c6 49 8b
> 44 24 78 <48> 8b 40 50 8b a8 b0 00 00 00 48 c7 03 f4 ff ff ff 4d 85 f6
> 0f 84
> [  375.423830] RSP: 0018:ff6856f988a0fa10 EFLAGS: 00010246
> [  375.429655] RAX: 0000000000000000 RBX: ff6856f988a0fa90 RCX: 000000000=
0000000
> [  375.437620] RDX: 0000000000000000 RSI: ffffffffc14cc7f4 RDI: ff20815ae=
89bdc60
> [  375.445586] RBP: ffffffffc16407c5 R08: 0000000000000020 R09: 000000000=
0000000
> [  375.453552] R10: ff6856f988a0fa10 R11: fefefefefefefeff R12: ff20815af=
4df6058
> [  375.461516] R13: ffffffffc160b0c0 R14: ff20815ae89bdc40 R15: 000000000=
0000000
> [  375.469480] FS:  00007f4bf7188940(0000) GS:ff20815e3a471000(0000)
> knlGS:0000000000000000
> [  375.478514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  375.484926] CR2: 0000000000000050 CR3: 0000000128c76004 CR4: 000000000=
0773ef0
> [  375.492892] PKRU: 55555554
> [  375.495912] Call Trace:
> [  375.498641]  <TASK>
> [  375.500986]  raid0_run+0x10d/0x150 [raid0]
> [  375.505559]  md_run+0x2bb/0x790
> [  375.509068]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  375.514906]  raid_ctr+0x492/0xcdb [dm_raid]
> [  375.519579]  dm_table_add_target+0x193/0x3c0 [dm_mod]
> [  375.525240]  populate_table+0x9a/0xd0 [dm_mod]
> [  375.530214]  ? __pfx_table_load+0x10/0x10 [dm_mod]
> [  375.535571]  table_load+0xc9/0x230 [dm_mod]
> [  375.540250]  ctl_ioctl+0x1a0/0x300 [dm_mod]
> [  375.544933]  dm_ctl_ioctl+0xe/0x20 [dm_mod]
> [  375.549612]  __x64_sys_ioctl+0x96/0xe0
> [  375.553800]  ? syscall_trace_enter+0xfe/0x1a0
> [  375.558664]  do_syscall_64+0x7f/0x810
> [  375.562757]  ? __rseq_handle_notify_resume+0x35/0x60
> [  375.568301]  ? arch_exit_to_user_mode_prepare.isra.0+0xa2/0xd0
> [  375.574816]  ? do_syscall_64+0xb1/0x810
> [  375.579100]  ? clear_bhb_loop+0x30/0x80
> [  375.583382]  ? clear_bhb_loop+0x30/0x80
> [  375.587665]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  375.593303] RIP: 0033:0x7f4bf74464bf

Looks like this is related to the raid0 changes recently.

Nan, do you have time to take a look?

Thanks,
Kuai

> [  375.597294] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28
> 00 00
> [  375.618244] RSP: 002b:00007ffef26ed6d0 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  375.626695] RAX: ffffffffffffffda RBX: 00005583edb4f810 RCX: 00007f4bf=
74464bf
> [  375.634660] RDX: 00005583edb4f8f0 RSI: 00000000c138fd09 RDI: 000000000=
0000003
> [  375.642625] RBP: 00007ffef26ed8b0 R08: 00005583eadfbbb8 R09: 00007ffef=
26ed580
> [  375.650588] R10: 0000000000000007 R11: 0000000000000246 R12: 00005583e=
ad95d8c
> [  375.658553] R13: 00005583edb4f9a0 R14: 00005583ead95d8c R15: 000000000=
0000020
> [  375.666517]  </TASK>
> [  375.668955] Modules linked in: raid0 dm_raid raid456
> async_raid6_recov async_memcpy async_pq async_xor xor async_tx
> raid6_pq tls rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd
> grace nfs_localio netfs rfkill intel_rapl_msr intel_rapl_common
> intel_uncore_frequency intel_uncore_frequency_common i10nm_edac
> skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp
> coretemp kvm_intel kvm ipmi_ssif irqbypass rapl intel_cstate cdc_ether
> iTCO_wdt usbnet mgag200 dax_hmem iTCO_vendor_support cxl_acpi cxl_port
> cxl_core mii isst_if_mmio intel_uncore i2c_i801 isst_if_mbox_pci
> i2c_algo_bit mei_me intel_th_gth ioatdma einj pcspkr i2c_smbus
> isst_if_common intel_th_pci intel_pch_thermal mei intel_vsec intel_th
> dca ipmi_si acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler
> acpi_pad sg fuse loop xfs sd_mod ahci libahci libata
> ghash_clmulni_intel tg3 wmi sunrpc dm_mirror dm_region_hash dm_log
> dm_multipath dm_mod nfnetlink
>
>
> Best Regards,
> Changhui
>
>
