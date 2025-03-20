Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52C1C3BF1
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448228; cv=none; b=K+oTG81Y9pnFWDGBAUHpihlg0zG5KULBisbFXSIiLLpht8q7IpKCLzfV4IyloL9jPv27yL8NhQ5XJ8XTKOKKkiRZ57H5KtxVdoKK7XYjGAmkZoI48T2hHrYdsq/Y9bINxtSIkT/W9BAVVxaNVg6LqQVPBL9fjompY7DZaJyMITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448228; c=relaxed/simple;
	bh=4GvouuYdaO20h72sHonDsMvHzDhgB4+J4FmTnQIcYfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9VmS3Iruf9YBfg1Cx+C+p/+j/VWBvs5/E3rPir2DI2eH5Aj7OrWgfYW2JLyH8CM9sLq/mqSCERsTjvKNxbQnSX12xjwG3SlToxW4By7c01NuF2pp99dzF5wwYxAXh6Ih5siVgwQBMRWyR7v+gn3oc4zsM+Aa3kShGql4jLb1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hs7TdjA+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hs7TdjA+"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 71BE03F2BA
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 05:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742448222;
	bh=OVHtoGKrGvWHw/ZivElln0r0wmsU1A2TFNN+OIwoKDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=hs7TdjA+vN1clNJB+SV3JhJasnOHj/913X15Dm/mN4ZxvKy336Us3Qj7zkqaqAV+D
	 p1kEFrtW7FGFFD2l7lPC0sU5QkIszzPJ8YnDVzKUWztkgLcpff4nOHsUdlgCWMZs9S
	 j21fDn/zAlKGKQKSuVe14xhwR8kx+gIBg2bEqHqrb/BPZORW5MWtzYgZ5H57c6/x9s
	 98DNb/r4/FDpDc4PYK4J7zJ9YXnsAMqrp8q74xFVbAGS9UcmEQO2o6EXrKT1cWZMZj
	 tsHVO65eu3PZVjVTwSd4+rOAm7MSsreJUaeHcBxdNXoIeth3dr4kvn9HdY90f0y48a
	 3PWo7ZnYpuZ1g==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3011c150130so638690a91.2
        for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 22:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742448221; x=1743053021;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVHtoGKrGvWHw/ZivElln0r0wmsU1A2TFNN+OIwoKDs=;
        b=ZwNXJ0WDDqJWSOIo0WQlFWAQSei+1W2tVK/a5fTmRR0H8MXmG+LBIoEe1pMbB8wTT1
         op1GcfXAHPdDtyIX3mNwRItC/N+qCC0AITQ8z8XR1YjFgVeiu/D2Wzqp4jiWgTZwYW22
         1lpjUKQeSZcCNb5OY/7P+9q+j6iJZNt3xXrqg3iIhQGN/+C9Pw61VLImZPB+FInGtOgy
         62bC44OdzA6CRj16BT3RmyZKRCyvJ94xNdeE1+/qdGdZgBUR/e3GKvvtfbNdWqj577EY
         hhrdizmj8VW5dG0jU4eZNqd2S0+GA+ULTjKM7fhDK4+rI91m1zA9Y7hQuOwPoa8FXm7W
         QCkQ==
X-Gm-Message-State: AOJu0Yy2fhM/tzrG6UkhZ2aSXcQrjHFfmBGH1xvep0fvvapRDFe7+oZU
	znUTcmvAoSmlFMpY7UNXHOp25ph1ui77ncuO2MOghLtvcwDFVdTNgknXhQ4T2UJp/2c48mCeQxU
	qU39fQI/gd6Ik0/uT7VtkorpNxEEgppFy6kiH1zVL281+F6t8vs1xV5fcI/8LQAXcB0NZG+1dDV
	6/
X-Gm-Gg: ASbGnctA65zMFC0giIq/6uVmPiDZm6T5IO0HK2K/fM/PnkkX7gI6s7Gbrw/jnCDr8p4
	hisi6cRIHO/99MLzR55A0xHgItD78b+eu196GHS1YkRntjPv+76RSqDWL5S/TyyfQe92gSyB+PM
	U66XQmeZNnyfgWCKS6sdqRX317UAWipuexKReWqQsiQR7ZPdRMig9dHf+rpiPlqmhg79aokIaoG
	uhwbpzHEmp3QGZaL850aGVP9ncFgLlo5HhEh5nZA67oh6RIMl9BWCwzwN2RSuoX/tmNag6huBKE
	PgNc3E6rdc/Xz4qh/J91Q/UZeQtd6f/m/s1UucYyBEvpR3tBWWxS720gwk7iv3vVVKI=
X-Received: by 2002:a17:90b:280b:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-301bdcad8b3mr10329601a91.0.1742448220835;
        Wed, 19 Mar 2025 22:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7A6+aMD71bjjP1q0HKgEYvJPdG73hymnhfxdHo00uQjmqZ+/PqYe6Puuhm0/pz78ho98O1A==
X-Received: by 2002:a17:90b:280b:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-301bdcad8b3mr10329570a91.0.1742448220457;
        Wed, 19 Mar 2025 22:23:40 -0700 (PDT)
Received: from acelan-precision5470 (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a682sm2784235a91.31.2025.03.19.22.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 22:23:39 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:23:34 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, 
	Christoph Hellwig <hch@infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, 
	yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com, 
	Dirk Su <dirk.su@canonical.com>
Subject: Re: Regression found in memory stress test with stress-ng
Message-ID: <z6wlwwcbrmr3mcws6wmn5r6z45kosinvq6wyfq6hxfvcuxdjp5@ucjecgmhqp42>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Baokun Li <libaokun1@huawei.com>, linux-block@vger.kernel.org, axboe@kernel.dk, 
	Christoph Hellwig <hch@infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, 
	yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com, 
	Dirk Su <dirk.su@canonical.com>
References: <CAFv23QnqgTVoB-XRe5yNndRz4-Z_3y38+QpKRxQMeZ2xQTg=gw@mail.gmail.com>
 <180d8a88-52d9-4b83-83de-0184ed7cb4a5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180d8a88-52d9-4b83-83de-0184ed7cb4a5@huawei.com>

On Thu, Mar 20, 2025 at 11:52:20AM +0800, Baokun Li wrote:
> On 2025/3/20 10:49, AceLan Kao wrote:
> > Hi all,
> > 
> > We have found a regression while doing a memory stress test using
> > stress-ng with the following command
> >     sudo stress-ng --aggressive --verify --timeout 300 --mmapmany 0
> > 
> > This issue occurs on recent kernel versions, and we have found that
> > the following commit leads to the issue
> >     4e63aeb5d010 ("blk-wbt: don't throttle swap writes in direct reclaim")
> > 
> > Before reverting the commit directly, I wonder if we can identify the
> > issue and implement a solution quickly.
> > Currently, I'm unable to provide logs, as the system becomes
> > unresponsive during testing. If you have any idea to capture logs,
> > please let me know, I'm willing to help.
> Hi AceLan,
> 
> I cannot reproduce this issue. The above command will trigger OOM.
> Have you enabled panic_on_oom? (You can check by sysctl vm.panic_on_oom).
> Or are there more kernel Oops reports in dmesg?
Actually, there is no kernel panic during the testing.
I tried using kernel magic key to trigger crash and this is what I
got.
It repeats the "Purging GPU memory" message over and over again.

[ 3605.341706] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.346295] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.350815] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.355463] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.360105] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.364743] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.369426] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.374044] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.378467] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.382958] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.387534] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.392130] [   T5739] Purging GPU memory, 0 pages freed, 0 pages still pinned, 2787 pages left available.
[ 3605.394571] [     C11] sysrq: Trigger a crash
[ 3605.394575] [     C11] Kernel panic - not syncing: sysrq triggered crash
[ 3605.394580] [     C11] CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Kdump: loaded Not tainted 6.11.0-1016-oem #16-Ubuntu
[ 3605.394586] [     C11] Hardware name: HP HP ZBook Fury 16 G11 Mobile Workstation PC/8CA7, BIOS W98 Ver. 01.01.12 11/25/2024
[ 3605.394588] [     C11] Call Trace:
[ 3605.394591] [     C11]  <IRQ>
[ 3605.394596] [     C11]  dump_stack_lvl+0x27/0xa0
[ 3605.394605] [     C11]  dump_stack+0x10/0x20
[ 3605.394608] [     C11]  panic+0x352/0x3e0
[ 3605.394613] [     C11]  sysrq_handle_crash+0x1a/0x20
[ 3605.394618] [     C11]  __handle_sysrq+0xf0/0x290
[ 3605.394623] [     C11]  sysrq_handle_keypress+0x2f4/0x550
[ 3605.394627] [     C11]  sysrq_filter+0x45/0xa0
[ 3605.394631] [     C11]  ? sched_balance_find_src_group+0x51/0x280
[ 3605.394637] [     C11]  input_handle_events_filter+0x46/0xb0
[ 3605.394643] [     C11]  input_pass_values+0x142/0x170
[ 3605.394647] [     C11]  input_event_dispose+0x167/0x170
[ 3605.394651] [     C11]  input_handle_event+0x41/0x80
[ 3605.394656] [     C11]  input_event+0x51/0x80
[ 3605.394659] [     C11]  atkbd_receive_byte+0x805/0x8f0
[ 3605.394664] [     C11]  ps2_interrupt+0xb4/0x1b0
[ 3605.394668] [     C11]  serio_interrupt+0x49/0xa0
[ 3605.394673] [     C11]  i8042_interrupt+0x196/0x4c0
[ 3605.394677] [     C11]  ? enqueue_hrtimer+0x4d/0xc0
[ 3605.394682] [     C11]  ? ktime_get+0x3f/0xf0
[ 3605.394686] [     C11]  ? lapic_next_deadline+0x2c/0x50
[ 3605.394691] [     C11]  __handle_irq_event_percpu+0x4c/0x1b0
[ 3605.394696] [     C11]  ? sched_clock_noinstr+0x9/0x10
[ 3605.394700] [     C11]  handle_irq_event+0x39/0x80
[ 3605.394706] [     C11]  handle_edge_irq+0x8c/0x250
[ 3605.394710] [     C11]  __common_interrupt+0x4e/0x110
[ 3605.394715] [     C11]  common_interrupt+0xb1/0xe0
[ 3605.394718] [     C11]  </IRQ>
[ 3605.394720] [     C11]  <TASK>
[ 3605.394721] [     C11]  asm_common_interrupt+0x27/0x40
[ 3605.394726] [     C11] RIP: 0010:poll_idle+0x4f/0xac
[ 3605.394731] [     C11] Code: 00 00 65 4c 8b 3d a1 78 7b 63 f0 41 80 4f 02 20 49 8b 07 a8 08 75 32 4c 89 ef 48 89 de e8 d9 fe ff ff 49 89 c5 b8 c9 00 00 00 <49> 8b 17 83 e2 08 75 17 f3 90 83 e8 01 75 f1 e8 bd d1 ff ff 4c 29
[ 3605.394735] [     C11] RSP: 0000:ffff9c57001f7dc8 EFLAGS: 00000206
[ 3605.394740] [     C11] RAX: 000000000000003c RBX: ffffbc56ff59b618 RCX: 0000000000000000
[ 3605.394743] [     C11] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ 3605.394744] [     C11] RBP: ffff9c57001f7df0 R08: 0000000000000000 R09: 0000000000000000
[ 3605.394747] [     C11] R10: 0000000000000000 R11: 0000000000000000 R12: 0000034772423b38
[ 3605.394749] [     C11] R13: 000000000000f424 R14: 0000000000000000 R15: ffff912c8122a900
[ 3605.394754] [     C11]  ? poll_idle+0x63/0xac
[ 3605.394757] [     C11]  cpuidle_enter_state+0x8e/0x720
[ 3605.394762] [     C11]  ? sysvec_apic_timer_interrupt+0x57/0xc0
[ 3605.394766] [     C11]  cpuidle_enter+0x2e/0x50
[ 3605.394771] [     C11]  call_cpuidle+0x22/0x60
[ 3605.394775] [     C11]  cpuidle_idle_call+0x119/0x190
[ 3605.394778] [     C11]  do_idle+0x82/0xe0
[ 3605.394781] [     C11]  cpu_startup_entry+0x29/0x30
[ 3605.394784] [     C11]  start_secondary+0x127/0x160
[ 3605.394788] [     C11]  common_startup_64+0x13e/0x141
[ 3605.394794] [     C11]  </TASK>

> 
> 
> Regards,
> Baokun
> > 
> > Best regards,
> > AceLan Kao.
> > 
> 
