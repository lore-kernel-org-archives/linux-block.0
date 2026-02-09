Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5230C36D
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770615725; cv=none; b=XVoZ+zW9VMu6awkwWRXwg66U96lAxqZRbaQHgbhAlT5ovR7S10Y2fyMdKbbg4eE+WFix1Ok+KgrM+VUjmmpg4+9W2ZBuSeRKr9BZwopZnDPykiELyXm+YjYcLAZcqeT837Zm5+ueRYcRHCCgy27TcrfpEtvxeJ/k2x49foWjFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770615725; c=relaxed/simple;
	bh=yDiD/GteKJawWw6L+Ox9M26v2z6d7ilCdYDNwF1LJc4=;
	h=From:Mime-Version:Cc:Subject:References:To:In-Reply-To:Date:
	 Message-Id:Content-Type; b=M9S7B4+Riv3EsyhS3CvTBCwGudOL0UL2Wff3+3N43EhuukXuRLkNjXBArkpRDbnKJdTZLYoNZzgO2SlolMew+cjMaDS0cE8D6rOosgWUvR2Y4lAoHRHUNh3eNH/LXn7oXjxBEQUQz6tkw6QwkzIJcmToYMJC7WL0sHg1JLEhTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=h7TdKoHt; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="h7TdKoHt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770615706;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=EwpT9+shb7SWYR1ITbx642pMm1pREtGm9z1LX2fvQPU=;
 b=h7TdKoHtsLzYZJWmWzxexq26/ok10pGULF0x+DCETp0foaugkVM1WIV7BAdzk48aXX5jMw
 QyXhAZ0yBIw4xhBkXYRGczqpsjpKUVSSm4am9o9DS922nQKdZUhvc1djdrZ3xUicGh0Q+o
 BN5+apBj2/lCGAPK9k8PvFqF7GZ3C/DjnndIW1SMXZtENuH2FGmgQ0HgyEchpb5zbWn+Pf
 I/kOtD6pAqR0wJfo2GapXJ4Mo2hhMR1gd9FMMF32igMBWXHd3s3RuanfH+BRQNwJs6rrYR
 lAiE1fEUv5/SAS+6rDrLJeheE0+GPT01wMn76d9FNXR6Npf0fu4leyZy6hiljQ==
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Mon, 09 Feb 2026 13:41:43 +0800
Reply-To: yukuai@fnnas.com
Cc: "linux-block" <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Ming Lei" <ming.lei@redhat.com>, "Jens Axboe" <axboe@kernel.dk>
Subject: Re: [bug report] WARNING: block/blk-mq-debugfs.c:620 at debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
Content-Language: en-US
References: <CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com> <aYWQR7CtYdk3K39g@shinmob>
To: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, 
	"Yi Zhang" <yi.zhang@redhat.com>
In-Reply-To: <aYWQR7CtYdk3K39g@shinmob>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+269897398+05bbf8+vger.kernel.org+yukuai@fnnas.com>
Date: Mon, 9 Feb 2026 13:41:41 +0800
Message-Id: <c7d588b5-c680-4c31-8d17-94ce8fc443fb@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2026/2/6 15:25, Shinichiro Kawasaki =E5=86=99=E9=81=93:
> On Feb 03, 2026 / 20:28, Yi Zhang wrote:
>> Hello
>>
>> CKI reported the following failure today. Seems it was introduced from
>> the recently blk-mq-debugfs update, please help check and let me know
>> if you need any testing/info.
>>
>> Reproducer: blktests nvme/tcp nvme/005
>> Commit message: Merge branch 'for-7.0/block' into for-next
>>
>> dmesg:
>> [  951.319384] run blktests nvme/005 at 2026-02-02 17:59:35
>> [  951.346116] loop0: detected capacity change from 0 to 2097152
>> [  951.356428] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [  951.370823] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>> [  951.397438] nvmet: Created nvm controller 1 for subsystem
>> blktests-subsystem-1 for NQN
>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>> [  951.412081] nvme nvme0: creating 128 I/O queues.
>> [  951.425914] nvme nvme0: mapped 128/0/0 default/read/poll queues.
>> [  951.467027] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
>> 127.0.0.1:4420, hostnqn:
>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
>> [  951.784608] nvmet: Created nvm controller 2 for subsystem
>> blktests-subsystem-1 for NQN
>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>> [  951.798920] nvme nvme0: creating 128 I/O queues.
>> [  951.871600] nvme nvme0: mapped 128/0/0 default/read/poll queues.
>> [  951.880680] ------------[ cut here ]------------
>> [  951.885309] WARNING: block/blk-mq-debugfs.c:620 at
>> debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
> FYI, I also observe this WARN at debugfs_create_files() using the blktest=
s test
> case zbd/012. When I repeat zbd/012 several times on the kernel with the =
tag
> next-20260204, the WARN below is reported:

Thanks for the test, although queue is unfrozen before debugfs_create_files=
() from
switching elevator, however, it's still possible queue can be frozen from o=
ther
context concurrently.

This warning is not false positive, however, we'll have to fix nvme cases f=
irst
before we can fix this.

>
> [ 1304.543824] [  T12755] ------------[ cut here ]------------
> [ 1304.545792] [  T12755] WARNING: block/blk-mq-debugfs.c:620 at debugfs_=
create_files+0x247/0x2c0, CPU#2: check/12755
> [ 1304.547377] [  T12755] Modules linked in: scsi_debug null_blk nft_fib_=
inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_re=
ject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv=
6 nf_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet pcspkr netfs i2c_=
piix4 i2c_smbus loop fuse dm_multipath nfnetlink vsock_loopback vmw_vsock_v=
irtio_transport_common zram vsock xfs bochs drm_client_lib drm_shmem_helper=
 drm_kms_helper nvme drm nvme_core floppy sym53c8xx nvme_keyring e1000 scsi=
_transport_spi nvme_auth hkdf serio_raw ata_generic pata_acpi i2c_dev qemu_=
fw_cfg [last unloaded: scsi_debug]
> [ 1304.554851] [  T12755] CPU: 2 UID: 0 PID: 12755 Comm: check Not tainte=
d 6.19.0-rc8-next-20260204 #383 PREEMPT(full)
> [ 1304.556421] [  T12755] Hardware name: QEMU Standard PC (i440FX + PIIX,=
 1996), BIOS 1.16.3-4.fc42 04/01/2014
> [ 1304.557886] [  T12755] RIP: 0010:debugfs_create_files+0x247/0x2c0
> [ 1304.559074] [  T12755] Code: ff e8 1d b0 83 01 83 f8 01 0f 85 67 fe ff=
 ff 0f 0b e9 60 fe ff ff 0f 0b e9 59 fe ff ff 48 89 ef e8 2e 59 69 ff e9 07=
 fe ff ff <0f> 0b e9 6e ff ff ff e8 fd 58 69 ff e9 9a fe ff ff 48 89 df e8 =
30
> [ 1304.562112] [  T12755] RSP: 0018:ffff888147b77530 EFLAGS: 00010202
> [ 1304.563343] [  T12755] RAX: 0000000000000000 RBX: ffffffffaa567360 RCX=
: 0000000000000001
> [ 1304.564728] [  T12755] RDX: 0000000000000001 RSI: ffffffffaae6910d RDI=
: ffff888130361a48
> [ 1304.566104] [  T12755] RBP: ffffffffabe49734 R08: 0000000000000001 R09=
: ffffed1022804075
> [ 1304.567487] [  T12755] R10: 0000000000000002 R11: ffff88812610c390 R12=
: ffff8881140202f0
> [ 1304.568850] [  T12755] R13: ffff888130361310 R14: ffff888130361310 R15=
: ffffffffaa567af0
> [ 1304.570246] [  T12755] FS:  00007f40d67a1740(0000) GS:ffff8884011ea000=
(0000) knlGS:0000000000000000
> [ 1304.571721] [  T12755] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [ 1304.573019] [  T12755] CR2: 000000001e02a810 CR3: 00000001148f6000 CR4=
: 00000000000006f0
> [ 1304.574409] [  T12755] Call Trace:
> [ 1304.575361] [  T12755]  <TASK>
> [ 1304.576229] [  T12755]  blk_mq_sched_reg_debugfs+0x28/0xe0
> [ 1304.577287] [  T12755]  elevator_change_done+0x2f2/0x610
> [ 1304.578342] [  T12755]  ? lockdep_hardirqs_on_prepare+0x50/0x1b0
> [ 1304.579452] [  T12755]  ? __pfx_elevator_change_done+0x10/0x10
> [ 1304.580469] [  T12755]  ? find_held_lock+0x2b/0x80
> [ 1304.581346] [  T12755]  ? elevator_change+0x2ed/0x4f0
> [ 1304.582246] [  T12755]  ? lock_release+0x1a7/0x320
> [ 1304.583142] [  T12755]  ? __pfx_sysfs_kf_write+0x10/0x10
> [ 1304.584087] [  T12755]  elevator_change+0x283/0x4f0
> [ 1304.584970] [  T12755]  ? __pfx_sysfs_kf_write+0x10/0x10
> [ 1304.585887] [  T12755]  elv_iosched_store+0x31d/0x3a0
> [ 1304.586784] [  T12755]  ? __pfx_elv_iosched_store+0x10/0x10
> [ 1304.587724] [  T12755]  ? lock_acquire+0x1b0/0x340
> [ 1304.588597] [  T12755]  ? kernfs_fop_write_iter+0x257/0x5e0
> [ 1304.589523] [  T12755]  ? __pfx___might_resched+0x10/0x10
> [ 1304.590396] [  T12755]  ? __might_fault+0x97/0x140
> [ 1304.591265] [  T12755]  ? __pfx_sysfs_kf_write+0x10/0x10
> [ 1304.592185] [  T12755]  queue_attr_store+0x235/0x360
> [ 1304.593064] [  T12755]  ? __lock_acquire+0x497/0x2230
> [ 1304.593929] [  T12755]  ? __pfx_queue_attr_store+0x10/0x10
> [ 1304.594787] [  T12755]  ? lock_acquire+0x1b0/0x340
> [ 1304.595629] [  T12755]  ? sysfs_file_kobj+0x1d/0x1b0
> [ 1304.596473] [  T12755]  ? lock_acquire+0x1c0/0x340
> [ 1304.597261] [  T12755]  ? find_held_lock+0x2b/0x80
> [ 1304.598107] [  T12755]  ? sysfs_file_kobj+0xaf/0x1b0
> [ 1304.598937] [  T12755]  ? lock_release+0x1a7/0x320
> [ 1304.599766] [  T12755]  ? sysfs_file_kobj+0xb9/0x1b0
> [ 1304.600598] [  T12755]  ? sysfs_kf_write+0x61/0x160
> [ 1304.601378] [  T12755]  ? __pfx_sysfs_kf_write+0x10/0x10
> [ 1304.602276] [  T12755]  kernfs_fop_write_iter+0x3d6/0x5e0
> [ 1304.603148] [  T12755]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
> [ 1304.604048] [  T12755]  vfs_write+0x523/0xf80
> [ 1304.604784] [  T12755]  ? arch_stack_walk+0xb3/0x100
> [ 1304.605573] [  T12755]  ? __pfx_vfs_write+0x10/0x10
> [ 1304.606283] [  T12755]  ? lock_acquire+0x1b0/0x340
> [ 1304.607038] [  T12755]  ? get_close_on_exec+0x1f/0x230
> [ 1304.607774] [  T12755]  ? get_close_on_exec+0xfc/0x230
> [ 1304.608502] [  T12755]  ? lock_release+0x1a7/0x320
> [ 1304.609150] [  T12755]  ksys_write+0xfb/0x200
> [ 1304.609803] [  T12755]  ? __pfx_ksys_write+0x10/0x10
> [ 1304.610495] [  T12755]  ? lock_release+0x1a7/0x320
> [ 1304.611181] [  T12755]  do_syscall_64+0x136/0x1540
> [ 1304.611845] [  T12755]  ? do_wp_page+0x168d/0x3610
> [ 1304.612505] [  T12755]  ? lock_acquire+0x1b0/0x340
> [ 1304.613151] [  T12755]  ? __pfx_do_wp_page+0x10/0x10
> [ 1304.613803] [  T12755]  ? lock_acquire+0x1b0/0x340
> [ 1304.614439] [  T12755]  ? do_raw_spin_lock+0x124/0x260
> [ 1304.615078] [  T12755]  ? lock_acquire+0x1c0/0x340
> [ 1304.615697] [  T12755]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [ 1304.616369] [  T12755]  ? __pfx_pte_write+0x10/0x10
> [ 1304.617022] [  T12755]  ? __handle_mm_fault+0x12b2/0x1d50
> [ 1304.617677] [  T12755]  ? __lock_acquire+0x497/0x2230
> [ 1304.618336] [  T12755]  ? __pfx_css_rstat_updated+0x10/0x10
> [ 1304.619065] [  T12755]  ? lock_acquire+0x1b0/0x340
> [ 1304.619677] [  T12755]  ? count_memcg_events_mm.constprop.0+0x22/0x130
> [ 1304.620438] [  T12755]  ? rcu_is_watching+0x11/0xb0
> [ 1304.621074] [  T12755]  ? count_memcg_events+0x106/0x4a0
> [ 1304.621741] [  T12755]  ? find_held_lock+0x2b/0x80
> [ 1304.622376] [  T12755]  ? rcu_read_unlock+0x17/0x60
> [ 1304.623047] [  T12755]  ? lock_release+0x1a7/0x320
> [ 1304.623656] [  T12755]  ? find_held_lock+0x2b/0x80
> [ 1304.624290] [  T12755]  ? exc_page_fault+0x83/0x110
> [ 1304.624926] [  T12755]  ? lock_release+0x1a7/0x320
> [ 1304.625553] [  T12755]  ? rcu_is_watching+0x11/0xb0
> [ 1304.626170] [  T12755]  ? irqentry_exit+0xdd/0x6a0
> [ 1304.626793] [  T12755]  ? lockdep_hardirqs_on_prepare+0xce/0x1b0
> [ 1304.627499] [  T12755]  ? irqentry_exit+0xe2/0x6a0
> [ 1304.628114] [  T12755]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1304.628821] [  T12755] RIP: 0033:0x7f40d681277e
> [ 1304.629425] [  T12755] Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b=
 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45=
 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e =
fa
> [ 1304.631432] [  T12755] RSP: 002b:00007ffd15db4a60 EFLAGS: 00000202 ORI=
G_RAX: 0000000000000001
> [ 1304.632364] [  T12755] RAX: ffffffffffffffda RBX: 000000000000000c RCX=
: 00007f40d681277e
> [ 1304.633275] [  T12755] RDX: 000000000000000c RSI: 000000001e02a810 RDI=
: 0000000000000001
> [ 1304.634198] [  T12755] RBP: 00007ffd15db4a70 R08: 0000000000000000 R09=
: 0000000000000000
> [ 1304.635127] [  T12755] R10: 0000000000000000 R11: 0000000000000202 R12=
: 000000000000000c
> [ 1304.636044] [  T12755] R13: 000000001e02a810 R14: 00007f40d698d5c0 R15=
: 0000000000000000
> [ 1304.636962] [  T12755]  </TASK>
> [ 1304.637532] [  T12755] irq event stamp: 6849
> [ 1304.638170] [  T12755] hardirqs last  enabled at (6861): [<ffffffffa76=
e6bae>] __up_console_sem+0x5e/0x70
> [ 1304.639207] [  T12755] hardirqs last disabled at (6872): [<ffffffffa76=
e6b93>] __up_console_sem+0x43/0x70
> [ 1304.640247] [  T12755] softirqs last  enabled at (5936): [<ffffffffa75=
21b66>] __irq_exit_rcu+0x126/0x240
> [ 1304.641299] [  T12755] softirqs last disabled at (5925): [<ffffffffa75=
21b66>] __irq_exit_rcu+0x126/0x240
> [ 1304.642338] [  T12755] ---[ end trace 0000000000000000 ]---
>
--=20
Thansk,
Kuai
