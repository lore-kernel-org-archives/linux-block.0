Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20701422AD
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120222; cv=none; b=ke4mXVT9iGeQ4nWWsCD/CZ6CLnqMmIVx68nQ6NBO+ctjif6OUgO+2LrSMsk/qKwXnCFcyN+3vC7qx1PrXNG+0Rt9NHcWdd3qiAMXksaYs2lcpHFRORatAqW9EZkU9hl2i4DVzyaZtBrfyD+4bnkTLwE2LLbxStMyLHlsMdHXlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120222; c=relaxed/simple;
	bh=cP6W/gDS4mS9uHttQDKr9VXS7O+9ZiGsvdsKFlZgIMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVRYtyXayC9Bs3ZcBCXOkiSUzz6gKg7iKSv/mV8Lyc7f5fDTE8AwFta1iyDA6nG5mze/BDwnY/ADbwrTHnrdJU1EZBZcqvazjt8cwZHsFyiZ7XVqdwQnjQybI0jbBoNDCpjAy5k0yH6aNoYaZGfJw9jBBdH7BBLiXIqIsrXTG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUvt9B3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUvt9B3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714120219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ouTVIVhhJWM5mFGEXpnbSBhGieu3FwiruTg3iTy9uM8=;
	b=AUvt9B3+hzi8shwWpvBiizEZs7GroyGH0cSFacoSBNlhNUfFaVy2yDQT7cq15SEwMd+YXk
	/XN8zMn6MASHrnSuPB39NodguSLHIDOpaO2Wgr0M0IFO7CZUDhTH6I7aic9kiuQNNWk3eD
	UYWcHVWMfivLJ884Fymm9YUJ5L4bk/c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-yr4ZN9GgOcqq6K4D_fj5Tw-1; Fri, 26 Apr 2024 04:30:18 -0400
X-MC-Unique: yr4ZN9GgOcqq6K4D_fj5Tw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2abc5b4f3c7so2223411a91.0
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 01:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714120216; x=1714725016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouTVIVhhJWM5mFGEXpnbSBhGieu3FwiruTg3iTy9uM8=;
        b=ZCTE9JToawTmW4CXoqgDK/ZhvVxaIwggibeEB5dstfEEUR31FT0U8S/nfgbZLBjmNy
         PI9yIGr4uZFYRHxYXE98eMyBhKiE0bx84HKciMddn+Vka7CXaHaqzd+hPKIMTIKBguQm
         qdVNIz8PrtUHpAbPeKANcVONir231RsEl4wDQnuqOx3o9RGAwG3dWLbsS9R6qxx1YTkF
         T0oEhIY58B4FtFTRDE++at+jC2AQdTvIjbpm2ythGcfjMpNeaow9YAGemVyq9ph2SsrI
         QTyTSF9PLhW1JOGBE3/7BBtpYaUpjuYyj1T7UBd21XMumE8JOM/g76d1Z/IGv49EkcgF
         5/OQ==
X-Gm-Message-State: AOJu0Yw77L4oNX1Q6JAAHRSQsq8FB6srYRq2h0BoDx3O3j9FxfMGNiPw
	f1GWGdImaUNV+5m2qnvu4L1aohbvwbjafSxUs6x4ja/nEUSE2CFxOPmZI8Ft5ap/KTmPsnZrQMb
	1ln/IvZf151nu6+aHs6issILGbi2yCOvJl/91jv319i3J83fT9p2yySkWnxSqjGRDnSE8BCEFnQ
	MN731SMswoacLz1DFpjHnKp2Rxfzr/G9oO+QU/G7DYQXQwAkQR
X-Received: by 2002:a17:90b:3692:b0:2ae:d553:6952 with SMTP id mj18-20020a17090b369200b002aed5536952mr1792609pjb.4.1714120215818;
        Fri, 26 Apr 2024 01:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGU0Ue6vP2JW/tcrs/AgNDP+YCt75lAhxkanBz2VBayAFtULgFtyi3uN3LU9FJ/1r08npwSZPbMlLpm6xPdPo=
X-Received: by 2002:a17:90b:3692:b0:2ae:d553:6952 with SMTP id
 mj18-20020a17090b369200b002aed5536952mr1792593pjb.4.1714120215389; Fri, 26
 Apr 2024 01:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
In-Reply-To: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 26 Apr 2024 16:30:03 +0800
Message-ID: <CAHj4cs-6TbqoNRvy54AEO0gA5NjOqnigEKnzD13SUadRhVBetQ@mail.gmail.com>
Subject: Re: [bug report][bisected] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damien

Bisect shows it was introduced with this patch, could you help check  it

commit 6f8fd758de63bab513c551bb1796a14f8cdc40d9
Author: Damien Le Moal <dlemoal@kernel.org>
Date:   Mon Apr 8 10:41:01 2024 +0900

    block: Restore sector of flush requests

On Tue, Apr 23, 2024 at 9:17=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi
> I found this issue on the latest linux-block/for-next by blktests
> nvme/tcp nvme/012, please help check it and let me know if you need
> any info/testing for it, thanks.
>
> [ 1873.394323] run blktests nvme/012 at 2024-04-23 04:13:47
> [ 1873.761900] loop0: detected capacity change from 0 to 2097152
> [ 1873.846926] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1873.987806] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 1874.208883] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 1874.243423] nvme nvme0: creating 48 I/O queues.
> [ 1874.362383] nvme nvme0: mapped 48/0/0 default/read/poll queues.
> [ 1874.517677] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [ 1875.649484] XFS (nvme0n1): Mounting V5 Filesystem
> b5a2998b-e06a-40d0-a291-a46b67aa43db
> [ 1875.770202] XFS (nvme0n1): Ending clean mount
> [ 1936.174561] nvme nvme0: I/O tag 49 (a031) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.182573] nvme nvme0: starting error recovery
> [ 1936.187622] nvme nvme0: I/O tag 50 (5032) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.196829] nvme nvme0: I/O tag 51 (b033) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.205619] block nvme0n1: no usable path - requeuing I/O
> [ 1936.211228] nvme nvme0: I/O tag 52 (0034) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.218975] block nvme0n1: no usable path - requeuing I/O
> [ 1936.224691] nvme nvme0: I/O tag 53 (3035) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.232395] block nvme0n1: no usable path - requeuing I/O
> [ 1936.237916] nvme nvme0: I/O tag 54 (0036) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.245731] block nvme0n1: no usable path - requeuing I/O
> [ 1936.251165] block nvme0n1: no usable path - requeuing I/O
> [ 1936.256967] nvme nvme0: I/O tag 55 (8037) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.264676] block nvme0n1: no usable path - requeuing I/O
> [ 1936.270159] nvme nvme0: I/O tag 56 (1038) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.277848] block nvme0n1: no usable path - requeuing I/O
> [ 1936.283294] block nvme0n1: no usable path - requeuing I/O
> [ 1936.288743] nvme nvme0: I/O tag 57 (b039) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.296450] block nvme0n1: no usable path - requeuing I/O
> [ 1936.301920] nvme nvme0: I/O tag 58 (503a) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.309621] block nvme0n1: no usable path - requeuing I/O
> [ 1936.315076] nvme nvme0: I/O tag 59 (a03b) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.323271] nvme nvme0: I/O tag 60 (803c) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.331018] nvme nvme0: I/O tag 61 (203d) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.338769] nvme nvme0: I/O tag 62 (503e) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.346515] nvme nvme0: I/O tag 63 (c03f) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.354693] nvme nvme0: I/O tag 64 (a040) type 4 opcode 0x1 (I/O
> Cmd) QID 2 timeout
> [ 1936.362479] nvme nvme0: I/O tag 49 (0031) type 4 opcode 0x0 (I/O
> Cmd) QID 8 timeout
> [ 1936.370819] nvme nvme0: I/O tag 50 (0032) type 4 opcode 0x1 (I/O
> Cmd) QID 8 timeout
> [ 1936.378679] nvme nvme0: I/O tag 51 (0033) type 4 opcode 0x1 (I/O
> Cmd) QID 8 timeout
> [ 1936.386464] nvme nvme0: I/O tag 52 (0034) type 4 opcode 0x1 (I/O
> Cmd) QID 8 timeout
> [ 1936.394235] nvme nvme0: I/O tag 53 (0035) type 4 opcode 0x1 (I/O
> Cmd) QID 8 timeout
> [ 1936.402062] nvme nvme0: I/O tag 54 (0036) type 4 opcode 0x1 (I/O
> Cmd) QID 8 timeout
> [ 1936.409847] nvme nvme0: I/O tag 55 (0037) type 4 opcode 0x1 (I/O
> Cmd) QID 8 timeout
> [ 1936.417773] nvme nvme0: I/O tag 56 (0038) type 4 opcode 0x1 (I/O
> Cmd) QID 8 timeout
> [ 1936.449539] general protection fault, probably for non-canonical
> address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN PTI
> [ 1936.450749] nvme nvme0: Reconnecting in 10 seconds...
> [ 1936.460764] KASAN: null-ptr-deref in range
> [0x0000000000000020-0x0000000000000027]
> [ 1936.460775] CPU: 15 PID: 848 Comm: kworker/15:1H Not tainted 6.9.0-rc4=
.v1+ #2
> [ 1936.480528] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
> 2.20.1 09/13/2023
> [ 1936.488094] Workqueue: kblockd blk_mq_run_work_fn
> [ 1936.492806] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
> [ 1936.498216] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a8 08 00 00
> 49 8d 7c 24 20 4d 89 65 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
> c1 ea 03 <80> 3c 02 00 0f 85 8e 08 00 00 49 8d 7d 30 4d 8b 64 24 20 48
> b8 00
> [ 1936.516960] RSP: 0018:ffffc9000f86f850 EFLAGS: 00010002
> [ 1936.522185] RAX: dffffc0000000000 RBX: 1ffff92001f0df10 RCX: 1ffff1154=
3588c4a
> [ 1936.529318] RDX: 0000000000000004 RSI: dffffc0000000000 RDI: 000000000=
0000020
> [ 1936.536449] RBP: ffff88aa1a419da0 R08: ffff88c7aba3f9e0 R09: 1ffffffff=
38e0bb3
> [ 1936.543582] R10: 1ffff11543588c4a R11: ffffffffffe25e18 R12: 000000000=
0000000
> [ 1936.550714] R13: ffff88aa1ac46200 R14: ffff88a9c4560d00 R15: 000000000=
0000000
> [ 1936.557847] FS:  0000000000000000(0000) GS:ffff88c7aba00000(0000)
> knlGS:0000000000000000
> [ 1936.565930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1936.571675] CR2: 00007fc90f80b004 CR3: 00000029d18a0004 CR4: 000000000=
07706f0
> [ 1936.578809] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 1936.585942] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 1936.593072] PKRU: 55555554
> [ 1936.595784] Call Trace:
> [ 1936.598237]  <TASK>
> [ 1936.600344]  ? __die_body.cold+0x19/0x25
> [ 1936.604279]  ? die_addr+0x46/0x70
> [ 1936.607606]  ? exc_general_protection+0x14f/0x250
> [ 1936.612325]  ? asm_exc_general_protection+0x26/0x30
> [ 1936.617212]  ? blk_flush_complete_seq+0x450/0x1060
> [ 1936.622012]  ? __pfx_blk_flush_complete_seq+0x10/0x10
> [ 1936.627072]  mq_flush_data_end_io+0x279/0x500
> [ 1936.631430]  ? __pfx_mq_flush_data_end_io+0x10/0x10
> [ 1936.636308]  blk_mq_end_request+0x1b8/0x690
> [ 1936.640493]  ? _raw_spin_unlock_irqrestore+0x45/0x80
> [ 1936.645460]  nvme_failover_req+0x37d/0x4e0 [nvme_core]
> [ 1936.650634]  nvme_fail_nonready_command+0x130/0x180 [nvme_core]
> [ 1936.656578]  blk_mq_dispatch_rq_list+0x3b3/0x2100
> [ 1936.661292]  ? __pfx_blk_mq_dispatch_rq_list+0x10/0x10
> [ 1936.666436]  __blk_mq_sched_dispatch_requests+0x554/0x1510
> [ 1936.671925]  ? __pfx___lock_acquire+0x10/0x10
> [ 1936.676285]  ? __pfx_lock_acquired+0x10/0x10
> [ 1936.680558]  ? __pfx___blk_mq_sched_dispatch_requests+0x10/0x10
> [ 1936.686477]  ? __pfx_lock_acquire+0x10/0x10
> [ 1936.690668]  blk_mq_sched_dispatch_requests+0xa6/0xf0
> [ 1936.695721]  blk_mq_run_work_fn+0x122/0x2c0
> [ 1936.699908]  ? blk_mq_run_work_fn+0x114/0x2c0
> [ 1936.704266]  process_one_work+0x85d/0x13f0
> [ 1936.708371]  ? worker_thread+0xcc/0x1130
> [ 1936.712301]  ? __pfx_process_one_work+0x10/0x10
> [ 1936.716835]  ? assign_work+0x16c/0x240
> [ 1936.720596]  worker_thread+0x6da/0x1130
> [ 1936.724438]  ? __pfx_worker_thread+0x10/0x10
> [ 1936.728712]  kthread+0x2ed/0x3c0
> [ 1936.731944]  ? _raw_spin_unlock_irq+0x28/0x60
> [ 1936.736303]  ? __pfx_kthread+0x10/0x10
> [ 1936.740058]  ret_from_fork+0x31/0x70
> [ 1936.743636]  ? __pfx_kthread+0x10/0x10
> [ 1936.747387]  ret_from_fork_asm+0x1a/0x30
> [ 1936.751319]  </TASK>
> [ 1936.753516] Modules linked in: nvmet_tcp nvmet nvme_tcp
> nvme_fabrics nvme_keyring nvme_core nvme_auth intel_rapl_msr
> intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
> isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp
> kvm_intel kvm spi_nor iTCO_wdt intel_pmc_bxt cdc_ether mtd usbnet
> iTCO_vendor_support dell_smbios rapl intel_cstate rfkill sunrpc dcdbas
> dell_wmi_descriptor wmi_bmof intel_uncore pcspkr bnxt_en mii tg3
> i2c_i801 spi_intel_pci i2c_smbus spi_intel mei_me ipmi_ssif mei
> lpc_ich intel_pch_thermal acpi_ipmi ipmi_si ipmi_devintf
> ipmi_msghandler nd_pmem nd_btt dax_pmem acpi_power_meter fuse loop
> nfnetlink zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel
> polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3
> sha256_ssse3 sha1_ssse3 mgag200 megaraid_sas i2c_algo_bit wmi nfit
> libnvdimm [last unloaded: nvmet]
> [ 1936.829942] ---[ end trace 0000000000000000 ]---
> [ 1936.880774] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
> [ 1936.886183] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a8 08 00 00
> 49 8d 7c 24 20 4d 89 65 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
> c1 ea 03 <80> 3c 02 00 0f 85 8e 08 00 00 49 8d 7d 30 4d 8b 64 24 20 48
> b8 00
> [ 1936.904925] RSP: 0018:ffffc9000f86f850 EFLAGS: 00010002
> [ 1936.910150] RAX: dffffc0000000000 RBX: 1ffff92001f0df10 RCX: 1ffff1154=
3588c4a
> [ 1936.917285] RDX: 0000000000000004 RSI: dffffc0000000000 RDI: 000000000=
0000020
> [ 1936.924416] RBP: ffff88aa1a419da0 R08: ffff88c7aba3f9e0 R09: 1ffffffff=
38e0bb3
> [ 1936.931548] R10: 1ffff11543588c4a R11: ffffffffffe25e18 R12: 000000000=
0000000
> [ 1936.938680] R13: ffff88aa1ac46200 R14: ffff88a9c4560d00 R15: 000000000=
0000000
> [ 1936.945811] FS:  0000000000000000(0000) GS:ffff88c7aba00000(0000)
> knlGS:0000000000000000
> [ 1936.953899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1936.959642] CR2: 00007fc90f80b004 CR3: 00000029d18a0004 CR4: 000000000=
07706f0
> [ 1936.966776] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 1936.973906] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 1936.981039] PKRU: 55555554
> [ 1936.983752] note: kworker/15:1H[848] exited with irqs disabled
> [ 1936.989617] note: kworker/15:1H[848] exited with preempt_count 1
> [ 1946.926323] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 1946.944673] nvme nvme0: creating 48 I/O queues.
>
> (gdb) l *(blk_flush_complete_seq+0x450)
> 0xffffffff826c5370 is in blk_flush_complete_seq (block/blk-flush.c:133).
> 128 * After flush data completion, @rq->bio is %NULL but we need to
> 129 * complete the bio again.  @rq->biotail is guaranteed to equal the
> 130 * original @rq->bio.  Restore it.
> 131 */
> 132 rq->bio =3D rq->biotail;
> 133 rq->__sector =3D rq->bio->bi_iter.bi_sector;
> 134
> 135 /* make @rq a normal request */
> 136 rq->rq_flags &=3D ~RQF_FLUSH_SEQ;
> 137 rq->end_io =3D rq->flush.saved_end_io;
>
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang

