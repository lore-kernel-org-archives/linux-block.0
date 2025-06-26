Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDA2E92DD
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947840; cv=none; b=Y9yigp9vd+ohCLHB1UUF8T0k1y7OOjsMFKDKeTQek+4hDIPCJXY+27XAU+BfB4Mly9Z++L0yHCvKI43wPlV4pJYvdu5HkFGTAbtMNTi5zIJxhIrKJpmAoP5KnX8/5OeTVHKck3UWM62p7k8QGSOCIPY0xM6qnZy0mChamHv0W7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947840; c=relaxed/simple;
	bh=zqJfM3kusDd23kV2/vXBIrjZ1R/E21T5J7fTfakoUE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j34RE0XkeO7Shm60xBADqFTJCQy5Bf6uE3Q2CmMeU+32CW1M45eutjctuzYsTpgc6dwAIjKOGhyaSzVDPc1gaXhvwmnk16Zx0F2T9OLa1HKMknIKUKkunTRybbvqJujsjZc+okHkPxO9/u9xZ7xtpgpqStJB4Sjqyv2pkG3solE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQUWbI/+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQUWbI/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750947837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UetQrMeSEyGl2rwFwyx9kitzWkBCw0wyrdYMIsJOXNo=;
	b=jQUWbI/+N+ZZjQAN4VPGuX3zBM7pDfTUkelGNBBlfmc6VrNzAMT2N6XhAjou0igcc+eJZO
	rllsaeyptROp7iyKNDB9ScqNHrr6RBpaiqII471ZPWzqaCIcYSF65Mhu7he0JuGJTHictS
	p8HEKcVD0dnJhILU6R4v0wcvKNF0Zvo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-CcXvEzQwPKyqC3nEYa2YIg-1; Thu, 26 Jun 2025 10:23:55 -0400
X-MC-Unique: CcXvEzQwPKyqC3nEYa2YIg-1
X-Mimecast-MFC-AGG-ID: CcXvEzQwPKyqC3nEYa2YIg_1750947834
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b88283ecdso4490521fa.3
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 07:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750947832; x=1751552632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UetQrMeSEyGl2rwFwyx9kitzWkBCw0wyrdYMIsJOXNo=;
        b=LxM08m4YJKEk084qhHmO+4SGSk96CjBS7hpggiD4qpk1W7cP9qj6XOo6DQetrrceQ/
         s+mRdY9/Dg1WY1QcbTY0KVrwrWjlMkCiW+TqenAADRVB7Fz9HLzQioH35OS6wRM9WU5W
         r5nUAnc61ceJ2onrB15HegsbL3bXtZVM0P9CLmbFWwIqpo/uFVh5ppIqkpJKPB8O45+N
         3wAhO02/nOxg6Yls8Jn8EsCm9fOX4OQebSV/OfpFhxMa5EwfQ1+b6TRwLD4PKzBTfz+4
         pmvfr9azmS0081+Wua8cvSltMwYX2WGYC1Mf2+ijRM1ixFyrjNrXoYqQ3N9ylirkBC4I
         LLyg==
X-Gm-Message-State: AOJu0YwC6H58jxrpqRE9dWq75UpcO77BnqOt9z/RPLJ2bSBzw17KrSTo
	tKiNM12SrS//IoksxcqtC5gkgGyuzjIJaStSbV/0Tlehjp3YXfUy6NtC4SLVeYVxy0/tTQwkEny
	DF0teAc/NpqLMJuVlBikK+p+h8NlQvBCyzfxoeaSHvJypbCrPjgyZhcIKslXul7KbBeqpGJjr2e
	RW0Rt0yCSl4sUUeeK4wx+w0+WZ7sMg6ZDE3dxxzriSaQVWBIqsKA==
X-Gm-Gg: ASbGncvFUE1EQJaQQU1BEjvc1XJBY6992ezFFr29SYAEI9kBbjSU0IKtkvXcly8FSDs
	h/5wlCLalAhHuDvynknKy4sfjOGaHb0MfXNZKWJsnw9W0FqdxHDWUgshlaD2EReMpFVNr1p0mWl
	46mqzk
X-Received: by 2002:a2e:b5a9:0:b0:32a:8916:55af with SMTP id 38308e7fff4ca-32cc646750dmr26403361fa.2.1750947831592;
        Thu, 26 Jun 2025 07:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjhrDmhUOoukl0zhnoB0Cxbn70zuwtSEPH783WIGUzJOmVnUnfoN3upawBEwceluAlI4AAUrZy2q3fkW51NoU=
X-Received: by 2002:a2e:b5a9:0:b0:32a:8916:55af with SMTP id
 38308e7fff4ca-32cc646750dmr26403301fa.2.1750947831072; Thu, 26 Jun 2025
 07:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs92q3Lc8f=mEZ-e9piZtLj62eJ2Z5iSO-wJuRepspkbsA@mail.gmail.com>
In-Reply-To: <CAHj4cs92q3Lc8f=mEZ-e9piZtLj62eJ2Z5iSO-wJuRepspkbsA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 26 Jun 2025 22:23:39 +0800
X-Gm-Features: Ac12FXyCcCg5Bt2bY8lPWHCq0IJ5ix_Uy0Pse2wIGpCf-mmNez00lAAjAs5fNIw
Message-ID: <CAHj4cs-C76gc67PhHGAE5dak-9AO4gAmRO=yEReWcm7Y+u6kHA@mail.gmail.com>
Subject: Re: [bug report] kernel BUG at mm/hugetlb.c:5880! triggered by
 blktests nvme/029
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue still can be reproduced on the latest 6.16-rc3 and triggered
by "test_user_io /dev/nvme0n1 511 1024" in blktests nvme/029, here is
the log:

+ test_user_io /dev/nvme0n1 511 1024
+ local disk=3D/dev/nvme0n1
+ local start=3D511
+ local cnt=3D1024
+ local bs size img img1
++ blockdev --getss /dev/nvme0n1
+ bs=3D512
+ size=3D524288
++ mktemp /tmp/blk_img_XXXXXX
+ img=3D/tmp/blk_img_4aWO9O
++ mktemp /tmp/blk_img_XXXXXX
+ img1=3D/tmp/blk_img_mFMZKv
+ dd if=3D/dev/urandom of=3D/tmp/blk_img_4aWO9O bs=3D512 count=3D1024 statu=
s=3Dnone
+ (( cnt-- ))
+ nvme write --start-block=3D511 --block-count=3D1023 --data-size=3D524288
--data=3D/tmp/blk_img_4aWO9O /dev/nvme0n1
failed to read data buffer from input file Bad address

[  536.473855] run blktests nvme/029 at 2025-06-26 09:01:58
[  536.512378] loop0: detected capacity change from 0 to 2097152
[  536.524471] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  536.562851] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  536.565289] nvme nvme0: creating 32 I/O queues.
[  536.572405] nvme nvme0: new ctrl: "blktests-subsystem-1"
[  536.881900] ------------[ cut here ]------------
[  536.882631] kernel BUG at mm/hugetlb.c:5880!
[  536.883313] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  536.883613] CPU: 6 UID: 0 PID: 1550 Comm: nvme Not tainted
6.16.0-0.rc3.31.fc43.x86_64 #1 PREEMPT(lazy)
[  536.884099] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/14/2018
[  536.884466] RIP: 0010:__unmap_hugepage_range+0x7bb/0x840
[  536.884792] Code: 3c 24 e8 b8 12 dd 00 e9 ac fb ff ff 48 b8 00 00
00 c0 7f 00 00 00 48 89 44 24 28 e9 06 f9 ff ff b9 0c 00 00 00 e9 4b
ff ff ff <0f> 0b 0f 0b e9 a0 f8 ff ff 0f 0b 65 48 8b 05 ba c6 03 03 48
8b 10
[  536.886122] RSP: 0018:ffffcf6ec50e39a8 EFLAGS: 00010206
[  536.886416] RAX: 0000000000400000 RBX: ffff8e098980dbc0 RCX: 00000000000=
00009
[  536.887183] RDX: 00000000001fffff RSI: ffff8e098980dbc0 RDI: ffffcf6ec50=
e3b00
[  536.887959] RBP: 0000000000000000 R08: ffffffff964f0f98 R09: 00000000000=
00003
[  536.888732] R10: 00007fd993a07000 R11: 00007fd993c07000 R12: 00007fd993a=
07000
[  536.889507] R13: ffffcf6ec50e3b00 R14: ffffcf6ec50e3b00 R15: ffff8e09898=
0dbc0
[  536.890315] FS:  00007fd994ad4840(0000) GS:ffff8e07e17fc000(0000)
knlGS:0000000000000000
[  536.890848] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  536.891542] CR2: 00007fd99418afb8 CR3: 000000010e120000 CR4: 00000000000=
406f0
[  536.892343] Call Trace:
[  536.892499]  <TASK>
[  536.893027]  ? unmap_page_range+0x1a4/0x260
[  536.893269]  unmap_vmas+0xa1/0x180
[  536.893838]  exit_mmap+0xe5/0x3c0
[  536.894423]  __mmput+0x41/0x140
[  536.895019]  exit_mm+0xb1/0x110
[  536.895617]  do_exit+0x1a2/0x440
[  536.896190]  ? xas_find+0x83/0x1b0
[  536.896766]  do_group_exit+0x2d/0xc0
[  536.896990]  __x64_sys_exit_group+0x18/0x20
[  536.897213]  x64_sys_call+0xfdb/0x14f0
[  536.897429]  do_syscall_64+0x82/0x2c0
[  536.897676]  ? filemap_map_pages+0x35a/0x590
[  536.898356]  ? do_read_fault+0x107/0x260
[  536.898600]  ? handle_pte_fault+0x118/0x240
[  536.898823]  ? do_fault+0x150/0x210
[  536.899392]  ? __handle_mm_fault+0x3a7/0x700
ault+0x21a/0x690
[  537.000163]  ? exc_page_fault+0x74/0x180
[  537.000394]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  537.000782] RIP: 0033:0x7fd994945da8
[  537.001019] Code: Unable to access opcode bytes at 0x7fd994945d7e.
[  537.001887] RSP: 002b:00007ffc4c8b40d8 EFLAGS: 00000202 ORIG_RAX:
00000000000000e7
[  537.002735] RAX: ffffffffffffffda RBX: 00007fd994a70fe8 RCX: 00007fd9949=
45da8
[  537.003520] RDX: 00007fd994ad4b48 RSI: ffffffffffffff78 RDI: 00000000000=
00001
[  537.004349] RBP: 00007ffc4c8b4130 R08: 0000000000000000 R09: 00000000000=
00000
[  537.005133] R10: 00007ffc4c8b3ec0 R11: 0000000000000202 R12: 00000000000=
00001
[  537.005909] R13: 0000000000000001 R14: 00007fd994a6f680 R15: 00007fd994a=
71000
[  537.006686]  </TASK>

On Mon, Jun 16, 2025 at 7:45=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi
> CKI triggered the following issue[2] with the block/fo-next commit[1],
> please help check it, thanks.
>
> [1]
> commit: 1cbac730bb6b Merge branch 'block-6.16' into for-next
>
> [2]
> [ 1207.436193] run blktests nvme/029 at 2025-06-13 16:11:12
> [ 1207.476177] loop0: detected capacity change from 0 to 2097152
> [ 1207.488130] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1207.506313] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 1207.556941] nvmet: Created nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 1207.560824] nvme nvme0: creating 32 I/O queues.
> [ 1207.561919] nvme nvme0: failed to connect socket: -512
> [ 1207.569392] nvmet: Created nvm controller 2 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 1207.572517] nvme nvme0: creating 32 I/O queues.
> [ 1207.580131] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> [ 1207.599121] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [ 1207.916342] ------------[ cut here ]------------
> [ 1207.917026] kernel BUG at mm/hugetlb.c:5880!
> [ 1207.917801] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [ 1207.918227] CPU: 18 UID: 0 PID: 47801 Comm: nvme Not tainted
> 6.16.0-rc1 #1 PREEMPT(lazy)
> [ 1207.918683] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/14/201=
8
> [ 1207.919300] RIP: 0010:__unmap_hugepage_range+0x7a4/0x7f0
> [ 1207.919611] Code: 89 ef 48 89 c6 e8 2c 90 ff ff 48 8b 3c 24 e8 73
> c3 d9 00 e9 bf fb ff ff 0f 0b 49 8b 50 30 48 f7 d2 4c 85 e2 0f 84 e3
> f8 ff ff <0f> 0b 0f 0b 65 48 8b 05 28 a2 0c 03 48 8b 10 f7 c2 00 00 00
> 20 74
> [ 1207.920942] RSP: 0018:ffffcd058ced7ae0 EFLAGS: 00010206
> [ 1207.921231] RAX: 0000000000400000 RBX: 0000000000000000 RCX: 000000000=
0000009
> [ 1207.922070] RDX: 00000000001fffff RSI: ffff8cb38c141c80 RDI: ffffcd058=
ced7c48
> [ 1207.922850] RBP: ffffffffffffffff R08: ffffffffacb56e98 R09: 000000000=
0200000
> [ 1207.923618] R10: 00007f6120006000 R11: ffff8cb4fb586000 R12: 00007f611=
fe06000
> [ 1207.924421] R13: ffffcd058ced7c48 R14: ffff8cb38c141c80 R15: ffffcd058=
ced7c00
> [ 1207.925221] FS:  00007f61210db840(0000) GS:ffff8cb70b096000(0000)
> knlGS:0000000000000000
> [ 1207.925639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1207.926357] CR2: 00007f6120f4d710 CR3: 000000025c3ba000 CR4: 000000000=
00406f0
> [ 1207.927164] Call Trace:
> [ 1207.927319]  <TASK>
> [ 1207.927833]  unmap_vmas+0xa6/0x180
> [ 1207.928565]  exit_mmap+0xf0/0x3b0
> [ 1207.929175]  __mmput+0x3e/0x130
> [ 1207.929790]  exit_mm+0xaf/0x110
> [ 1207.930457]  do_exit+0x1a5/0x450
> [ 1207.931054]  do_group_exit+0x30/0x80
> [ 1207.931287]  __x64_sys_exit_group+0x18/0x20
> [ 1207.931504]  x64_sys_call+0xfdb/0x14f0
> [ 1207.931751]  do_syscall_64+0x84/0x2c0
> [ 1207.931977]  ? count_memcg_events+0x167/0x1d0
> [ 1207.932623]  ? handle_mm_fault+0x220/0x340
> [ 1207.932879]  ? do_user_addr_fault+0x2c3/0x7f0
> [ 1207.933528]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1207.933842] RIP: 0033:0x7f6120f4d728
> [ 1207.934079] Code: Unable to access opcode bytes at 0x7f6120f4d6fe.
> [ 1207.934818] RSP: 002b:00007ffe4c80b528 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000e7
> [ 1207.935606] RAX: ffffffffffffffda RBX: 00007f6121076fc8 RCX: 00007f612=
0f4d728
> [ 1207.936392] RDX: 00007f61210dbb48 RSI: ffffffffffffff90 RDI: 000000000=
0000001
> [ 1207.937391] RBP: 00007ffe4c80b580 R08: 0000000000000000 R09: 000000000=
0000000
> [ 1207.938510] R10: 00007ffe4c80b310 R11: 0000000000000206 R12: 000000000=
0000001
> [ 1207.939326] R13: 0000000000000001 R14: 00007f6121075680 R15: 00007f612=
1076fe0
> [ 1207.940102]  </TASK>
> [ 1207.940260] Modules linked in: nvmet_tcp nvmet nvme_tcp
> nvme_fabrics nvme nvme_core nvme_keyring nvme_auth nbd pktcdvd rfkill
> sunrpc amd64_edac edac_mce_amd ipmi_ssif kvm tg3 i2c_piix4
> fam15h_power acpi_power_meter k10temp hpilo pcspkr ipmi_si i2c_smbus
> irqbypass acpi_ipmi acpi_cpufreq ipmi_devintf ipmi_msghandler fuse
> loop nfnetlink zram lz4hc_compress lz4_compress xfs polyval_clmulni
> ata_generic ghash_clmulni_intel pata_acpi sha512_ssse3 hpsa mgag200
> serio_raw sha1_ssse3 pata_atiixp sp5100_tco scsi_transport_sas hpwdt
> i2c_algo_bit [last unloaded: nvmet]
> [10: 00007f6120006000 R11: ffff8cb4fb586000 R12: 00007f611fe06000
> [ 1208.443808] R13: ffffcd058ced7c48 R14: ffff8cb38c141c80 R15: ffffcd058=
ced7c00
> [ 1208.444605] FS:  00007f61210db840(0000) GS:ffff8cb70b016000(0000)
> knlGS:0000000000000000
> [ 1208.445062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1208.445777] CR2: 0000562c0be4a000 CR3: 000000025c3ba000 CR4: 000000000=
00406f0
> [ 1208.446610] Kernel panic - not syncing: Fatal exception
> [ 1208.447172] Kernel Offset: 0x28200000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 1208.451887] ERST: [Firmware Warn]: Firmware does not respond in time.
> [ 1208.484105] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> --
> Best Regards,
>   Yi Zhang



--
Best Regards,
  Yi Zhang

